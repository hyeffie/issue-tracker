export const mainData = {
  user: {
    id: 23123,
    name: 'Lily',
    profileUrl:
      'https://lh3.googleusercontent.com/ogw/AOLn63F6B2eAe4HzDtvFPJU2zTjgdOtSHvHt-FnbIYcYgqU=s64-c-mo',
  },
  issues: [
    {
      issueId: 1,
      title: 'First Issue',
      content: 'This is the first issue',
      userName: 'JohnDoe',
      profileUrl: 'https://example.com/johndoe',
      isOpen: true,
      createdAt: '2023-05-15 10:30:00',
      closedAt: '',
      milestoneName: 'Milestone 1',
      labelList: [
        {
          labelId: 1,
          labelName: 'Bug',
          backgroundColor: '#FF0000',
          fontColor: '#FFFFFF',
        },
        {
          labelId: 2,
          labelName: 'High Priority',
          backgroundColor: '#FFA500',
          fontColor: '#000000',
        },
      ],
    },
    {
      issueId: 2,
      title: 'Second Issue',
      content: 'This is the second issue',
      userName: 'JaneSmith',
      profileUrl: 'https://example.com/janesmith',
      isOpen: true,
      createdAt: '2023-05-16 09:15:00',
      closedAt: '',
      milestoneName: 'Milestone 2',
      labelList: [
        {
          labelId: 3,
          labelName: 'Feature',
          backgroundColor: '#00FF00',
          fontColor: '#000000',
        },
        {
          labelId: 4,
          labelName: 'Low Priority',
          backgroundColor: '#0000FF',
          fontColor: '#FFFFFF',
        },
      ],
    },
    {
      issueId: 3,
      title: 'Third Issue',
      content: 'This is the third issue',
      userName: 'RobertJohnson',
      profileUrl: 'https://example.com/robertjohnson',
      isOpen: false,
      createdAt: '2023-05-14 14:20:00',
      closedAt: '2023-05-16 11:45:00',
      milestoneName: 'Milestone 1',
      labelList: [
        {
          labelId: 5,
          labelName: 'Enhancement',
          backgroundColor: '#FFFF00',
          fontColor: '#000000',
        },
        {
          labelId: 6,
          labelName: 'Medium Priority',
          backgroundColor: '#800080',
          fontColor: '#FFFFFF',
        },
      ],
    },
  ],
  userList: [
    {
      userId: 1,
      userName: 'John',
      profileUrl: 'https://example.com/john',
    },
    {
      userId: 2,
      userName: 'Emily',
      profileUrl: 'https://example.com/emily',
    },
    {
      userId: 3,
      userName: 'Michael',
      profileUrl: 'https://example.com/michael',
    },
  ],
  labelList: [
    {
      labelId: 1,
      labelName: 'Red',
      backgroundColor: '#FF0000',
      fontColor: '#FFFFFF',
      dscription: 'This is a red label',
    },
    {
      labelId: 2,
      labelName: 'Blue',
      backgroundColor: '#0000FF',
      fontColor: '#FFFFFF',
      dscription: 'This is a red label',
    },
    {
      labelId: 3,
      labelName: 'Green',
      backgroundColor: '#00FF00',
      fontColor: '#000000',
      dscription: 'This is a red label',
    },
  ],
  milestone: [
    {
      milestoneId: 1,
      milestoneName: 'Task 1',
    },
    {
      milestoneId: 2,
      milestoneName: 'Task 2',
    },
    {
      milestoneId: 3,
      milestoneName: 'Task 3',
    },
  ],
  countAllLabels: 13,
  countAllMilestones: 11,
  countOpenedIssues: 23,
  countClosedIssues: 47,
};
