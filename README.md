# Docker container for CRON

This cron container receives jobs via the environment variables and scrips to be run can be mounted via volumes. Output is logged to the console

## Examples

To run any of the examples below, clone this repository locally and build a sample image:

```
$> git clone https://github.com/cristiroma/docker.cron.git
$> cd docker.cron
$> sudo su
#> docker build -t cronimage .
```

## Example 1 - Run echo every minute


```
docker run --rm -e "CRON_JOB_ECHO=* * * * * root . /usr/local/bin/cron-env.sh; echo \"Hello Dave ...\"" --name sisyphus_container cronimage
```

After a couple of minutes, the console should look like this:

```
Installing job: CRON_JOB_ECHO in /etc/cron.d/CRON_JOB_ECHO
1 CRON jobs installed ...
```

