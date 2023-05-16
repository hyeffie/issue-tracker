import React from 'react';

import openedIssue from '@assets/openedIssue.svg';
import closedIssue from '@assets/closedIssue.svg';
import milestone from '@assets/milestone.svg';
import Profile from '@common/Profile';
import Label from '@common/Label';
import { LabelRow } from './IssueList';

console.log(openedIssue);
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
  onIssueTitleClick: (id: number) => void;
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
    <div className="flex border-t px-8 py-4">
      <div className="mr-4">{/* TODO(Lily): add check box */}c</div>
      <div>
        <div className="mb-1 flex">
          {isOpen ? (
            <img className="mr-1" src={openedIssue} />
          ) : (
            <img className="mr-1" src={closedIssue} />
          )}
          {/* TODO(Lily): 라우터 설치 및 설정 이후에 Link 태그로 바꾸기 */}
          <button
            className="mr-1 text-lg font-bold text-neutral-strong"
            onClick={() => onIssueTitleClick(id)}
          >
            {title}
          </button>
          {labels.map(label => (
            <Label
              key={label.id}
              labelName={label.title}
              backgroundColor={label.backgroundColor}
              fontColor={label.fontColor}
            />
          ))}
        </div>
        <div className="flex">
          <span className="mr-2 text-neutral-weak">#{id}</span>
          <span className="mr-2 text-neutral-weak">
            {/* TODO(Lily): 경과 시간 계산은 위에서 하고 계산 된 값을 props로 받아서 처리하기 */}
            {isOpen
              ? `이 이슈가 ${createdAt}분 전, ${userName}님에 의해 작성되었습니다.`
              : `이 이슈가 ${closedAt}분 전, ${userName}에 의해 닫혔습니다.`}
          </span>
          <div className="flex">
            <img className="mr-1" src={milestone} />
            <span className="text-neutral-weak">{milestoneName}</span>
          </div>
        </div>
      </div>
      {/* FIXME(Jayden): Profile 태그의 상위 태그의 높이가 고정 */}
      <div className="flex h-5 w-5 grow justify-end self-center">
        <Profile url={profileUrl} />
      </div>
    </div>
  );
};

export default Issue;
