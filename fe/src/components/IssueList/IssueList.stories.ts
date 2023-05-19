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
        elapseTime: {
          days: 12,
          hours: 2,
          minutes: 49,
          seconds: 22,
        },
        milestoneName: 'milestone name',
        labels: [
          {
            labelId: 20123,
            labelName: 'title',
            backgroundColor: 'tomato',
            fontColor: 'black',
          },
          {
            labelId: 20123,
            labelName: 'document',
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
        elapseTime: {
          days: 12,
          hours: 2,
          minutes: 49,
          seconds: 22,
        },
        milestoneName: 'milestone name',
        labels: [
          {
            labelId: 20123,
            labelName: 'Jayden',
            backgroundColor: 'orange',
            fontColor: 'black',
          },
          {
            labelId: 20123,
            labelName: 'Lily',
            backgroundColor: 'pink',
            fontColor: 'black',
          },
          {
            labelId: 20123,
            labelName: 'FE',
            backgroundColor: 'red',
            fontColor: 'black',
          },
        ],
      },
    ],
    countOpenedIssues: 10,
    countClosedIssues: 20,
    isDropdownOpen: {
      filter: false,
      assignee: false,
      label: false,
      milestone: false,
      writer: false,
    },
    status: true,
  },
};

export const Secondary: Story = {
  args: {
    issues: [],
    countOpenedIssues: 0,
    countClosedIssues: 0,
    isDropdownOpen: {
      filter: false,
      assignee: false,
      label: false,
      milestone: false,
      writer: false,
    },
    status: true,
  },
};
