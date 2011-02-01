//
//  LQMenulet.h
//  Geoloqi-Mac
//
//  Created by Aaron Parecki on 2/1/11.
//  Copyright 2011 Geoloqi.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LQMenulet : NSObject {
	NSStatusItem *statusItem;
	IBOutlet NSMenu *theMenu;
	NSMenuItem *ipMenuItem;
}

@property (nonatomic, retain) IBOutlet NSMenu *theMenu;

@end
