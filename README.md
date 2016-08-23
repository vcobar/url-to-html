# Url-To-Html

## Running Locally

### Install dependencies

- Install Redis
On Linux
```
$ sudo apt-get install redis-server
```
- On Mac
```
$ brew install redis
```

### Starting the App
- Install dependencies
```
bundle install
```
- Start Sidekiq
```
bundle exec sidekiq
```
- Start redis
```
redis-server
```
- Start the Rails App
```
rails server
```