//
//  IssueListViewController+Select.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/30.
//

import UIKit

extension IssueListViewController {
   @objc func toggleSelectMode() {
      isSelectMode = true
      self.navigationItem.title = "이슈 선택"
      self.navigationItem.leftBarButtonItem?.isHidden = true
      self.navigationItem.rightBarButtonItem = createCancelButton()
      self.collectionView.allowsMultipleSelection = true
      configureTabBar(isHiding: true)
      self.selectToolbar = createSelectToolBar()
   }
   
   func createSelectToolBar() -> SelectToolBar? {
      let nib = UINib(nibName: "SelectToolBar", bundle: nil)
      guard let toolBar = nib.instantiate(withOwner: self, options: nil).first as? SelectToolBar else {
         return nil
      }
      
      toolBar.delegate = self
      self.view.addSubview(toolBar)
      toolBar.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
         toolBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
         toolBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
         toolBar.topAnchor.constraint(equalTo: (self.tabBarController?.tabBar.topAnchor)!),
         toolBar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
      ])
      
      return toolBar
   }
   
   func createCancelButton() -> UIBarButtonItem {
      return UIBarButtonItem(title: "취소",
                             style: .plain,
                             target: self,
                             action: #selector(cancelSelectMode))
   }
   
   @objc func cancelSelectMode() {
      self.navigationItem.leftBarButtonItem?.isHidden = false
      setSelectButton()
      configureTabBar(isHiding: false)
      deselectAllCells()
      self.collectionView.allowsMultipleSelection = false
      self.isSelectMode = false
      self.navigationItem.title = "이슈"
   }
   
   func setSelectButton() {
      let selectButton = UIBarButtonItem(
         title: "선택",
         style: .plain,
         target: self,
         action: #selector(toggleSelectMode))
      self.navigationItem.rightBarButtonItems = [selectButton]
   }
   
   func deselectAllCells() {
      guard let indexPaths = collectionView.indexPathsForSelectedItems else {
         return
      }
      
      indexPaths.forEach {
         guard let cell = collectionView.cellForItem(at: $0) as? IssueListCollectionViewCell else {
            return
         }
         
         cell.didDeSelect()
      }
   }
}
