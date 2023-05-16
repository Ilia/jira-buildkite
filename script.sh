#!/bin/bash

# Jira configuration in order to create version and assign tickets that will be released to it.
JIRA_PROJECT_ID=17612
JIRA_URL=https://smartbear.atlassian.net
if [ -z ${JIRA_AUTH} ]; then 
  echo "JIRA_AUTH not set, please set it with by exporting JIRA_AUTH=email:token, you can create a token here: https://id.atlassian.com/manage-profile/security/api-tokens"
  exit 128
fi

payload_version="{\"archived\":false,\"name\":\"${DEV_TAG::7}\",\"projectId\":${JIRA_PROJECT_ID},\"released\":false}"

curl --request GET \
   --url "$JIRA_URL/rest/api/3/version" \
   --user "$JIRA_AUTH" \
   --header 'Accept: application/json' \
   --header 'Content-Type: application/json' \
   #--data "${payload_version}"
