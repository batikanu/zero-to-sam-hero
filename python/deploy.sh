#!/usr/bin/env bash
set -e

STACK_NAME=python-playground
ARTIFACT_BUCKET_NAME=mdm-sandbox-buckets-gf-lambdasources3bucket-5u4adjsrz462

# Create the distribution
rm -rf ./dist
mkdir -p ./dist
cp -R ./src/* ./dist
pip install -r requirements.txt -t ./dist

# Run tests
python -m doctest dist/*.py

# Convert Sam to CF and push up source artifact
aws cloudformation package \
  --template-file ./sam.yml \
  --output-template-file ./sam-output-template.yml \
  --s3-prefix ${STACK_NAME}-src \
  --s3-bucket ${ARTIFACT_BUCKET_NAME}

# Deploy CF template
aws cloudformation deploy \
  --template-file ./sam-output-template.yml \
  --stack-name ${STACK_NAME} \
  --capabilities CAPABILITY_IAM
