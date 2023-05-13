import React from 'react';

interface Props {
  size?: 'large' | 'medium';
}

const Logo: React.FC<Props> = ({ size = 'medium' }) => {
  return (
    <img
      src="/assets/Logo.svg"
      width={size === 'medium' ? 199 : 342}
      height={size === 'medium' ? 40 : 72}
      alt="logo"
    />
  );
};

export default Logo;
