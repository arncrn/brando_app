const supertest = require('supertest');
const app = require('../app');

const api = supertest(app);

test('main clothing page is rendered', async () => {
  await api
    .get("/clothing")
    .expect(200)
    // .expect('Content-Type', /\/json/)
})