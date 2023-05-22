import React from 'react';

import Profile from '@common/Profile';
import Label from '@common/Label';
import { LabelRow, elapseTime } from './IssueList';
import { ReactComponent as AlertCircle } from '@assets/alertCircle.svg';
import { ReactComponent as Archive } from '@assets/archive.svg';
import { ReactComponent as Milestone } from '@assets/milestone.svg';

interface Props {
  issueId: number;
  title: string;
  userName: string;
  profileUrl: string;
  isOpen: boolean;
  labelList: LabelRow[];
  elapseTime: elapseTime;
  milestoneName?: string;
  onIssueTitleClick: (id: number) => void;
}

const Issue: React.FC<Props> = ({
  issueId,
  title,
  userName,
  profileUrl,
  isOpen,
  elapseTime,
  milestoneName,
  labelList,
  onIssueTitleClick,
}) => {
  const { days, hours, minutes } = elapseTime;
  const elapsedMessage = isOpen
    ? `${days !== 0 ? `${days}일 ` : ''}${hours !== 0 ? `${hours}시간 ` : ''}${
        minutes !== 0 ? `${minutes}분 ` : ''
      }전, ${userName}님에 의해 작성되었습니다.`
    : `${days !== 0 ? `${days}일 ` : ''}${
        hours !== 0 ? `${hours}시간 ` : ''
      } ${minutes}분 전, ${userName}님에 의해 닫혔습니다.`;

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
            onClick={() => onIssueTitleClick(issueId)}
          >
            {title}
          </button>
          <div className="flex">
            {labelList.map(label => {
              const { labelId, labelName, backgroundColor, fontColor } = label;
              return (
                <Label
                  key={labelId}
                  labelName={labelName}
                  backgroundColor={backgroundColor}
                  fontColor={fontColor}
                />
              );
            })}
          </div>
        </div>
        {/* TODO: issue info 세로 가운데 정렬 */}
        <div className="flex">
          <span className="mr-4 text-gray-600">#{issueId}</span>
          <span className="mr-4 text-gray-600">{elapsedMessage}</span>
          {milestoneName && (
            <div className="flex items-center">
              <Milestone fill="#6E7191" />
              <span className="ml-2 text-gray-600">{milestoneName}</span>
            </div>
          )}
        </div>
      </div>
      {/* FIXME(Jayden): Profile 태그의 상위 태그의 높이가 고정 */}
      <div className="flex grow items-center justify-end">
        <Profile url={profileUrl} width={20} height={20} />
      </div>
    </div>
  );
};

export default Issue;
