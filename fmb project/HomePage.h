//
//  HomePage.h
//  Fmb
//
//  Created by SMB-Mobile01 on 9/6/14.
//  Copyright (c) 2014 SAK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"
#import "EMAccordionTableViewController.h"
//#import "AFNetworking.h"
#import "XMLReader.h"
#import "ASIHTTPRequest.h"
//#import "NXJsonParser.h"
#import "SVProgressHUD.h"

@interface HomePage : UIViewController<EMAccordionTableDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,UITabBarDelegate,NSXMLParserDelegate>{
    UITableView *lbl;
    NSMutableArray *sublist;
    IBOutlet UILabel *lbltitle;
    IBOutlet UIView *container;
    IBOutlet UITableView *tvMainmenu;
    IBOutlet UIButton *btnobjOpenMenu;
    IBOutlet UITextField *txtConfirmPassword;
    IBOutlet UITextField *txtNewPassword;
    IBOutlet UITextField *txtOldPassword;
    IBOutlet UIButton *btnobjChangeCancel;
    IBOutlet UIButton *btnObjChangeSubmit;
    IBOutlet UIView *ChagePasswordView;
    IBOutlet UIView *view3;
    
    
    __weak IBOutlet UIWebView *web_Display;
    __weak IBOutlet UIView *view_WebView;
}
- (IBAction)btnClickedSubmit:(id)sender;
- (IBAction)btnClickedCancel:(id)sender;
- (IBAction)btnOpenMenu:(id)sender;
- (IBAction)btnLogOut:(id)sender;
@property (copy, nonatomic) NSString *url;
@end
