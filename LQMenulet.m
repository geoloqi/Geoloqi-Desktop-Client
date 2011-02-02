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

@synthesize theMenu;
@synthesize places;

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
	
	[statusItem setMenu:self.theMenu];
	
	NSMenuItem *loadingItem = [[NSMenuItem alloc] initWithTitle:@"Click to Reload Places" action:nil keyEquivalent:@""];
	[loadingItem setAction:@selector(clickedMenuItem:)];
	[loadingItem setTarget:self];
	[loadingItem setTag:1];
	[self.theMenu addItem:loadingItem];
	[loadingItem release];
	
}


- (void)reloadPlaces:(id)sender
{
	[self callAPIPath:@"place/list"
			   method:@"POST"
   includeAccessToken:YES 
	includeClientCred:NO 
			 postBody:@"layer_type=autocheckin"
			 callback:[self getPlaceListCallback]
				  url:[NSURL URLWithString:@"http://api.geoloqi.local/1/"]];
	
	NSLog(@"Fetching layer");
}


- (void)clickedMenuItem:(NSMenuItem *)sender
{
	if(sender.tag == 1){
		[self reloadPlaces:nil];
		return;
	}
	
	
	NSLog(@"Clicked %d: %@", sender.tag, sender);
}

- (void)showGeonotePrompt:(NSMenuItem *)sender
{
	NSLog(@"Clicked a place!!");
	NSLog(@"Place: %d %@", sender.tag, [self.places objectAtIndex:sender.tag]);
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
	[req setValue:@"OAuth 3e8-feba61b179ec1edf7e6808878983fb3a36615ac3" forHTTPHeaderField:@"Authorization"];
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

			NSInteger i = 0;
			for( NSMutableDictionary *place in [res objectForKey:@"places"] )
			{
				[self.places insertObject:place atIndex:i];
				NSMenuItem *newItem = [[NSMenuItem alloc] initWithTitle:[place objectForKey:@"name"]
														action:@selector(showGeonotePrompt:) keyEquivalent:@""];
				[newItem setTarget:self];
				[newItem setTag:i];
				[self.theMenu addItem:newItem];
				[newItem release];
				i++;
			}
        }
		else 
		{
			NSLog(@"Error finding places \"%@\": %@", responseBody, err);
		}
	} copy];
}


-(void)dealloc
{
    [statusItem release];
	[super dealloc];
}

@end
