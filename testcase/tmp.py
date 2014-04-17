#!/usr/bin/env python

import time
#from uiautomator import device as d
from uiautomator import Device

#d = Device("c19284734447e810506")
d = Device("860424734447f8e0109")

print d.info

d.screen.on()
d.press.home()
d(description="Apps").click()
#d(text="Calculator").click()
#d(text="9").click()
#d(description="multiply").click()
#d(text="2").click()
#d(text="=").click()
#d.press.back()
#d.press.back()
#d.screen.off()


#d.screen.on()
#d.press.home()
#d(description="Apps").click()
#d(text="Settings").click()
#d(className="android.widget.ListView", resourceId="android:id/list") \
#.child_by_text(
#"About tablet",
#allow_scroll_search=True,
#className="android.widget.TextView"
#).click()


#d.screen.on()
#d.press.home()
#d(description="Apps").click()
#d(text="Camera").click()
#d(description="Camera, video, or panorama selector").click()
#d(description="Switch to photo").click()
#d(description="Shutter button").click()
#d(description="Menu button").click()
#d.click(302,412)
#d(description="Shutter button").click()
#d(description="Menu button").click()
#case $DEVICE in
#    p4)
#        d.click(302,412)
#        ;;
#    *)
#        echo "DEVICE is required"
#        exit 1
#esac


#d.screen.on()
#d.press.home()
#d.orientation = "r"
#time.sleep(1)
#d.orientation = "n"
#time.sleep(1)
#d.orientation = "l"
#time.sleep(1)
#d.orientation = "n"

