# Url-To-Html
An API to get the HTML from a given URL.  The information of the website is transformed into a hash using [Metainspector](https://github.com/jaimeiniesta/metainspector).  It also uses [Sidekiq](https://github.com/mperham/sidekiq) to process the requests in the background.

## API Methods
| Method | Response |
|--------|----------|
|fetchHTML(url) | { jobID: [integer]} |
##### Example 
```
$ curl -H "Content-Type: application/json" -X GET -d '{"url": "http://google.com"}' http://localhost:3000/jobs/fetchHTML => {"jobID":43}
```


| Method | Response |
|--------|----------|
|fetchJobStatus(id) | {{"jobID": [integer],"status" : [text]}}|
##### Example 
```
/jobs/fetchJobStatus/2 =>
{"jobID":2,"status":"COMPLETE"}
```


| Method | Response |
|--------|----------|
|fetchJob(id) | {{"id": [integer],"url": [text],"html":[text],"server_code": [integer],"completed":[boolean],"created_at":[datetime],"updated_at":[dattime]}}|
##### Example 
```
/jobs/fetchJob/2 =>
{"id":2,"url":"http://yahoo.com","html":"\u003chtml\u003e\u003cbody\u003eyahoo was here\u003c/body\u003e\u003c/html\u003e","server_code":200,"completed":true,"created_at":"2016-08-23T19:35:07.114Z","updated_at":"2016-08-23T19:35:07.114Z"}
```

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