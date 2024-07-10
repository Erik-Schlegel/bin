# Sync To

## Description
Syncs changes in a watched linux local folder to a remote (ssh'd) folder. This is a one-way operation; changes in the remote do not sync to the local.


## Local Setup
- Install requisite tools
`sudo apt install inotify-tools`
- Create one or more configs from the template
`cp _template.synconfig custom.synconfig`

- Modify your configuration file(s)

## Remote Setup
ssh into the remote and create a destination folder into which your local folder will be copied.

## List the available configs
`syncTo -l`

## Run syncTo
  - using default `my.synconfig` file
  `./syncTo`
  - using custom config file, assuming custom.synconfig exists
   `./syncTo -c custom`
