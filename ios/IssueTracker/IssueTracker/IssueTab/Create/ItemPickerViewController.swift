//
//  ItemPickerViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/31.
//

import UIKit

struct PickerElement: Hashable {
   let id: Int
   let name: String
}

struct PickerElementItem: Hashable {
   let element: PickerElement
   var isSelected: Bool
}

final class ItemPickerViewController: UIViewController {
   let elements: [PickerElement]
   let isMultiSelectable: Bool
   var completion: ((Set<Int>, String?) -> Void)? = nil
   
   var selectedItemIds = Set<Int>() {
      didSet {
         applyUpdatedSnapshot(animated: false)
      }
   }
   
   private var collectionView: UICollectionView!
   private var dataSource: DataSource?
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   init(title: String,
        elements: [PickerElement],
        selectedItems: Set<Int>,
        multiSelectable: Bool = true,
        completion: ((Set<Int>, String?) -> Void)?
   ) {
      self.elements = elements
      self.selectedItemIds = selectedItems
      self.isMultiSelectable = multiSelectable
      self.completion = completion
      super.init(nibName: nil, bundle: nil)
      
      self.title = "\(title) 선택"
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setCollectionView()
      addSaveButton()
      configureDataSource()
      applyUpdatedSnapshot()
   }
   
   private func addSaveButton() {
      self.navigationItem.rightBarButtonItem = .init(title: "완료", style: .done, target: self, action: #selector(save))
   }
   
   private func makeStateDescription() -> String {
      guard let targetId = selectedItemIds.first else { return "" }
      guard let target = elements.first(where: { element in element.id == targetId }) else { return "" }
      var result = target.name
      result += selectedItemIds.count > 1 ? "외 \(selectedItemIds.count - 1)개" : ""
      return result
   }
   
   @objc func save() {
      let stateDescription = makeStateDescription()
      completion?(selectedItemIds, stateDescription)
      self.dismiss(animated: true)
   }
}

// MARK: - CollectionView

extension ItemPickerViewController {
   private func setCollectionView() {
      collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
      collectionView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(collectionView)
      
      NSLayoutConstraint.activate([
         collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         collectionView.topAnchor.constraint(equalTo: view.topAnchor),
         collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
      
      collectionView.allowsMultipleSelection = true
      collectionView.delegate = self
   }
   
   private func setCollectionViewLayout() -> UICollectionViewCompositionalLayout {
      let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { _, layoutEnvironment in
         var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
         config.showsSeparators = true
         return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
      }
      return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
   }
}

// MARK: - CollectionView DataSource

extension ItemPickerViewController {
   private class DataSource: UICollectionViewDiffableDataSource<Section, Item> { }
   
   typealias Item = PickerElementItem
   
   enum Section {
      case items
   }
   
   private func configureDataSource() {
      let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { (cell, indexPath, item) in
         var content = cell.defaultContentConfiguration()
         cell.accessories = item.isSelected ? [.checkmark()] : []
         content.text = item.element.name
         cell.contentConfiguration = content
      }
      dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
         return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
      }
   }
   
   private func applyUpdatedSnapshot(animated: Bool = true) {
      var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
      snapshot.appendSections([.items])
      let items = elements.map { element in PickerElementItem(element: element, isSelected: selectedItemIds.contains(element.id)) }
      snapshot.appendItems(items, toSection: .items)
      dataSource?.apply(snapshot, animatingDifferences: animated)
   }
   
}

// MARK: - CollectionView Delegate

extension ItemPickerViewController: UICollectionViewDelegate {
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      collectionView.deselectItem(at: indexPath, animated: true)
      
      guard let item = dataSource?.itemIdentifier(for: indexPath) else { return }
      let id = item.element.id
      
      if isMultiSelectable == false { selectedItemIds = [] }
      
      if selectedItemIds.contains(id) {
         selectedItemIds.remove(id)
      } else {
         selectedItemIds.update(with: id)
      }
   }
}
