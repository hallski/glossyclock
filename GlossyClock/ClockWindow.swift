//
// Created by Mikael Hallendal on 16/05/15.
// Copyright (c) 2015 Mikael Hallendal. All rights reserved.
//

import Foundation
import Cocoa


class ClockWindow: NSWindow {

    override init(contentRect: NSRect,
                  styleMask aStyle: Int,
                  backing bufferingType: NSBackingStoreType,
                  defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: aStyle, backing: bufferingType, defer: flag)

        setupWindow()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupWindow() {
        opaque = false
        backgroundColor = NSColor.clearColor()
        movableByWindowBackground = true
        level = Int(CGWindowLevelForKey(CGWindowLevelKey(kCGPopUpMenuWindowLevelKey)))
        styleMask = NSBorderlessWindowMask
        setIsVisible(true)
    }

    override func setIsVisible(flag: Bool) {
        self.animator().alphaValue = flag ? 1.0 : 0.0

        super.setIsVisible(flag)
    }

    func toggleVisibility() {
        self.setIsVisible(!self.visible)
    }
}
