//
//  LQMenulet.m
//  Geoloqi-Mac
//
//  Created by Aaron Parecki on 2/1/11.
//  Copyright 2011 Geoloqi.com. All rights reserved.
//

#import "LQMenulet.h"


@implementation LQMenulet

@synthesize theMenu;

- (void)awakeFromNib
{
	statusItem = [[[NSStatusBar systemStatusBar] 
				   statusItemWithLength:NSVariableStatusItemLength]
				  retain];
	[statusItem setHighlightMode:YES];
	[statusItem setTitle:@""];
	[statusItem setImage:[NSImage imageNamed:@"loqisaur-menu.png"]];
	[statusItem setHighlightMode:YES];
	[statusItem setEnabled:YES];
	[statusItem setToolTip:@"Geoloqi"];
//	[statusItem setAction:@selector(getSomeStuff:)];
//	[statusItem setTarget:self];
	
	[statusItem setMenu:self.theMenu];
	
	ipMenuItem = [[NSMenuItem alloc] initWithTitle:@"0.0.0.0" 
											action:@selector(getSomeStuff:) keyEquivalent:@""];
	[ipMenuItem setTarget:self];
	[self.theMenu insertItem:ipMenuItem atIndex:0];
	
}

-(IBAction)getSomeStuff:(id)sender
{
	NSString *ipAddr = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://highearthorbit.com/service/myip.php"]];
	NSLog(@"%@", ipAddr);
	if(ipAddr != NULL)
		[ipMenuItem setTitle:[NSString stringWithString:ipAddr]]; 
}

-(void)dealloc
{
    [statusItem release];
	[super dealloc];
}

@end
