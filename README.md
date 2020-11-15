# AWS Batch Quickstart

An AWS Batch Quickstart repo to deploy the infrastructure required to run AWS Batch Jobs.

## Installation

- TODO

### GitHub Access Token

We will need a GitHub access token to let CodeBuild pull changes from GitHub. To generate an access token, go to <https://github.com/settings/tokens/new> and click Generate new token.

Give it `repo` and `admin:repo_hook` permissions, and click Generate token.

Tokens and passwords are sensitive information and should not be checked into source repositories. There are sophisticated ways to store them, but for now we will put our new token in a local file that we can later read into an environment variable.

``` BASH
mkdir -p ~/.github/aws-batch-quickstart
echo "aws-batch-quickstart" > ~/.github/aws-batch-quickstart/repo
echo "russomi-labs" > ~/.github/aws-batch-quickstart/owner
echo "<token>" > ~/.github/aws-batch-quickstart/access-token
```

### Build and run from local

``` BASH
cd src
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 673839138862.dkr.ecr.us-east-1.amazonaws.com
docker build -t batch_processor .
docker tag batch-processing-job-repository:latest 673839138862.dkr.ecr.us-east-1.amazonaws.com/batch-processing-job-repository:latest
docker push 673839138862.dkr.ecr.us-east-1.amazonaws.com/batch-processing-job-repository:latest

```

- [get-login-password](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ecr/get-login-password.html) - To log in to an Amazon ECR registry
- https://aws.amazon.com/blogs/devops/build-a-continuous-delivery-pipeline-for-your-container-images-with-amazon-ecr-as-source/
- https://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html

## Usage

- TODO

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you **would** like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
