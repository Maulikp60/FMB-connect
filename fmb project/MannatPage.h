//
//  MannatPage.h
//  FMB Salumber
//
//  Created by SMB-Mobile01 on 5/12/15.
//  Copyright (c) 2015 SAK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQActionSheetPickerView.h"

@interface MannatPage : UIViewController<IQActionSheetPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UILabel *lbl2;
    IBOutlet UITableView *tblType;
    IBOutlet UILabel *lblNoOfThali;
    IBOutlet UITextField *txtNiyatname;
    IBOutlet UITextField *txtDate;
    IBOutlet UITextField *txtAmount;
    IBOutlet UITextField *txtNoOfThali;
    IBOutlet UITextField *txtMannatType;
    IBOutlet UIImageView *imgDate;
    IBOutlet UILabel *lbl5;
    IBOutlet UILabel *lblDate;
    IBOutlet UILabel *lbl4;
    IBOutlet UILabel *lblRemark;
    IBOutlet UILabel *lbl3;
    IBOutlet UILabel *lblAmount;
    IBOutlet UIImageView *imgDateIcon;
    IBOutlet UIButton *btnObjDate;
    IBOutlet UIView *view3;
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedLogout:(id)sender;
- (IBAction)btnSubmit:(id)sender;

- (IBAction)btnClickedType:(id)sender;
- (IBAction)btnClickedDate:(id)sender;


@end
