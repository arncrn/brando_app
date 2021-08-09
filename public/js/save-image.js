// this file must be rebuilt with "npm run build" after each edit 

const { CognitoIdentityClient } = require("@aws-sdk/client-cognito-identity");
const {
  fromCognitoIdentityPool,
} = require("@aws-sdk/credential-provider-cognito-identity");
const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");

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



const addPhoto = async (albumName, pictureName) => {
  const files = document.getElementById("picture-uploader").files;
  try {
    const albumPhotosKey = encodeURIComponent(albumName) + "/";
   
    const file = files[0];
    const fileName = pictureName;
    const photoKey = albumPhotosKey + fileName;
    const uploadParams = {
      Bucket: albumBucketName,
      Key: photoKey,
      Body: file
    };
    try {
      await s3.send(new PutObjectCommand(uploadParams));
      // alert("Successfully uploaded photo.");
    } catch (err) {
      // return alert("There was an error uploading your photo: ", err.message);
    }
  } catch (err) {
    if (!files.length) {
      // return alert("Choose a file to upload first.");
      console.log('no image added');
      return;
    }
  }
};
// Make addPhoto function available to the browser
window.addPhoto = addPhoto;



