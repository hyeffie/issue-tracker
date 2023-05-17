import React from 'react';

import Issue from './Issue';
import Button from '@common/Button';
import { ReactComponent as AlertCircle } from '@assets/alertCircle.svg';
import { ReactComponent as Archive } from '@assets/archive.svg';

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
}

const IssueList: React.FC<Props> = ({
  issues,
  countOpenedIssues,
  countClosedIssues,
  onIssueTitleClick,
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
                  color="Gray"
                  hasDropDown={true}
                  condition="Press"
                />
              );
            })}
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
