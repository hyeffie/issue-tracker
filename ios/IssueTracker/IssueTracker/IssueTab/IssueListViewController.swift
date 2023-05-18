//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/12.
//

import UIKit

class IssueListViewController: UIViewController, DataSenderDelegate {
   
   let cellIdentifier = "IssueListCollectionViewCell"
   
   var networkManager: NetworkManager?
   var objects: [IssueListDTO.Issue] = []
   
   let useCase = IssueListUseCase(issues: Issue, users: <#T##<<error type>>#>, labels: <#T##<<error type>>#>, milestones: <#T##<<error type>>#>)
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.title = "이슈"
      setCollectionView()
      setNetworkManagerAndData()
   }
   
   func setCollectionView() {
      collectionView.dataSource = self
      
      let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
      collectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
      
      if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
         flowLayout.minimumLineSpacing = 1
         flowLayout.minimumInteritemSpacing = 0
         flowLayout.estimatedItemSize = .zero
         flowLayout.itemSize = CGSize(width: collectionView.frame.width, height: 180)
      }
   }
   
   func setNetworkManagerAndData() {
      let urlSession = MockURLSession(withJson: "issues")
      networkManager = NetworkManager(session: urlSession)
      
      networkManager?.fetchIssueList(completion: { [weak self] dto in
         self?.objects = dto.body
      })
   }
   
   func receive() -> [Any] {
      return [useCase.users, useCase.labels, useCase.milestones]
   }
   
   @IBAction func filter(_ sender: Any) {
      guard let filterListViewController = self.storyboard?.instantiateViewController(withIdentifier: "FilterElementList") as? FilterElementListViewController else {
         return
      }
      
      filterListViewController.delegate = self
      self.navigationController?.pushViewController(filterListViewController, animated: true)
      
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
