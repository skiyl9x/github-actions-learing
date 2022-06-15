#!/bin/bash
ACCESS_TOKEN=$ACCESS_TOKEN
REG_TOKEN=$(curl -sX POST -H "Authorization: token $ACCESS_TOKEN" https://api.github.com/repos/skiyl9x/github-actions-learing/actions/runners/registration-token | jq .token --raw-output)
cd /home/runner/actions-runner

./config.sh --url https://github.com/skiyl9x/github-actions-learing --token $REG_TOKEN --labels RedHat8,terraform-instance
./run.sh & tail -f /dev/null
#
