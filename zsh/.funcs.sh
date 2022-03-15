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
        echo -e "yt-dlp -o \"${HOME}/Music/youtube_dl/%(title)s.%(ext)s\" --extract-audio --embed-thumbnail --audio-format mp3  ${query} "
        yt-dlp -o "${HOME}/Music/youtube_dl/%(title)s.%(ext)s" --extract-audio --embed-thumbnail --audio-format mp3 ${query}
    else
        becho "Searching..."
        echo -e "yt-dlp -o \"${HOME}/Music/youtube_dl/%(title)s.%(ext)s\" --extract-audio --embed-thumbnail --audio-format mp3  \"ytsearch:${query}\" "
        yt-dlp -o "${HOME}/Music/youtube_dl/%(title)s.%(ext)s" --extract-audio --embed-thumbnail --audio-format mp3 "ytsearch:${query}"
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
    local i=1
    local success=true
    local caseIn=".${a}_in${i}"
    local caseAns=".${a}_ans${i}"
    local caseOut=".${a}_out${i}"
    [ -e "$caseIn" ] || recho "No test case for ${a}"
    while [ -e "$caseIn" ]; do

        \time -o timetmp -f "Time Taken %e\n" ./$b <$caseIn >$caseOut 2>err

        becho "\n\n****************************"
        becho "Test Case: ${i}"
        becho "****************************"
        yecho "\nInput: "
        cat $caseIn
        yecho "\n\nOutput: "
        cat $caseOut
        if [ -s err ]; then
            yecho "\n\nErrors: "
            cat err
        fi
        yecho "\n\nExpected: "
        cat $caseAns
        yecho "\n\nDiff: "
        # remove all comments from input file. gcc -fpreprocessed -dD -E $b.cpp
        # check if there is "trace" in result. grep
        # if not, then output diff 
        grep -q "trace" =(gcc -fpreprocessed -dD -E $b.cpp) && { echo "Skipped..." && success=false } || { diff --color=always -Zsa =(nl -ba -w3 -s"| " $caseAns) =(nl -ba -w3 -s"| " $caseOut ) || success=false }
        yecho "\n\nResult: "
        cat timetmp
        rm timetmp err

        let "i++"
        caseIn=".${a}_in${i}"
        caseAns=".${a}_ans${i}"
        caseOut=".${a}_out${i}"
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
    local i=1
    local success=true
    local caseIn=".${a}_in${i}"
    local caseAns=".${a}_ans${i}"
    local caseOut=".${a}_out${i}"
    [ -e "$caseIn" ] || recho "No test case for ${a}"
    while [ -e "$caseIn" ]; do

        \time -o "timetmp" -f "Time Taken %e\n" ./$b <$caseIn 1>$caseOut 
        becho "\n\n****************************"
        becho "Test Case: ${i}"
        becho "****************************"

        yecho "\nDiff: "
        grep -q "trace" =(gcc -fpreprocessed -dD -E $b.cpp) && { echo "Skipped..." && success=false } || { diff --color=always -Zsa =(nl -ba -w3 -s"| " $caseAns) =(nl -ba -w3 -s"| " $caseOut ) || success=false }

        yecho "\n\nResult: "
        cat timetmp
        rm timetmp 

        let "i++"
        caseIn=".${a}_in${i}"
        caseAns=".${a}_ans${i}"
        caseOut=".${a}_out${i}"
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
    local i=1
    local caseIn=".${a}_in${i}"
    local caseAns=".${a}_ans${i}"
    local caseOut=".${a}_out${i}"
    [ -e "$caseIn" ] || recho "No test case for ${a}"
    local success=true
    while [ -e "$caseIn" ]; do

        \time -o "timetmp" -f "\nTime Taken %e\nMemory %M" ./$b <$caseIn 1>$caseOut 2>&1
        becho "\n\n****************************"
        becho "test case: ${i}"
        becho "****************************"

        diff --color=always -Zsaq =(nl -ba -w3 -s"| " $caseAns) =(nl -ba -w3 -s"| " $caseOut ) || success=false
        cat timetmp
        rm timetmp 

        let "i++"
        caseIn=".${a}_in${i}"
        caseAns=".${a}_ans${i}"
        caseOut=".${a}_out${i}"
    done

    if [ "$success" = true ]; then
        gecho "Sample test cases passed"
        submit $b
    else
        recho "Sample test cases failed"
    fi
}

cleancch() {
    rm ~/cc/*/.*_in* ~/cc/*/.*_ans* ~/cc/*/.*_out* 
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
    subfile="${HOME}/submit.cpp"
    echo -e "#include <bits/stdc++.h> \n" >$subfile
    gcc -D SUBMIT -E "${a}.cpp" | grep -A 10000 "using namespace std;" | sed "/^#/d" >>$subfile && gecho "Created $subfile"
 }

precompile() {
    echo -e "#include <bits/stdc++.h> \n" >"precompiled.cpp"
    gcc -E $1 | grep -A 10000 "using namespace std;" | sed "/^#/d" >>"precompiled.cpp"
    \cat precompiled.cpp
}
