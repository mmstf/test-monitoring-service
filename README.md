### Description
Service monitors test-service by requesting api

### Project location
Paste your files into ```/opt/exps/test-monitoring``` location - service work directory is setup to this directory
```bash
mkdir -p /opt/exps/test-monitoring
cd /opt/exps/test-monitoring
git clone https://github.com/mmstf/test-monitoring-service.git .
```

### How to run service easily
```bash
chmod 744 ./boot-service.sh
./boot-service.sh
```