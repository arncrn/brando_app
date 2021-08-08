FROM public.ecr.aws/lambda/nodejs:14

COPY package.json ${LAMBDA_TASK_ROOT}

RUN npm install

ENV AWS_ACCESS_KEY_ID AKIAT65UOMGIYF3KFVN4
ENV AWS_REGION us-west-1
ENV AWS_SECRET_ACCESS_KEY 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
ENV AWS_BUCKET_NAME brandomaniapictures

COPY process-image.js ${LAMBDA_TASK_ROOT}

CMD [ "process-image.handler" ]