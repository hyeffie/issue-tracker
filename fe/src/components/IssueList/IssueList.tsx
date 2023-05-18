import React from 'react';

import Issue from './Issue';
import Button from '@common/Button';

import { DropdownItems } from '../../pages/MainPage';
import FilterList from '@components/FilterList/FilterList';

export interface LabelRow {
  id: number;
  title: string;
  backgroundColor: string;
  fontColor: string;
}

export interface IssueRow {
  id: number;
  title: string;
  content: string;
  userName: string;
  profileUrl: string;
  isOpen: boolean;
  createdAt: string;
  closedAt?: string;
  milestoneName: string;
  labels: LabelRow[];
}

interface Props {
  issues: IssueRow[];
  countOpenedIssues: number;
  countClosedIssues: number;
  onIssueTitleClick: () => void;
  isDropdownOpen?: DropdownItems;
  onDropdownTitleClick?: (title: keyof DropdownItems) => void;
}

const IssueList: React.FC<Props> = ({
  issues,
  countOpenedIssues,
  countClosedIssues,
  onIssueTitleClick,
  isDropdownOpen,
  onDropdownTitleClick,
}) => {
  return (
    <div className="w-160 box-border rounded-2xl border">
      <div className="box-border rounded-t-2xl bg-gray-100 px-8 py-4">
        <div className="flex justify-between">
          <div className="flex items-center">
            <div className="mr-8">
              <input
                type="checkbox"
                checked={false}
                onChange={() => console.log('check')}
              />
            </div>
            <div className="flex gap-x-3">
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
                  items={[
                    {
                      id: 0,
                      title: 'chloe',
                    },
                    {
                      id: 1,
                      title: 'lily',
                    },
                    {
                      id: 2,
                      title: 'jayden',
                    },
                    {
                      id: 3,
                      title: 'wood',
                    },
                    {
                      id: 4,
                      title: 'poro',
                    },
                  ]}
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
                  items={[
                    {
                      id: 0,
                      title: 'documentation',
                    },
                    {
                      id: 1,
                      title: 'bug',
                    },
                  ]}
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
                  items={[
                    {
                      id: 0,
                      title: '[FE]w01',
                    },
                    {
                      id: 1,
                      title: '[BE]w01',
                    },
                    {
                      id: 2,
                      title: '[iOS]w01',
                    },
                  ]}
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
                  items={[
                    {
                      id: 0,
                      title: 'luke',
                    },
                    {
                      id: 1,
                      title: 'effie',
                    },
                  ]}
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
            id,
            title,
            userName,
            profileUrl,
            isOpen,
            createdAt,
            closedAt,
            milestoneName,
            labels,
          } = issue;
          return (
            <Issue
              key={id}
              id={id}
              title={title}
              userName={userName}
              profileUrl={profileUrl}
              isOpen={isOpen}
              createdAt={createdAt}
              closedAt={closedAt}
              milestoneName={milestoneName}
              labels={labels}
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
