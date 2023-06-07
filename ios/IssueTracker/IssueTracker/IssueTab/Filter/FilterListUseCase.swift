//
//  FilterListUseCase.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/28.
//

import Foundation

class FilterListUseCase {
   private var filterList: IssueFilterList
   private var countAllHeaders: Int
   private var countAllStatus: Int
   private var countAllUsers: Int
   private var countAllLabels: Int
   private var countAllMilestones: Int
   
   init(filterList: IssueFilterList) {
      self.filterList = filterList
      self.countAllHeaders = filterList.headerList.count
      self.countAllStatus = 4
      self.countAllUsers = filterList.userList.count
      self.countAllLabels = filterList.labelList.count
      self.countAllMilestones = filterList.milestoneList.count
   }
   
   func sendHeaderCount() -> Int {
      countAllHeaders
   }
   
   func sendHeaderName(section: Int) -> String {
      return self.filterList.headerList[section]
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
   
   func sendItemId(section: Int, index: Int) -> Int {
      switch section {
      case 0:
         guard index < 3 else { return 1 }
         return 0
      case 1:
         return self.filterList.userList[index].userId
      case 2:
         return self.filterList.labelList[index].labelId
      default:
         return self.filterList.milestoneList[index].milestoneId
      }
   }
}
