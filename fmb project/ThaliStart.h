//
//  ThaliStart.h
//  Fmb
//
//  Created by SMB-Mobile01 on 10/9/14.
//  Copyright (c) 2014 SAK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"
#import "IQActionSheetPickerView.h"
#import "AFNetworking.h"
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "SVProgressHUD.h"

@interface ThaliStart : UIViewController<CCKFNavDrawerDelegate,UITextFieldDelegate,UITextViewDelegate,IQActionSheetPickerViewDelegate,SKPSMTPMessageDelegate>{
    IBOutlet UITextField *txtStartDate;
    IBOutlet UITextView *txvrReason;
}
- (IBAction)btnOpenMenu:(id)sender;
- (IBAction)btnStartDate:(id)sender;
- (IBAction)btnSubmit:(id)sender;
- (IBAction)btnCancel:(id)sender;
- (IBAction)btnLogOut:(id)sender;

@end
