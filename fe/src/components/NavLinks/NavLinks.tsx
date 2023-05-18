import React from 'react';

import Button from '@common/Button';

interface Props {
  countAllLabels: number;
  countAllMilestones: number;
}

const NavLinks: React.FC<Props> = ({ countAllLabels, countAllMilestones }) => {
  return (
    <div className="flex h-10 w-80 rounded-2xl border border-gray-200">
      <div className="flex w-1/2 justify-center  border-r">
        <Button
          title={`레이블(${countAllLabels})`}
          onClick={() => console.log('레이블')}
          size="Small"
          color="Gray"
          type="Ghost"
          iconName="label"
          condition="Press"
        />
      </div>
      <div className="flex w-1/2 justify-center">
        <Button
          title={`마일스톤(${countAllMilestones})`}
          onClick={() => console.log('마일스톤')}
          size="Small"
          color="Gray"
          type="Ghost"
          iconName="milestone"
          condition="Press"
        />
      </div>
    </div>
  );
};

export default NavLinks;
