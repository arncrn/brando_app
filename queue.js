const Queue = require("bull");
// const imageProcessor = require("./lib/process-image");

// initiate the queue
// optional endpoint url
// redis-11371.c60.us-west-1-2.ec2.cloud.redislabs.com:11371
// password: RWhPiFw2urQ8D3mV8G2grk10PQylO8rE
const processImageQueue = new Queue('processImage', {
  redis: {
    host: 'redis-11371.c60.us-west-1-2.ec2.cloud.redislabs.com',
    port: 11371,
    password: 'RWhPiFw2urQ8D3mV8G2grk10PQylO8rE'
  }
});

// const processImageQueue = new Queue('processImage', 'redis-11371.c60.us-west-1-2.ec2.cloud.redislabs.com:11371');

// const data = {
//   originalFileName: 'me.jpg',
//   newFileName: 'tester1234.png'
// }

// const options = {
//   delay: 5000,
//   attempts: 2,
//   removeOnComplete: true
// }

// add a job to the queue
// processImageQueue.add(data, options);

// // consumer
// processImageQueue.process(async job => {
//   return await imageProcessor(job.data.originalFileName, job.data.newFileName);
// })


module.exports = processImageQueue;