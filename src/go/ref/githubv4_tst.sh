#!/bin/bash

script='query {
  viewer {
    repositories(first: 100) {
      nodes {
        name
      }
      pageInfo {
        endCursor
        startCursor
        hasNextPage
      }
    }
  }
  organization(login: \"github\") {
    repositories(first: 100) {
      nodes {
        name
      }
      pageInfo {
        endCursor
        startCursor
        hasNextPage
      }
    }
  }

}
'

script="$(echo $script)"   # the query should be onliner, without newlines

echo $script

token=$(cat ~/.fhub_token)
curl -i -H 'Content-Type: application/json' \
   -H "Authorization: bearer $token" \
   -X POST -d "{ \"query\": \"$script\"}" https://api.github.com/graphql


