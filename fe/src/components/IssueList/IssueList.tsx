import React from 'react';

import Issue from './Issue';
import Button from '@common/Button';

import { DropdownItems } from '../../pages/MainPage';
import FilterList from '@components/FilterList/FilterList';

export interface LabelRow {
  labelId: number;
  labelName: string;
  backgroundColor: string;
  fontColor: string;
}

export interface IssueRow {
  issueId: number;
  title: string;
  content: string;
  userName: string;
  profileUrl: string;
  isOpen: boolean;
  createdAt: string;
  closedAt?: string;
  milestoneName?: string;
  labelList: LabelRow[];
}

export interface UserRow {
  userId: number;
  userName: string;
  profileUrl: string;
}
export interface MilestoneRow {
  milestoneId: number;
  milestoneName: string;
  description: string;
}

interface Props {
  issues: IssueRow[];
  users: UserRow[];
  labels: LabelRow[];
  milestones: MilestoneRow[];
  countOpenedIssues: number;
  countClosedIssues: number;
  onIssueTitleClick: () => void;
  isDropdownOpen?: DropdownItems;
  onDropdownTitleClick?: (title: keyof DropdownItems) => void;
}

const IssueList: React.FC<Props> = ({
  issues,
  users,
  labels,
  milestones,
  countOpenedIssues,
  countClosedIssues,
  onIssueTitleClick,
  isDropdownOpen,
  onDropdownTitleClick,
}) => {
  return (
    <div className="w-160 box-border rounded-2xl border">
      <div className="box-border rounded-t-2xl bg-gray-100 px-6 py-4">
        <div className="flex justify-between">
          <div className="flex items-center">
            <div className="mr-8">
              <input
                type="checkbox"
                checked={false}
                onChange={() => console.log('check')}
              />
            </div>
            <div className="flex">
              <Button
                title={`열린 이슈(${countOpenedIssues})`}
                onClick={() => console.log('열린 이슈')}
                type="Ghost"
                color="Gray"
                size="Small"
                iconName="alertcircle"
                condition="Enabled"
              />
              <Button
                title={`닫힌 이슈(${countClosedIssues})`}
                onClick={() => console.log('닫힌 이슈')}
                type="Ghost"
                color="Gray"
                size="Small"
                iconName="archive"
                condition="Press"
              />
            </div>
          </div>
          <div className="flex justify-end gap-6">
            {/* FIXME(Jayden): 추후 key값 고려해보기 */}
            <div className="relative">
              <Button
                title="담당자"
                onClick={() => onDropdownTitleClick!('assignee')}
                type="Ghost"
                color="Gray"
                hasDropDown={true}
                condition="Press"
                isFlexible={true}
              />
              {isDropdownOpen!.assignee && (
                <FilterList
                  title="담당자"
                  items={users.map(user => {
                    return {
                      id: user.userId,
                      title: user.userName,
                      imgUrl: user.profileUrl,
                    };
                  })}
                  isNullAvailability={true}
                  onClick={() => {
                    console.log('test');
                  }}
                />
              )}
            </div>
            <div className="relative">
              <Button
                title="레이블"
                onClick={() => onDropdownTitleClick!('label')}
                type="Ghost"
                color="Gray"
                hasDropDown={true}
                condition="Press"
                isFlexible={true}
              />
              {isDropdownOpen!.label && (
                <FilterList
                  title="레이블"
                  items={labels.map(label => {
                    return {
                      id: label.labelId,
                      title: label.labelName,
                      backgroundColor: label.backgroundColor,
                      fontColor: label.fontColor,
                    };
                  })}
                  isNullAvailability={true}
                  onClick={() => {
                    console.log('test');
                  }}
                />
              )}
            </div>
            <div className="relative">
              <Button
                title="마일스톤"
                onClick={() => onDropdownTitleClick!('milestone')}
                type="Ghost"
                color="Gray"
                hasDropDown={true}
                condition="Press"
                isFlexible={true}
              />
              {isDropdownOpen!.milestone && (
                <FilterList
                  title="마일스톤"
                  items={milestones.map(milestone => {
                    return {
                      id: milestone.milestoneId,
                      title: milestone.milestoneName,
                    };
                  })}
                  onClick={() => {
                    console.log('test');
                  }}
                />
              )}
            </div>
            <div className="relative">
              <Button
                title="작성자"
                onClick={() => onDropdownTitleClick!('writer')}
                type="Ghost"
                color="Gray"
                hasDropDown={true}
                condition="Press"
                isFlexible={true}
              />
              {isDropdownOpen!.writer && (
                <FilterList
                  title="작성자"
                  items={users.map(user => {
                    return {
                      id: user.userId,
                      title: user.userName,
                      imgUrl: user.profileUrl,
                    };
                  })}
                  isNullAvailability={false}
                  onClick={() => {
                    console.log('test');
                  }}
                />
              )}
            </div>
          </div>
        </div>
      </div>
      {/* TODO: 이슈의 존재 유무에 따른 분기 처리 */}
      {issues ? (
        issues.map(issue => {
          const {
            issueId,
            title,
            userName,
            profileUrl,
            isOpen,
            createdAt,
            closedAt,
            milestoneName,
            labelList,
          } = issue;
          return (
            <Issue
              key={issueId}
              issueId={issueId}
              title={title}
              userName={userName}
              profileUrl={profileUrl}
              isOpen={isOpen}
              createdAt={createdAt}
              closedAt={closedAt}
              milestoneName={milestoneName}
              labelList={labelList}
              onIssueTitleClick={onIssueTitleClick}
            />
          );
        })
      ) : (
        <div className="my-5 text-center text-neutral-weak">
          검색과 일치하는 결과가 없습니다.
        </div>
      )}
    </div>
  );
};

export default IssueList;
