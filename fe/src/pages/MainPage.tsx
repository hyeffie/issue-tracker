import React from 'react';

import Header from '@components/Header/Header';
import FilterBar from '@components/FilterBar/FilterBar';
import NavLinks from '@components/NavLinks/NavLinks';
import IssueList from '@components/IssueList/IssueList';

const MainPage = () => {
  return (
    <section>
      <Header
        url={
          'https://images.unsplash.com/photo-1600354587397-681c16c184bf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80'
        }
      />
      <div>
        <FilterBar />
        <NavLinks countAllMilestones={12} countAllLabels={123} />
      </div>
      <IssueList
        issues={[
          {
            id: 10,
            title: 'issue title',
            content: 'issue content',
            userName: 'user name',
            profileUrl:
              'https://lh3.googleusercontent.com/ogw/AOLn63F6B2eAe4HzDtvFPJU2zTjgdOtSHvHt-FnbIYcYgqU=s64-c-mo',
            isOpen: true,
            createdAt: 'create date',
            closedAt: 'crate close',
            milestoneName: 'milestone name',
            labels: [
              {
                id: 20123,
                title: 'title',
                backgroundColor: 'tomato',
                fontColor: 'black',
              },
              {
                id: 20123,
                title: 'document',
                backgroundColor: 'blue',
                fontColor: 'black',
              },
            ],
          },
          {
            id: 10,
            title: 'issue title',
            content: 'issue content',
            userName: 'user name',
            profileUrl:
              'https://lh3.googleusercontent.com/ogw/AOLn63F6B2eAe4HzDtvFPJU2zTjgdOtSHvHt-FnbIYcYgqU=s64-c-mo',
            isOpen: true,
            createdAt: 'create date',
            closedAt: 'crate close',
            milestoneName: 'milestone name',
            labels: [
              {
                id: 20123,
                title: 'Jayden',
                backgroundColor: 'orange',
                fontColor: 'black',
              },
              {
                id: 20123,
                title: 'Lily',
                backgroundColor: 'pink',
                fontColor: 'black',
              },
              {
                id: 20123,
                title: 'FE',
                backgroundColor: 'red',
                fontColor: 'black',
              },
            ],
          },
        ]}
        countOpenedIssues={10}
        countClosedIssues={20}
        onIssueTitleClick={() => console.log('onIssueTitleClick')}
      />
    </section>
  );
};

export default MainPage;
