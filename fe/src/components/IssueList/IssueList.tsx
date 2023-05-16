import React from 'react';

import Issue from './Issue';

import dropDownArrow from '@assets/dropDownArrow.svg';
import { ReactComponent as OpenedIssue } from '@assets/openedIssue.svg';
import { ReactComponent as ClosedIssue } from '@assets/closedIssue.svg';
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
  closedAt: string;
  milestoneName: string;
  labels: LabelRow[];
}

interface Props {
  issues: IssueRow[];
  countOpenedIssues: number;
  countClosedIssues: number;
  onIssueTitleClick: () => void;
}

const IssueList: React.FC<Props> = ({
  issues,
  countOpenedIssues,
  countClosedIssues,
  onIssueTitleClick,
}) => {
  return (
    <div className="w-160 box-border rounded-2xl border">
      <div className="w-160 box-border rounded-t-2xl bg-light-mode px-8 py-6">
        <div className="flex justify-between">
          <div className="flex ">
            <div className="mr-8">
              <input
                type="checkbox"
                checked={false}
                onChange={() => console.log('check')}
              />
            </div>
            <div className="flex ">
              <button className="mr-3 flex items-center font-bold text-neutral-strong">
                <OpenedIssue stroke="#14142B" />
                <span className="ml-1">열린 이슈({countOpenedIssues})</span>
              </button>
              <button className="flex items-center text-neutral">
                <ClosedIssue stroke="#4E4B66" />
                <span className="ml-1">닫힌 이슈({countClosedIssues})</span>
              </button>
            </div>
          </div>
          <div className="flex">
            <button className="mr-8 flex items-center font-bold text-neutral-weak">
              <span className="mr-2">담당자</span>
              <img src={dropDownArrow} />
            </button>
            <button className="mr-8 flex items-center font-bold text-neutral-weak">
              <span className="mr-2">레이블</span>
              <img src={dropDownArrow} />
            </button>
            <button className="mr-8 flex items-center font-bold text-neutral-weak">
              <span className="mr-2">마일스톤</span>
              <img src={dropDownArrow} />
            </button>
            <button className="flex items-center font-bold text-neutral-weak">
              <span className="mr-2">작성자</span>
              <img src={dropDownArrow} />
            </button>
          </div>
        </div>
      </div>
      {issues.length ? (
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
