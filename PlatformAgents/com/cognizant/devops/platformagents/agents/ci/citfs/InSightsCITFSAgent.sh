#! /bin/sh
# /etc/init.d/InSightsCITFSAgent

### BEGIN INIT INFO
# Provides: Runs a Python script on startup
# Required-Start: BootPython start
# Required-Stop: BootPython stop
# Default-Start: 2 3 4 5
# Default-stop: 0 1 6
# Short-Description: Simple script to run python program at boot
# Description: Runs a python program at boot
### END INIT INFO
#export INSIGHTS_AGENT_HOME=/home/ec2-user/insightsagents
source /etc/profile

case "$1" in
  start)
    if [[ $(ps aux | grep '[c]i.citfs.CITFSAgent' | awk '{print $2}') ]]; then
     echo "InSightsCITFSAgent already running"
    else
     echo "Starting InSightsCITFSAgent"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/citfs
     python -c "from com.cognizant.devops.platformagents.agents.ci.citfs.CITFSAgent import CITFSAgent; CITFSAgent()" &
    fi
    if [[ $(ps aux | grep '[c]i.citfs.CITFSAgent' | awk '{print $2}') ]]; then
     echo "InSightsCITFSAgent Started Sucessfully"
    else
     echo "InSightsCITFSAgent Failed to Start"
    fi
    ;;
  stop)
    echo "Stopping InSightsCITFSAgent"
    if [[ $(ps aux | grep '[c]i.citfs.CITFSAgent' | awk '{print $2}') ]]; then
     sudo kill -9 $(ps aux | grep '[c]i.citfs.CITFSAgent' | awk '{print $2}')
    else
     echo "InSIghtsCITFSAgent already in stopped state"
    fi
    if [[ $(ps aux | grep '[c]i.citfs.CITFSAgent' | awk '{print $2}') ]]; then
     echo "InSightsCITFSAgent Failed to Stop"
    else
     echo "InSightsCITFSAgent Stopped"
    fi
    ;;
  restart)
    echo "Restarting InSightsCITFSAgent"
    if [[ $(ps aux | grep '[c]i.citfs.CITFSAgent' | awk '{print $2}') ]]; then
     echo "InSightsCITFSAgent stopping"
     sudo kill -9 $(ps aux | grep '[c]i.citfs.CITFSAgent' | awk '{print $2}')
     echo "InSightsCITFSAgent stopped"
     echo "InSightsCITFSAgent starting"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/citfs
     python -c "from com.cognizant.devops.platformagents.agents.ci.citfs.CITFSAgent import CITFSAgent; CITFSAgent()" &
     echo "InSightsCITFSAgent started"
    else
     echo "InSightsCITFSAgent already in stopped state"
     echo "InSightsCITFSAgent starting"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/citfs
     python -c "from com.cognizant.devops.platformagents.agents.ci.citfs.CITFSAgent import CITFSAgent; CITFSAgent()" &
     echo "InSightsCITFSAgent started"
    fi
    ;;
  status)
    echo "Checking the Status of InSightsCITFSAgent"
    if [[ $(ps aux | grep '[c]i.citfs.CITFSAgent' | awk '{print $2}') ]]; then
     echo "InSightsCITFSAgent is running"
    else
     echo "InSightsCITFSAgent is stopped"
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/InSightsCITFSAgent {start|stop|restart|status}"
    exit 1
    ;;
esac
exit 0
