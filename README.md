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
- cd ~/3rdparty_src$ ./x_prometheus_receiver
- cd /Applications/prometheus-1.6.2.darwin-amd64/; /Applications/prometheus-1.6.2.darwin-amd64$ ./prometheus -config.file=prometheus.yml

* Ruby version

* System dependencies

* Configuration
- Prometheus Server:
  - Install Prometheus server from https://prometheus.io/download/ and configure it to scrape from metric_gamble app.
  - Start Prometheus: /Applications/prometheus-1.6.2.darwin-amd64$ ./prometheus -config.file=prometheus.yml
- Configure Prometheus to send metrics to Wavefront:
  - Install Go.
  - Follow https://www.robustperception.io/using-the-remote-write-path/.
  - I installed wavefront_prometheus_receiver to ~/3rdparty_src as I already had the receiver.
  - chmod u+x wavefront_prometheus_receiver
  - Ensure prometheus.yml contains remote_write: url: http://localhost:1234/receive as specified in above.
  - Start wavefront_prometheus_receiver: ~/3rdparty_src$ ./wavefront_prometheus_receiver
- Install proxy to forward metrics to Wavefront:
  - java -version it should be version 1.7 or 1.8. If not, install java first.
  - Make a “wavefront” directory or similar and keep everything in it.
  - Download Wavefront Proxy to the wavefront directory you created: https://wavefront-customer.s3.amazonaws.com/proxy-release/wavefront-push-agent-3.24-1.jar
  - Download wavefront.conf to same wavefront directory from Github and enter a valid token in the line where it says: token=
  - You can get a token from within the Wavefront UI by going to Gear Icon (top right hand corner) → click your email → scroll down the API Access section.
  - Run the proxy:
  - cd /Applications/wavefront; nohup java -jar ./wavefront-push-agent-3.24-1.jar -f ./wavefront.conf >> ./wavefront.log 2>&1 &
  - Browse --> Agents within the Wavefront UI to see your Agent. If you send now data to port 2878 on localhost it should wind up in Wavefront.
  
* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
