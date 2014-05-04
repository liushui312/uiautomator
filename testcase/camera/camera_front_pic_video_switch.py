#!/usr/bin/env python
#-*- coding: UTF-8 -*

import time
import sys
import getopt
import string

def runtest(serialno, loop):
    if serialno:
        from uiautomator import Device
        d = Device(serialno)
        #d = Device("860424734447f8e0109")
    else:
        from uiautomator import device as d

    print "总共 %d 次循环" %loop
    for i in range(1, loop):
        print "第 %d 次循环" %i
        d.screen.on()
        d.press.home()
        d(description="Apps").click()
        d(text="Camera").click()
        d(description="Menu button").click()
        d.click(302,412)
        time.sleep(2)
        d(description="Camera, video, or panorama selector").click()
        d(description="Switch to photo").click()
        d(description="Shutter button").click()
        d(description="Camera, video, or panorama selector").click()
        d(description="Switch to video").click()
        d(description="Shutter button").click()
        time.sleep(30)
        d(description="Shutter button").click()
        d(description="Menu button").click()
        d.click(306,409)
        time.sleep(2)
        d.press.back()
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

    runtest(options.serialno, string.atoi(options.loop))


if __name__ == "__main__":
    main()
