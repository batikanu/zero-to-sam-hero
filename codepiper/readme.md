## Purpose
Point this script via the SAM enabled project ([see example](https://collaboration.msi.audi.com/stash/users/robert.kuhr_man.eu/repos/starter-python-sam/browse) and pull the trigger.  It will create a code pipeline that:
* Monitor a repo in CodeCommit
* Start the pipeline when specified branch is updated
* Builds the project according to the `buildspec.yml` in the project
* Creates a changeset based on the `sam.yml` template in the project
* Deploys changeset to the environment

[AWS SAM](https://github.com/awslabs/serverless-application-model)

## Usage:
"TargetStackName=${STACK_NAME}" \
"CodeCommitRepoName=${PIPELINE_CODE_REPO}" \
"RuntimeVersion=${CODEBUILD_RUNTIME_VERSION}" \
"CodeCommitBranch=${PIPELINE_CODE_BRANCH}" \
"LambdaSourceS3Bucket=${SSM_FOR_LAMBDA_SOURCE_BUCKET}"


    STACK_NAME=simple-lambda-py
    # Name of the stack and the pipeline stack
    # z.B.: ${STACK_NAME}-codepipeline
    # aka simple-lambda-py-codepipeline

    SSM_FOR_LAMBDA_SOURCE_BUCKET=lamba-source-bucket-awesome
    # ssm key name for where we are storing the bucket name
    # where we put lambda source code 

    PIPELINE_CODE_REPO=py-ground
    # CodeCommit Repository name

    PIPELINE_CODE_BRANCH=master
    # Branch to monitor and deploy from

    CODEBUILD_RUNTIME_VERSION='python:2.7.12'
    # The Version of the CodeBuild container you want to use to create your artifacts
    # z.B.: python:2.7.12 for python or golang:1.7.3 for golang

#### Create Pipeline
easy-peasy:

    ./create-pipeline-go.sh

## To-Dos:
* Figure out how to remove dependency in the CF that it produces on roles that are in this pipeline (in case user deletes codepipeline stack before the deployed stack which causes problems when cleaning up)
* Move deployment role to be cetralized and shareable and `more secure`™
* Fix ECR version of scripts
