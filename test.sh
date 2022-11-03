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
  title: /tmp1 exists
  severity: 100
  query: |
    file("/tmp1") {
      permissions.user_readable == true
    }
EOF
cnspec version
grep -i pretty_name /etc/os-release

cnspec scan local --incognito --score-threshold 100 -o full -f /tmp/test.yaml --json >/tmp/out.json
echo exit:$?
cat /tmp/out.json | jq --monochrome-output
