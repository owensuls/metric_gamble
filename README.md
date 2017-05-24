# README

## Overview
The purpose of this application is to provide a fun game for users to play to
try to win a prize. This game is intended to demonstrate usage of the Prometheus monitoring technology,
 whilst at the same time providing entertainment. It uses the Prometheus client library to emit metrics,
 the Prometheus server to scrape metrics from the client, and a Wavefront Proxy to forward metrics to
 Wavefront.

How it works:
* Application prompts user to enter their name.
* User clicks a button that selects a random number.
* A metric data point is emitted where:
  * Value of the data point is the random number.
  * "Name" point tag is included with the data point.
  * Value of the "Name" point tag is that entered by the user.
* Prometheus server subsequently scrapes this metric and forwards it to Wavefront.
* Person with the data point whose value is highest during the event wins a prize.

## Running the application
The following instructions make some assumptions about where stuff is installed.

* cd /Applications/wavefront; nohup java -jar ./wavefront-push-agent-3.24-1.jar -f ./wavefront.conf >> ./wavefront.log 2>&1 &
* cd Folder_Where_Wavefront_Prometheus_Receiver_Installed; ./wavefront_prometheus_receiver
* cd /Applications/prometheus-1.6.2.darwin-amd64/; ./prometheus -config.file=prometheus.yml
* cd Home_Folder_For_This_App; bin/rails server

## Ruby version used
2.4.0

## Installing and configuring dependencies
* Prometheus Server:
  * Install Prometheus server from https://prometheus.io/download/ and configure it to scrape from metric_gamble app.
* Configure Prometheus to send metrics to Wavefront:
  * Install Go.
  * Follow https://www.robustperception.io/using-the-remote-write-path/ (I already had the receiver so skipped this).
  * chmod u+x wavefront_prometheus_receiver
  * Ensure prometheus.yml contains remote_write: url: http://localhost:1234/receive as specified in above instructions.
* Install Wavefront proxy to forward metrics to Wavefront:
  * java -version: should be version 1.7 or 1.8. If not, install JDK.
  * Make a “wavefront” directory or similar and keep everything in it.
  * Download Wavefront Proxy to the wavefront directory you created: https://wavefront-customer.s3.amazonaws.com/proxy-release/wavefront-push-agent-3.24-1.jar
  * Download wavefront.conf to same wavefront directory from Github and enter a valid token in the line where it says: token=
  * You can get a token from within the Wavefront UI by going to Gear Icon (top right hand corner) → click your email → scroll down the API Access section.
  * Run the proxy:
    * cd /Applications/wavefront; nohup java -jar ./wavefront-push-agent-3.24-1.jar -f ./wavefront.conf >> ./wavefront.log 2>&1 &
    * Browse --> Agents within the Wavefront UI to see your Agent.
    * If you send now data to port 2878 on localhost it should wind up in Wavefront.

## Database creation
* Use following command (similar to instructions at http://guides.rubyonrails.org/getting_started.html#creating-the-article-model).
* /bin/rails generate model Randomnumber name:string number:number
