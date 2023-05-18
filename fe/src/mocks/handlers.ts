import { rest } from 'msw';
import { mainData } from './mainData';

export const handlers = [
  rest.get('/issues', (req, res, ctx) => {
    return res(ctx.status(200), ctx.json(mainData));
  }),
];
