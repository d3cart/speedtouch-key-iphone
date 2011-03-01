//
//  SpeedTouchKeyAppDelegate.h
//  SpeedTouchKey
//
//  Created by Sveinbjorn Thordarson on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpeedTouchKeyViewController;

@interface SpeedTouchKeyAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SpeedTouchKeyViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SpeedTouchKeyViewController *viewController;

@end

