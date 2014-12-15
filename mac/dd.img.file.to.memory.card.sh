#!/usr/bin/env bash

diskutil list
echo -n "Which /dev/disk would you like to be the target of your dd?: "
read TARGET
echo -n "Do you really want to completely erase contents of ${TARGET}: [y/N]: "
read ANSWER
if [ "${ANSWER}" != "y" ]; then
   echo "Ok, no harm done."
   exit 0;
fi

if [ -z "${1}" ] ; then
   echo "Specify image file"
   exit 311
fi

IMAGEFILE="${1}"

if [ ! -r "${IMAGEFILE}" ]; then
    echo "Cannot read '${IMAGEFILE}'. Please make sure it exists and is readable"
    exit 911;
fi

echo diskutil unmountDisk ${TARGET}
diskutil unmountDisk ${TARGET}

echo "dd'ing ${IMAGEFILE} to ${TARGET}, show a little patience"
echo sudo dd bs=1m if="${IMAGEFILE}" of="${TARGET}"
time sudo dd bs=1m if="${IMAGEFILE}" of="${TARGET}"

echo "That's all folks..."
