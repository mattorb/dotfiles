#!/bin/bash
go get -d ./...
go build -o ../../bin/listrepo listrepo.go
go build -o ../../bin/listrepo_gql listrepo_gql.go