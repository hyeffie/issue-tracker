import React from 'react';

import label from '@assets/label.svg';
import milestone from '@assets/milestone.svg';

interface Props {
  countAllLabels: number;
  countAllMilestones: number;
}

const NavLinks: React.FC<Props> = ({ countAllLabels, countAllMilestones }) => {
  return (
    <div className="flex h-10 w-80 items-center justify-around">
      <div className="flex h-full w-40 items-center justify-center gap-1 rounded-l-2xl border border-gray-200">
        <img className="w-4" src={label} alt="link to label list" />
        <span className="text-base font-semibold text-gray-600">
          레이블({countAllLabels})
        </span>
      </div>
      <div className="flex h-full w-40 items-center justify-center gap-1 rounded-r-2xl border border-gray-200">
        <img className="w-4" src={milestone} alt="link to milestone list" />
        <span className="font-semibold text-gray-600">
          마일스톤({countAllMilestones})
        </span>
      </div>
    </div>
  );
};

export default NavLinks;
