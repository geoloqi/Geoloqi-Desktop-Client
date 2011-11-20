//
//  LQAppController.h
//  Geoloqi-Mac
//
//  Created by Aaron Parecki on 2/3/11.
//  Copyright 2011 Geoloqi.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LQGeonoteWindow.h"

@interface LQAppController : NSObject {
	LQGeonoteWindow *geonoteWindowController;
}


- (void)showGeonotePrompt:(NSMenuItem *)sender;



@property (nonatomic, retain) NSMenu *menu;


@end
