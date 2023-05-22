import React from 'react';

import { ReactComponent as Search } from '@assets/search.svg';
import Button from '@common/Button';

interface Props {
  onClick: () => void;
}

const FilterBar: React.FC<Props> = ({ onClick }) => {
  return (
    <div className="flex w-auto justify-start rounded-2xl border border-gray-200">
      <Button
        title="필터"
        onClick={onClick}
        size="Small"
        color="Gray"
        type="Ghost"
        hasDropDown={true}
        condition="Press"
      />
      <form
        action=""
        className="flex w-[472px] items-center justify-start gap-x-3 rounded-r-2xl bg-gray-100 pl-6"
      >
        <Search stroke="#6E7191" className="w-4 self-center" />
        <input
          type="text"
          // TODO(Lily): value 값을 현재 선택된 필터 항목을 props로 받아서 처리
          value="is:issue is:open"
          className="w-96 bg-gray-100 text-gray-600"
        />
      </form>
    </div>
  );
};

export default FilterBar;
