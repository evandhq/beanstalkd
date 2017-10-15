# Beanstalkd Docker

To deploy on AbarCloud:
1. Deploy beanstalkd:
   ```
   oc new-app --strategy=docker https://github.com/evandhq/beanstalkd.git
   ```
2. Create a storage volume in AbarCloud and attach it to the beanstalkd deployment under `/var/lib/beanstalkd`
3. Deploy the web console using this:
  ```
  oc new-app --strategy=docker --name=beanstalkd-console --context-dir=beanstalkd-console \
  --env AUTH=enable \
  --env AUTH_USERNAME=MY_USERNAME_HERE \
  --env AUTH_PASSWORD=MY_PASSWORD_HERE \
  https://github.com/schickling/dockerfiles
  ```
4. Create a secure route for the console:
  ```
  oc expose service beanstalkd-console --name=beanstalkd-console --hostname=beanstalkd-console-staging.abar.cloud
  oc patch route/beanstalkd-console -p '{"spec":{"tls":{"termination":"edge","insecureEdgeTerminationPolicy":"Redirect"}}}'
  ```
