import React from 'react';

const FilterBar: React.FC = () => {
  return (
    <div className="w-auto flex justify-start ">
      <button className="w-32 h-10 flex justify-center items-center gap-x-3 rounded-l-2xl border border-gray-200 bg-white text-gray-500 font-bold">
        <span>필터</span>
        <img src="/assets/ChevronDown.svg" alt="chevron-down" />
      </button>
      <form
        action=""
        className="w-[472px] pl-10 flex justify-start gap-x-3 rounded-r-2xl border border-gray-200 bg-gray-100"
      >
        <img src="/assets/Search.svg" alt="search" className="w-4" />
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
