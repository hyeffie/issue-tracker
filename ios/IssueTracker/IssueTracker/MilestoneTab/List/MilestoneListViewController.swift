//
//  MilestoneListViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/25.
//

import UIKit

class MilestoneListViewController: UIViewController {
   private var collectionView: UICollectionView!
   private var dataSource: DataSource!
   
   var observers: [NSObjectProtocol] = []
   
   private var networkManager: NetworkManager?
   private var list: MilestoneList = MilestoneList()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = .systemBackground
      self.title = "마일스톤"
      addObservers()
      setCollectionView()
      configureDataSource()
      setNetworkManager()
      fetchMilestones()
   }
   
   func setNetworkManager() {
      networkManager = NetworkManager(session: URLSession.shared)
   }
}

extension MilestoneListViewController {
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

extension MilestoneListViewController {
   func createSwipeActionProvider() -> UICollectionLayoutListConfiguration.SwipeActionsConfigurationProvider {
      return { _ in
         let delete = SwiptAction.delete.makeAction(withHandler: { _, _, _ in })
         let edit = SwiptAction.edit.makeAction(withHandler: { _, _, _ in })
         let config = UISwipeActionsConfiguration(actions: [delete, edit])
         config.performsFirstActionWithFullSwipe = false
         return config
      }
   }
}

extension MilestoneListViewController {
   typealias MilestoneCell = MilestoneListCell
   private enum Section {
      case milestone
   }
   
   private enum Item: Hashable {
      case milestone(milestone: MilestoneList.Milestone)
   }
   
   private class DataSource: UICollectionViewDiffableDataSource<Section, Item> { }
   
   private func createMilestoneCellRegisteration() -> UICollectionView.CellRegistration<MilestoneCell, Item> {
      let cellNib = UINib(nibName: MilestoneCell.cellId, bundle: nil)
      return .init(cellNib: cellNib) { cell, _, itemIdentifier in
         guard case Item.milestone(let milestone) = itemIdentifier else { return }
         cell.configure(with: milestone)
      }
   }
   
   private func configureDataSource() {
      let milestoneCellRegistration = createMilestoneCellRegisteration()
      
      dataSource = DataSource(
         collectionView: collectionView,
         cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
         switch item {
         case .milestone:
            return collectionView.dequeueConfiguredReusableCell(
               using: milestoneCellRegistration,
               for: indexPath,
               item: item)
         }
      })
   }
   
   private func applyUpdatedSnapshot(animated: Bool = true) {
      var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
      snapshot.appendSections([.milestone])
      let milestoneItems = list.milestones.map { milestone in Item.milestone(milestone: milestone) }
      snapshot.appendItems(milestoneItems, toSection: .milestone)
      dataSource.apply(snapshot, animatingDifferences: animated)
   }
}

extension MilestoneListViewController {
   private func addObservers() {
      let noti = NotificationCenter.default.addObserver(
         forName: MilestoneList.Notifications.didAddMilestones,
         object: list,
         queue: .main,
         using: { [weak self] _ in
            self?.applyUpdatedSnapshot()
         })
      self.observers.append(noti)
   }
}

extension MilestoneListViewController {
   func fetchMilestones(cellCompletion: (() -> Void)? = nil) {
      networkManager?.requestMilestoneList { [weak self] dto in
         cellCompletion?()
         if dto.milestoneList.count > 0 {
            let milestones = ListingItemFactory.MilestoneTab.makeMilestoneList(with: dto)
            self?.list.emptyList()
            self?.list.add(milestones: milestones)
         }
      }
   }
}
