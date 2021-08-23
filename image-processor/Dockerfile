FROM public.ecr.aws/lambda/nodejs:14

COPY package.json ${LAMBDA_TASK_ROOT}

RUN npm install

ENV AWS_REGION us-west-1

ENV AWS_BUCKET_NAME brandomaniapictures

COPY process-image.js ${LAMBDA_TASK_ROOT}

CMD [ "process-image.handler" ]

# if there is an error of 
#   "failed to solve with frontend dockerfile.v0: failed to create LLB definition: unexpected status code [manifests 14]: 403 Forbidden"
# try 
  # docker logout public.ecr.aws
# and then reauthenticate
# OR
# try "docker login"
# or "DOCKER_BUILDKIT=0 COMPOSE_DOCKER_CLI_BUILD=0 docker build -t image-processor ."
