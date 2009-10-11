//
//  GlossyClockAppDelegate.h
//  GlossyClock
//
//  Created by Mikael Hallendal on 2009-10-10.
//  Copyright 2009 Mikael Hallendal. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GlossyClockAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
