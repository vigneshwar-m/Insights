#-------------------------------------------------------------------------------
# Copyright 2017 Cognizant Technology Solutions
#   
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License.  You may obtain a copy
# of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations under
# the License.
#-------------------------------------------------------------------------------
#! /bin/sh
# /etc/init.d/InSightsGitLabAgent

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
    if [[ $(ps aux | grep '[s]cm.gitlab.GitLabAgent' | awk '{print $2}') ]]; then
     echo "InSightsGitLabAgent already running"
    else
     echo "Starting InSightsGitLabAgent"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/gitlab
     python -c "from com.cognizant.devops.platformagents.agents.scm.gitlab.GitLabAgent import GitLabAgent; GitLabAgent()" &
    fi
    if [[ $(ps aux | grep '[s]cm.gitlab.GitLabAgent' | awk '{print $2}') ]]; then
     echo "InSightsGitLabAgent Started Sucessfully"
    else
     echo "InSightsGitLabAgent Failed to Start"
    fi
    ;;
  stop)
    echo "Stopping InSightsGitLabAgent"
    if [[ $(ps aux | grep '[s]cm.gitlab.GitLabAgent' | awk '{print $2}') ]]; then
     sudo kill -9 $(ps aux | grep '[s]cm.gitlab.GitLabAgent' | awk '{print $2}')
    else
     echo "InSIghtsGitLabAgent already in stopped state"
    fi
    if [[ $(ps aux | grep '[s]cm.gitlab.GitLabAgent' | awk '{print $2}') ]]; then
     echo "InSightsGitLabAgent Failed to Stop"
    else
     echo "InSightsGitLabAgent Stopped"
    fi
    ;;
  restart)
    echo "Restarting InSightsGitLabAgent"
    if [[ $(ps aux | grep '[s]cm.gitlab.GitLabAgent' | awk '{print $2}') ]]; then
     echo "InSightsGitLabAgent stopping"
     sudo kill -9 $(ps aux | grep '[s]cm.gitlab.GitLabAgent' | awk '{print $2}')
     echo "InSightsGitLabAgent stopped"
     echo "InSightsGitLabAgent starting"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/gitlab
     python -c "from com.cognizant.devops.platformagents.agents.scm.gitlab.GitLabAgent import GitLabAgent; GitLabAgent()" &
     echo "InSightsGitLabAgent started"
    else
     echo "InSightsGitLabAgent already in stopped state"
     echo "InSightsGitLabAgent starting"
     cd $INSIGHTS_AGENT_HOME/PlatformAgents/gitlab
     python -c "from com.cognizant.devops.platformagents.agents.scm.gitlab.GitLabAgent import GitLabAgent; GitLabAgent()" &
     echo "InSightsGitLabAgent started"
    fi
    ;;
  status)
    echo "Checking the Status of InSightsGitLabAgent"
    if [[ $(ps aux | grep '[s]cm.gitlab.GitLabAgent' | awk '{print $2}') ]]; then
     echo "InSightsGitLabAgent is running"
    else
     echo "InSightsGitLabAgent is stopped"
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/InSightsGitLabAgent {start|stop|restart|status}"
    exit 1
    ;;
esac
exit 0
