import React from 'react';

import { LabelRow } from './IssueList';
interface Props {
  id: number;
  title: string;
  userName: string;
  profileUrl: string;
  isOpen: boolean;
  createdAt: string;
  closedAt: string;
  milestoneName: string;
  labels: LabelRow[];
  onIssueTitleClick: () => void;
}

const Issue: React.FC<Props> = ({
  id,
  title,
  userName,
  profileUrl,
  isOpen,
  createdAt,
  closedAt,
  milestoneName,
  labels,
  onIssueTitleClick,
}) => {
  return (
    <div className="flex px-8 py-4">
      <div className="mr-4">{/* TODO(Lily): add check box */}c</div>
      <div>
        <div className="flex mb-1">
          {isOpen && <img className="mr-1" src="assets/openedIssue.svg" />}
          <button
            className="mr-1 text-lg text-neutral-strong font-bold"
            onClick={onIssueTitleClick}
          >
            {title}
          </button>
          {labels.map(label => (
            // TODO(Lily): add Label component instead of image
            <img key={id} className="mr-1" src={label.title} />
          ))}
        </div>
        <div className="flex">
          <span className="mr-2 text-neutral-week">이슈 번호</span>
          <span className="mr-2 text-neutral-week">
            {/* TODO(Lily): To replace with a function that calculates the time */}
            이 이슈가 {isOpen ? createdAt : closedAt}분 전, {userName}님에 의해
            작성되었습니다.
          </span>
          <div className="flex">
            <img className="mr-1" src="assets/milestone.svg" />
            <span className="text-neutral-week">{milestoneName}</span>
          </div>
        </div>
      </div>
      <div className="w-5 h-5 flex grow justify-end self-center">
        <img src={profileUrl} />
      </div>
    </div>
  );
};

export default Issue;
