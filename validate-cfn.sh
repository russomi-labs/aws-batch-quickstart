#!/bin/bash

CLI_PROFILE=$AWS_PROFILE

# Validate the CloudFormation template
aws cloudformation validate-template \
    --profile $CLI_PROFILE \
    --template-body file://main.yaml \
