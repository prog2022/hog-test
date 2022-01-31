#!/bin/sh
# Test student code using ok

if [ ! -f hog.py ]; then
	echo "No file hog.py"
	exit 1
fi
errors=`python3 ok --local | grep Error | wc -l`
exit $errors
