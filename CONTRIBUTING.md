# Contributing to TaxCloud

This gem is the work of [many contributors](https://github.com/txcrb/tax_cloud/graphs/contributors). You're encouraged to submit [pull requests](https://github.com/txcrb/tax_cloud/pulls), [propose features, ask questions, and discuss issues](https://github.com/txcrb/tax_cloud/issues).

## Fork the Project

Fork the [project on GitHub](https://github.com/txcrb/tax_cloud) and check out your copy.

```sh
git clone https://github.com/contributor/tax_cloud.git
cd tax_cloud
git remote add upstream https://github.com/txcrb/tax_cloud.git
```

## Create a Topic Branch

Make sure your fork is up-to-date and create a topic branch for your feature or bug fix.

```sh
git checkout master
git pull upstream master
git checkout -b my-feature-branch
```

## Run Tests

Ensure that you can build the project and run tests.

```sh
bundle install
bundle exec rake
```

VCR and WebMock replay recorded TaxCloud responses from `test/cassettes`, so tests do not call the API. To record new requests against TaxCloud, delete the cassettes you want to refresh and set your keys first. The cassettes filter out your configuration details.

```sh
TAXCLOUD_API_LOGIN_ID=... TAXCLOUD_API_KEY=... TAXCLOUD_USPS_USERNAME=... bundle exec rake test
```

## Lint

`bundle exec rake lint` checks Ruby, Ruby examples in Markdown, YAML, and spelling with RuboCop, [rubocop-md](https://github.com/rubocop/rubocop-md), [rubocop-prose](https://github.com/dblock/rubocop-prose), [rubocop-spellcheck](https://github.com/dblock/rubocop-spellcheck), and [rubocop-yaml](https://github.com/dblock/rubocop-yaml). The linters install only on MRI Ruby 3.3 and newer, where `bundle exec rake` runs lint and tests; on older Rubies it runs tests only. Add reviewed project vocabulary to `.spellcheck.txt`.

## Write Tests

Try to write a test that reproduces the problem you're trying to fix or describes a feature that you want to build. Add to [test](test).

## Write Code

Implement your feature or bug fix.

## Write Documentation

Document any external behavior in the [README](README.md).

## Update Changelog

Add a line to [CHANGELOG](CHANGELOG.md) under *Next*. Make it look like every other line, including your name and link to your GitHub account.

## Commit Changes

Make sure git knows your name and email address.

```sh
git config --global user.name "Your Name"
git config --global user.email "contributor@example.com"
```

Writing good commit logs is important. A commit log should describe what changed and why.

```sh
git add ...
git commit
```

## Push

```sh
git push origin my-feature-branch
```

## Make a Pull Request

Go to https://github.com/contributor/tax_cloud and select your feature branch. Click the "Pull Request" button and fill out the form. Pull requests are usually reviewed within a few days.

## Thank You

Please do know that we really appreciate and value your time and work. We love you, really.
