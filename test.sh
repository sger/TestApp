#!/usr/bin/env bash
access_token=$BITRISE_API_ACCESS_TOKEN
app_slug=$BITRISE_APP_SLUG
build_slug=$BITRISE_BUILD_SLUG

bitrise_api_url="https://api.bitrise.io/v0.1"
the_url="$bitrise_api_url/apps/$app_slug/builds/$build_slug/artifacts"

artifacts_array=$(curl -s -H "Authorization: $access_token" $the_url)

for artifact_index in 0 1 2
do
    artifact=$(echo ${artifacts_array} | jq -r ".data[$artifact_index]")

    artifact_slug=$(echo ${artifact} | jq -r '.slug')

    artifact_url="$the_url/$artifact_slug"

    artifact_metadata_response=$(curl -s -H "Authorization: $access_token" ${artifact_url})
    artifact_name=$(echo ${artifact_metadata_response} | jq -r '.data .title')
    artifact_download_url=$(echo ${artifact_metadata_response} | jq -r '.data .expiring_download_url')
    echo
    echo ":point_down: $artifact_name :point_down:"
    echo
    echo ${artifact_download_url}
done