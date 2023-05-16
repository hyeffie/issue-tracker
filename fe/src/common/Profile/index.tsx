import React from 'react';

interface Props {
  url: string;
  width?: number;
  height?: number;
}

const Profile: React.FC<Props> = ({ url, width = 32, height = 32 }) => {
  return (
    <img
      src={url}
      width={width}
      height={height}
      className="h-fit rounded-full"
      alt="profile"
    />
  );
};

export default Profile;
