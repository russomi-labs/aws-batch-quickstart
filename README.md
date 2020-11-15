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

## Usage

- TODO

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you **would** like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
