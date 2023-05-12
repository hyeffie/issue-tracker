import React from 'react';

interface Props {
  countAllLabels: number;
  countAllMilestones: number;
}

const NavLinks: React.FC<Props> = ({ countAllLabels, countAllMilestones }) => {
  return (
    <div className="w-80 h-10 flex justify-around items-center">
      <div className="w-40 h-full flex justify-center items-center gap-1 border rounded-l-2xl border-gray-200">
        <img className="w-4" src="/assets/Label.svg" alt="link to label list" />
        <span className="text-base font-semibold text-gray-600">
          레이블({countAllLabels})
        </span>
      </div>
      <div className="w-40 h-full flex justify-center items-center gap-1 border rounded-r-2xl border-gray-200">
        <img
          className="w-4"
          src="/assets/Milestone.svg"
          alt="link to milestone list"
        />
        <span className="font-semibold text-gray-600">
          마일스톤({countAllMilestones})
        </span>
      </div>
    </div>
  );
};

export default NavLinks;
