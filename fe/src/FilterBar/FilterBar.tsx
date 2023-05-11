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
        <img
          src="/assets/Search.svg"
          alt="search"
          className="w-4 text-gray-400"
        />
        <input
          type="text"
          value="is:issue is:open"
          className="w-full bg-gray-100 text-gray-500"
        />
      </form>
    </div>
  );
};

export default FilterBar;
