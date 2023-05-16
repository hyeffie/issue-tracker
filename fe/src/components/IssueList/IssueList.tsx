import React from 'react';

import openedIssue from '@assets/openedIssue.svg';
import closedIssue from '@assets/closedIssue.svg';
import dropDownArrow from '@assets/dropDownArrow.svg';
import Issue from './Issue';
import Button from '@common/Button';

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
            <div className="mr-4">
              <input
                type="checkbox"
                checked={false}
                onChange={() => console.log('check')}
              />
            </div>
            <div className="flex ">
              <button className="mr-3 flex items-center font-bold text-neutral-strong">
                <img src={openedIssue} />
                <span className="ml-1">열린 이슈({countOpenedIssues})</span>
              </button>
              <button className="flex items-center text-neutral">
                <img src={closedIssue} />
                <span className="ml-1">닫힌 이슈({countClosedIssues})</span>
              </button>
            </div>
          </div>
          <div className="flex">
            {/* FIXME(Jayden): 추후 key값 고려해보기 */}
            {['담당자', '레이블', '마일스톤', '작성자'].map((title, i) => {
              return (
                <Button
                  key={i}
                  title={title}
                  onClick={() => console.log(`${title}!`)}
                  size="Small"
                  type="Ghost"
                  color="GrayLight"
                  hasDropDown={true}
                />
              );
            })}
          </div>
        </div>
      </div>
      {/* TODO(Lily): 구조분해할당 적용하기 */}
      {issues.length ? (
        issues.map(issue => (
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
        ))
      ) : (
        <div className="my-5 text-center text-neutral-weak">
          검색과 일치하는 결과가 없습니다.
        </div>
      )}
    </div>
  );
};

export default IssueList;
