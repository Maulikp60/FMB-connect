//
//  ProfilePage.h
//  Fmb
//
//  Created by SMB-Mobile01 on 9/6/14.
//  Copyright (c) 2014 SAK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "EMAccordionTableViewController.h"
#import "DropDownListView.h"

//#import "CollapseClick.h"

@interface ProfilePage : UIViewController<EMAccordionTableDelegate,UITableViewDataSource,UITableViewDelegate,kDropDownListViewDelegate>
{
    IBOutlet UILabel *lblEjamaatNo;
    IBOutlet UILabel *lblSabeelNo;
    IBOutlet UILabel *lblThaliNo;
    IBOutlet UILabel *lblCount;
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblAddress;
    IBOutlet UILabel *lblMobileNo;
    IBOutlet UILabel *lblMohalla;
    IBOutlet UILabel *lblEmail;
    IBOutlet UILabel *lblTakhmeenHoob;
    IBOutlet UILabel *lblDueAmt;
    NSMutableDictionary *dictionary1;
    IBOutlet UIImageView *imgProfile;
    UITableView *lbl;
    NSMutableArray *sublist;
    DropDownListView * Dropobj;

    __weak IBOutlet UIView *view_EditProfile;
    IBOutlet UIView *view3;
    IBOutlet UIImageView *imgOpenClose;
    IBOutlet UIView *viewprofile;
    
    
    __weak IBOutlet UITextField *txt_Email;
    __weak IBOutlet UITextField *txt_MobileNo;
    __weak IBOutlet UITextField *txt_Mohalla;
    __weak IBOutlet UITextField *txt_Name;
}
- (IBAction)btnOpenMenu:(id)sender;
- (IBAction)btnLogOut:(id)sender;
- (IBAction)btnCollapse:(id)sender;

@end
