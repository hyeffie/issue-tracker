import type { Meta, StoryObj } from '@storybook/react';
import FilterBar from './FilterBar';

const meta = {
  title: 'Main/FilterBar',
  component: FilterBar,
} satisfies Meta<typeof FilterBar>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {},
};
