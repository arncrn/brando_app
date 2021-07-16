# npm install --save-dev jest
# npm install --save-dev supertest

# mock the psql database?


# testing where multiple components of the system are being tested as a group, is called `integration testing`.

# It would be better to run our tests using a database that is installed and running in the developer's local machine. The optimal solution would be to have every test execution use its own separate database. This is "relatively simple" to achieve by running Mongo in-memory or by using Docker containers.