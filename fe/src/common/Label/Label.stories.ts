import type { Meta, StoryObj } from '@storybook/react';
import Label from './Label';

// More on how to set up stories at: https://storybook.js.org/docs/react/writing-stories/introduction
const meta = {
  title: 'Main/Label',
  component: Label,
} satisfies Meta<typeof Label>;

export default meta;
type Story = StoryObj<typeof meta>;

// More on writing stories with args: https://storybook.js.org/docs/react/writing-stories/args
export const Primary: Story = {
  args: {
    labelName: 'Primary',
    backgroundColor: '#4d8c55',
    fontColor: '#ffffff',
  },
};
