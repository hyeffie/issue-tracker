import React from 'react';

interface Props {
  labelName: string;
  backgroundColor: string;
  fontColor: string;
}

const Label: React.FC<Props> = ({ labelName, backgroundColor, fontColor }) => {
  return (
    <div
      className={`w-fit h-8 px-6 py-2 rounded-2xl text-xs bg-[${backgroundColor}] text-[${fontColor}]`}
      style={{ backgroundColor, color: fontColor }}
    >
      {labelName}
    </div>
  );
};

export default Label;
