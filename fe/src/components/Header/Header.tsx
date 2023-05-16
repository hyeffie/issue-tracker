import React from 'react';

import Logo from '@common/Logo';
import Profile from '@common/Profile';

interface Props {
  url: string;
}

const Header: React.FC<Props> = ({ url }) => {
  return (
    <header className="mb-[59px] flex items-center justify-between">
      <Logo size="Medium" />
      <Profile url={url} />
    </header>
  );
};

export default Header;
