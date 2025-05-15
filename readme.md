# Instructions

```bash
# Build container
docker compose build

# Start Session
./develop.sh

# There is a bug in the Dockerfile where the ~/ardupilot folder does not get populated from the repository.  For now, run these commands on your first session.

git clone https://github.com/ArduPilot/ardupilot.git
cd ardupilot
git submoduld update --init --recursive

# Now Build
cd ardupilot
./waf list_boards                   # Find your hardware
./waf configure --board pixhawk1    # configure for your hardware
./waf rover                         # build 
```
