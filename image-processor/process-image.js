// https://docs.aws.amazon.com/lambda/latest/dg/with-s3-tutorial.html
require("dotenv").config();
const { S3Client, PutObjectCommand, DeleteObjectCommand, GetObjectCommand, waitUntilBucketExists} = require("@aws-sdk/client-s3");
const Jimp = require('jimp');
const getStream = require('get-stream');

const modifyImage = async (image) => {
  if (!image) return false;
  const file = await Jimp.read(Buffer.from(image.buffer, 'base64'))
    .then(async image => {
      image.scaleToFit(500, 900);
      image.quality(80);
      return image.getBufferAsync(Jimp.MIME_PNG);
    });
  
    return file;
}

const getImage = async (s3, bucket, key) => {
  console.log('Bucket:', bucket);
  console.log('Key:', key);
  const downloadParams = {
    Bucket: bucket,
    Key: key,
  };
  try {
    const { Body } = await s3.send(new GetObjectCommand(downloadParams));
    const buffer = await getStream.buffer(Body);
    return buffer;
  } catch (err) {
    console.log(err);
    const message = `Error getting object ${key} from bucket ${bucket}.`;
    console.log(message);
    throw new Error(message);
  }
}

const uploadImage = async (s3, pictureName, modifiedImage) => {
  const uploadParams = {
    Bucket: process.env.AWS_BUCKET_NAME,
    Key:  pictureName,
    Body: modifiedImage,
    ContentType: 'image/png',
    ACL: 'public-read'
  }

  try {
    await s3.send(new PutObjectCommand(uploadParams));
    return true
  } catch (err) {
    console.log(err);
    const message = `Error uploading object ${pictureName} from bucket ${process.env.AWS_BUCKET_NAME}.`;
    console.log(message);
    throw new Error(message);
  }
}

const deleteImage = async (s3, bucket, key) => {
  const deleteParams = {
    Bucket: bucket,
    Key: key,
  };
  try {
    await s3.send(new DeleteObjectCommand(deleteParams));
  } catch (err) {
    console.log(err);
    const message = `Error deleting object ${key} from bucket ${bucket}.`;
    console.log(message);
    throw new Error(message);
  }
}

exports.handler = async (event) => {
  const s3 = new S3Client({
    region: "us-west-1",
  });
    // Get the object from the event, modify it, and reupload it to a separate bucket
    const bucket = event.Records[0].s3.bucket.name;
    const key = decodeURIComponent(event.Records[0].s3.object.key.replace(/\+/g, ' '));
    const pictureName = key.split('/')[1];

    try {
        const buffer = await getImage(s3, bucket, key);
        const modifiedImage = await modifyImage(buffer);
        const uploadedSuccess = await uploadImage(s3, pictureName, modifiedImage);
        if (uploadedSuccess) {
          await deleteImage(s3, bucket, key);
        }

        return key;
    } catch (err) {
        console.log(err);
        const message = `Something went wrong`;
        console.log(message);
        throw new Error(message);
    }
};