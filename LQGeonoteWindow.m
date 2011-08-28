//
//  LQGeonoteWindow.m
//  Geoloqi-Mac
//
//  Created by Aaron Parecki on 2/3/11.
//  Copyright 2011 Geoloqi.com. All rights reserved.
//

#import "LQGeonoteWindow.h"


@implementation LQGeonoteWindow

@synthesize window, geonoteText, placeName, createBtn;

- (id)init
{
	self = [super initWithWindowNibName:@"LQGeonoteWindow"];
	if(!self){
		return nil;
	}
	NSLog(@"Geonote window: %@", self.window);
	return self;
}

- (IBAction)showWindow:(id)sender
{
	NSLog(@"Window: %@ %@", self.window, self.geonoteText);
	[[self window] center];
	[super showWindow:sender];
}


@end
