# TimeTracking-workers
The main idea of the application is to display certain dashboards with indicators depending on the role of the user, Admin, Worker. The company has projects, according to which it is calculated how much the employee spent hours per project

## Installation 

### Docker
The repo is dockerised so you can  clone/git pull the repo into any local directory

```
$ git clone https://github.com/NjekTt/TimeTracking-workers
```

Open the terminal in this directory and run:

```
$ docker-compose up -d
```

and open then http://localhost:32792/dsw/index.html#/IRISAPP


## Dashboard "Overview"

This dashboard shows general metrics. Certain indicators will be displayed depending on the user's role. For example, for the Admin user, all possible data will be shown, for the Worker user only the data of workers.

![image](https://user-images.githubusercontent.com/47400570/143784136-f854a2e5-c218-43be-998d-dccc221a948d.png)
