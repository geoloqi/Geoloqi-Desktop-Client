//
//  LQMenulet.h
//  Geoloqi-Mac
//
//  Created by Aaron Parecki on 2/1/11.
//  Copyright 2011 Geoloqi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQHTTPRequestLoader.h"
#import "Geoloqi_MacAppDelegate.h"
#import "LQGeonoteWindow.h"
#import "LQAppController.h"

// Get an access token here: https://developers.geoloqi.com/getting-started
#define LQ_ACCESS_TOKEN @"" 

@interface LQMenulet : NSObject {

	NSStatusItem *statusItem;

	NSMenuItem *ipMenuItem;
	NSMutableArray *places;
	LQHTTPRequestCallback getPlaceListCallback;

	IBOutlet NSMenu *theMenu;
	IBOutlet NSWindow *window;
	IBOutlet LQAppController *appController;	
}

- (LQHTTPRequestCallback)getPlaceListCallback;

- (void)addReloadingMenuItem;
- (void)reloadPlaces:(id)sender;
- (void)clickedMenuItem:(id)sender;

- (void)callAPIPath:(NSString *)path
			 method:(NSString *)httpMethod
 includeAccessToken:(BOOL)includeAccessToken
  includeClientCred:(BOOL)includeClientCred
		   postBody:(NSString *)postBody
		   callback:(LQHTTPRequestCallback)callback
				url:(NSURL *)URL;



@property (nonatomic, retain) NSMutableArray *places;


@end
