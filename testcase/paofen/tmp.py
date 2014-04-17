#!/usr/bin/env python
#-*- coding: UTF-8 -*

import os
import sys
import time
import getopt
import string
import random

def removeRecentList(d, app_desc):
    d.press.home()
    d.press.recent()
    time.sleep(1)
    if d(description=app_desc).exists:
        d(description=app_desc).long_click()
        d(text="Remove from list").click()
    d.press.home()


def runtest(serialno, loop):
    if serialno:
        from uiautomator import Device
        d = Device(serialno)
    else:
        from uiautomator import device as d

    d.watcher("liushui").when(text="Video problem").stop()
    d(description="Apps").click() 
    print "liushui"
    while loop:
       time.sleep(2) 
       print d.watcher("liushui").triggered
    print "test success!"


def main():
    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option("-l", "--loop", dest="loop", default="10",
            help="the loop count of this testcase to run [default: %default]")
    parser.add_option("-s", dest="serialno", 
            help="the device serialno")
    (options, args) = parser.parse_args()

    runtest(options.serialno, string.atoi(options.loop))


if __name__ == "__main__":
    main()
