import React from 'react';

import Profile from '@common/Profile';
import Label from '@common/Label';
import { LabelRow } from './IssueList';

import { ReactComponent as AlertCircle } from '@assets/alertCircle.svg';
import { ReactComponent as Archive } from '@assets/archive.svg';
import { ReactComponent as Milestone } from '@assets/milestone.svg';

interface Props {
  id: number;
  title: string;
  userName: string;
  profileUrl: string;
  isOpen: boolean;
  createdAt: string;
  closedAt?: string;
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
      <div className="mr-8 mt-2">
        <input
          type="checkbox"
          checked={false}
          onChange={() => console.log('check')}
        />
      </div>
      <div>
        <div className="mb-1 flex items-center">
          {isOpen ? (
            <AlertCircle stroke="#007AFF" />
          ) : (
            <Archive stroke="#4E4B66" />
          )}
          {/* TODO(Lily): 라우터 설치 및 설정 이후에 Link 태그로 바꾸기 */}
          <button
            className="mx-2 text-left text-lg font-bold text-neutral-strong"
            onClick={() => onIssueTitleClick(id)}
          >
            {title}
          </button>
          <div className="flex">
            {labels.map(label => {
              const { id, title, backgroundColor, fontColor } = label;
              return (
                <Label
                  key={id}
                  labelName={title}
                  backgroundColor={backgroundColor}
                  fontColor={fontColor}
                />
              );
            })}
          </div>
        </div>
        {/* TODO: issue info 세로 가운데 정렬 */}
        <div className="flex">
          <span className="mr-2 text-gray-600">#{id}</span>
          <span className="mr-2 text-gray-600">
            {/* TODO(Lily): 경과 시간 계산은 위에서 하고 계산 된 값을 props로 받아서 처리하기 */}
            {isOpen
              ? `이 이슈가 ${createdAt}분 전, ${userName}님에 의해 작성되었습니다.`
              : `이 이슈가 ${closedAt}분 전, ${userName}에 의해 닫혔습니다.`}
          </span>
          <div className="flex items-center">
            <Milestone fill="#6E7191" />
            <span className="ml-2 text-gray-600">{milestoneName}</span>
          </div>
        </div>
      </div>
      {/* FIXME(Jayden): Profile 태그의 상위 태그의 높이가 고정 */}
      <div className="flex h-16 w-16 grow items-center justify-end">
        <Profile url={profileUrl} width={20} height={20} />
      </div>
    </div>
  );
};

export default Issue;
