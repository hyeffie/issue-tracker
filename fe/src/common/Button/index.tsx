import React from 'react';

// NOTE(Jayden): 버튼 앞에 오는 아이콘을 위한 import
import { ReactComponent as PlusIcon } from '@assets/plus.svg';
import { ReactComponent as CheveronDown } from '@assets/chevronDown.svg';
import { ReactComponent as XSquare } from '@assets/xSquare.svg';
import { ReactComponent as Label } from '@assets/label.svg';
import { ReactComponent as Milestone } from '@assets/milestone.svg';
import { ReactComponent as AlertCircle } from '@assets/alertCircle.svg';
import { ReactComponent as Archive } from '@assets/archive.svg';
import { ReactComponent as PaperClip } from '@assets/paperclip.svg';
import { ReactComponent as Trash } from '@assets/trash.svg';
import { ReactComponent as Edit } from '@assets/edit.svg';
import { ReactComponent as Smile } from '@assets/smile.svg';
import { ReactComponent as Calendar } from '@assets/calendar.svg';

type SVGNames =
  | 'none'
  | 'plus'
  | 'xsquare'
  | 'label'
  | 'milestone'
  | 'alertcircle'
  | 'archive'
  | 'paperclip'
  | 'trash'
  | 'edit'
  | 'smile'
  | 'calendar';

interface Props {
  title: string;
  isFlexible?: boolean;
  type?: 'Contained' | 'Outline' | 'Ghost';
  iconName?: SVGNames;
  condition?: 'Enabled' | 'Hover' | 'Press' | 'Disabled';
  size?: 'Large' | 'Medium' | 'Small';
  color?: 'Blue' | 'Gray';
  fontSize?: string;
  hasDropDown?: boolean;
  onClick: () => void;
}

const Button: React.FC<Props> = ({
  title,
  isFlexible = false,
  type = 'Contained',
  iconName = 'None',
  condition = 'Enabled',
  size = 'Medium',
  color = 'Blue',
  fontSize = 'text-base',
  hasDropDown = false,
  onClick,
}) => {
  const widthHeight = getWidthHeight(size);
  const opacity = getOpacity(condition);

  return (
    <button
      className={`${isFlexible && 'w-auto'} ${widthHeight} ${getType(
        type,
        getColor(color)
      )} ${opacity} flex items-center justify-center gap-x-2 rounded-2xl font-bold`}
      onClick={onClick}
    >
      {getSvgComponent(iconName, getHexByType(color, type))}
      <span className={`${fontSize}`}>{title}</span>
      {hasDropDown && <CheveronDown stroke={getHexByType(color, type)} />}
    </button>
  );
};

function getSvgComponent(iconName: string, strokeColor: string) {
  switch (iconName.toLowerCase()) {
    case 'none':
      return false;
    case 'plus':
      return <PlusIcon stroke={strokeColor} />;
    case 'xsquare':
      return <XSquare stroke={strokeColor} />;
    case 'label':
      return <Label stroke={strokeColor} />;
    case 'milestone':
      return <Milestone stroke={strokeColor} />;
    case 'alertcircle':
      return <AlertCircle stroke={strokeColor} />;
    case 'archive':
      return <Archive stroke={strokeColor} />;
    case 'paperclip':
      return <PaperClip stroke={strokeColor} />;
    case 'trash':
      return <Trash stroke={strokeColor} />;
    case 'edit':
      return <Edit stroke={strokeColor} />;
    case 'smile':
      return <Smile stroke={strokeColor} />;
    case 'calendar':
      return <Calendar stroke={strokeColor} />;
    default:
      return false;
  }
}

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
    case 'Gray':
      return 'gray-900';
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
      return 'opacity-[0.64]';
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
      return `bg-white border-[1px] border-${color} text-${color}`;
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
    case 'Gray':
      return '#14142B';
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
    default:
      return '#FFFFFF';
  }
}

export default Button;
