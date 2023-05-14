import React from 'react';

interface Props {
  labelName: string;
  backgroundColor: string;
  fontColor: string;
}

const Label: React.FC<Props> = ({ labelName, backgroundColor, fontColor }) => {
  return (
    // NOTE(Jayden): tailwindcss 이슈 - backgroundColor, fontColor는 style 객체로 넘겨줘야 함
    <div
      className={'w-fit h-8 mr-1 px-6 py-2 rounded-2xl text-xs font-semibold'}
      style={{ backgroundColor, color: fontColor }}
    >
      {labelName}
    </div>
  );
};

export default Label;
