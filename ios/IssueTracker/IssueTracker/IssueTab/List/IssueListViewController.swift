//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/12.
//

import UIKit

class IssueListViewController: UIViewController, UIToolbarDelegate {
   var collectionView: UICollectionView!
   private var dataSource: DataSource?

   private var observers: [NSObjectProtocol] = []

   private let filterListID = "FilterList"

   var list: IssueList = IssueList()
   private var filterList = IssueFilterList()

   private var filterApplyList: FilterApplyList? = nil
   private var searchQuery: String? = nil

   var networkManager: NetworkManager?
   var selectToolbar: SelectToolBar?
   var selectedIssues = IssuePatchDTO()
   var selectedCells = Set<Int>()

   private var floatingActionButton: UIButton?

   var currentPageNumber: Int = 1
   var isPaging = false
   var hasNextPage = true
   var isSelectMode = false
   let toolbarTag: Int = 100

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
      addFloatingActionButton()
      fetchIssues()
   }

   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      self.tabBarController?.tabBar.isHidden = false
   }

   private func setNetworkManager() {
      networkManager = NetworkManager(session: URLSession.shared)
   }

   func reset() {
      list.emptyList()
      currentPageNumber = 1
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
      collectionView.keyboardDismissMode = .onDrag
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
      return { indexPath in
         let delete = SwipeAction.delete.makeAction(hasImage: true, withHandler: { [weak self] _, _, _ in
            guard let issueId = self?.list.getIssueId(of: indexPath.item) else { return }
            self?.networkManager?.deleteIssue(id: issueId, completion: { self?.list.deleteIssue(id: issueId) })
         })
         
         let edit = SwipeAction.edit.makeAction(hasImage: true, withHandler: { [weak self] _, _, complete in
            guard let issueId = self?.list.getIssueId(of: indexPath.item) else { return }
            self?.networkManager?.requestIssueDetail(issueId: issueId, completion: { dto in
               let detail = ListingItemFactory.IssueTab.makeIssueDetailPostDTO(with: dto)
               DispatchQueue.main.async { [weak self] in
                  let viewController = IssueCreateViewController.instantiate(id: issueId, detail: detail)
                  self?.navigationController?.pushViewController(viewController, animated: true)
               }
            })
            complete(true)
         })
         
         let config = UISwipeActionsConfiguration(actions: [delete, edit])
         config.performsFirstActionWithFullSwipe = false
         return config
      }
   }
}

// MARK: - CollectionView DataSource

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
      return .init(cellNib: issueCellNib) { cell, indexPath, itemIdentifier in
         guard case Item.issue(let issue) = itemIdentifier else { return }
         
         
         cell.configure(issue: issue, isSelected: self.selectedCells.contains(indexPath.row))
         
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

// MARK: - CollectionView Delegate

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

      self.observers.append(NotificationCenter.default.addObserver(
         forName: IssueList.Notifications.didEmptyIssue,
         object: list, queue: .main,
         using: { [weak self] _ in
            self?.hasNextPage = false
            self?.applyUpdatedSnapshot() }))
      
      self.observers.append(NotificationCenter.default.addObserver(
         forName: IssueList.Notifications.didDeleteIssue,
         object: list, queue: .main,
         using: { [weak self] _ in self?.applyUpdatedSnapshot() }))
      
      self.observers.append(NotificationCenter.default.addObserver(
         forName: IssueList.Notifications.didAddIssue,
         object: nil, queue: .main,
         using: { [weak self] _ in
            self?.reset()
            self?.fetchIssues() }))
      
      self.observers.append(NotificationCenter.default.addObserver(
         forName: IssueList.Notifications.didEditIssue,
         object: nil, queue: .main,
         using: { [weak self] _ in
            self?.reset()
            self?.fetchIssues() }))
   }
}

// MARK: - Request

extension IssueListViewController {
   func fetchIssues(cellCompletion: (() -> Void)? = nil) {
      guard hasNextPage else { return }
      isPaging = true
      networkManager?.requestIssueList(
         searchQuery: self.searchQuery,
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
            DispatchQueue.main.async { self?.setSearchBar() }
         }
   }
}

// MARK: - Detail

extension IssueListViewController {
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      guard isSelectMode, let cell = collectionView.cellForItem(at: indexPath) as? IssueListCollectionViewCell else {
         let storyboard = UIStoryboard(name: "IssueDetail", bundle: nil)
         guard let viewController = storyboard.instantiateInitialViewController() as? IssueDetailTableViewController else { return }

         viewController.issueId = list.issues[indexPath.row].issueId
         self.navigationController?.pushViewController(viewController, animated: true)
         return
      }
      
      self.selectToolbar?.configureItems()
      
      cell.didSelect()
      self.selectedIssues.add(issue: IssuePatchDTO.Issue(issueId: list.findIssue(row: indexPath.row)))
      self.selectedCells.insert(indexPath.row)
   }
   
   func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
      guard let cell = collectionView.cellForItem(at: indexPath) as? IssueListCollectionViewCell else {
         return
      }
      
      self.selectToolbar?.configureItems(isSelected: false)
      cell.didDeSelect()
      self.selectedIssues.remove(id: indexPath.row)
      self.selectedCells.remove(indexPath.row)
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

// MARK: - Search

extension IssueListViewController {
   private func setSearchBar() {
      guard navigationItem.searchController == nil else { return }
      let searchController = UISearchController()
      searchController.searchBar.placeholder = "이슈 제목으로 검색"
      navigationItem.searchController = searchController
      navigationItem.searchController?.searchBar.delegate = self
   }
   
   private func search(text: String?) {
      self.searchQuery = text
      self.reset()
      self.fetchIssues()
   }
}

extension IssueListViewController: UISearchBarDelegate {
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      search(text: searchText)
   }
   
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      self.resignFirstResponder()
      search(text: searchBar.text)
   }
   
   func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      search(text: nil)
   }
}

// MARK: - FAB Action

extension IssueListViewController {
   private func addFloatingActionButton() {
      let fabSize: CGFloat = 56
      let fab = UIButton()
      view.addSubview(fab)
      fab.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         fab.widthAnchor.constraint(equalToConstant: fabSize),
         fab.heightAnchor.constraint(equalToConstant: fabSize),
         fab.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
         fab.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
      ])
      
      fab.backgroundColor = Color.blue.color
      let symbolConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
      let plusImage = UIImage(systemName: "plus")?.applyingSymbolConfiguration(symbolConfig)
      fab.setImage(plusImage, for: .normal)
      fab.tintColor = .white
      fab.layer.cornerRadius = fabSize / 2
      fab.clipsToBounds = true
      
      fab.addTarget(self,
                    action: #selector(presentIssueAddViewController),
                    for: .primaryActionTriggered)
   }
   
   @objc func presentIssueAddViewController() {
      let viewController = IssueCreateViewController.instantiate(detail: nil)
      self.navigationController?.pushViewController(viewController, animated: true)
   }
}
