//
//  ChangePwd.h
//  FMB Connect
//
//  Created by SMB-Mobile01 on 11/4/15.
//  Copyright (c) 2015 SAK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"
#import "IQActionSheetPickerView.h"
#import "AFNetworking.h"
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "SVProgressHUD.h"

@interface ChangePwd : UIViewController<CCKFNavDrawerDelegate,UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,SKPSMTPMessageDelegate>{
    IBOutlet UITextField *txtNewPassword;
IBOutlet UITextField *txtOldPassword;
    
    __weak IBOutlet UIView *view3;
}
- (IBAction)btnOpenMenu:(id)sender;
- (IBAction)btnSubmit:(id)sender;
- (IBAction)btnCancel:(id)sender;
- (IBAction)btnLogOut:(id)sender;

@end

