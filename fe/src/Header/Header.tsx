import React from 'react';
import Profile from '../common/Profile/Profile';
import Logo from '../common/Logo/Logo';

interface Props {
  url?: string;
}

const Header: React.FC<Props> = ({ url }) => {
  return (
    <header className="h-24 flex justify-between items-center">
      <Logo />
      <Profile url={url} />
    </header>
  );
};

export default Header;
