import type { Meta, StoryObj } from '@storybook/react';
import Label from './Label';

const meta = {
  title: 'Main/Label',
  component: Label,
} satisfies Meta<typeof Label>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    labelName: 'Primary',
    backgroundColor: '#4d8c55',
    fontColor: '#ffffff',
  },
};
