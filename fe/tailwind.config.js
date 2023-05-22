/** @type {import('tailwindcss').Config} */

export const content = ['./src/**/*.{js,jsx,ts,tsx}'];
export const theme = {
  extend: {
    colors: {
      // NOTE(Jayden): 기본 color
      'gray': {
        50: '#FEFEFE',
        100: '#F7F7FC',
        200: '#EFF0F6',
        300: '#D9DBE9',
        400: '#BEC1D5',
        500: '#A0A3BD',
        600: '#6E7191',
        700: '#4E4B66',
        800: '#2A2A44',
        900: '#14142B',
      },
      // NOTE(Jayden): DEFAULT로 색상 지정 시, 해당 색상을 사용할 때는 bg-blue, text-blue 등으로 사용(기존 tailwindcss 제공 색상 유지 가능)
      'blue': { DEFAULT: '#007AFF' },
      'navy': { DEFAULT: '#0025E6' },
      'red': { DEFAULT: '#FF3B30' },
      // TODO: 아래 컬러들을 위의 테마 컬러로 변경하기
      'neutral': '#4E4B66',
      'neutral-weak': '#6E7191',
      'neutral-strong': '#14142B',
      'light-mode': '#F7F7FC',
    },
    // NOTE(Jayden): 기본 font-size
    fontSize: {
      'sm': ['12px', '20px'],
      'md': ['16px', '28px'],
      'lg': ['18px', '32px'],
      'xl': ['24px', '40px'],
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
export const safelist = [{ pattern: /(bg|text|border)-(blue|gray|red|navy)/ }];
export const plugins = [];
