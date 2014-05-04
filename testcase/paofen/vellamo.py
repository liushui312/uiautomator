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
    d.watcher("Vellamo out of memory").when(text="Vellamo Out of Memory").click(text="ok")
    for i in range(1, loop+1):
        print "第 %d 次循环" %i
        d.screen.on()
        d.press.home()
        removeRecentList(d, "Benchmarking Application")
        d(description="Apps").click()
        d(text="Vellamo").click()
        time.sleep(2)

        if d(text="Accept").exists:
            d(text="Accept").click()
        if d(text="Welcome").exists:
            d.swipe(500,240,100,240)
            d.swipe(500,240,100,240)
            d.swipe(500,240,100,240)
        d(className="android.support.v4.view.ViewPager", \
            resourceId="com.quicinc.vellamo:id/act_main_pager_portrait")\
            .child(className="android.view.View")[0].click()

        #d(className="android.view.View")[2].click()
        if d(text="Yes").exists:
            d(text="Yes").click()
        while not d(text="Your device's score!").exists:
            time.sleep(2)
        else:
            d.screenshot("%s/screenshot/%d_vellamo_%s.png"\
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
