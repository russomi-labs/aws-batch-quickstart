#!/bin/bash

STACK_NAME=aws-batch-quickstart
REGION=us-east-1
CLI_PROFILE=aws-homesite-home-sandbox-acct

AWS_ACCOUNT_ID=`aws sts get-caller-identity --profile $CLI_PROFILE \
        --query "Account" --output text`

CODEPIPELINE_BUCKET="$STACK_NAME-$REGION-codepipeline-$AWS_ACCOUNT_ID"

CFN_BUCKET="$STACK_NAME-cfn-$AWS_ACCOUNT_ID"

# EC2_INSTANCE_TYPE=t2.micro
# DOMAIN=the-good-parts.com
# CERT=`aws acm list-certificates --region $REGION --profile awsbootstrap --output text \
#         --query "CertificateSummaryList[?DomainName=='$DOMAIN'].CertificateArn | [0]"`

# Generate a personal access token with repo and admin:repo_hook
#    permissions from https://github.com/settings/tokens
GH_ACCESS_TOKEN=$(cat ~/.github/aws-batch-quickstart/access-token)
GH_OWNER=$(cat ~/.github/aws-batch-quickstart/owner)
GH_REPO=$(cat ~/.github/aws-batch-quickstart/repo)
GH_BRANCH=master

# Deploys static resources
echo -e "\n\n=========== Deploying setup.yml ==========="
aws cloudformation deploy \
  --region $REGION \
  --profile $CLI_PROFILE \
  --stack-name $STACK_NAME-setup \
  --template-file setup.yaml \
  --no-fail-on-empty-changeset \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    CodePipelineBucket=$CODEPIPELINE_BUCKET \
    CloudFormationBucket=$CFN_BUCKET

# Package up CloudFormation templates into an S3 bucket
echo -e "\n\n=========== Packaging main.yml ==========="
mkdir -p ./cfn_output

PACKAGE_ERR="$(aws cloudformation package \
  --region $REGION \
  --profile $CLI_PROFILE \
  --template main.yaml \
  --s3-bucket $CFN_BUCKET \
  --output-template-file ./cfn_output/main.yaml 2>&1)"

if ! [[ $PACKAGE_ERR =~ "Successfully packaged artifacts" ]]; then
  echo "ERROR while running 'aws cloudformation package' command:"
  echo $PACKAGE_ERR
  exit 1
fi

# Deploy the CloudFormation template
echo -e "\n\n=========== Deploying main.yml ==========="
aws cloudformation deploy \
  --region $REGION \
  --profile $CLI_PROFILE \
  --stack-name $STACK_NAME \
  --template-file ./cfn_output/main.yaml \
  --no-fail-on-empty-changeset \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    GitHubOwner=$GH_OWNER \
    GitHubRepo=$GH_REPO \
    GitHubBranch=$GH_BRANCH \
    GitHubPersonalAccessToken=$GH_ACCESS_TOKEN \
    CodePipelineBucket=$CODEPIPELINE_BUCKET

# If the deploy succeeded, list exports
if [ $? -eq 0 ]; then
  echo -e "Deploy Succeeded."
  # aws cloudformation list-exports \
  #   --profile awsbootstrap \
  #   --query "Exports[?ends_with(Name,'LBEndpoint')].Value"
fi
