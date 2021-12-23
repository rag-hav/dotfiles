gecho() {
    echo -e "\e[1;32m${1}\e[0m"
}

yecho(){
    echo -e "\e[1;33m${1}\e[0m"
}

recho(){
    echo -e "\e[1;31m${1}\e[0m"
}

becho(){
    echo -e "\e[1;34m${1}\e[0m"
}

songdl() {

    # check karo, ki argument diya hai ki nhi
    if [[ -z $1 ]]; then
        # agar argument nhi h, toh input lo
        echo -e "Enter song to search and download"
        read query

    else
        # warna argument hi query h
        query="$*"
    fi

    # ye command actually download karega
    if [[ $query =~ "https?://(www.)?youtu\.?be.*" ]]; then
        becho "Downloading song from url"
        echo -e " youtube-dl -o \"/home/raghav/Music/youtube_dl/%(title)s.%(ext)s\" --extract-audio --embed-thumbnail --audio-format mp3  ${query} "
        youtube-dl -o "/home/raghav/Music/youtube_dl/%(title)s.%(ext)s" --extract-audio --embed-thumbnail --audio-format mp3 ${query}
    else
        becho "Searching..."
        echo -e "youtube-dl -o \"/home/raghav/Music/youtube_dl/%(title)s.%(ext)s\" --extract-audio --embed-thumbnail --audio-format mp3  \"ytsearch:${query}\" "
        youtube-dl -o "/home/raghav/Music/youtube_dl/%(title)s.%(ext)s" --extract-audio --embed-thumbnail --audio-format mp3 "ytsearch:${query}"
    fi
}

pexport() {
    if [[ -z $2 ]]; then
        a="qid"
        b=$1
    else
        a=$1
        b=$2
    fi

    pexportpy $a $b
    export $a=$b
}

ftester() {
    if [[ -z $1 ]]; then
        a=$qid
        b=$qid
    else
        if [[ $1 == "-t" ]]; then
            a=${qid}
            b=${qid}tmp
        else
            a=$1
            b=$1
        fi
    fi


    make $b || return
    i=1
    local success=true
    caseIn=".in_${a}_${i}"
    caseAns=".ans_${a}_${i}"
    caseOut=".out_${a}_${i}"
    [ -e "$caseIn" ] || recho "No test case for ${a}"
    while [ -e "$caseIn" ]; do

        \time -o "timetmp" -f "\nTime Taken %e\nMemory %M" ./$b <$caseIn 1>$caseOut 2>&1

        becho "\n\n****************************"
        becho "test case: ${i}"
        becho "****************************"
        yecho "\n\ninput: "
        cat $caseIn
        yecho "\n\noutput: "
        cat $caseOut
        yecho "\n\nexpected: "
        cat $caseAns
        yecho "\n\ndiff: "
        # remove all comments from input file. gcc -fpreprocessed -dD -E $b.cpp
        # check if there is "trace" in result. grep
        # if not, then output diff 
        grep -q "trace" =(gcc -fpreprocessed -dD -E $b.cpp) && { recho "Skipped..." && success=false } || { diff --color=always -Zsa =(nl -ba -w3 -s"| " $caseAns) =(nl -ba -w3 -s"| " $caseOut ) || success=false }
        cat timetmp
        rm timetmp $caseOut

        let "i++"
        caseIn=".in_${a}_${i}"
        caseAns=".ans_${a}_${i}"
        caseOut=".out_${a}_${i}"
    done

    if [ "$success" = true ]; then
        gecho "Sample test cases passed"
        submit $b
    else
        recho "Sample test cases failed"
    fi
}

