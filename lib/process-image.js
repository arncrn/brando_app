const config = require("./config");

const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");
const Jimp = require('jimp');

// const removeSpaces = (string) => {
//   return string.split(' ').join('-').toLowerCase();
// }

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

const processImage = async (image, pictureName) => {
  if (!image) return;

  const file = await Jimp.read(Buffer.from(image.buffer, 'base64'))
    .then(async image => {
      // image.resize(Jimp.AUTO, 900);
      // image.resize(Jimp.AUTO, 460);
      image.scaleToFit(500, 900);
      image.quality(80);
      return image.getBufferAsync(Jimp.MIME_PNG);
    });

    // if (tagNumber.includes('?')) {
    //   tagNumber = Math.floor(Math.random() * 1000);
    // }
    
    // type = removeSpaces(type);
    // brand = removeSpaces(brand);

    // let fileName = `${brand}-${type}-${tagNumber}.png`
  
    await sendToS3(file, pictureName);
    // return fileName;
}



module.exports = processImage;