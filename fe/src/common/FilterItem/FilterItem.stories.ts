import type { Meta, StoryObj } from '@storybook/react';
import FilterItem from './FilterItem';

const meta = {
  title: 'Main/FilterItem',
  component: FilterItem,
} satisfies Meta<typeof FilterItem>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    imgUrl:
      'https://lh3.googleusercontent.com/ogw/AOLn63F6B2eAe4HzDtvFPJU2zTjgdOtSHvHt-FnbIYcYgqU=s64-c-mo',
    title: 'Lily',
    width: 20,
    height: 20,
  },
};

export const Secondary: Story = {
  args: {
    title: '열린이슈',
    bold: true,
    imgUrl: 'assets/openedIssue.svg',
    width: 16,
    height: 16,
  },
};

export const noImageUrl: Story = {
  args: {
    imgUrl: '',
    title: 'assignee',
  },
};
