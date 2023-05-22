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
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.title = "이슈"
      setCollectionView()
      setNetworkManagerAndData()
   }
   
   func setCollectionView() {
      collectionView.dataSource = self
      collectionView.delegate = self
      
      let issueCell = UINib(nibName: issueCellID, bundle: nil)
      collectionView.register(issueCell, forCellWithReuseIdentifier: issueCellID)
      let loadCell = UINib(nibName: loadCellID, bundle: nil)
      collectionView.register(loadCell, forCellWithReuseIdentifier: loadCellID)
      
      if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
         flowLayout.estimatedItemSize = .zero
      }
   }
   
   func fetchIssues(cellCompletion: (() -> Void)? = nil) {
      guard hasNextPage else { return }
      isPaging = true
      networkManager?.fetchIssueList() { [weak self] dto in
         cellCompletion?()
         self?.isPaging = false
         self?.hasNextPage = dto.issues.count < NetworkManager.defaultPagingOffSet ? false : true
         if dto.issues.count > 0 {
            self?.objects.append(contentsOf: dto.issues)
            self?.fetchedAllData = dto
            DispatchQueue.main.async { [weak self] in self?.collectionView.reloadData() }
            self?.currentPageNumber += 1
         }
      }
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

extension IssueListViewController: UICollectionViewDataSource {
   func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 2
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      switch section {
      case 0: return objects.count
      case 1: return 1
      default: return 0
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      switch indexPath.section {
      case 0:
         guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: issueCellID,
            for: indexPath) as? IssueListCollectionViewCell else { return UICollectionViewCell() }
         
         let issue = objects[indexPath.item]
         cell.titleLabel.text = issue.title
         cell.descriptionLabel.text = issue.content
         cell.milestoneLabel.text = issue.milestoneName
         issue.labelList.forEach { label in cell.addLabel(name: label.labelName, color: label.backgroundColor) }
         return cell
         
      case 1:
         guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: loadCellID,
            for: indexPath) as? LoadCollectionViewCell else { return LoadCollectionViewCell() }
         return cell
         
      default:
         return UICollectionViewCell()
      }
   }
}

extension IssueListViewController: UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 0.5, left: 0, bottom: 0.5, right: 0)
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      sizeForItemAt indexPath: IndexPath
   ) -> CGSize {
      switch indexPath.section {
      case 0:
         return CGSize(width: collectionView.frame.width, height: 180)
      case 1:
         return CGSize(width: collectionView.frame.width, height: 80)
      default:
         return .zero
      }
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      minimumLineSpacingForSectionAt section: Int
   ) -> CGFloat {
      return 1.0
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      minimumInteritemSpacingForSectionAt section: Int
   ) -> CGFloat {
      return 0
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      willDisplay cell: UICollectionViewCell,
      forItemAt indexPath: IndexPath)
   {
      if indexPath.section == 1 && indexPath.item == 0 {
         guard let loadCell = cell as? LoadCollectionViewCell else { return }
         loadCell.start()
         let completion: () -> Void = {
            DispatchQueue.main.async { [weak loadCell] in loadCell?.stop() } }
         fetchIssues(cellCompletion: completion)
      }
   }
}
   
extension IssueListViewController: DataSenderDelegate {
   func receive() -> IssueListDTO {
      fetchedAllData
   }
}
