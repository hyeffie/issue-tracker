import type { Meta, StoryObj } from '@storybook/react';

import IssueList from './IssueList';

const meta = {
  title: 'Main/IssueList',
  component: IssueList,
  argTypes: {},
} satisfies Meta<typeof IssueList>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    issues: [
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
    ],
    countOpenedIssues: 10,
    countClosedIssues: 20,
  },
};

export const Secondary: Story = {
  args: {
    issues: [],
    countOpenedIssues: 0,
    countClosedIssues: 0,
  },
};
