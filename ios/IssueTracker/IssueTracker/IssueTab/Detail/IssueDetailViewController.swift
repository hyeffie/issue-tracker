//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/26.
//

import UIKit

class IssueDetailViewController: UIViewController {
   @IBOutlet weak var collectionView: UICollectionView!
   var issueId: Int?
   var issueDetailUseCase = IssueDetailUseCase()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      hideTabBar()
      addEditButton()
      setCollectionView()
      issueDetailUseCase.loadData(issueId: issueId)
   }
   
   private func addEditButton() {
      guard let editImage = UIImage(systemName: "ellipsis") else { return }
      let editButton = UIBarButtonItem(image: editImage)
      self.navigationItem.rightBarButtonItem = editButton
   }
   
   private func setCollectionView() {
      let headerId = "IssueDetailCollectionViewHeader"
      let cellId = "IssueDetailCollectionViewCell"
      
      let detailHeader = UINib(nibName: headerId, bundle: nil)
      collectionView.register(detailHeader,
                              forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                              withReuseIdentifier: headerId)
      let detailCell = UINib(nibName: cellId, bundle: nil)
      collectionView.register(detailCell,
                              forCellWithReuseIdentifier: cellId)
   }
}
