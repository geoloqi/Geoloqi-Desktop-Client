//
//  LQGeonoteWindow.h
//  Geoloqi-Mac
//
//  Created by Aaron Parecki on 2/3/11.
//  Copyright 2011 Geoloqi.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LQGeonoteWindow : NSWindowController {

}

@property (nonatomic, retain) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet NSTextField *geonoteText;
@property (nonatomic, retain) IBOutlet NSTextField *placeName;
@property (nonatomic, retain) IBOutlet NSButton *createBtn;

@end
