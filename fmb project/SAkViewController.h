//
//  SAkViewController.h
//  Fmb
//
//  Created by SMB-Mobile01 on 9/6/14.
//  Copyright (c) 2014 SAK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"
#import "SVProgressHUD.h"

@interface SAkViewController : UIViewController<UITextFieldDelegate>{
    IBOutlet UITextField *txtSabeelno;
    IBOutlet UITextField *txtPassword;
}

- (IBAction)btnClickedLogin:(id)sender;
- (IBAction)btnClickedExit:(id)sender;
- (IBAction)btnClickedForgotPassword:(id)sender;

@end
