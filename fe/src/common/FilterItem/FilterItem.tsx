import React from 'react';

import Profile from '../Profile/Profile';

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
      className={`text-neutral flex items-center gap-x-1 ${
        bold && 'font-bold'
      }`}
    >
      {imgUrl && <Profile url={imgUrl} width={width} height={height} />}
      <span>{title}</span>
    </div>
  );
};

export default FilterItem;
