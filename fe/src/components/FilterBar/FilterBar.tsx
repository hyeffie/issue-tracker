import React from 'react';

import search from '@assets/search.svg';
import { ReactComponent as ChevronDown } from '@assets/chevronDown.svg';

const FilterBar: React.FC = () => {
  return (
    <div className="flex w-auto justify-start ">
      <button className="flex h-10 w-32 items-center justify-center gap-x-3 rounded-l-2xl border border-gray-200 bg-white font-bold text-gray-500">
        <span>필터</span>
        <ChevronDown stroke="#6E7191" />
      </button>
      <form
        action=""
        className="flex w-[472px] justify-start gap-x-3 rounded-r-2xl border border-gray-200 bg-gray-100 pl-6"
      >
        <img src={search} alt="search" className="w-4" />
        <input
          type="text"
          // TODO(Lily): value 값을 현재 선택된 필터 항목을 props로 받아서 처리
          value="is:issue is:open"
          className="w-96 bg-gray-100 text-gray-500"
        />
      </form>
    </div>
  );
};

export default FilterBar;
