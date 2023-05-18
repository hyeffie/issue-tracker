import React, { useEffect, useState } from 'react';

import Header from '@components/Header/Header';
import FilterBar from '@components/FilterBar/FilterBar';
import NavLinks from '@components/NavLinks/NavLinks';
import Button from '@common/Button';
import IssueList from '@components/IssueList/IssueList';
import FilterList from '@components/FilterList/FilterList';

const MainPage = () => {
  // TODO: 올바른 타입 명시
  const [data, setData] = useState({} as any);
  const [isFilterOpen, setIsFilterOpen] = useState({
    filter: false,
    assignee: false,
    label: false,
    milestone: false,
    writer: false,
  });

  const handleClickFilter = (title: keyof typeof isFilterOpen) => {
    const newIsFilterOpen = { ...isFilterOpen };
    for (const key in newIsFilterOpen) {
      if (key === title) {
        newIsFilterOpen[key] = !newIsFilterOpen[key];
      } else {
        newIsFilterOpen[key as keyof typeof isFilterOpen] = false;
      }
    }

    setIsFilterOpen(newIsFilterOpen);
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await fetch('/issues');
        const data = await res.json();

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
        <FilterBar onClick={() => handleClickFilter('filter')} />
        {isFilterOpen.filter && (
          <FilterList
            title="이슈"
            items={[
              {
                id: 231,
                title: '열린 이슈',
              },
              {
                id: 131232,
                title: '내가 작성한 이슈',
              },
              {
                id: 1223,
                title: '나에게 할당된 이슈',
              },
              {
                id: 1223,
                title: '내가 댓글을 남긴 이슈',
              },
              {
                id: 1223,
                title: '닫힌 이슈',
              },
            ]}
            isNullAvailability={false}
            onClick={() => {
              console.log('test');
            }}
          />
        )}
        {/* FIXME: justify style check */}
        <div className="justify- flex gap-x-5">
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
          />
        </div>
      </div>
      <IssueList
        issues={data.issues}
        countOpenedIssues={data.countOpenedIssues}
        countClosedIssues={data.countOpenedIssues}
        onIssueTitleClick={() => console.log('onIssueTitleClick')}
      />
    </section>
  );
};

export default MainPage;
