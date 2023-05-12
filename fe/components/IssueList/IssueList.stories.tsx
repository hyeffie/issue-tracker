import type { Meta, StoryObj } from '@storybook/react';

import IssueList from './IssueList';

const meta = {
  title: 'main/IssueList',
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
        profileUrl: 'image url',
        isOpen: true,
        createdAt: 'create date',
        closedAt: 'crate close',
        milestoneName: 'milestone name',
        labels: [
          {
            id: 20123,
            title: 'title',
            backgroundColor: 'red',
            fontColor: 'black',
          },
        ],
      },
      {
        id: 10,
        title: 'issue title',
        content: 'issue content',
        userName: 'user name',
        profileUrl: 'image url',
        isOpen: true,
        createdAt: 'create date',
        closedAt: 'crate close',
        milestoneName: 'milestone name',
        labels: [
          {
            id: 20123,
            title: 'title',
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