tester() {
    if [[ -z $1 ]]; then
        a=$qid
        b=$qid
    else
        if [[ $1 == "-t" ]]; then
            a=${qid}
            b=${qid}tmp
        else
            a=$1
            b=$1
        fi
    fi

    make ${b} || return
    i=1
    local success=true
    caseIn=".in_${a}_${i}"
    caseAns=".ans_${a}_${i}"
    caseOut=".out_${a}_${i}"
    [ -e "$caseIn" ] || recho "No test case for ${a}"
    while [ -e "$caseIn" ]; do

        \time -o "timetmp" -f "\nTime Taken %e\nMemory %M" ./$b <$caseIn 1>$caseOut 2>&1
        becho "\n\n****************************"
        becho "test case: ${i}"
        becho "****************************"

        grep -q "trace" =(gcc -fpreprocessed -dD -E $b.cpp) && { recho "Skipped..." && success=false } || { diff --color=always -Zsa =(nl -ba -w3 -s"| " $caseAns) =(nl -ba -w3 -s"| " $caseOut ) || success=false }
        grep -q "trace" $b.cpp && { recho "Skipped..." && success=false } || { diff --color=always -Zsa =(nl -ba -w3 -s"| " $caseAns) =(nl -ba -w3 -s"| " $caseOut ) || success=false }
        cat timetmp
        rm timetmp $caseOut

        let "i++"
        caseIn=".in_${a}_${i}"
        caseAns=".ans_${a}_${i}"
        caseOut=".out_${a}_${i}"
    done

    if [ "$success" = true ]; then
        gecho "Sample test cases passed"
        submit $b
    else
        recho "Sample test cases failed"
    fi
}

qtester() {
    if [[ -z $1 ]]; then
        a=$qid
        b=$qid
    else
        if [[ $1 == "-t" ]]; then
            a=${qid}
            b=${qid}tmp
        else
            a=$1
            b=$1
        fi
    fi

    make ${b} || return
    caseIn=".in_${a}_${i}"
    caseAns=".ans_${a}_${i}"
    caseOut=".out_${a}_${i}"
    [ -e "$caseIn" ] || recho "No test case for ${a}"
    i=1
    local success=true
    while [ -e "$caseIn" ]; do

        \time -o "timetmp" -f "\nTime Taken %e\nMemory %M" ./$b <$caseIn 1>$caseOut 2>&1
        becho "\n\n****************************"
        becho "test case: ${i}"
        becho "****************************"

        diff --color=always -Zsaq =(nl -ba -w3 -s"| " $caseAns) =(nl -ba -w3 -s"| " $caseOut ) || success=false
        cat timetmp
        rm timetmp $caseOut

        let "i++"
        caseIn=".in_${a}_${i}"
        caseAns=".ans_${a}_${i}"
        caseOut=".out_${a}_${i}"
    done

    if [ "$success" = true ]; then
        gecho "Sample test cases passed"
        submit $b
    else
        recho "Sample test cases failed"
    fi
}

cleancch() {
    rm ~/cc/*/.in_* ~/cc/*/.ans_* 
    find ~/cc/ -type f ! -name "*.*" -delete
}

solncompare() {

    # ye executables
    # 1 test case maker
    # 2 soln 1
    # 3 soln 2

    echo -e "test_case_maker soln1 soln2 runs"

    chmod +x $1

    if [[ -z $4 ]]; then
        runs=100
    else
        runs=$4
    fi

    i=0

    while [ $i -lt $runs ]; do

        ./$1 >solncompare_tc
        ./$2 <solncompare_tc >solncompare_out1
        ./$3 <solncompare_tc >solncompare_out2

        diff --color=always -Zsa =(nl -ba -w3 -s"| " $caseAns) =(nl -ba -w3 -s"| " $caseOut ) || success=false

        let "i++"

    done
}

submit() {
    if [[ -z $1 ]]; then
        a=$qid
    else
        a=$1
    fi
    subfile="/home/raghav/submit.cpp"
    echo -e "#include <bits/stdc++.h> \n" >$subfile
    gcc -C -E "${a}.cpp" | grep -A 10000 "using namespace std;" | sed "/^#/d" >>$subfile && gecho "Created $subfile"
}

precompile() {
    echo -e "#include <bits/stdc++.h> \n" >"precompiled.cpp"
    gcc -C -E $1 | grep -A 10000 "using namespace std;" | sed "/^#/d" >>"precompiled.cpp"
    \cat precompiled.cpp
}
