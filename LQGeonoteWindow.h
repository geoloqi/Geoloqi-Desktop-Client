//
//  LQGeonoteWindow.h
//  Geoloqi-Mac
//
//  Created by Aaron Parecki on 2/3/11.
//  Copyright 2011 Geoloqi.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LQGeonoteWindow : NSWindowController {
	IBOutlet NSWindow *window;
	IBOutlet NSTextField *geonoteText;
	IBOutlet NSTextField *placeName;
	IBOutlet NSButton *createBtn;			
}


- (IBAction)showWindow:(id)sender;

@end
