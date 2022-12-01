#!/bin/sh

set -e

echo "## config api gateway..##"

echo "create upstream.."
curl -ss -XPUT "http://127.0.0.1:9180/apisix/admin/upstreams/100" -H "X-API-KEY: edd1c9f034335f136f87ad84b625c8f1" -d '
{
  "type": "roundrobin",
  "name": "php-app-be",
  "nodes": {
    "192.168.1.47:10000": 1
  }
}'

echo "create public route.."
curl -ss -XPUT "http://127.0.0.1:9180/apisix/admin/routes/100" -H "X-API-KEY: edd1c9f034335f136f87ad84b625c8f1" -d '
{
  "methods": ["GET"],
  "name": "Public route",
  "uri": "/app-01/*",
  "upstream_id": "100"
}'
