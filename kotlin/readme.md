# Kotlin SAM Ground Zero
Please steal, duplicate, hack, smash, criticise, etc this
repo.  This is only here to give samples to anyone and keep
notes of where I can grow my SAM-fu.

## Use:
#### Update the deploy.sh script
You will need to configure the following 2 lines (1 if you are ok with the stack name)

    STACK_NAME=kotlin-playground
    ARTIFACT_BUCKET_NAME=YOUR_BUCKET_NAME_HERE

Change `YOUR_BUCKET_NAME_HERE` to whatever your lambda source bucket is.

Then, assuming your `aws-cli` is configured properly and you have the correct credentials, you can just run `./deploy.sh` and it should setup a stack in cloudformation with this lambda.

## Resources:
* [SAM](https://github.com/awslabs/serverless-application-model)
* [Kotlin](https://kotlinlang.org/)
* [Gradle](https://gradle.org/)

## Todo:
* integrate the deploy process into gradle's scripts (when in
Rome or something...)
* ... more
