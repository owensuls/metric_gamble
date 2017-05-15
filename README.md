# README

The purpose of this application is to provide a fun game for users to play to
try to win a prize. This game is intended to demonstrate usage of the Prometheus monitoring technology,
 whilst at the same time providing entertainment.

The logic is as follows:
- Enter their name.
- Click a button that selects a random number.
- Causes a data point to be sent to Wavefront.
  - Value of the data point is the random number.
  - "Name" point tag is included with the data point sent.
  - Value of the "Name" point tag is that entered by the user.
  - For example Name=Owen Sullivan
- Person with the data point whose value is highest during the event wins a prize.

* Run
- /$ cd /Applications/prometheus-1.6.2.darwin-amd64/
- /Applications/prometheus-1.6.2.darwin-amd64$ ./prometheus -config.file=prometheus.yml

* Ruby version

* System dependencies

* Configuration
- Install Prometheus server from https://prometheus.io/download/ and configure it to scrape from metric_gamble app.

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
