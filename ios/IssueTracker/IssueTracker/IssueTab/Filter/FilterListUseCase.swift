//
//  FilterListUseCase.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/28.
//

import Foundation

class FilterListUseCase {
   private var filterList: IssueFilterList
   var countAllStatus: Int
   var countAllUsers: Int
   var countAllLabels: Int
   var countAllMilestones: Int
   
   init(filterList: IssueFilterList) {
      self.filterList = filterList
      self.countAllStatus = 4
      self.countAllUsers = filterList.userList.count
      self.countAllLabels = filterList.labelList.count
      self.countAllMilestones = filterList.milestoneList.count
   }
   
   func sendCount(section: Int) -> Int {
      switch section {
      case 0:
         return self.countAllStatus
      case 1:
         return self.countAllUsers
      case 2:
         return self.countAllLabels
      default:
         return self.countAllMilestones
      }
   }
   
   func sendItemName(section: Int, index: Int) -> String {
      switch section {
      case 0:
         return self.filterList.statusList[index]
      case 1:
         return self.filterList.userList[index].userName
      case 2:
         return self.filterList.labelList[index].labelName
      default:
         return self.filterList.milestoneList[index].milestoneName ?? ""
      }
   }
}
