//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/12.
//

import UIKit

class IssueListViewController: UIViewController {
   let issueCellID = "IssueListCollectionViewCell"
   let loadCellID = "LoadCollectionViewCell"
   let filterListID = "FilterList"
   
   var networkManager: NetworkManager?
   var objects: [IssueListDTO.Issue] = []
   var fetchedAllData = IssueListDTO()
   
   var currentPageNumber: Int = 0
   var isPaging = false
   var hasNextPage = true
   
   @IBOutlet weak var collectionView: UICollectionView!
   private var dataSource: DataSource!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.title = "이슈"
      setCollectionView()
      configureDataSource()
      setNetworkManagerAndData()
   }
   
   func setCollectionView() {
      collectionView.collectionViewLayout = createLayout()
      collectionView.delegate = self
   }
   
   func createLayout() -> UICollectionViewLayout {
      let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { _, layoutEnvironment in
         var config = UICollectionLayoutListConfiguration(appearance: .plain)
         config.showsSeparators = true

         return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
      }
      return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
   }
   
   func fetchIssues(cellCompletion: (() -> Void)? = nil) {
      guard hasNextPage else { return }
      isPaging = true
      networkManager?.fetchIssueList() { [weak self] dto in
         cellCompletion?()
         self?.isPaging = false
         self?.hasNextPage = dto.issues.count < NetworkManager.defaultPagingOffSet ? false : true
         if dto.issues.count > 0 {
            self?.objects = []
            self?.objects.append(contentsOf: dto.issues)
            self?.fetchedAllData = dto
            DispatchQueue.main.async { [weak self] in
               self?.applyUpdatedSnapshot()
            }
            self?.currentPageNumber += 1
         }
      }
   }
   
   private func createIssueCellRegisteration() -> UICollectionView.CellRegistration<IssueListCollectionViewCell, ItemType> {
      let issueCellNib = UINib(nibName: issueCellID, bundle: nil)
      return .init(cellNib: issueCellNib) { cell, indexPath, itemIdentifier in
         guard indexPath.section == 0, case Item.issue(let issue) = itemIdentifier else { return }
         cell.configure(issue: issue)
      }
   }
   
   private func createLoadCellRegisteration() -> UICollectionView.CellRegistration<LoadCollectionViewCell, ItemType> {
      let loadCellNib = UINib(nibName: loadCellID, bundle: nil)
      return .init(cellNib: loadCellNib, handler: { _, _, _ in })
   }
   
   private func configureDataSource() {
      let issueCellRegistration = createIssueCellRegisteration()
      let loadCellRegistration = createLoadCellRegisteration()
      
      dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
         switch item {
         case .issue(let issue):
            return collectionView.dequeueConfiguredReusableCell(using: issueCellRegistration, for: indexPath, item: item)
         case .load:
            return collectionView.dequeueConfiguredReusableCell(using: loadCellRegistration, for: indexPath, item: item)
         default:
            return nil
         }
      }
   }
   
   private func applyUpdatedSnapshot(animated: Bool = true) {
      var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
      snapshot.appendSections([.issue, .loadIndicator])
      snapshot.appendItems(objects.map { object in Item.issue(issue: object) }, toSection: .issue)
      snapshot.appendItems([.load], toSection: .loadIndicator)
      dataSource.apply(snapshot, animatingDifferences: animated)
   }
   
   func setNetworkManagerAndData() {
      networkManager = NetworkManager(session: URLSession.shared)
      fetchIssues()
   }
   
   @IBAction func filter(_ sender: Any) {
      let storyboard = UIStoryboard(name: filterListID, bundle: nil)
      guard let filterListViewController = storyboard.instantiateInitialViewController() as? FilterListViewController else { return }
      filterListViewController.delegate = self
      self.present(filterListViewController, animated: true)
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
   
extension IssueListViewController: DataSenderDelegate {
   func receive() -> IssueListDTO {
      fetchedAllData
   }
}

extension IssueListViewController {
   typealias SectionType = Section
   typealias ItemType = Item
   
   enum Section {
      case issue
      case loadIndicator
      
      var cellClass: UICollectionViewCell.Type {
         switch self {
         case .issue: return IssueListCollectionViewCell.self
         case .loadIndicator: return LoadCollectionViewCell.self
         }
      }
      
      var cellIdentifier: String {
         switch self {
         case .issue: return "IssueListCollectionViewCell"
         case .loadIndicator: return "LoadCollectionViewCell"
         }
      }
   }
   
   enum Item: Hashable {
      case issue(issue: IssueListDTO.Issue)
      case load
   }
   
   private class DataSource: UICollectionViewDiffableDataSource<SectionType, ItemType> {
      
   }
}
