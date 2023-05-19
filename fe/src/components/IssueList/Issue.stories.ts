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
    issueId: 10,
    title: 'issue title',
    userName: 'lily',
    profileUrl:
      'https://lh3.googleusercontent.com/ogw/AOLn63F6B2eAe4HzDtvFPJU2zTjgdOtSHvHt-FnbIYcYgqU=s64-c-mo',
    isOpen: true,
    elapseTime: {
      days: 12,
      hours: 2,
      minutes: 49,
      seconds: 22,
    },
    milestoneName: 'milestone',
    labelList: [],
  },
};

export const Secondary: Story = {
  args: {
    issueId: 10,
    title:
      '글자가 길어지면 어떻게 될까요오오오오오오오오오오오오오오오오오오오오오오오오오오오오오오오오오오오오',
    userName: 'lily',
    profileUrl:
      'https://lh3.googleusercontent.com/ogw/AOLn63F6B2eAe4HzDtvFPJU2zTjgdOtSHvHt-FnbIYcYgqU=s64-c-mo',
    isOpen: true,
    elapseTime: {
      days: 12,
      hours: 2,
      minutes: 49,
      seconds: 22,
    },
    milestoneName: 'milestone',
    labelList: [
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
    ],
  },
};
