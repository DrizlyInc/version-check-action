#!/usr/bin/env bash

set -e

function check_version {
  VERSION=$1
  ! curl -s ${GITHUB_API_URL}/repos/${GITHUB_REPOSITORY}/git/matching-refs/tags | jq -e --arg VERSION "$VERSION" '.[] | select(.ref | endswith($VERSION))'

  if [ $? -eq 0 ]; then
    echo "::set-output name=new-version::true"
  else
    echo "::set-output name=new-version::false"
  fi
}


if [ ! -z "${INPUT_VERSION}" ]; then
  check_version $INPUT_VERSION
  exit 0
fi

if [ ! -z "${INPUT_VERSION_FILE}" ]; then
  check_version $(cat ${INPUT_VERSION_FILE})
  exit 0
fi

echo "Either 'version' or 'version_file' must be provided!"
exit 1
