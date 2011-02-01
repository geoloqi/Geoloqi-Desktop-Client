//
//  Geoloqi_MacAppDelegate.h
//  Geoloqi-Mac
//
//  Created by Aaron Parecki on 2/1/11.
//  Copyright 2011 Geoloqi.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Geoloqi_MacAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
