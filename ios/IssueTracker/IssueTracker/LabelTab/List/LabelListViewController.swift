//
//  LabelListViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/24.
//

import UIKit

class LabelListViewController: UIViewController {
   private var collectionView: UICollectionView!
   private var dataSource: DataSource?
   
   var observers: [NSObjectProtocol] = []
   
   private var networkManager: NetworkManager?
   private var list: LabelList = LabelList()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = .systemBackground
      self.title = "레이블"
      addObservers()
      setCollectionView()
      setCreateButton()
      configureDataSource()
      setNetworkManager()
      fetchLabels()
   }
   
   func setNetworkManager() {
      networkManager = NetworkManager(session: URLSession.shared)
   }
}

extension LabelListViewController {
   private func setCollectionView() {
      collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
      collectionView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(collectionView)
      
      NSLayoutConstraint.activate([
         collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
      ])
   }
   
   private func setCollectionViewLayout() -> UICollectionViewCompositionalLayout {
      let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { [weak self] _, layoutEnvironment in
         var config = UICollectionLayoutListConfiguration(appearance: .plain)
         config.showsSeparators = true
         config.trailingSwipeActionsConfigurationProvider = self?.createSwipeActionProvider()
         return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
      }
      return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
   }
}

extension LabelListViewController {
   func createSwipeActionProvider() -> UICollectionLayoutListConfiguration.SwipeActionsConfigurationProvider {
      return { indexPath in
         var delete = SwipeAction.delete.makeAction(hasImage: false) { [weak self] _, _, _ in
            guard let labelId = self?.list.getLabelId(of: indexPath.item) else { return }
            self?.networkManager?.deleteLabel( id: labelId) { self?.list.deleteLabel(id: labelId) }
         }
         
         let edit = SwipeAction.edit.makeAction(hasImage: false, withHandler: { [weak self] _, _, complete in
            let detail = self?.list.getLabelDetail(of: indexPath.item)
            let viewController = LabelEditViewController.instantiate(detail: detail)
            self?.navigationController?.pushViewController(viewController, animated: true)
            complete(true)
         })
         let config = UISwipeActionsConfiguration(actions: [delete, edit])
         config.performsFirstActionWithFullSwipe = false
         return config
      }
   }
}

extension LabelListViewController {
   typealias LabelCell = LabelListCell
   
   private enum Section {
      case label
   }
   
   private enum Item: Hashable {
      case label(label: LabelDetail)
   }
   
   private class DataSource: UICollectionViewDiffableDataSource<Section, Item> { }
   
   private func createLabelCellRegisteration() -> UICollectionView.CellRegistration<LabelCell, Item> {
      let cellNib = UINib(nibName: LabelCell.cellId, bundle: nil)
      return .init(cellNib: cellNib) { cell, _, itemIdentifier in
         guard case Item.label(let label) = itemIdentifier else { return }
         cell.configure(with: label)
      }
   }
   
   private func configureDataSource() {
      let labelCellRegistration = createLabelCellRegisteration()
      
      dataSource = DataSource(
         collectionView: collectionView,
         cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
         switch item {
         case .label:
            return collectionView.dequeueConfiguredReusableCell(
               using: labelCellRegistration,
               for: indexPath,
               item: item)
         }
      })
   }
   
   private func applyUpdatedSnapshot(animated: Bool = true) {
      var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
      snapshot.appendSections([.label])
      snapshot.appendItems(list.labels.map { label in Item.label(label: label) }, toSection: .label)
      dataSource?.apply(snapshot, animatingDifferences: animated)
   }
}

extension LabelListViewController {
   private func addObservers() {
      self.observers.append(NotificationCenter.default.addObserver(
         forName: LabelList.Notifications.didAddLabels,
         object: list,
         queue: .main,
         using: { [weak self] _ in self?.applyUpdatedSnapshot() }))
      
      self.observers.append(NotificationCenter.default.addObserver(
         forName: LabelList.Notifications.didAddLabel,
         object: nil,
         queue: .main,
         using: { [weak self] _ in self?.fetchLabels() }))
      
      self.observers.append(NotificationCenter.default.addObserver(
         forName: LabelList.Notifications.didEditLabel,
         object: nil,
         queue: .main,
         using: { [weak self] _ in self?.fetchLabels() }))
      
      self.observers.append(NotificationCenter.default.addObserver(
         forName: LabelList.Notifications.didDeleteLabel,
         object: list,
         queue: .main,
         using: { [weak self] _ in self?.applyUpdatedSnapshot() }))
   }
}

extension LabelListViewController {
   func fetchLabels(cellCompletion: (() -> Void)? = nil) {
      networkManager?.requestLabelList { [weak self] dto in
         cellCompletion?()
         if dto.labelList.count > 0 {
            let labels = ListingItemFactory.LabelTab.makeLabelList(with: dto)
            self?.list.emptyList()
            self?.list.add(labels: labels)
         }
      }
   }
}

extension LabelListViewController {
   @objc func presentCreateEditVC() {
      let viewController = LabelEditViewController.instantiate()
      self.navigationController?.pushViewController(viewController, animated: true)
   }
   
   func setCreateButton() {
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(
         title: "추가",
         style: .plain,
         target: self,
         action: #selector(presentCreateEditVC))
   }
}
