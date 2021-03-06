# Micro-Learning App

[![CircleCI](https://circleci.com/gh/chadwalt/micro-learning-app.svg?style=svg)](https://circleci.com/gh/chadwalt/micro-learning-app)
[![Maintainability](https://api.codeclimate.com/v1/badges/5d552065374c71f28f36/maintainability)](https://codeclimate.com/github/chadwalt/micro-learning-app/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/5d552065374c71f28f36/test_coverage)](https://codeclimate.com/github/chadwalt/micro-learning-app/test_coverage)

Micro-Learning App is a responsive web application that sends you one or multiple pages per day about things you want to learn.

The application provides a user with a choice of specifying interests and through this, appropriate pages are found and sent via the user's email.

## Usage
Using  [Ruby Version Manager](https://rvm.io/rvm/install) download and install the latest version of ruby, which can be downloaded from [here](https://www.ruby-lang.org/en/downloads/).

The application is built with [sinatra Web Framework](http://sinatrarb.com/) which is one of the fastest, secure and most reliable web framework.

To clone the respository execute the following command.
```
git clone https://github.com/chadwalt/micro-learning-app.git
```

Execute the following code to install all the application dependencies.
```
bundle install
```

The application can be run locally by executing the following command
```
shotgun
```

To access the appliation navigate to
```
https://micro-learning-app-staging.herokuapp.com/
```

The application uses `whenever gem` to send emails to users very 24 hours informing them about something new to learn about.

Before sending emails one has to create an email that will be used to send emails, and these have to be provided in the STMP configurations. The application requries one to provide following to fully configure email sending:- `EMAIL_DOMAIN`, `EMAIL`, `EMAIL_USERNAME`,and `EMAIL_PASSWORD`.

Executing this rake command triggers the sending of emails.
```
rake send_emails:mail
```

### Testing
Tests can be run using
```
bundle exec rspec
```

