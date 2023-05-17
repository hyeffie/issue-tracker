import React from 'react';

import { ReactComponent as Label } from '@assets/label.svg';
import { ReactComponent as Milestone } from '@assets/milestone.svg';

interface Props {
  countAllLabels: number;
  countAllMilestones: number;
}

const NavLinks: React.FC<Props> = ({ countAllLabels, countAllMilestones }) => {
  return (
    <div className="flex h-10 w-80 items-center justify-around">
      <div className="flex h-full w-40 items-center justify-center gap-1 rounded-l-2xl border border-gray-200">
        <Label stroke="#4E4B66" />
        <span className="text-base font-semibold text-gray-700">
          레이블({countAllLabels})
        </span>
      </div>
      <div className="flex h-full w-40 items-center justify-center gap-1 rounded-r-2xl border border-gray-200">
        <Milestone className="h-4" fill="#4E4B66" />
        <span className="font-semibold text-gray-700">
          마일스톤({countAllMilestones})
        </span>
      </div>
    </div>
  );
};

export default NavLinks;
