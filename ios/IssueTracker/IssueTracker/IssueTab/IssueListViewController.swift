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
   
   func setNetworkManagerAndData() {
      let urlSession = MockURLSession(withJson: "issues")
      networkManager = NetworkManager(session: urlSession)
      
      networkManager?.fetchIssueList(completion: { [weak self] dto in
         self?.objects = dto.body
         
         DispatchQueue.main.async { [weak self] in self?.collectionView.reloadData() }
      })
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
}
