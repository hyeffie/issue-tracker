import React, { useEffect, useState } from 'react';

import Header from '@components/Header/Header';
import FilterBar from '@components/FilterBar/FilterBar';
import NavLinks from '@components/NavLinks/NavLinks';
import Button from '@common/Button';
import IssueList from '@components/IssueList/IssueList';

const MainPage = () => {
  // TODO: 올바른 타입 명시
  const [data, setData] = useState({} as any);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await fetch('/issues');
        const data = await res.json();

        console.log(data.user);
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
      <div className="mb-6 flex justify-between">
        <FilterBar />
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
