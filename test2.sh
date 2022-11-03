#!/bin/bash

set -e

cat <<EOF >/tmp/test.yaml
policies:
- uid: my-policies
  specs:
  - asset_filter:
      query: platform.family.contains(_ == 'unix')
    scoring_queries:
      test1: null
queries:
- uid: test1
  title: /tmp/1667513535.txt exists
  severity: 100
  query: |
    file("/tmp/1667513535.txt") {
      permissions.group_readable == true
    }
EOF
cnspec version
grep -i pretty_name /etc/os-release

touch /tmp/1667513535.txt
chmod 700 /tmp/1667513535.txt
cnspec scan local --incognito --score-threshold 100 -o full -f /tmp/test.yaml --json >/tmp/out.json
echo exit:$?
jq --monochrome-output . /tmp/out.json
