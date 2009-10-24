//
//  GlossyClockAppDelegate.m
//  GlossyClock
//
//  Created by Mikael Hallendal on 2009-10-10.
//  Copyright 2009 Mikael Hallendal. All rights reserved.
//

#import <Carbon/Carbon.h>

#import "GlossyClockAppDelegate.h"
#import "ClockWindow.h"

@implementation GlossyClockAppDelegate

@synthesize window;

OSStatus
HotKeyHandler(EventHandlerCallRef nextHandler,
              EventRef theEvent, 
              void *userData)
{
    GlossyClockAppDelegate *delegate = (GlossyClockAppDelegate *)[[NSApplication sharedApplication] delegate];
    
    [[delegate window] toggleVisibility];
    
    return noErr;
}

- (void)registerHotKeys 
{
    EventHotKeyRef hotKeyRef;
    EventHotKeyID hotKeyID;
    EventTypeSpec eventType;
    
    eventType.eventClass = kEventClassKeyboard;
    eventType.eventKind = kEventHotKeyPressed;
    
    hotKeyID.signature = 'htk1';
    hotKeyID.id = 1;

    InstallApplicationEventHandler(&HotKeyHandler, 1, 
                                   &eventType, NULL, NULL);
    
    RegisterEventHotKey(49, cmdKey+controlKey, hotKeyID, 
                        GetApplicationEventTarget(), 0, &hotKeyRef);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{
    [self registerHotKeys];
}

@end
