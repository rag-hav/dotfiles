#!/usr/bin/env python3

import socket
from pid.decorator import pidfile
from pid import PidFileError
from datetime import datetime
import os
import re
import shutil
import time
import json

from http_parser.http import HttpStream
from http_parser.reader import SocketReader

home = os.getenv("HOME")
if not home:
    print("Error Home directory not found")
    exit(2)

# home folder for everything
CODE_HOME = os.path.join(home, "cc")

# template file that will be copied to new file
TEMPLATE = os.path.join(CODE_HOME, "templates/default.cpp")

LOGFILE = os.path.join(CODE_HOME, ".cchlog")

# path to file that will store $qid environment variable
EXPORTS_FILE = os.path.join(home, ".exports.sh")


PORTS = [
    1327,
    4244,
    6174,
    10042,
    10043,
    10045,
    27121,
]

HOST = "127.0.0.1"


def pexport(value):
    print("pexport ", value)
    with open(EXPORTS_FILE, "r") as f:
        txt = f.read()

    newtxt = re.sub(f"qid=.*", f"qid='{value}'", txt)
    if newtxt == txt:
        newtxt += f"\nqid='{value}'"

    print(newtxt)

    with open(EXPORTS_FILE, "w") as f:
        f.write(newtxt)


@pidfile("cch", piddir="/tmp/")
def main():
    data = ""
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:

        # try to bind to all ports
        port = 0
        while 1:
            try:
                s.bind((HOST, PORTS[port % len(PORTS)]))
                print("Ready")
                break
            except OSError:
                time.sleep(0.5)
                port += 1
                if port > 100:
                    print("Failed to bina a port")
                    exit(1)
        s.listen()

        while 1:
            conn, addr = s.accept()
            qid = ""
            site = ""
            with conn:
                r = SocketReader(conn)
                p = HttpStream(r)
                data = json.load(p.body_file())
                print(data)
                if "codechef" in data["url"]:
                    qid = data["url"].split("/")[-1]
                    site = "codechef"

                elif "codeforces" in data["url"]:
                    qid = (
                        "".join(data["url"].split("/")[-3:])
                        .replace("contest", "")
                        .replace("problem", "")
                    )
                    site = "codeforces"

                elif "hackerearth" in data["url"]:
                    site = "hackerearth"
                    qid = data["name"].title()

                elif "atcoder" in data["url"]:
                    site = "atcoder"
                    qid = "".join(data["url"].split("/")[-1])

                elif "cses" in data["url"]:
                    site = "cses"
                    qid = data["name"]

                elif "spoj" in data["url"]:
                    site = "spoj"
                    qid = data["name"]

                elif "leetcode" in data["url"]:
                    site = "leetcode"
                    qid = data["name"]

                else:
                    site = "misc"
                    qid = data["name"]

                qid = "".join(a for a in qid if a.isalnum())

                if qid != os.getenv("qid"):
                    pexport(qid)

                codefile = os.path.join(CODE_HOME, site, qid + ".cpp")
                site = os.path.join(CODE_HOME, site)

                if not os.path.isdir(site):
                    os.mkdir(site)

                os.chdir(site)

                if not os.path.isfile(codefile):
                    shutil.copyfile(TEMPLATE, codefile)

                for i, test in enumerate(data["tests"]):
                    with open(f".{qid}_ans{i+1}", "w") as f:
                        f.write(test["input"])
                    with open(f".{qid}_in{i+1}", "w") as f:
                        f.write(test["output"])

                with open(LOGFILE, "a") as log:
                    log.write(str(datetime.now()) + "\t" + data["name"] + "\n")


if __name__ == "__main__":

    try:
        main()
    except PidFileError:
        print("Already running")
