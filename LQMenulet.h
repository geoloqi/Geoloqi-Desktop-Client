//
//  LQMenulet.h
//  Geoloqi-Mac
//
//  Created by Aaron Parecki on 2/1/11.
//  Copyright 2011 Geoloqi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQHTTPRequestLoader.h"

@interface LQMenulet : NSObject {
	NSStatusItem *statusItem;
	IBOutlet NSMenu *theMenu;
	NSMenuItem *ipMenuItem;
	NSMutableArray *places;
	LQHTTPRequestCallback getPlaceListCallback;
}

- (LQHTTPRequestCallback)getPlaceListCallback;

- (void)addReloadingMenuItem;
- (void)reloadPlaces:(id)sender;
- (void)clickedMenuItem:(id)sender;
- (void)showGeonotePrompt:(id)sender;

- (void)callAPIPath:(NSString *)path
			 method:(NSString *)httpMethod
 includeAccessToken:(BOOL)includeAccessToken
  includeClientCred:(BOOL)includeClientCred
		   postBody:(NSString *)postBody
		   callback:(LQHTTPRequestCallback)callback
				url:(NSURL *)URL;
	
@property (nonatomic, retain) IBOutlet NSMenu *theMenu;
@property (nonatomic, retain) NSMutableArray *places;

@end
