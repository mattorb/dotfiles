#!/bin/bash
go get -d ./...
go build -ldflags="-s -w" -o ../../bin/listrepo listrepo.go
go build -ldflags="-s -w" -o ../../bin/listrepo_gql listrepo_gql.go
