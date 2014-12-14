find . -name "*.jpg" -size -1k -print -exec rm {} \;
find . -name "*.jpg" -size -15k -exec jpeginfo -c {} \; | grep -e WARNING -e ERROR | awk ' { print $1 } ' | xargs rm
#find . -name "*.jpg" -exec jpeginfo -c {} \; | grep -e WARNING -e ERROR | awk ' { print $1 } ' | xargs rm
