//
//  ThaliManagePage.h
//  Fmb
//
//  Created by SMB-Mobile01 on 9/6/14.
//  Copyright (c) 2014 SAK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQActionSheetPickerView.h"
#import "AFNetworking.h"
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "SVProgressHUD.h"

@interface ThaliManagePage : UIViewController<UITextFieldDelegate,UITextViewDelegate,IQActionSheetPickerViewDelegate,SKPSMTPMessageDelegate,UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITextView *txvReason;
    IBOutlet UITableView *tblPopup;
    IBOutlet UITableView *tblThali;
    IBOutlet UIButton *btnObjNewThali;
    IBOutlet UITextField *txtNewThali;
    IBOutlet UIImageView *imgNewThali;
    IBOutlet UITextField *txtToDate;
    IBOutlet UITextField *txtFromDate;
    IBOutlet UILabel *lblIncreaseThali;
    IBOutlet UILabel *lblTodate;
    IBOutlet UIImageView *imgDateicon;
    IBOutlet UIButton *btnObjFromdate;
    IBOutlet UIImageView *imgFromdate;
    IBOutlet UILabel *lblFromdate;
    IBOutlet UIButton *btnObjCancel;
    IBOutlet UIButton *btnObjSubmit;
    IBOutlet UILabel *lblOldThali1;
    IBOutlet UIImageView *imgIncreaseThali;
    IBOutlet UIStepper *stepThali;
    IBOutlet UITextField *txtIncrease;
    IBOutlet UILabel *lblThali;
    IBOutlet UILabel *lblOldThali;
    IBOutlet UILabel *lblDisplayThali;
    IBOutlet UIButton *btnObjTrasparent;
    IBOutlet UIView *view3;
    NSDictionary *json1;
}
- (IBAction)btnOpenMenu:(id)sender;
- (IBAction)btnFromDate:(id)sender;
- (IBAction)btnSubmit:(id)sender;
- (IBAction)btnCancel:(id)sender;
- (IBAction)btnLogOut:(id)sender;
- (IBAction)btnClickedStart:(id)sender;
- (IBAction)btnClickedStop:(id)sender;
- (IBAction)btnClickedIncDec:(id)sender;
- (IBAction)btnClickedNewThali:(id)sender;
- (IBAction)btnTrasparent:(id)sender;
- (IBAction)valueChanged:(UIStepper *)sender;
@end
