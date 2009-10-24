//
//  GlossyClockAppDelegate.m
//  GlossyClock
//
//  Created by Mikael Hallendal on 2009-10-10.
//  Copyright 2009 Mikael Hallendal. All rights reserved.
//

#import "GlossyClockAppDelegate.h"
#import <Carbon/Carbon.h>

@implementation GlossyClockAppDelegate

@synthesize window;

OSStatus
MyHotKeyHandler(EventHandlerCallRef nextHandler, EventRef theEvent, void *userData)
{
    // Do something once the key is pressed
    NSLog(@"Hot key pressed");
    return noErr;
}

- (void)registerHotKeys 
{
    EventHotKeyRef hotKeyRef;
    EventHotKeyID hotKeyID;
    EventTypeSpec eventType;
    
    NSLog(@"Registering hot key");
    
    eventType.eventClass = kEventClassKeyboard;
    eventType.eventKind = kEventHotKeyPressed;
    
    hotKeyID.signature = 'htk1';
    hotKeyID.id = 1;

    InstallApplicationEventHandler(&MyHotKeyHandler, 1, 
                                   &eventType, NULL, NULL);
    
    RegisterEventHotKey(49, cmdKey+controlKey, hotKeyID, 
                        GetApplicationEventTarget(), 0, &hotKeyRef);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{
    [self registerHotKeys];
}

@end
