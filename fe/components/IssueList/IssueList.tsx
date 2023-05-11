import React from 'react';

import Issue from './Issue';

import dropDownArrow from '../../asset/dropDownArrow.svg';
import openedIssue from '../../asset/openedIssue.svg';
import closedIssue from '../../asset/closedIssue.svg';

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
    <div className="w-160 border box-border rounded-2xl">
      <div className="w-160 px-8 py-6 bg-light-mode border-b rounded-t-2xl box-border">
        <div className="flex justify-between">
          <div className="flex ">
            <div>{/* TODO(Lily): add check box */}c</div>
            <div className="flex">
              <button className="mr-4">{/* TODO(Lily): add icon */}</button>
              <div className="flex mr-3 text-neutral-strong font-bold">
                <img src={openedIssue} />
                <span className="ml-1">열린 이슈({countOpenedIssues})</span>
              </div>
            </div>
            <div className="flex">
              <button>{/* TODO(Lily): add icon */}</button>
              <div className="flex text-neutral">
                <img src={closedIssue} />
                <span className="ml-1">닫힌 이슈({countClosedIssues})</span>
              </div>
            </div>
          </div>
          <div className="flex">
            <button className="flex items-center mr-4 text-neutral-week font-bold">
              <span className="mr-1.5">담당자</span>
              <img src={dropDownArrow} />
            </button>
            <button className="flex items-center mr-4 text-neutral-week font-bold">
              <span className="mr-1.5">레이블</span>
              <img src={dropDownArrow} />
            </button>
            <button className="flex items-center mr-4 text-neutral-week font-bold">
              <span className="mr-1.5">마일스톤</span>
              <img src={dropDownArrow} />
            </button>
            <button className="flex items-center text-neutral-week font-bold">
              <span className="mr-1.5">작성자</span>
              <img src={dropDownArrow} />
            </button>
          </div>
        </div>
      </div>
      {issues.map(issue => (
        <Issue
          key={issue.id}
          id={issue.id}
          title={issue.title}
          userName={issue.userName}
          profileUrl={issue.profileUrl}
          isOpen={issue.isOpen}
          createdAt={issue.createdAt}
          closedAt={issue.closedAt}
          milestoneName={issue.milestoneName}
          labels={issue.labels}
          onIssueTitleClick={onIssueTitleClick}
        />
      ))}
    </div>
  );
};

export default IssueList;
