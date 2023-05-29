//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/12.
//

import UIKit

class IssueListViewController: UIViewController {
   private var collectionView: UICollectionView!
   private var dataSource: DataSource?
   
   private var observers: [NSObjectProtocol] = []
   
   private let filterListID = "FilterList"
   
   private var networkManager: NetworkManager?
   private var list: IssueList = IssueList()
   private var filterList = IssueFilterList()
   private var filterApplyList: FilterApplyList? = nil
   
   private var currentPageNumber: Int = 0
   private var isPaging = false
   private var hasNextPage = true
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = .systemBackground
      self.title = "이슈"
      setNetworkManager()
      setCollectionView()
      configureDataSource()
      addObservers()
      setFilterButton()
      setSelectButton()

      fetchIssues()
   }
   
   private func setNetworkManager() {
      networkManager = NetworkManager(session: URLSession.shared)
   }
   
   private func reset() {
      list.emptyList()
      currentPageNumber = 0
      hasNextPage = true
   }
}

// MARK: - CollectionView

extension IssueListViewController {
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
      
      collectionView.delegate = self
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

extension IssueListViewController {
   private func createSwipeActionProvider() -> UICollectionLayoutListConfiguration.SwipeActionsConfigurationProvider {
      return { _ in
         let delete = SwipeAction.delete.makeAction(hasImage: false, withHandler: { _, _, _ in })
         let edit = SwipeAction.edit.makeAction(hasImage: false, withHandler: { _, _, _ in })
         let config = UISwipeActionsConfiguration(actions: [delete, edit])
         config.performsFirstActionWithFullSwipe = false
         return config
      }
   }
}

// MARK: - CollectionView Data Source

extension IssueListViewController {
   typealias SectionType = Section
   typealias ItemType = Item
   
   enum Section {
      case issue
      case loadIndicator
      
      var cellClass: UICollectionViewCell.Type {
         switch self {
         case .issue: return IssueCell.self
         case .loadIndicator: return LoadCell.self
         }
      }
   }
   
   enum Item: Hashable {
      case issue(issue: IssueSummary)
      case load
   }
   
   private class DataSource: UICollectionViewDiffableDataSource<SectionType, ItemType> { }
   
   typealias IssueCell = IssueListCollectionViewCell
   typealias LoadCell = LoadCollectionViewCell
   
   private func createIssueCellRegisteration() -> UICollectionView.CellRegistration<IssueCell, ItemType> {
      let issueCellNib = UINib(nibName: IssueCell.cellId, bundle: nil)
      return .init(cellNib: issueCellNib) { cell, _, itemIdentifier in
         guard case Item.issue(let issue) = itemIdentifier else { return }
         cell.configure(issue: issue)
      }
   }
   
   private func createLoadCellRegisteration() -> UICollectionView.CellRegistration<LoadCell, ItemType> {
      let loadCellNib = UINib(nibName: LoadCell.cellId, bundle: nil)
      return .init(cellNib: loadCellNib, handler: { _, _, _ in })
   }
   
   private func configureDataSource() {
      let issueCellRegistration = createIssueCellRegisteration()
      let loadCellRegistration = createLoadCellRegisteration()
      
      dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
         switch item {
         case .issue:
            return collectionView.dequeueConfiguredReusableCell(
               using: issueCellRegistration,
               for: indexPath,
               item: item)
         case .load:
            return collectionView.dequeueConfiguredReusableCell(
               using: loadCellRegistration,
               for: indexPath,
               item: item)
         }
      }
   }
   
   private func applyUpdatedSnapshot(animated: Bool = true) {
      var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
      snapshot.appendSections([.issue, .loadIndicator])
      let issues = list.issues.map { issue in Item.issue(issue: issue) }
      snapshot.appendItems(issues, toSection: .issue)
      if hasNextPage { snapshot.appendItems([.load], toSection: .loadIndicator) }
      dataSource?.apply(snapshot, animatingDifferences: animated)
   }
}

extension IssueListViewController: UICollectionViewDelegate {
   func collectionView(
      _ collectionView: UICollectionView,
      willDisplay cell: UICollectionViewCell,
      forItemAt indexPath: IndexPath)
   {
      if indexPath == IndexPath(item: 0, section: 1) {
         guard let loadCell = cell as? LoadCollectionViewCell else { return }
         loadCell.start()
         fetchIssues(cellCompletion: { DispatchQueue.main.async { [weak loadCell] in loadCell?.stop() } })
      }
   }
}

// MARK: - Notification

extension IssueListViewController {
   private func addObservers() {
      self.observers.append(NotificationCenter.default.addObserver(
         forName: IssueList.Notifications.didAddIssues,
         object: list, queue: .main,
         using: { [weak self] _ in self?.applyUpdatedSnapshot() }))
      
      self.observers.append(NotificationCenter.default.addObserver(
         forName: IssueList.Notifications.didAddFilteredIssues,
         object: list, queue: .main,
         using: { [weak self] _ in self?.applyUpdatedSnapshot() }))
      
      self.observers.append(NotificationCenter.default.addObserver(
         forName: FilterApplyList.applyFilter,
         object: nil, queue: .main,
         using: { [weak self] notification in
            guard let filterApplyList = notification.userInfo?[FilterApplyList.Keys.Filters] as? FilterApplyList else { return }
            self?.filterApplyList = filterApplyList
            self?.reset()
            self?.fetchIssues() }))
   }
}

// MARK: - Request

extension IssueListViewController {
   private func fetchIssues(cellCompletion: (() -> Void)? = nil) {
      guard hasNextPage else { return }
      isPaging = true
      networkManager?.requestIssueList(
         filterList: filterApplyList,
         pageNumber: currentPageNumber) { [weak self] dto in
         cellCompletion?()
         self?.isPaging = false
         self?.hasNextPage = dto.issues.count < NetworkManager.defaultPagingOffSet ? false : true
         if dto.issues.count > 0 {
            let newIssues = ListingItemFactory.IssueTab.makeIssues(with: dto.issues)
            self?.list.add(issues: newIssues) // -> POST NOTIFICATION
            self?.filterList = FilterListFactory.make(issueList: dto)
            self?.currentPageNumber += 1
         }
      }
   }
}

// MARK: - Detail

extension IssueListViewController {
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let storyboard = UIStoryboard(name: "IssueDetail", bundle: nil)
      guard let viewController = storyboard.instantiateInitialViewController() as?
                                       IssueDetailViewController else { return }
      
      viewController.issueId = list.issues[indexPath.row].issueId
      self.navigationController?.pushViewController(viewController, animated: true)
   }
}

// MARK: - Filter

extension IssueListViewController: DataSenderDelegate {
   typealias DataType = IssueFilterList
   
   func send() -> IssueFilterList {
      filterList
   }
}

extension IssueListViewController {
   @objc func presentFilterViewController() {
      let storyboard = UIStoryboard(name: "FilterList", bundle: nil)
      guard let viewController = storyboard.instantiateInitialViewController() as? FilterListViewController else { return }
      viewController.delegate = self
      self.present(viewController, animated: true)
   }
   
   private func setFilterButton() {
      self.navigationItem.leftBarButtonItem = UIBarButtonItem(
         title: "필터",
         style: .plain,
         target: self,
         action: #selector(presentFilterViewController))
   }
}

// MARK: - Select Mode

extension IssueListViewController {
   @objc func toggleSelectMode() {
      
   }
   
   private func setSelectButton() {
      let selectButton = UIBarButtonItem(
         title: "선택",
         style: .plain,
         target: self,
         action: #selector(toggleSelectMode))
      self.navigationItem.rightBarButtonItems = [selectButton]
   }
}
