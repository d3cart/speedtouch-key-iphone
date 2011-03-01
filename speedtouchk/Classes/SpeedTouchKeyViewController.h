//
//  SpeedTouchKeyViewController.h
//  SpeedTouchKey
//
//  Created by Sveinbjorn Thordarson on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeedTouchKeyViewController : UIViewController 
{	
	IBOutlet UITextField *textField;
	IBOutlet UIButton *getKeyButton;
	IBOutlet UITextView *resultsTextView;
	IBOutlet UIActivityIndicatorView *activityIndicatorView;
}
-(IBAction)getKeysButtonPressed;
@end

