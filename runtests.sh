#!/bin/bash

if [ ! -f "ok" ]; then
   echo "No ok file"
   exit 9
fi

# Arrays to record results. Elements are appended in runtests()
questions=(00 01 02 03 04 05 06 07 08 09 10 11 12)
expect=(2 59 36 10 107 111 8 5 7 8 106 105 1)
actual=()

drawline( ) {
echo "----------------------------------------------------------------------"
}

runtests( ) {
	for question in ${questions[@]}; do
        echo -n "Question $question  "
		# grep -C 0 -A 3 = print 0 lines of context, 1 following line
        export result=$(python3 ok --local -q $question | grep -C 0 -A 3 "Test summary" | grep "test cases")
		echo $result
		correct=`echo $result | cut -d " " -f1`
		actual+=($correct)
	done
}

showresults() {
    drawline
    echo "RESULTS of 'ok' on All Questions"
    drawline
    echo "#Tests=total test cases for a question"
    echo ""
    echo "Question  #Tests  #Correct  Status"
    failures=0

	length=${#questions[@]}

	for (( question=0; question<$length; question++ )); do
        if [ ${expect[$question]} -eq ${actual[$question]} ]; then
			pass="Pass!"
		else
			pass="Fail"
			failures=$(($failures+1))
		fi
        printf "   %02d      %4d     %4d    %s\n" ${question} ${expect[$question]} ${actual[$question]} $pass
	done
    correct=$(($length-$failures))
	echo "Total  $correct Correct  $failures Incorrect"
	echo ""
	if [ $failures -eq 0 ]; then
		echo "All Questions Passed.  Great Work!"
	elif [ $failures -eq 1 ]; then
		echo "Almost Done!  Fix the 1 question with failures/locked test."
	fi
    exit $failures
}

runtests
showresults
