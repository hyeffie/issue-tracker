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
