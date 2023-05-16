import React from 'react';

import Profile from '../Profile';

export interface FilterItemRaw {
  id: number;
  title: string;
  bold?: boolean;
  imgUrl?: string;
  backgroundColor?: string;
  width?: number;
  height?: number;
}

const FilterItem: React.FC<FilterItemRaw> = ({
  title,
  bold = false,
  imgUrl,
  backgroundColor,
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
      {backgroundColor && (
        <div
          className={'h-5 w-5 rounded-full'}
          style={{ backgroundColor }}
        ></div>
      )}
      <span>{title}</span>
    </div>
  );
};

export default FilterItem;
