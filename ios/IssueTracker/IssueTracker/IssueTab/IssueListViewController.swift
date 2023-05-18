//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/12.
//

import UIKit

class IssueListViewController: UIViewController {
   let cellIdentifier = "IssueListCollectionViewCell"
   
   var networkManager: NetworkManager?
   var objects: [IssueListDTO.Issue] = []
   
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
      
      let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
      collectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
      
      if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
         flowLayout.estimatedItemSize = .zero
      }
   }
   
   func fetchIssues() {
      guard hasNextPage else { return }
      isPaging = true
      networkManager?.fetchIssueList(pageNumber: currentPageNumber) { [weak self] dto in
         self?.isPaging = false
         self?.hasNextPage = dto.body.count < NetworkManager.defaultPagingOffSet ? false : true
         if dto.body.count > 0 {
            let mockBody = dto.body.map { IssueListDTO.Issue(title: "\(self?.currentPageNumber ?? 0)",
                                                             description: $0.description,
                                                             milestone: $0.milestone,
                                                             labels: $0.labels) }
            self?.objects.append(contentsOf: mockBody)
            DispatchQueue.main.async { [weak self] in self?.collectionView.reloadData() }
            self?.currentPageNumber += 1
         }
      }
   }
   
   func setNetworkManagerAndData() {
      let urlSession = MockURLSession(withJson: "issues")
      networkManager = NetworkManager(session: urlSession)
      fetchIssues()
   }
}

extension IssueListViewController: UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return objects.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(
         withReuseIdentifier: cellIdentifier,
         for: indexPath) as? IssueListCollectionViewCell else { return UICollectionViewCell() }
      
      let issue = objects[indexPath.item]
      cell.titleLabel.text = issue.title
      cell.descriptionLabel.text = issue.description
      cell.milestoneLabel.text = issue.milestone
      issue.labels.forEach { label in cell.addLabel(name: label.title, color: label.color) }
      return cell
   }
}

extension IssueListViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      sizeForItemAt indexPath: IndexPath
   ) -> CGSize {
      return CGSize(width: collectionView.frame.width, height: 180)
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
      if indexPath.item == collectionView.numberOfItems(inSection: 0) - 1 {
         fetchIssues()
      }
   }
}
