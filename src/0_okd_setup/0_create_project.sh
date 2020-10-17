#!/usr/bin/env bash
# O_create_project.sh
# O_create_project.sh is a script for setting OKD project
#
# Variables:
# PROJECT_NAME=${1:-sasmlopshmeq} the name of the project
# DISPLAY_NAME=${2:-'SAS ModelOps HMEQ Tensorflow'} the label of the project
# SERVICE_ACCOUNT=${3:-ivnard} the name of service account to control API access without token
#
# Steps:
# 1 - Create new project
# 2 - Create service account
# 3 - Add policy roles
# 4 - Print service account info and ask to export the token

# Variables
PROJECT_NAME=${1:-sasmlopshmeq}
DISPLAY_NAME=${2:-"SAS ModelOps HMEQ Tensorflow"}
SERVICE_ACCOUNT=${3:-ivnard}
TAG=${PROJECT_NAME}:${SERVICE_ACCOUNT}

# 1 - Create new project
echo "$(date '+%x %r') INFO Creating new project..."
oc new-project ${PROJECT_NAME} --display-name="${DISPLAY_NAME}"

# 2 - Create service account (default is ivnard...)
echo "$(date '+%x %r') INFO Creating ivnard service account..."
oc create serviceaccount ${SERVICE_ACCOUNT}

# 3 - Add policy roles
echo "$(date '+%x %r') INFO Adding policy role to the ${SERVICE_ACCOUNT} service account..."
oc policy add-role-to-user system:image-builder system:serviceaccount:${TAG}
oc policy add-role-to-user edit system:serviceaccount:${TAG}

# 4 - Print service account info and ask to export the token
echo "$(date '+%x %r') INFO Describing ${SERVICE_ACCOUNT} ..."
oc describe sa ivnard
echo ""
echo "------------------------------------------------------------"
echo "Please:"
echo ""
echo "1. Select on token secret running the following command:"
echo ""
echo "oc describe secret ivnard-token-<id>."
echo ""
echo "2. Export the token in a TOKEN variable"
echo ""
echo "export TOKEN=<tokenid>"
echo ""
echo "------------------------------------------------------------"
