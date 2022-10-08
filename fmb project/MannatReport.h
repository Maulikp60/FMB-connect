//
//  MannatReport.h
//  FMB Salumber
//
//  Created by SMB-Mobile01 on 5/12/15.
//  Copyright (c) 2015 SAK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MannatReport : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UIView *view3;
    IBOutlet UITableView *tblMannatReport;
}
- (IBAction)btnClickedMenu:(id)sender;
- (IBAction)btnClickedLogout:(id)sender;


@end
