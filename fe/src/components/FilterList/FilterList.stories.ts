import type { Meta, StoryObj } from '@storybook/react';
import FilterList from './FilterList';

const meta = {
  title: 'Common/FilterList',
  component: FilterList,
} satisfies Meta<typeof FilterList>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    title: '이슈',
    items: [
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
    ],
    isNullAvailability: false,
  },
};

export const Assignee: Story = {
  args: {
    title: '담당자',
    items: [
      {
        id: 231,
        title: 'Jayden',
        imgUrl:
          'https://lh3.googleusercontent.com/ogw/AOLn63F6B2eAe4HzDtvFPJU2zTjgdOtSHvHt-FnbIYcYgqU=s64-c-mo',
      },
      {
        id: 131232,
        title: 'Chloe',
        imgUrl:
          'https://lh3.googleusercontent.com/ogw/AOLn63F6B2eAe4HzDtvFPJU2zTjgdOtSHvHt-FnbIYcYgqU=s64-c-mo',
      },
      {
        id: 1223,
        title: 'sam',
        imgUrl:
          'https://lh3.googleusercontent.com/ogw/AOLn63F6B2eAe4HzDtvFPJU2zTjgdOtSHvHt-FnbIYcYgqU=s64-c-mo',
      },
      {
        id: 1223,
        title: 'Lily',
        imgUrl:
          'https://lh3.googleusercontent.com/ogw/AOLn63F6B2eAe4HzDtvFPJU2zTjgdOtSHvHt-FnbIYcYgqU=s64-c-mo',
      },
      {
        id: 1223,
        title: 'zello',
        imgUrl:
          'https://lh3.googleusercontent.com/ogw/AOLn63F6B2eAe4HzDtvFPJU2zTjgdOtSHvHt-FnbIYcYgqU=s64-c-mo',
      },
    ],
    isNullAvailability: true,
  },
};

export const Label: Story = {
  args: {
    title: '레이블',
    items: [
      {
        id: 231,
        title: 'documentation',
        imgUrl:
          'https://lh3.googleusercontent.com/ogw/AOLn63F6B2eAe4HzDtvFPJU2zTjgdOtSHvHt-FnbIYcYgqU=s64-c-mo',
      },
      {
        id: 131232,
        title: 'bug',
        imgUrl:
          'https://lh3.googleusercontent.com/ogw/AOLn63F6B2eAe4HzDtvFPJU2zTjgdOtSHvHt-FnbIYcYgqU=s64-c-mo',
      },
    ],
    isNullAvailability: true,
  },
};

export const Milestone: Story = {
  args: {
    title: '마일스톤',
    items: [
      {
        id: 231,
        title: '그룹프로젝트: 이슈트래커',
      },
    ],
    isNullAvailability: true,
  },
};

export const NoMultipleItems: Story = {
  args: {
    title: '상태 변경',
    items: [
      {
        id: 231,
        title: '선택한 이슈 열기',
      },
      {
        id: 231,
        title: '선택한 이슈 닫기',
      },
    ],
    isNullAvailability: false,
    canSelectMultipleItems: false,
  },
};
