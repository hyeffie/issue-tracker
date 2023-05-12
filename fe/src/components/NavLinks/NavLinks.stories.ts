import type { Meta, StoryObj } from '@storybook/react';
import NavLinks from './NavLinks';

// More on how to set up stories at: https://storybook.js.org/docs/react/writing-stories/introduction
const meta = {
  title: 'Main/NavLinks',
  component: NavLinks,
} satisfies Meta<typeof NavLinks>;

export default meta;
type Story = StoryObj<typeof meta>;

// More on writing stories with args: https://storybook.js.org/docs/react/writing-stories/args
export const Primary: Story = {
  args: { countAllLabels: 5, countAllMilestones: 7 },
};
