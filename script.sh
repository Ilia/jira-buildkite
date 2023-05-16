#!/bin/bash


JIRA_VERSION_NAME=$1

# Jira configuration in order to create version and assign tickets that will be released to it.
JIRA_PROJECT_ID=17612
JIRA_URL=https://smartbear.atlassian.net
if [ -z ${JIRA_AUTH} ]; then 
  echo "JIRA_AUTH not set, please set it with by exporting JIRA_AUTH=email:token, you can create a token here: https://id.atlassian.com/manage-profile/security/api-tokens"
  exit 128
fi

echo "Getting Versions" 
JIRA_VERSION_ID=$(curl -s --request GET \
   --url "$JIRA_URL/rest/api/3/project/$JIRA_PROJECT_ID/version?query=$JIRA_VERSION_NAME" \
   --user "$JIRA_AUTH" \
   --header 'Accept: application/json' \
   --header 'Content-Type: application/json' | jq '.values[].id' | tr -d '"')

echo 
echo "Updating Release for Version ID: $JIRA_VERSION_ID"

payload_update="{\"released\":true,\"releaseDate\":\"$(date '+%Y-%m-%d')\"}"
curl -s --request PUT \
   --url "$JIRA_URL/rest/api/3/version/$JIRA_VERSION_ID" \
   --user "$JIRA_AUTH" \
   --header 'Accept: application/json' \
   --header 'Content-Type: application/json' \
   --data "${payload_update}"