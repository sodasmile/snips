#!/bin/bash

set -e
set -u
SCRIPT="$0"
SCRIPT_PATH="`/bin/readlink -f ${SCRIPT}`"
SCRIPT_NAME="`/usr/bin/basename ${SCRIPT_PATH}`"
SCRIPT_DIR="`/usr/bin/dirname ${SCRIPT_PATH}`"

debug() {
    : #/bin/echo -e "DEBUG: ${1}"
}

info() {
    /bin/echo -e "INFO: ${1}"
}

debug "SCRIPT PATH: ${SCRIPT_PATH}"
debug "SCRIPT_NAME: ${SCRIPT_NAME}"
debug "SCRIPT_DIR: ${SCRIPT_DIR}"

set +u
if [ -z "${1}" ]; then
    info "Specify config file"
    exit 911
fi
set -u

CONFIG_FILE="${SCRIPT_DIR}/${1}"
debug "CONFIG_FILE: ${CONFIG_FILE}"

if [ ! -r "${CONFIG_FILE}" ]; then
    info "Cannot find config file ${CONFIG_FILE}"
    exit 411
fi

. ${CONFIG_FILE}

debug "DATE_FORMAT: ${DATE_FORMAT}"
FORMATTED_DATE=`date +${DATE_FORMAT}`

debug "FORMATTED_DATE: ${FORMATTED_DATE}"

OUTPUT_FILE="${SCRIPT_DIR}/${OUTPUT_FOLDER}/${PREFIX}${FORMATTED_DATE}${EXT}"

debug "OUTPUT_FILE: ${OUTPUT_FILE}"

ERROR_OUT="/dev/null"

/usr/bin/curl -# ${SRC_ADDRESS} 2> ${ERROR_OUT} > ${OUTPUT_FILE}

