//
//  LQAppController.m
//  Geoloqi-Mac
//
//  Created by Aaron Parecki on 2/3/11.
//  Copyright 2011 Geoloqi.com. All rights reserved.
//

#import "LQAppController.h"
#import "LQGeonoteWindow.h"

@implementation LQAppController

@synthesize menu;

- (void)showGeonotePrompt:(NSMenuItem *)sender
{
	NSLog(@"Clicked a place!!");
	// NSLog(@"Place: %d %@", sender.tag, [self.places objectAtIndex:sender.tag]);
	
	LQGeonoteWindow *geonoteWindowController = [[LQGeonoteWindow alloc] init];
	[NSApp activateIgnoringOtherApps:YES];
	[geonoteWindowController showWindow:self];
}

@end
