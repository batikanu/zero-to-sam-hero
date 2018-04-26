#!/usr/bin/env bash
STACK_NAME=python-ztsh-piped-stack
PIPELINE_CODE_REPO=python-ztsh
PIPELINE_CODE_BRANCH=master
CODEBUILD_RUNTIME_VERSION='python:2.7.12'
ARTIFACT_BUCKET_NAME=$(aws ssm get-parameter --name "ztsh-source-bucket" --query "Parameter.Value" --output text)

PIPELINE_STACK_NAME="${STACK_NAME}-codepipeline"
echo "Creating/update ${PIPELINE_STACK_NAME} with code in ${PIPELINE_CODE_REPO}
from branch ${PIPELINE_CODE_BRANCH}."

aws cloudformation deploy \
    --template-file ./cloudformation.yml \
    --stack-name ${PIPELINE_STACK_NAME} \
    --capabilities CAPABILITY_IAM \
    --parameter-overrides \
        "TargetStackName=${STACK_NAME}" \
        "CodeCommitRepoName=${PIPELINE_CODE_REPO}" \
        "RuntimeVersion=${CODEBUILD_RUNTIME_VERSION}" \
        "CodeCommitBranch=${PIPELINE_CODE_BRANCH}" \
        "LambdaSourceS3Bucket=${ARTIFACT_BUCKET_NAME}"
