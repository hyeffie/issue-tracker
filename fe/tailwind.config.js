/** @type {import('tailwindcss').Config} */

export const content = ['./src/**/*.{js,jsx,ts,tsx}'];
export const theme = {
  extend: {
    colors: {
      // NOTE(Jayden): 기본 컬러 설정
      'gray-50': '#FEFEFE',
      'gray-100': '#F7F7FC',
      'gray-200': '#EFF0F6',
      'gray-300': '#D9DBE9',
      'gray-400': '#BEC1D5',
      'gray-500': '#A0A3BD',
      'gray-600': '#6E7191',
      'gray-700': '#4E4B66',
      'gray-800': '#2A2A44',
      'gray-900': '#14142B',
      blue: '#007AFF',
      navy: '#0025E6',
      red: '#FF3B30',

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
