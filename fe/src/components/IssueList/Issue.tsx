import React from 'react';

import { LabelRow } from './IssueList';
import Profile from '../../common/Profile';
import Label from '../../common/Label';

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
    <div className="flex px-8 py-4 border-t">
      <div className="mr-4">{/* TODO(Lily): add check box */}c</div>
      <div>
        <div className="flex mb-1">
          {isOpen ? (
            <img className="mr-1" src="assets/openedIssue.svg" />
          ) : (
            <img className="mr-1" src="assets/closedIssue.svg" />
          )}
          {/* TODO(Lily): 라우터 설치 및 설정 이후에 Link 태그로 바꾸기 */}
          <button
            className="mr-1 text-lg text-neutral-strong font-bold"
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
            <img className="mr-1" src="assets/milestone.svg" />
            <span className="text-neutral-weak">{milestoneName}</span>
          </div>
        </div>
      </div>
      <div className="w-5 h-5 flex grow justify-end self-center">
        <Profile url={profileUrl} />
      </div>
    </div>
  );
};

export default Issue;
