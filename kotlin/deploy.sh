#!/usr/bin/env bash
set -e

STACK_NAME=kotlin-playground
ARTIFACT_BUCKET_NAME=tunagami-zero-to-sam-hero-src

# Build our jar with all the required libs.
./gradlew shadowJar

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
