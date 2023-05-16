//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/12.
//

import UIKit

class IssueListViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
    let data = [["description", "#1429D6"], ["Label", "#A36139"], ["wood", "#B4A239"]]
  
  var networkManager: NetworkManager?
  var objects: [IssueListDTO.Issue] = []
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "이슈"
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    let cellNib = UINib(nibName: "IssueListCollectionViewCell", bundle: nil)
    collectionView.register(cellNib, forCellWithReuseIdentifier: "IssueListCollectionViewCell")
    
    if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.estimatedItemSize = .zero
    }
    
    let urlSession = MockURLSession(withJson: "issues")
    networkManager = NetworkManager(session: urlSession)
    
    networkManager?.fetchIssueList(completion: { [weak self] dto in
      self?.objects = dto.body
    })
  }
}

extension IssueListViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return objects.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "IssueListCollectionViewCell",
      for: indexPath) as? IssueListCollectionViewCell else { return UICollectionViewCell() }
    cell.configure(issue: objects[indexPath.item])
      return cell
  }
}

extension IssueListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 150)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 0
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 0
  }
}
