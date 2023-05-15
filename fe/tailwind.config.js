/** @type {import('tailwindcss').Config} */

export const content = ['./src/**/*.{js,jsx,ts,tsx}'];
export const theme = {
  extend: {
    colors: {
      // NOTE(Jayden): 기본 color
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
      // TODO: 아래 컬러들을 위의 테마 컬러로 변경하기
      neutral: '#4E4B66',
      'neutral-weak': '#6E7191',
      'neutral-strong': '#14142B',
      'light-mode': '#F7F7FC',
    },
    // NOTE(Jayden): 기본 font-size
    fontSize: {
      sm: ['12px', '20px'],
      md: ['16px', '28px'],
      lg: ['18px', '32px'],
      xl: ['24px', '40px'],
      '2xl': ['32px', '48px'],
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
export const safelist = [{ pattern: /bg-(blue|gray)/ }];
export const plugins = [];
