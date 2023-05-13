import type { Meta, StoryObj } from '@storybook/react';

import Issue from './Issue';

const meta = {
  title: 'Main/Issue',
  component: Issue,
} satisfies Meta<typeof Issue>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    id: 10,
    title: 'issue title',
    userName: 'lily',
    profileUrl: 'url',
    isOpen: true,
    createdAt: 'time',
    closedAt: 'time',
    milestoneName: 'milestone',
    labels: [],
  },
};

export const Secondary: Story = {
  args: {
    id: 10,
    title:
      '글자가 길어지면 어떻게 될까요오오오오오오오오오오오오오오오오오오오오오오오오오오오오오오오오오오오오',
    userName: 'lily',
    profileUrl: 'url',
    isOpen: true,
    createdAt: 'time',
    closedAt: 'time',
    milestoneName: 'milestone',
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
    ],
  },
};
