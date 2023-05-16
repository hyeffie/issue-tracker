import React from 'react';

import Profile from '../Profile';

interface Props {
  title: string;
  bold?: boolean;
  imgUrl?: string;
  width?: number;
  height?: number;
}

const FilterItem: React.FC<Props> = ({
  title,
  bold = false,
  imgUrl,
  width,
  height,
}) => {
  return (
    <div
      className={`flex items-center gap-x-1 text-gray-700 ${
        bold && 'font-bold'
      }`}
    >
      {imgUrl && <Profile url={imgUrl} width={width} height={height} />}
      <span>{title}</span>
    </div>
  );
};

export default FilterItem;
