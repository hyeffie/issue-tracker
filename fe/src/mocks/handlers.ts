// src/mocks/handlers.js
import { rest } from 'msw';
import { mainData } from './mainData';
export const handlers = [
  rest.get('/issues', (req, res, ctx) => {
    // if (!isAuthenticated) {
    //   // If not authenticated, respond with a 403 error
    //   return res(
    //     ctx.status(403),
    //     ctx.json({
    //       errorMessage: 'Not authorized',
    //     })
    //   );
    // }

    // If authenticated, return a mocked user details

    console.log(res);
    return res(ctx.status(200), ctx.json(mainData));
  }),
];

// const userData = {
//   id: 23123,
//   name: 'Lily',
//   profileUrl:
//     'https://lh3.googleusercontent.com/ogw/AOLn63F6B2eAe4HzDtvFPJU2zTjgdOtSHvHt-FnbIYcYgqU=s64-c-mo',
// };

// const fetchData = {
//   user: {
//     id: 23123,
//     name: 'Lily',
//     profileUrl:
//       'https://lh3.googleusercontent.com/ogw/AOLn63F6B2eAe4HzDtvFPJU2zTjgdOtSHvHt-FnbIYcYgqU=s64-c-mo',
//   },
//   issues: [
//     {
//       id: 1,
//       title: 'First Issue',
//       content: 'This is the first issue',
//       userName: 'JohnDoe',
//       profileUrl: 'https://example.com/johndoe',
//       isOpen: true,
//       createdAt: '2023-05-15 10:30:00',
//       closedAt: '',
//       milestoneName: 'Milestone 1',
//       labels: [
//         {
//           id: 1,
//           title: 'Bug',
//           backgroundColor: '#FF0000',
//           fontColor: '#FFFFFF',
//         },
//         {
//           id: 2,
//           title: 'High Priority',
//           backgroundColor: '#FFA500',
//           fontColor: '#000000',
//         },
//       ],
//     },
//     {
//       id: 2,
//       title: 'Second Issue',
//       content: 'This is the second issue',
//       userName: 'JaneSmith',
//       profileUrl: 'https://example.com/janesmith',
//       isOpen: true,
//       createdAt: '2023-05-16 09:15:00',
//       closedAt: '',
//       milestoneName: 'Milestone 2',
//       labels: [
//         {
//           id: 3,
//           title: 'Feature',
//           backgroundColor: '#00FF00',
//           fontColor: '#000000',
//         },
//         {
//           id: 4,
//           title: 'Low Priority',
//           backgroundColor: '#0000FF',
//           fontColor: '#FFFFFF',
//         },
//       ],
//     },
//     {
//       id: 3,
//       title: 'Third Issue',
//       content: 'This is the third issue',
//       userName: 'RobertJohnson',
//       profileUrl: 'https://example.com/robertjohnson',
//       isOpen: false,
//       createdAt: '2023-05-14 14:20:00',
//       closedAt: '2023-05-16 11:45:00',
//       milestoneName: 'Milestone 1',
//       labels: [
//         {
//           id: 5,
//           title: 'Enhancement',
//           backgroundColor: '#FFFF00',
//           fontColor: '#000000',
//         },
//         {
//           id: 6,
//           title: 'Medium Priority',
//           backgroundColor: '#800080',
//           fontColor: '#FFFFFF',
//         },
//       ],
//     },
//   ],
//   userList: [
//     {
//       userId: 1,
//       userName: 'John',
//       profileUrl: 'https://example.com/john',
//     },
//     {
//       userId: 2,
//       userName: 'Emily',
//       profileUrl: 'https://example.com/emily',
//     },
//     {
//       userId: 3,
//       userName: 'Michael',
//       profileUrl: 'https://example.com/michael',
//     },
//   ],
//   labelList: [
//     {
//       id: 1,
//       title: 'Red',
//       backgroundColor: '#FF0000',
//       fontColor: '#FFFFFF',
//     },
//     {
//       id: 2,
//       title: 'Blue',
//       backgroundColor: '#0000FF',
//       fontColor: '#FFFFFF',
//     },
//     {
//       id: 3,
//       title: 'Green',
//       backgroundColor: '#00FF00',
//       fontColor: '#000000',
//     },
//   ],
//   milestone: [
//     {
//       milestoneId: 1,
//       milestoneName: 'Task 1',
//     },
//     {
//       milestoneId: 2,
//       milestoneName: 'Task 2',
//     },
//     {
//       milestoneId: 3,
//       milestoneName: 'Task 3',
//     },
//   ],
//   countAllLabels: 13,
//   countAllMilestones: 11,
//   countOpenedIssues: 23,
//   countClosedIssues: 47,
// };
