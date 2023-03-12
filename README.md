### Hexlet tests and linter status:
[![Actions Status](https://github.com/asagafonov/rails-project-66/workflows/hexlet-check/badge.svg)](https://github.com/asagafonov/rails-project-66/actions)

[![linter & tests](https://github.com/asagafonov/rails-project-66/actions/workflows/linter-and-tests.yml/badge.svg)](https://github.com/asagafonov/rails-project-66/actions/workflows/linter-and-tests.yml)


### [Deployment link](https://rails-code-analyzer.up.railway.app)

> Deployment might be down if Railway hours expire by the end of the month. Feel free to set up project locally, instructions below.

### Project description

The app allows you to add GitHub repositories and perform linter checks on them (currently available for JavaScript and Ruby).

<hr>

### Launch project locally

Set correct versions
```
16.19.0 for NodeJS
3.1.2 for Ruby
```

Install dependencies
```
bundle install
yarn install
```

Seed database
```
rails db:seed
```

Run migrations
```
rails migrate
```

Run server
```
rails server
```

Visit project locally
```
http://localhost:3000
```

<hr>

### Coded by

[@asagafonov](https://github.com/asagafonov)