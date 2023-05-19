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
   let filterStatusList = ["열린 이슈", "내가 작성한 이슈", "내가 댓글을 남긴 이슈", "닫힌 이슈"]
   let filterHeaderNames = ["상태", "담당자", "레이블", "마일스톤"]
   
   var delegate: DataSenderDelegate?
   var useCase = IssueListDTO()
   let statusCellCount = 4
   let sectionCount = 4
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      guard let receivedData = delegate?.receive() else {
         return
      }
      useCase = receivedData
      setCollectionView()
   }
   
   func setCollectionView() {
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
   }
   
   @IBAction func cancel(_ sender: Any) {
      self.dismiss(animated: true)
   }
   
   @IBAction func save(_ sender: Any) {
      // 필터목록에서 선택된 필터들을 기반으로 URL을 생성해 서버에 데이터를 요청하며, 원래 화면으로 돌아갑니다.
      self.dismiss(animated: true)
   }
}
