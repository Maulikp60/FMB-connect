//
//  FeedbackPage.h
//  Fmb
//
//  Created by SMB-Mobile01 on 9/6/14.
//  Copyright (c) 2014 SAK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQActionSheetPickerView.h"
#import "DropDownListView.h"
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "SVProgressHUD.h"

@interface FeedbackPage : UIViewController<IQActionSheetPickerViewDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,kDropDownListViewDelegate,SKPSMTPMessageDelegate>{
    IBOutlet UITextField *txtThaliDate;
    IBOutlet UITextField *txtSelectType;
    IBOutlet UITableView *tblSelectType;
    IBOutlet UITableView *tblPoorPopUp;
    IBOutlet UITableView *tblQuestion;
    IBOutlet UIButton *btnObjSelectType;
    IBOutlet UIView *PoorView;
    IBOutlet UIImageView *btnCheck;
    IBOutlet UITextField *txtcomment;
    IBOutlet UILabel *lblDishName;
    DropDownListView * Dropobj;
    IBOutlet UITextField *txtRemark;
    IBOutlet UIButton *btnObjThalidate;
    IBOutlet UIView *view3;
}
- (IBAction)btnOpenMenu:(id)sender;
- (IBAction)btnThaliDate:(id)sender;
- (IBAction)btnSelectType:(id)sender;
- (IBAction)btnSubmit:(id)sender;
- (IBAction)btnCancel:(id)sender;
- (IBAction)btnSubmitPopup:(id)sender;
- (IBAction)btnClickedRemark:(id)sender;
- (IBAction)btnLogOut:(id)sender;

@end
