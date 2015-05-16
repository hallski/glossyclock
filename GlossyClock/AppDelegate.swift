//
// Created by Mikael Hallendal on 16/05/15.
// Copyright (c) 2015 Mikael Hallendal. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var clockView: ClockView!
    
    var clockTimer = ClockTimer(interval: 1.0)

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        clockTimer.start { date in
            self.clockView.time = date
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

