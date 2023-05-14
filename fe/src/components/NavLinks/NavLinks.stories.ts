import type { Meta, StoryObj } from '@storybook/react';
import NavLinks from './NavLinks';

const meta = {
  title: 'Main/NavLinks',
  component: NavLinks,
} satisfies Meta<typeof NavLinks>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: { countAllLabels: 5, countAllMilestones: 7 },
};
