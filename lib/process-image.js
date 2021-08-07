const config = require("./config");

const { CognitoIdentityClient } = require("@aws-sdk/client-cognito-identity");
const {
  fromCognitoIdentityPool,
} = require("@aws-sdk/credential-provider-cognito-identity");
const { S3Client, PutObjectCommand, DeleteObjectCommand, GetObjectCommand} = require("@aws-sdk/client-s3");
const Jimp = require('jimp');
const getStream = require('get-stream');

const deleteRawImage = async (key) => {
  // Set the AWS Region
  const REGION = "us-west-1"; //REGION

  // Initialize the Amazon Cognito credentials provider
  const s3 = new S3Client({
    region: REGION,
    credentials: fromCognitoIdentityPool({
      client: new CognitoIdentityClient({ region: REGION }),
      identityPoolId: "us-west-1:74f56e69-c9db-44f4-8973-56cea2805c31", // IDENTITY_POOL_ID
    }),
  });

  const deleteParams = {
    Bucket: "brandorawpictures",
    Key: key,
  };
  try {
    const data = await s3.send(new DeleteObjectCommand(deleteParams));
  } catch (err) {
    console.log("couldn't delete image:", err);
  }
}

const getRawImage = async (photoKey) => {
  // Set the AWS Region
  const REGION = "us-west-1"; //REGION

  // Initialize the Amazon Cognito credentials provider
  const s3 = new S3Client({
    region: REGION,
    credentials: fromCognitoIdentityPool({
      client: new CognitoIdentityClient({ region: REGION }),
      identityPoolId: "us-west-1:74f56e69-c9db-44f4-8973-56cea2805c31", // IDENTITY_POOL_ID
    }),
  });

  const albumBucketName = "brandorawpictures"; //BUCKET_NAME

  const downloadParams = {
    Bucket: albumBucketName,
    Key: photoKey,
  };
  try {
    const data = await s3.send(new GetObjectCommand(downloadParams));
    let buffer = await getStream.buffer(data.Body);
    return buffer;
  } catch (err) {
    console.log("couldn't get the image:", err);
  }
}

const sendToS3 = async (file, fileName) => {
  const s3 = new S3Client({
    accessKeyId: config.AWS_ACCESS_KEY_ID,
    secretAccessKey: config.AWS_SECRET_ACCESS_KEY,
    region: config.AWS_REGION,
  });

  const params = {
    Bucket: config.AWS_BUCKET_NAME,
    Key:  fileName,
    Body: file,
    ContentType: 'image/png',
    ACL: 'public-read'
  }

  const command = new PutObjectCommand(params);

  try {
    await s3.send(command);
    return true;
  } catch (err) {
    console.log("image did not upload", err);
  }
}

const modifyImage = async (image, pictureName) => {
  if (!image) return;

  const file = await Jimp.read(Buffer.from(image.buffer, 'base64'))
    .then(async image => {
      // image.resize(Jimp.AUTO, 900);
      // image.resize(Jimp.AUTO, 460);
      image.scaleToFit(500, 900);
      image.quality(80);
      return image.getBufferAsync(Jimp.MIME_PNG);
    });
  
    await sendToS3(file, pictureName);
}

const processImage = async (fileName, modifiedPictureName) => {
  const albumPhotosKey = "unprocessed/";
  const photoKey = albumPhotosKey + fileName;

  let bufferData = await getRawImage(photoKey);
  await modifyImage(bufferData, modifiedPictureName);
  await deleteRawImage(photoKey);
}



module.exports = processImage;

// getRawImage();