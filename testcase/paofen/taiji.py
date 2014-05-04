#!/usr/bin/env python
#-*- coding: UTF-8 -*

import os
import sys
import time
import getopt
import string
import random
import datetime

now = datetime.datetime.now()
ISOFORMAT='%Y_%m_%d_%H_%M_%S' #设置输出格式

def removeRecentList(d, app_desc):
    d.press.home()
    d.press.recent()
    time.sleep(1)
    if d(description=app_desc).exists:
        d(description=app_desc).long_click()
        d(text="Remove from list").click()
    d.press.home()


def runtest(serialno, loop):
    print "liu: in runtest"
    if serialno:
        print "liu: in serialno"
        from uiautomator import Device
        d = Device(serialno)
    else:
        print "liu: in else"
        from uiautomator import device as d

    print "总共 %d 次循环" %loop

    for i in range(1, loop+1):
        print "第 %d 次循环" %i
        d.screen.on()
        d.press.home()
        d(description="Apps").click()
        d(text="Basemark ES2 Taiji Free").click()
        time.sleep(2)

        if d(text="Agree").exists:
            d(text="Agree").click()

        d(text="Run Benchmark").click()
        while not d(text="FRAMES PER SECOND").exists:
            time.sleep(2)
        else:
            d.screenshot("%s/screenshot/%d_taiji_%s.png"\
                    %(sys.path[0], i, now.strftime(ISOFORMAT)))

        d.press.home()
        i += 1

    print "***** test end ********"


def main():
    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option("-l", "--loop", dest="loop", default="10",
            help="the loop count of this testcase to run [default: %default]")
    parser.add_option("-s", dest="serialno", 
            help="the device serialno")
    (options, args) = parser.parse_args()
    print "liu: before runtest"
    runtest(options.serialno, string.atoi(options.loop))


if __name__ == "__main__":
    main()
