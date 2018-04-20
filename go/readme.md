## Purpose
General template to copy/clone/fork/delete from that is based on [AWS SAM](https://github.com/awslabs/serverless-application-model) and
golang

# To Use:
#### Update the deploy.sh script
You will need to configure the following 2 lines (1 if you are ok with the stack name)

    STACK_NAME=go-playground
    ARTIFACT_BUCKET_NAME=YOUR_BUCKET_NAME_HERE

Change `YOUR_BUCKET_NAME_HERE` to whatever your lambda source bucket is.

Then, assuming your `aws-cli` is configured properly and you have the correct credentials, you can just run `./deploy.sh` and it should setup a stack in cloudformation with this lambda.

## To Do:
... more to come
