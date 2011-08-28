//
//  LQAppController.h
//  Geoloqi-Mac
//
//  Created by Aaron Parecki on 2/3/11.
//  Copyright 2011 Geoloqi.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LQAppController : NSObject {

}

@property (nonatomic, retain) NSMenu *menu;

- (void)showGeonotePrompt:(NSMenuItem *)sender;

@end
