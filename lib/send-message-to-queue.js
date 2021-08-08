const config = require("./config");

 const { SQSClient, SendMessageCommand } = require("@aws-sdk/client-sqs");
 
 const sendMessage = async (sqs, queueUrl, message) => {
   const params = {
     DelaySeconds: 10,
     MessageBody: JSON.stringify(message),
     QueueUrl: queueUrl
   };
   const command = new SendMessageCommand(params);
 
   try {
     await sqs.send(command);
   } catch (err) {
     console.log(err);
   }
 };
 
 
 module.exports = async (message) => {
   const sqs = new SQSClient({ 
      region: config.AWS_REGION,
      accessKeyId: config.AWS_ACCESS_KEY_ID,
      secretAccessKey: config.AWS_SECRET_ACCESS_KEY
    });
   const queueUrl = "https://sqs.us-west-1.amazonaws.com/272571982225/brando-queue";
   await sendMessage(sqs, queueUrl, message);
 };
 