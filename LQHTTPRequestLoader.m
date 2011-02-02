//
//  LQHTTPRequestLoader.m
//  Geoloqi
//
//  Created by Jacob Bandes-Storch on 8/24/10.
//  Copyright 2010 Geoloqi.com. All rights reserved.
//

#import "LQHTTPRequestLoader.h"

@interface LQHTTPRequestLoader ()
- (void)loadRequest:(NSURLRequest *)request
		   callback:(LQHTTPRequestCallback)block;
@end


@implementation LQHTTPRequestLoader

+ (void)loadRequest:(NSURLRequest *)request
		   callback:(LQHTTPRequestCallback)block {
	
	LQHTTPRequestLoader *loader = [[self alloc] init];
	[loader loadRequest:request
			   callback:^(NSError *error, NSString *responseBody) {
				   
				   // TODO: If the response returned an expired token error,
				   // make a request to oauth/token with the refresh token and try the request again.
				   // This is not technically necessary, because the auth manager knows if its access
				   // token has expired and will get a new one if needed. However, it's possible that
				   // if the phone and server clocks are not in sync, the phone may not know to get
				   // a new token. This check here is more of a fail-safe than normal operations.

				   /*
				   // TODO: Modify all callback blocks to accept a dictionary instead of a string.
				   // Now that this method is parsing the JSON, we don't need to parse it twice.
				   NSError *err = nil;
				   NSDictionary *res = [[CJSONDeserializer deserializer] deserializeAsDictionary:[responseBody dataUsingEncoding:
																								  NSUTF8StringEncoding]
																						   error:&err];
				   if (!responseBody || [response objectForKey:@"error"] != nil) {
					   [[[Geoloqi sharedInstance] authManager] refreshAccessTokenWithCallback:block];
				   }
					*/
				   
				   block(error, responseBody);
				   [loader release];
			   }];
}

- (void)loadRequest:(NSURLRequest *)request
		   callback:(LQHTTPRequestCallback)block {
    
    NSLog(@"loadRequest: %@", [[request URL] absoluteString]);
    
	connection = [[NSURLConnection alloc] initWithRequest:request
												 delegate:self];
	callback = [block copy];
}

- (void)connection:(NSURLConnection *)conn didReceiveResponse:(NSURLResponse *)response {
	[data release];
	data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)newData {
	[data appendData:newData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn {
	callback(nil, [[[NSString alloc] initWithData:data
										 encoding:NSUTF8StringEncoding] autorelease]);
	[data release];
	data = nil;
}

- (void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error {
	callback(error, nil);
	[data release];
	data = nil;
}

- (void)dealloc {
	[data release];
	[connection release];
	[callback release];
	[super dealloc];
}

@end
