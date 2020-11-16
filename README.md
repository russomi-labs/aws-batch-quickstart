# AWS Batch Quickstart

An AWS Batch Quickstart repo to deploy the infrastructure required to run AWS Batch Jobs.

## Installation

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
docker tag batch_processor:latest 673839138862.dkr.ecr.us-east-1.amazonaws.com/batch-processing-job-repository:latest
docker push 673839138862.dkr.ecr.us-east-1.amazonaws.com/batch-processing-job-repository:latest
```

## Deployment

- Review `deploy-infra.sh` and customize the environment variables at the top of
  the script.
- Execute `./deploy-infra.sh` to deploy `setup.yaml` and `main.yaml`
- Every commit will trigger a new docker image build and push to ECR based on the `buildspec.yml`
- Execute `./validate-cfn.sh` to ensure the templates are valid

## TODO

- [ ] Add Launch Template to Compute Environment to expand disk
- [ ] Add CloudWatchEvent Schedule to trigger AWS Batch Job
- [ ] Add SNS Notification for Success/Failure
- [ ] Add CI with CodeBuild for PRs and Feature Branches

## Resources

- [get-login-password](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ecr/get-login-password.html)
- [Build a Continuous Delivery Pipeline for Your Container Images with Amazon ECR as Source](https://aws.amazon.com/blogs/devops/build-a-continuous-delivery-pipeline-for-your-container-images-with-amazon-ecr-as-source/)
- [Docker sample for CodeBuild](https://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html)
- [Quick Start Contributor's Guide](https://aws-quickstart.github.io/index.html)

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you **would** like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
