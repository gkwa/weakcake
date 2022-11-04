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
      permissions.user_readable == true
    }
EOF
cnspec version
grep -i pretty_name /etc/os-release

rm -f /tmp/1667513535.txt
cnspec scan local --incognito --score-threshold 100 --output full --policy-bundle /tmp/test.yaml --json >/tmp/out.json
echo exit:$?
jq --monochrome-output . /tmp/out.json
