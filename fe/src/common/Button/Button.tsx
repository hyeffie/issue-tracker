import React from 'react';

import { ReactComponent as PlusIcon } from '../../assets/plus.svg';

interface Props {
  isFlexible?: boolean;
  type?: 'Contained' | 'Outline' | 'Ghost';
  hasIcon?: boolean;
  condition?: 'Enabled' | 'Hover' | 'Press' | 'Disabled';
  size?: 'Large' | 'Medium' | 'Small';
  color?: 'Blue' | 'grayDark' | 'grayLight';
  content?: string;
  onClick?: React.MouseEventHandler<HTMLButtonElement>;
}

const Button: React.FC<Props> = ({
  isFlexible = false,
  type = 'Contained',
  hasIcon = false,
  condition = 'Enabled',
  size = 'Medium',
  color = 'Blue',
  content = 'Button',
  onClick = () => {
    console.log('clicked!');
  },
}) => {
  const widthHeight = getWidthHeight(size);
  const bgColor = `bg-${getColor(color)}`;
  console.log(bgColor);
  const opacity = getOpacity(condition);
  return (
    <button
      className={`${
        isFlexible && 'w-auto px-6 '
      } ${widthHeight} ${bgColor} ${opacity} flex items-center justify-center gap-x-2 rounded-2xl font-bold text-white`}
      onClick={onClick}
    >
      {hasIcon && <PlusIcon stroke={'#ffffff'} />}
      <span>{content}</span>
    </button>
  );
};

function getWidthHeight(size: string) {
  switch (size) {
    case 'Large':
      return 'w-80 h-14';
    case 'Medium':
      return 'w-60 h-14';
    case 'Small':
      return 'w-[120px] h-10';
  }
}

function getColor(color: string) {
  switch (color) {
    case 'Blue':
      return 'blue';
    case 'grayDark':
      return 'gray-900';
    case 'grayLight':
      return 'gray-100';
    default:
      'blue';
  }
}

function getOpacity(condition: string) {
  switch (condition) {
    case 'Enabled':
      return 'opacity-100';
    case 'Hover':
      return 'opacity-80';
    case 'Press':
      return 'opacity-[.64]';
    case 'Disabled':
      return 'opacity-[.32]';
  }
}

// TODO(Jayden): 타입 조건과 색상 조건 합쳐서 하나의 함수로 만들기
// function getType(type: string) {
//   switch (type) {
//     case 'Contained':
//       return 'bg-blue-500';
//     case 'Outline':
//       return 'bg-white border border-blue-500';
//     case 'Ghost':
//       return 'bg-transparent';
//   }
// }
export default Button;
