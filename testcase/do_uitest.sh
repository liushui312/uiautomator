#!/bin/bash

CUR_FILE_PATH=`dirname $0`
dir_list=`find $CUR_FILE_PATH -maxdepth 1 -type d`
TEST_RESULT="$CUR_FILE_PATH/"

ROOT=$CUR_FILE_PATH
export PATH="${PATH}:"$( find ${ROOT} -type d -exec printf ":"{} \; )

source "common.sh"

create_jelly() {
    jelly="../../../email-templates/UItest.jelly"
    rm $jelly
    cp ../../../email-templates/html.jelly $jelly

    insert_string=$(echo -e '<!-- TEST RESULT -->\n<TABLE width="100%" cellpadding="0" cellspacing="0"><TR><TD class="bg1"><B>TEST RESULT</B></TD></TR></TABLE>\n<TABLE border="1" width="60%">\n<TR><TH>Testcase</TH><TH>Result</TH><TH>Exit value</TH></TR>\n')
    echo "${insert_string}"  >> $jelly

    cat ${TEST_RESULT} | grep 'FAIL' > tm1.txt
    while read line
    do
        testcase_fail=$(echo $line | awk '{print $1}')
        exit_value_fail=$(echo $line | awk '{print $3}')
        
        insert_string="<TR><TD>"${testcase_fail}"</TD><TD><font color=\"red\">FAIL</font></TD><TD>"${exit_value_fail}"</TD></TR>"
        insert_string="${insert_string}$(echo -e '\n')"
        echo "${insert_string}"  >> $jelly

        let fail_count++
    done < tm1.txt  

    cat ${TEST_RESULT} | grep 'PASS' > tm2.txt
    while read line
    do
        testcase_pass=$(echo $line | awk '{print $1}')
        
        insert_string="<TR><TD>"${testcase_pass}"</TD><TD>PASS</TD><TD>0</TD></TR>"
        insert_string="${insert_string}$(echo -e '\n')"
        echo "${insert_string}"  >> $jelly

        let pass_count++
    done < tm2.txt

    rm tm1.txt tm2.txt

    let 'total_count=pass_count + fail_count'

    insert_string=$(echo -e '<BR/>\n</TABLE>\n<TABLE border="1" width="60%">\n<TR><TH>Total</TH><TH>PASS</TH><TH>FAIL</TH></TR>\n')
    echo "${insert_string}"  >> $jelly

    insert_string="<TR><TD>"${total_count}"</TD><TD>${pass_count}</TD><TD><font color=\"red\">${fail_count}</font></TD></TR>"
    echo "${insert_string}"  >> $jelly

    insert_string=$(echo -e '</TABLE>\n<BR/>\n</BODY>\n</j:jelly>\n')
    echo "${insert_string}"  >> $jelly
}

paofen.sh
ret_check
