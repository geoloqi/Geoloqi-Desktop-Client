//
//  LQGeonoteWindow.m
//  Geoloqi-Mac
//
//  Created by Aaron Parecki on 2/3/11.
//  Copyright 2011 Geoloqi.com. All rights reserved.
//

#import "LQGeonoteWindow.h"


@implementation LQGeonoteWindow



- (id)init
{
	self = [super initWithWindowNibName:@"LQGeonoteWindow"];
	if(!self){
		return nil;
	}

	return self;
}

- (IBAction)showWindow:(id)sender
{
	[[self window] center];
	[super showWindow:sender];
}


@end
