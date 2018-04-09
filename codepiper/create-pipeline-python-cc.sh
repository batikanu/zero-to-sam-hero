#!/usr/bin/env bash
STACK_NAME=simple-lambda-py
PIPELINE_CODE_REPO=py-ground
PIPELINE_CODE_BRANCH=master
CODEBUILD_RUNTIME_VERSION='python:2.7.12'

PIPELINE_STACK_NAME="${STACK_NAME}-codepipeline"
echo "Creating/update ${PIPELINE_STACK_NAME} with code in ${PIPELINE_CODE_REPO}
from branch ${PIPELINE_CODE_BRANCH}."

aws cloudformation deploy \
    --template-file ./codepipeline.cf.sam.yml \
    --stack-name ${PIPELINE_STACK_NAME} \
    --capabilities CAPABILITY_IAM \
    --parameter-overrides \
        "TargetStackName=${STACK_NAME}" \
        "CodeCommitRepoName=${PIPELINE_CODE_REPO}" \
        "RuntimeVersion=${CODEBUILD_RUNTIME_VERSION}" \
        "CodeCommitBranch=${PIPELINE_CODE_BRANCH}"