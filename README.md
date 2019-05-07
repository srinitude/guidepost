# Guidepost

[![Gem Version](https://badge.fury.io/rb/guidepost.svg)](https://badge.fury.io/rb/guidepost)

## Purpose

Your knowledge base is an incredibly important component of your company, providing value to your customers, employees, and other stakeholders! The purpose of this project is to help you gain more control over it.

## Current Use Cases

* [Back up your knowledge base to S3](#back-up-your-knowledge-base-to-s3)
* [Import your knowledge base into your application](#import-your-knowledge-base-into-your-application)

## Table of Contents

* [Prerequisites/Requirements](#prerequisites-requirements)
* [Knowledge Base Providers](#knowledge-base-providers)
* [Storage Services](#storage-services)
* [Installation](#installation)
* [Environment Variables](#environment-variables)
* [Usage](#usage)
* [Contact](#contact)
* [Roadmap](#roadmap)
* [License](#license)

### Prerequisites/Requirements

* Rails 4.2+
* Ruby 2.5+

### Knowledge Base Providers

* Zendesk

### Storage Services

* Amazon Simple Storage Service (Amazon S3)

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'guidepost'
```

And then execute:

    $ bundle

### Environment Variables

Make sure to have certain environmental variables set, preferrably in your `.bash_profile` or in your `.bashrc`! The prefix of each environment variable needs to be the uppercased version of the name of your project that you will use to initialize your `Guidepost::Provider` (i.e. Zendesk in this case, since this is the only provider currently supported):

#### Zendesk

```ruby
# The email associated with your Zendesk subdomain
ENV["#{YOUR_PROJECT_NAME}_GUIDEPOST_ZENDESK_EMAIL"]

# The password token associated with your Zendesk subdomain
ENV["#{YOUR_PROJECT_NAME}_GUIDEPOST_PASSWORD_TOKEN"]
```

#### S3

```ruby
# The access key associated with your AWS account
ENV["#{YOUR_PROJECT_NAME}_GUIDEPOST_AWS_ACCESS_KEY_ID"]

# The secret key associated with your AWS account
ENV["#{YOUR_PROJECT_NAME}_GUIDEPOST_AWS_SECRET_ACCESS_KEY"]

# The name of the S3 bucket you want to upload your backups to
ENV["#{YOUR_PROJECT_NAME}_GUIDEPOST_S3_BUCKET_NAME"]
```

### Usage

#### Back up your knowledge base to S3

```ruby
# The subdomain of your Zendesk account
subdomain = "example"

# The name you want to give to your project (name your environment variables accordingly)
project_name = "example"

zendesk = Guidepost::Provider::Zendesk.new(subdomain: subdomain, project_name: project_name)
zendesk.backup_all_articles
```

#### Import your knowledge base into your application



```ruby

```

## Contact

If you find and want to address any security issues with the project, email [me](mailto:srinitude@gmail.com.com)! For anything else, like bug identifications or feature requests, feel free to file a Github issue or tweet me [@srinitude](https://twitter.com/srinitude).

## Roadmap

* Tests
* More robust documentation
* More relevant use cases

## License

Guidepost is released under the [MIT License](LICENSE).
