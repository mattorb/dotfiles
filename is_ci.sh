#!/usr/bin/env bash

is_ci() {
    # Running inside a GITHUB Action build
    [ ${GITHUB_ACTION} ] && return 0
    
    # Running inside an Azure DevOps pipeline
    if [ "$TF_BUILD" == "True" ]; then
     return 0
    fi
    
    return 1
}