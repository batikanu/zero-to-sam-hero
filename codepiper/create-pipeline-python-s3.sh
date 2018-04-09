#!/usr/bin/env bash
STACK_NAME=simple-lambda-py3
SOURCE_S3_BUCKET="${STACK_NAME}-src-code"
SOURCE_S3_KEY="source/${STACK_NAME}.zip"


##### S3 SOURCE CODE ###################################
### THIS FUNCTIONALITY IS ONLY NEEDED WHEN YOU DEFINE YOUR SOURCE Code
### BUCKET HERE
# See if the source bucket exists and if not, create it
BUCKET_EXISTS=$(aws s3api list-buckets --query "Buckets[?Name=='${SOURCE_S3_BUCKET}'].Name"  --output text)

if [ -z "${BUCKET_EXISTS}" ]; then
  echo ':::: WARNING ::::'
  echo "Creating bucket ${SOURCE_S3_BUCKET}"
  aws s3api create-bucket --bucket ${SOURCE_S3_BUCKET} --create-bucket-configuration LocationConstraint=eu-west-1
  echo "Enabling Versioning on ${SOURCE_S3_BUCKET}"
  aws s3api put-bucket-versioning --bucket ${SOURCE_S3_BUCKET} --versioning-configuration Status=Enabled
fi
##### S3 SOURCE CODE ###################################

PIPELINE_STACK_NAME="${STACK_NAME}-codepipeline"
echo "Creating/update ${PIPELINE_STACK_NAME} with code in ${SOURCE_S3_BUCKET}
at ${SOURCE_S3_KEY}."

aws cloudformation deploy \
    --template-file ./codepipeline.cf.sam.yml \
    --stack-name ${PIPELINE_STACK_NAME} \
    --capabilities CAPABILITY_IAM \
    --parameter-overrides \
        "TargetStackName=${STACK_NAME}" \
        "S3SourceBucket=${SOURCE_S3_BUCKET}" \
        "S3SourceKey=${SOURCE_S3_KEY}"


echo ':::: INFO ::::'
echo "Code Pipeline will fail until you upload source to ${SOURCE_S3_BUCKET}/${SOURCE_S3_KEY}"
echo ':::: INFO ::::'
