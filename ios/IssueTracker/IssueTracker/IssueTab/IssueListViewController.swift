//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/12.
//

import UIKit

class IssueListViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
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
  }
}

extension IssueListViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "IssueListCollectionViewCell",
      for: indexPath) as? IssueListCollectionViewCell else { return UICollectionViewCell() }
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
