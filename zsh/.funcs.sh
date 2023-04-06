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

check_chapter() {
    if [[ -z $1 ]]; then
        recho "give link plz"
        return 1
    fi
    sleep_time="${2:-15}"

    while true; do {
        sleep "$sleep_time"; 
        curl -s "$1" | {
            grep -q "disabled\">Next" && date; } 
        } || 
            { notify-send "Chapter aa gya" "$1" && break; } 
        done
    }

songdl() {

    # check karo, ki argument diya hai ki nhi
    if [[ -z $1 ]]; then
        # agar argument nhi h, toh input lo
        echo -e "Enter song to search and download"
        read query

    else
        # warna argument hi query h
        query="$1"
    fi

    # ye command actually download karega
    if [[ $query =~ "https?://(www.)?youtu\.?be.*" ]]; then
        becho "Downloading song from url"
        echo -e "yt-dlp -o \"$HOME/Music/youtube_dl/%(title)s.%(ext)s\" --extract-audio --embed-thumbnail --audio-format mp3 ${@:2:99} $query "
        yt-dlp -o "$HOME/Music/youtube_dl/%(title)s.%(ext)s" --extract-audio --embed-thumbnail --audio-format mp3 "${@:2:99}" "$query"
    else
        becho "Searching..."
        echo -e "yt-dlp -o \"$HOME/Music/youtube_dl/%(title)s.%(ext)s\" --extract-audio --embed-thumbnail --audio-format mp3 ${@:2:99}  \"ytsearch:$query\" "
        yt-dlp -o "$HOME/Music/youtube_dl/%(title)s.%(ext)s" --extract-audio --embed-thumbnail --audio-format mp3 "${@:2:99}" "ytsearch:$query"
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

    pexportpy "$a" "$b"
    export "$a=$b"
}

ftester() {
    if [[ -z $1 ]]; then
        a=$qid
        b=$qid
    else
        if [[ $1 == "-t" ]]; then
            a=$qid
            b=${qid}tmp
        else
            a=$1
            b=$1
        fi
    fi


    make "$b" || return
    local i=1
    local success=true
    local caseIn=".${a}_in$i"
    local caseAns=".${a}_ans$i"
    local caseOut=".${a}_out$i"
    [ -e "$caseIn" ] || recho "No test case for $a"
    while [ -e "$caseIn" ]; do

        \time -o timetmp -f "Time Taken %e\n" ./"$b" <"$caseIn" >"$caseOut" 2>err

        becho "\n\n****************************"
        becho "Test Case: $i"
        becho "****************************"
        yecho "\nInput: "
        cat "$caseIn"
        yecho "\n\nOutput: "
        cat "$caseOut"
        if [ -s err ]; then
            yecho "\n\nErrors: "
            cat err
        fi
        yecho "\n\nExpected: "
        cat "$caseAns"
        yecho "\n\nDiff: "
        # remove all trace output and compare output with expected 
        diff --color=always -Zsa  =(grep -vE  "^([1;[0-9]+m?)[0-9]+> " "$caseOut" | nl -ba -w3 -s"| " )  =(nl -ba -w3 -s"| " "$caseAns") || success=false
        # diff --color=always -W 50 --left-column -yZsa  =(grep -vE  "^([1;[0-9]+m?)[0-9]+> " "$caseOut")  "$caseAns" || success=false 
        yecho "\n\nResult: "
        cat timetmp
        rm timetmp err

        let "i++"
        caseIn=".${a}_in$i"
        caseAns=".${a}_ans$i"
        caseOut=".${a}_out$i"
    done

    if [ "$success" = true ]; then
        gecho "Sample test cases passed"
        submit "$b"
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
            a=$qid
            b=${qid}tmp
        else
            a=$1
            b=$1
        fi
    fi

    make "$b" || return
    local i=1
    local success=true
    local caseIn=".${a}_in$i"
    local caseAns=".${a}_ans$i"
    local caseOut=".${a}_out$i"
    [ -e "$caseIn" ] || recho "No test case for $a"
    while [ -e "$caseIn" ]; do

        \time -o "timetmp" -f "Time Taken %e\n" ./"$b" <"$caseIn" 1>"$caseOut" 
        becho "\n\n****************************"
        becho "Test Case: $i"
        becho "****************************"

        yecho "\nDiff: "
        diff --color=always -Zsa  =(grep -vE  "^([1;[0-9]+m?)[0-9]+> " "$caseOut" | nl -ba -w3 -s"| " )  =(nl -ba -w3 -s"| " "$caseAns") || success=false 

        yecho "\n\nResult: "
        cat timetmp
        rm timetmp 

        let "i++"
        caseIn=".${a}_in$i"
        caseAns=".${a}_ans$i"
        caseOut=".${a}_out$i"
    done

    if [ "$success" = true ]; then
        gecho "Sample test cases passed"
        submit "$b"
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
            a=$qid
            b=${qid}tmp
        else
            a=$1
            b=$1
        fi
    fi

    make "$b" || return
    local i=1
    local caseIn=".${a}_in$i"
    local caseAns=".${a}_ans$i"
    local caseOut=".${a}_out$i"
    [ -e "$caseIn" ] || recho "No test case for $a"
    local success=true
    while [ -e "$caseIn" ]; do

        \time -o "timetmp" -f "\nTime Taken %e\nMemory %M" ./"$b" <"$caseIn" 1>"$caseOut" 2>&1
        becho "\n\n****************************"
        becho "test case: $i"
        becho "****************************"

        diff --color=always -Zsaq  =(grep -vE  "^([1;[0-9]+m?)[0-9]+> " "$caseOut" | nl -ba -w3 -s"| " )  =(nl -ba -w3 -s"| " "$caseAns") || success=false 
        cat timetmp
        rm timetmp 

        let "i++"
        caseIn=".${a}_in$i"
        caseAns=".${a}_ans$i"
        caseOut=".${a}_out$i"
    done

    if [ "$success" = true ]; then
        gecho "Sample test cases passed"
        submit "$b"
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

    chmod +x "$1"

    if [[ -z $4 ]]; then
        runs=100
    else
        runs=$4
    fi

    i=0

    while [ "$i" -lt "$runs" ]; do

        ./"$1" >solncompare_tc
        ./"$2" <solncompare_tc >solncompare_out1
        ./"$3" <solncompare_tc >solncompare_out2

        diff --color=always -Zsa =(nl -ba -w3 -s"| " "$caseAns") =(nl -ba -w3 -s"| " "$caseOut" ) || success=false

        let "i++"

    done
}

