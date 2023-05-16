import React from 'react';

import Logo from '@common/Logo';
import Profile from '@common/Profile';

interface Props {
  url: string;
}

const Header: React.FC<Props> = ({ url }) => {
  return (
    <header className="flex h-24 items-center justify-between">
      <Logo size="Medium" />
      <Profile url={url} />
    </header>
  );
};

export default Header;
