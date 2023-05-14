/** @type {import('tailwindcss').Config} */

export const content = ['./src/**/*.{js,jsx,ts,tsx}'];
export const theme = {
  extend: {
    colors: {
      neutral: '#4E4B66',
      'neutral-weak': '#6E7191',
      'neutral-strong': '#14142B',
      'light-mode': '#F7F7FC',
    },
  },
  // TODO(Lily): set default attributes (font color)
  // plugins: [
  //   plugin(({ addBase, theme }) => {
  //     addBase({
  //       html: { color: theme('colors.slate.800') },
  //     });
  //   }),
  // ],
};
export const plugins = [];
