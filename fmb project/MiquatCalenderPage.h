//
//  MiquatCalenderPage.h
//  FMB Salumber
//
//  Created by SMB-Mobile01 on 5/11/15.
//  Copyright (c) 2015 SAK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiquatCalenderPage : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    IBOutlet UITextField *txtMonth;
    IBOutlet UIButton *btnObjLogout;
    IBOutlet UIButton *btnObjMenu;
    IBOutlet UITableView *tblMiquatCalender;
    IBOutlet UIView *view3;
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnLogout:(id)sender;
- (IBAction)btnClickedNext:(id)sender;
- (IBAction)btnClickedPrevious:(id)sender;

@end
