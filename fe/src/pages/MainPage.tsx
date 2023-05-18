import React, { useEffect, useState } from 'react';

import Header from '@components/Header/Header';
import FilterBar from '@components/FilterBar/FilterBar';
import NavLinks from '@components/NavLinks/NavLinks';
import Button from '@common/Button';
import IssueList from '@components/IssueList/IssueList';
import FilterList from '@components/FilterList/FilterList';

export type DropdownItems = {
  filter: boolean;
  assignee: boolean;
  label: boolean;
  milestone: boolean;
  writer: boolean;
};

const issueDropdownList = [
  {
    id: 0,
    title: '열린 이슈',
  },
  {
    id: 1,
    title: '내가 작성한 이슈',
  },
  {
    id: 2,
    title: '나에게 할당된 이슈',
  },
  {
    id: 3,
    title: '내가 댓글을 남긴 이슈',
  },
  {
    id: 4,
    title: '닫힌 이슈',
  },
];

const MainPage = () => {
  // TODO: 올바른 타입 명시
  const [data, setData] = useState({} as any);
  const [isDropdownOpen, setIsDropdownOpen] = useState({
    filter: false,
    assignee: false,
    label: false,
    milestone: false,
    writer: false,
  });

  const handleClickDropdown = (title: keyof typeof isDropdownOpen) => {
    const newIsDropdownOpen = { ...isDropdownOpen };
    for (const key in newIsDropdownOpen) {
      if (key === title) {
        newIsDropdownOpen[key] = !newIsDropdownOpen[key];
      } else {
        newIsDropdownOpen[key as keyof typeof isDropdownOpen] = false;
      }
    }
    setIsDropdownOpen(newIsDropdownOpen);
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await fetch('http://43.200.199.205:8080/api/');

        const data = await res.json();
        console.log(data);
        if (res.status === 200) {
          setData(data);
        }
      } catch (error) {
        console.log(error);
      }
    };

    fetchData();
  }, []);

  return (
    <section className="mx-10 my-[27px]">
      {/* ref: https://ko.javascript.info/optional-chaining */}
      <Header url={data.user?.profileUrl} />
      <div className="relative mb-6 flex justify-between">
        <FilterBar onClick={() => handleClickDropdown('filter')} />
        {isDropdownOpen.filter && (
          <FilterList
            title="이슈"
            items={issueDropdownList}
            isNullAvailability={false}
            onClick={() => {
              console.log('test');
            }}
          />
        )}
        {/* FIXME: justify style check */}
        <div className="flex gap-x-5">
          <NavLinks
            countAllMilestones={data.countAllMilestones}
            countAllLabels={data.countAllLabels}
          />
          <Button
            title={'이슈 작성'}
            onClick={() => {
              console.log('test');
            }}
            size={'Small'}
            iconName="plus"
          />
        </div>
      </div>
      <IssueList
        issues={data.issues}
        countOpenedIssues={data.countOpenedIssues}
        countClosedIssues={data.countClosedIssues}
        onIssueTitleClick={() => console.log('onIssueTitleClick')}
        isDropdownOpen={isDropdownOpen}
        onDropdownTitleClick={handleClickDropdown}
      />
    </section>
  );
};

export default MainPage;
