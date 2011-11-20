//
//  LQMenulet.m
//  Geoloqi-Mac
//
//  Created by Aaron Parecki on 2/1/11.
//  Copyright 2011 Geoloqi.com. All rights reserved.
//

#import "LQMenulet.h"
#import "LQHTTPRequestLoader.h"
#import "CJSONDeserializer.h"

@implementation LQMenulet

@synthesize places;

- (void)awakeFromNib
{
	statusItem = [[[NSStatusBar systemStatusBar] 
				   statusItemWithLength:NSVariableStatusItemLength]
				  retain];
	[statusItem setHighlightMode:YES];
	// [statusItem setTitle:@"2011-240"];
	[statusItem setImage:[NSImage imageNamed:@"loqisaur-menu.png"]];
	[statusItem setHighlightMode:YES];
	[statusItem setEnabled:YES];
	[statusItem setToolTip:@"Geoloqi"];
	
	[statusItem setMenu:theMenu];
	
	NSLog(@"Window: %@", window);
	[window setIsVisible:NO];

	[self reloadPlaces:nil];
	
	[self addReloadingMenuItem];
}

- (void)addReloadingMenuItem
{
	NSMenuItem *loadingItem = [[NSMenuItem alloc] initWithTitle:@"Reload List" action:nil keyEquivalent:@""];
	[loadingItem setAction:@selector(clickedMenuItem:)];
	[loadingItem setTarget:self];
	[loadingItem setTag:1];
	[theMenu addItem:loadingItem];
	[loadingItem release];
}

- (void)reloadPlaces:(id)sender
{
	[self callAPIPath:@"place/list"
			   method:@"GET"
   includeAccessToken:YES 
	includeClientCred:NO 
			 postBody:nil
			 callback:[self getPlaceListCallback]
				  url:[NSURL URLWithString:@"https://api.geoloqi.com/1/"]];
	
	NSLog(@"Fetching places");
}


- (void)clickedMenuItem:(NSMenuItem *)sender
{
	if(sender.tag == 1){
		[self reloadPlaces:nil];
		return;
	}
	
	[NSApp activateIgnoringOtherApps:YES];
	[NSApp orderFrontStandardAboutPanel:self];

	// TODO: Make this open the geonote window
	LQGeonoteWindow *geonoteWindowController = [[LQGeonoteWindow alloc] init];
	[NSApp activateIgnoringOtherApps:YES];
	[geonoteWindowController showWindow:self];
	
	NSLog(@"Clicked %@: %@", sender.tag, sender);
}


- (void)callAPIPath:(NSString *)path
			 method:(NSString *)httpMethod
 includeAccessToken:(BOOL)includeAccessToken
  includeClientCred:(BOOL)includeClientCred
		   postBody:(NSString *)postBody
		   callback:(LQHTTPRequestCallback)callback
				url:(NSURL *)URL {
	
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:
								[URL URLByAppendingPathComponent:path]];
    
	[req setHTTPMethod:httpMethod];
	[req setValue:@"Geoloqi Mac" forHTTPHeaderField:@"Geoloqi-Client"];
	[req setValue:[NSString stringWithFormat:@"OAuth %@", LQ_ACCESS_TOKEN] forHTTPHeaderField:@"Authorization"];
	[req setHTTPBody:[postBody dataUsingEncoding:NSUTF8StringEncoding]];
	
	[LQHTTPRequestLoader loadRequest:req callback:callback];
}

- (LQHTTPRequestCallback)getPlaceListCallback {
	if (getPlaceListCallback) return getPlaceListCallback;
	return getPlaceListCallback = [^(NSError *error, NSString *responseBody) {
		NSError *err = nil;
		NSDictionary *res = [[CJSONDeserializer deserializer] deserializeAsDictionary:[responseBody dataUsingEncoding:
																					   NSUTF8StringEncoding]
																				error:&err];
		if (!res || [res objectForKey:@"error"] != nil) {
			NSLog(@"Error deserializing response \"%@\": %@", responseBody, err);
			exit(-1);
			return;
		}
		
        if ([[res objectForKey:@"places"] isKindOfClass:[NSArray class]] && [[res objectForKey:@"places"] count])
        {
			NSLog(@"Found %d places", [[res objectForKey:@"places"] count]);
			
			self.places = nil;
			self.places = [[NSMutableArray alloc] initWithCapacity:[[res objectForKey:@"places"] count]];
			[theMenu removeAllItems];

			NSInteger i = 0;
			for( NSMutableDictionary *place in [res objectForKey:@"places"] )
			{
				[self.places insertObject:place atIndex:i];
				NSMenuItem *newItem = [[NSMenuItem alloc] initWithTitle:[place objectForKey:@"name"]
														action:@selector(showGeonotePrompt:) keyEquivalent:@""];
				[newItem setTarget:appController];
				[newItem setTag:i];
				[theMenu addItem:newItem];
				[newItem release];
				i++;
			}
			
			[theMenu addItem:[NSMenuItem separatorItem]];
			[self addReloadingMenuItem];
        }
		else 
		{
			NSLog(@"Error finding places \"%@\": %@", responseBody, err);
		}
	} copy];
}


-(void)dealloc
{
	[appController release];
	[places release];
	[window release];
    [statusItem release];
	[super dealloc];
}

@end
