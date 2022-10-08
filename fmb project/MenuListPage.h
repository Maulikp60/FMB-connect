//
//  MenuListPage.h
//  Fmb
//
//  Created by SMB-Mobile01 on 9/6/14.
//  Copyright (c) 2014 SAK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "custom.h"
#import "AFNetworking.h"

@interface MenuListPage : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    IBOutlet UITableView *tblMenuList;
    IBOutlet UIView *view3;
}
- (IBAction)btnOpenMenu:(id)sender;
- (IBAction)btnLogOut:(id)sender;

@end
