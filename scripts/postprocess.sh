#!/bin/sh

if [ "$1" = "" ] || [ "$2" = "" ]; then
    echo "Expecting two arguments, got none"
    exit 1
fi

REPO_ROOT=$(cd "$(dirname "$0")/.."; pwd -P)
LOCAL_DIR="${REPO_ROOT}/local"
POSTPROCESSING_SCRIPT="${LOCAL_DIR}/${1}.local.sh"

if [ -x "${POSTPROCESSING_SCRIPT}" ]; then
    sh ${POSTPROCESSING_SCRIPT} "${2}"
    if [ "$?" = "0" ]; then
        echo "Finished running postprocessing script at ${POSTPROCESSING_SCRIPT}"
    else
        echo "Bad exit code when running ${POSTPROCESSING_SCRIPT}"
        exit 1
    fi
else
    echo "No local postprocessing script to apply for ${1}"
fi

exit 0
