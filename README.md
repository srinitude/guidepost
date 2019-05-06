# Guidepost

## Purpose

Your knowledge base is a hugely important component of your company! The purpose of this project is to help you gain more control over it.

## Table of Contents

* [Prerequisites/Requirements](#prerequisites-requirements)
* [Current Knowledge Base Providers](#current-knowledge-base-providers)
* [Current Storage Services](#current-storage-services)
* [Installation](#installation)
* [Environment Variables](#environment-variables)
* [Current Use Cases](#current-use-cases)
* [Contact](#contact)
* [Roadmap](#roadmap)
* [License](#license)

### Prerequisites/Requirements

* Rails 4.2+
* Ruby 2.5+

### Current Knowledge Base Providers

* Zendesk

If you're looking to use this gem, but work with providers like Freshdesk, Zoho, and Confluence, feel free to reach out!

### Current Storage Services

* Amazon Simple Storage Service (Amazon S3)

If you're looking to use this gem, but work with other storage services like Google Cloud Storage, feel free to reach out!

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

### Current Use Cases

* Back up your knowledge base to S3

#### Back up your knowledge base to S3

```ruby
subdomain = "example"
project_name = "example"

zendesk = Guidepost::Provider::Zendesk.new(subdomain: subdomain, project_name: project_name)
zendesk.backup_all_articles
```

## Contact

If you find and want to address any security issues with the project, email [Kiren Srinivasan](mailto:srinitude@gmail.com.com)! For anything else, feel free to file a Github issue or tweet me [@srinitude](https://twitter.com/srinitude).

## Roadmap

* Tests
* More robust documentation
* More relevant use cases

## License

Guidepost is released under the [MIT License](LICENSE).