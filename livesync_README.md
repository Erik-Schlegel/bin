# Sync To

## Description
Syncs changes in a watched local folder to a remote folder. This is a one-way operation; changes in the remote do not sync to the local.


## Local Setup
- Install requisite tools
`sudo apt install inotify-tools sshpass`
- Create one or more configs from the template
`cp __template.synconfig custom.synconfig`
- Modify your custom configuration file(s)

## Remote Setup
ssh into the remote and create a destination folder into which your local folder will be copied.

## List the available livesync configs
`livesync -l`

## Run livesync
  - using config file. Assuming your_custom.synconfig exists
   `./livesync -c your_custom`