submit() {
    if [[ -z $1 ]]; then
        a=$qid
    else
        a=$1
    fi
    subfile="$HOME/submit.cpp"
    echo -e "#include <bits/stdc++.h> \n" > "$subfile"
    gcc -D SUBMIT -E "$a.cpp" | grep -A 10000 "using namespace std;" | sed "/^#/d" >> "$subfile" && gecho "Created $subfile"
}

precompile() {
    {
        echo -e "#include <bits/stdc++.h> \n" 
        gcc -E "$1" | grep -A 10000 "using namespace std;" | sed "/^#/d" 
    } >precompile.cpp 
}

journal() {
    src_dir=$HOME/notes/.diary.encrypted
    mnt_dir=$HOME/notes/diary/
    bkp_dir=$HOME/notes/diary.backup

    if [ ! -d $src_dir ]; then 
        recho "Encrypted folder $src_dir does not exist"
        return 1
    fi


    case $1 in 

        "open")
            if [ -f $mnt_dir/.mount ]; then
                gecho "Journal already open"
            else
                if [ -d $mnt_dir ]; then 
                    find $mnt_dir -empty -type d -delete
                fi
                mkdir -p $mnt_dir

                if [ ! -z "$(ls -A $mnt_dir)" ]; then
                    mkdir -p $bkp_dir
                    if [ ! -z "$(ls -A $mnt_dir)" ]; then
                        recho "Mount dir: $mnt_dir is not empty, but backup dir: $bkp_dir is also not empty"
                        return 1
                    fi
                    mv $mnt_dir/* $bkp_dir
                fi
                gocryptfs -i "10m" $src_dir $mnt_dir
            fi
            ;;

        "close")
            if [ ! -d $mnt_dir ]; then 
                recho "Mount directory: $mnt_dir does not exist"
            fi
            fusermount -u $mnt_dir
            ;;

        *)
            echo "Invalid command\n Use 'journal open' to decrypt the journal\n 'journal close' to encrypt it\n 'journal flush' to flush it"
            ;;
    esac

}
