import React from 'react';

import logo from '../../assets/logo.svg';

interface Props {
  size: 'Large' | 'Medium';
}

const Logo: React.FC<Props> = ({ size = 'Medium' }) => {
  return (
    <img
      src={logo}
      width={size === 'Medium' ? 199 : 342}
      height={size === 'Medium' ? 40 : 72}
      alt="logo"
    />
  );
};

export default Logo;
