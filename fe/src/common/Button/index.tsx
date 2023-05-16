import React from 'react';

import { ReactComponent as PlusIcon } from '@assets/plus.svg';
import { ReactComponent as CheveronDown } from '@assets/chevronDown.svg';
interface Props {
  isFlexible?: boolean;
  type?: 'Contained' | 'Outline' | 'Ghost';
  hasIcon?: boolean;
  condition?: 'Enabled' | 'Hover' | 'Press' | 'Disabled';
  size?: 'Large' | 'Medium' | 'Small';
  color?: 'Blue' | 'GrayDark' | 'GrayLight';
  title: string;
  onClick: React.MouseEventHandler<HTMLButtonElement>;
  hasDropDown?: boolean;
}

const Button: React.FC<Props> = ({
  isFlexible = false,
  type = 'Contained',
  hasIcon = false,
  condition = 'Enabled',
  size = 'Medium',
  color = 'Blue',
  title = 'Button',
  onClick = () => {
    // TODO: 아래 console.log 추후 지우기
    console.log('clicked!');
  },
  hasDropDown = false,
}) => {
  const widthHeight = getWidthHeight(size);
  const opacity = getOpacity(condition);
  return (
    <button
      className={`${isFlexible && 'w-auto px-6'} ${widthHeight} ${getType(
        type,
        getColor(color)
      )} ${opacity} flex items-center justify-center gap-x-2 rounded-2xl font-bold`}
      onClick={onClick}
    >
      {hasIcon && <PlusIcon stroke={getHexByType(color, type)} />}
      <span>{title}</span>
      {hasDropDown && <CheveronDown stroke={getHexByType(color, type)} />}
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
    default:
      return 'w-60 h-14';
  }
}

function getColor(color: string) {
  switch (color) {
    case 'Blue':
      return 'blue';
    case 'GrayDark':
      return 'gray-900';
    case 'GrayLight':
      return 'gray-600';
    default:
      return 'blue';
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
    default:
      return 'opacity-100';
  }
}

function getType(type: string, color: string) {
  switch (type) {
    case 'Contained':
      return `bg-${color} text-white`;
    case 'Outline':
      return `bg-white border-2 border-${color} text-${color}`;
    case 'Ghost':
      return `bg-transparent text-${color}`;
    default:
      return `bg-${color} text-white`;
  }
}
function getHex(color: string) {
  switch (color) {
    case 'Blue':
      return '#007AFF';
    case 'GrayDark':
      return '#14142B';
    case 'GrayLight':
      return '#6E7191';
    default:
      return '#007AFF';
  }
}

function getHexByType(color: string, type: string) {
  switch (type) {
    case 'Contained':
      return '#FFFFFF';
    case 'Outline':
      return getHex(color);
    case 'Ghost':
      return getHex(color);
  }
}

export default Button;
