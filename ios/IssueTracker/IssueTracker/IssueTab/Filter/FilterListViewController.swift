//
//  FilterListViewController.swift
//  IssueTracker
//
//  Created by 1 on 2023/05/18.
//

import UIKit

class FilterListViewController: UIViewController {
   let filterCellID = "FilterListCollectionViewCell"
   let filterHeaderID = "FilterListCollectionViewHeader"
   
   var delegate: (any DataSenderDelegate)?
   var filterListUseCase: FilterListUseCase?
   var filterApplyList = FilterApplyList()
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      receiveData()
      setCollectionView()
   }
   
   private func receiveData() {
      guard let receivedData = delegate?.send() as? IssueFilterList else {
         return
      }
      
      self.filterListUseCase = FilterListUseCase(filterList: receivedData)
   }
   
   private func setCollectionView() {
      collectionView.delegate = self
      collectionView.dataSource = self
      
      let filterCell = UINib(nibName: filterCellID, bundle: nil)
      collectionView.register(filterCell, forCellWithReuseIdentifier: filterCellID)
      let filterHeader = UINib(nibName: filterHeaderID, bundle: nil)
      collectionView.register(filterHeader,
                              forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                              withReuseIdentifier: filterHeaderID)
      
      if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
         flowLayout.estimatedItemSize = .zero
      }
      
      collectionView.allowsMultipleSelection = true
   }
   
   @IBAction func cancel(_ sender: Any) {
      self.dismiss(animated: true)
   }
   
   @IBAction func save(_ sender: Any) {
      
      self.dismiss(animated: true)
   }
}

extension FilterListViewController: UICollectionViewDataSource {
   func numberOfSections(in collectionView: UICollectionView) -> Int {
      guard let countOfSections = filterListUseCase?.sendHeaderCount() else {
         return 0
      }
      
      return countOfSections
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      viewForSupplementaryElementOfKind kind: String,
      at indexPath: IndexPath)
   -> UICollectionReusableView
   {
      guard let header = collectionView.dequeueReusableSupplementaryView(
         ofKind: kind,
         withReuseIdentifier: filterHeaderID,
         for: indexPath) as? FilterListCollectionViewHeader else {
         return UICollectionReusableView()
      }
      
      guard let sectionName = filterListUseCase?.sendHeaderName(section: indexPath.section) else {
         return header
      }
      
      header.sectionName.text = sectionName
      header.configureFont()
      return header
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      numberOfItemsInSection section: Int)
   -> Int {
      guard let countOfItems = filterListUseCase?.sendCount(section: section) else {
         return 1
      }
      
      return countOfItems
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      cellForItemAt indexPath: IndexPath)
   -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(
         withReuseIdentifier: filterCellID,
         for: indexPath
      ) as? FilterListCollectionViewCell else { return UICollectionViewCell() }
      
      guard let itemName = filterListUseCase?.sendItemName(section: indexPath.section,
                                                 index: indexPath.row) else {
         return cell
      }
      
      cell.filterName.text = itemName
      cell.configureFont()
      cell.configureImage()
      return cell
   }
}

extension FilterListViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: collectionView.frame.width, height: 44)
   }
   
   func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       referenceSizeForHeaderInSection section: Int) -> CGSize {
      return CGSize(width: collectionView.frame.width, height: 44)
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      minimumLineSpacingForSectionAt section: Int
   ) -> CGFloat {
      return 1.0
   }
   
   func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 1.0, left: 0, bottom: 4.0, right: 0)
   }
}
