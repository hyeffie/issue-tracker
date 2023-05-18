import React from 'react';

import FilterItem, { FilterItemRaw } from '@common/FilterItem/FilterItem';
// import checkOffCircle from '@assets/checkOffCircle.svg';
import { ReactComponent as CheckOffCircle } from '@assets/checkOffCircle.svg';
import { ReactComponent as CheckOnCircle } from '@assets/checkOnCircle.svg';

interface Props {
  title: string;
  items: FilterItemRaw[];
  isNullAvailability?: boolean;
  canSelectMultipleItems?: boolean;
  onClick: () => void;
}

const FilterList: React.FC<Props> = ({
  title,
  items,
  isNullAvailability = true,
  canSelectMultipleItems = true,
  onClick,
}) => {
  const filterItemStyle =
    'flex w-full justify-between items-center border-t px-4 py-2 text-gray-700';

  return (
    <div
      className={`absolute top-12 z-10 flex w-60 flex-col items-center rounded-lg border ${
        title !== '이슈' && 'right-0'
      }`}
    >
      <div className="w-full rounded-t-lg bg-gray-100 py-2 pl-4 text-left text-sm">
        {title} 필터
      </div>
      <div className="w-full rounded-b-lg bg-white">
        {isNullAvailability && (
          <button className={filterItemStyle} onClick={onClick}>
            <span>{title} 없는 이슈</span>
            {/* TODO(Lily): item이 선택되면 checkOnCircle로 바꾸기 */}
            {canSelectMultipleItems && <CheckOffCircle />}
          </button>
        )}
        {items.map(item => {
          const { id, title, imgUrl, backgroundColor } = item;
          return (
            <button key={id} className={filterItemStyle} onClick={onClick}>
              <FilterItem
                id={id}
                title={title}
                imgUrl={imgUrl}
                width={20}
                height={20}
                backgroundColor={backgroundColor}
              />
              {/* TODO(Lily): item이 선택되면 checkOnCircle로 바꾸기 */}
              {canSelectMultipleItems && <CheckOffCircle />}
            </button>
          );
        })}
      </div>
    </div>
  );
};

export default FilterList;
