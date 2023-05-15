import React from 'react';

import Profile from '../../common/Profile';
import Logo from '../../common/Logo';

interface Props {
  url?: string;
}

const Header: React.FC<Props> = ({ url }) => {
  return (
    <header className="flex h-24 items-center justify-between">
      <Logo />
      <Profile url={url} />
    </header>
  );
};

export default Header;
