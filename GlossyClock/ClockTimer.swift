//
// Created by Mikael Hallendal on 16/05/15.
// Copyright (c) 2015 Mikael Hallendal. All rights reserved.
//

import Foundation

class ClockTimer {
    let interval: NSTimeInterval
    var timer: dispatch_source_t?

    init(interval: NSTimeInterval) {
        self.interval = interval
    }

    func start(callback: (NSDate) -> ()) {
        if let t = timer {
            dispatch_source_cancel(t)
        }

        let t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue())
        let startTime = dispatch_time(DISPATCH_TIME_NOW, Int64(interval))
        dispatch_source_set_timer(t, startTime, UInt64(interval), 0)
        dispatch_source_set_event_handler(t) { callback(NSDate()) }
        dispatch_resume(t)

        timer = t
    }

    func stop() {
        if let t = timer {
            dispatch_source_cancel(t)
        }

        timer = nil
    }
}