#!/bin/sh
# Test student code using ok

if [ ! -f hog.py ]; then
	echo "No file hog.py"
	exit 1
fi
python3 ok --local

# Run test again and count failing tests
errors=`python3 ok --local | grep Error | wc -l`
exit $errors
