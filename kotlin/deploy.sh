#!/usr/bin/env bash
set -e

STACK_NAME=kotlin-playground
ARTIFACT_BUCKET_NAME=YOUR_BUCKET_NAME_HERE

# Build our jar with all the required libs.
./gradlew shadowJar

# Here we could put in a test step to stop on failed tests
# ./gradlew test

# Convert Sam to CF and push up source artifact
aws cloudformation package \
  --template-file ./sam.yaml \
  --output-template-file ./sam-output-template.yaml \
  --s3-prefix ${STACK_NAME}-src \
  --s3-bucket ${ARTIFACT_BUCKET_NAME}

# Deploy CF template
aws cloudformation deploy  \
  --template-file ./sam-output-template.yaml \
  --stack-name ${STACK_NAME} \
  --capabilities CAPABILITY_IAM
