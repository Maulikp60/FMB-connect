//
//  ProfilePage.m
//  Fmb
//
//  Created by SMB-Mobile01 on 9/6/14.
//  Copyright (c) 2014 SAK. All rights reserved.
//

#import "ProfilePage.h"
#import "CDRTranslucentSideBar.h"
#import "ThaliManagePage.h"
#import "HomePage.h"
#import "MenuListPage.h"
#import "MiquatCalenderPage.h"
#import "MannatPage.h"
#import "MannatReport.h"
#import "FeedbackPage.h"
#import "SAkViewController.h"
#import "Singleton.h"
#import "ChangePwd.h"
#import "Validate.h"
#define kTableHeaderHeight 40.0f
#define kTableRowHeight 20.0f
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)

@interface ProfilePage ()<CDRTranslucentSideBarDelegate>{
     EMAccordionTableViewController *emTV;
    NSMutableArray *arryEjamaatno,*arrySabeelno,*arryThalino,*arryCount,*arryName,*arryAddress,*arryMobileno,*arryMohalla,*arryEmail,*arryTakhmeenhoob,*arryDueamt,*arryProfileimg,*arryDelivery;
    
    NSMutableArray *arr_catIds,*arr_Mohaalla;
    NSMutableArray *arr_catNames;
    NSMutableArray *DishName;
    NSMutableArray *Anndescription;
    NSUserDefaults *prefs;
    NSString *Companyid,*Sabeelno,*MuminId,*MohallaID;
    IBOutlet UIImageView *imgDelivery;
     NSDictionary *json;
    NSMutableArray *arrrecipedta;
    NSMutableArray *arrreceiptno;
    NSMutableArray *arrpayment;
    
    NSMutableArray *TakhDetails;
    NSMutableArray *arrTakhYear;
    NSMutableArray *arrTakhAmt;
    NSMutableArray *arrTakhPaid;
    NSMutableArray *arrTakhDue;
    
    int p;
    UITableView *tableView;
    
    UIButton *btnclk;
    UITableView *tableView1;
}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@end

@implementation ProfilePage
{
    NSArray *sections;
    CGFloat origin;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    p=0;
    self.sideBar = [[CDRTranslucentSideBar alloc] init];
    
    self.sideBar.sideBarWidth = self.view.frame.size.width*0.75;
    self.sideBar.delegate = self;
    self.sideBar.tag = 0;
    
    tableView1 = [[UITableView alloc] init];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView1.bounds.size.width, tableView1.bounds.size.height)];
    v.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:243.0/255.0 blue:209.0/255.0 alpha:1.0];
    [tableView1 setTableHeaderView:v];
    [tableView1 setTableFooterView:v];
    
    tableView1.dataSource = self;
    tableView1.delegate = self;
    [self.sideBar setContentViewInSideBar:tableView1];
    prefs = [NSUserDefaults standardUserDefaults];
    Companyid = [prefs stringForKey:@"CompanyId"];
    Sabeelno = [prefs stringForKey:@"Sabeelno"];
    MuminId=[prefs stringForKey:@"muminmasterid"];
    //strCollapse={@"[@"1",@"2"]"};
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    txt_MobileNo.inputAccessoryView = keyboardDoneButtonView;

   
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self ProfileMenu];
    [self TodaysMenu];
    [self Announcement];
    [self GetMohalla];
    txt_Name.layer.cornerRadius=1.0f;
    txt_Name.layer.masksToBounds=YES;
    txt_Name.layer.borderColor=[[UIColor redColor]CGColor];
    txt_Name.layer.borderWidth= 1.0f;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txt_Name.leftView = paddingView;
    txt_Name.leftViewMode = UITextFieldViewModeAlways;
    
    txt_Mohalla.layer.cornerRadius=1.0f;
    txt_Mohalla.layer.masksToBounds=YES;
    txt_Mohalla.layer.borderColor=[[UIColor redColor]CGColor];
    txt_Mohalla.layer.borderWidth= 1.0f;
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txt_Mohalla.leftView = paddingView1;
    txt_Mohalla.leftViewMode = UITextFieldViewModeAlways;
    
    txt_MobileNo.layer.cornerRadius=1.0f;
    txt_MobileNo.layer.masksToBounds=YES;
    txt_MobileNo.layer.borderColor=[[UIColor redColor]CGColor];
    txt_MobileNo.layer.borderWidth= 1.0f;
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txt_MobileNo.leftView = paddingView2;
    txt_MobileNo.leftViewMode = UITextFieldViewModeAlways;
    
    txt_Email.layer.cornerRadius=1.0f;
    txt_Email.layer.masksToBounds=YES;
    txt_Email.layer.borderColor=[[UIColor redColor]CGColor];
    txt_Email.layer.borderWidth= 1.0f;
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txt_Email.leftView = paddingView3;
    txt_Email.leftViewMode = UITextFieldViewModeAlways;
    
    origin = 20.0f;
    
    if ([[UIDevice currentDevice].model hasPrefix:@"iPad"])
        origin = 100.0f;
    float n=0;
    NSLog(@"%f",n);
    
    if (IS_IPHONE_5)
    {
        n=85.0+viewprofile.frame.size.height;
    }
    else
    {
        n=72+viewprofile.frame.size.height;
    }
    
    NSLog(@"%f",viewprofile.bounds.origin.y);
    NSLog(@"%f",viewprofile.frame.size.height);
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,n, 320, self.view.bounds.size.height - n) style:UITableViewStylePlain];
    [tableView setSectionHeaderHeight:kTableHeaderHeight];
    [tableView setBackgroundColor:[UIColor clearColor]];
    /*
     ... set here some other tableView properties ...
     */
    
    // Setup the EMAccordionTableViewController
    emTV = [[EMAccordionTableViewController alloc] initWithTable:tableView withAnimationType:EMAnimationTypeBounce];
    [emTV setDelegate:self];
    
    [emTV setClosedSectionIcon:[UIImage imageNamed:@"closedIcon"]];
    [emTV setOpenedSectionIcon:[UIImage imageNamed:@"openedIcon"]];
    // Section graphics
    UIColor *sectionsColor = [UIColor colorWithRed:71.0f/255.0f green:70.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
    UIColor *sectionTitleColor = [UIColor whiteColor];
    UIFont *sectionTitleFont = [UIFont fontWithName:@"Futura" size:24.0f];
    
    // Add the sections to the controller
    EMAccordionSection *section03 = [[EMAccordionSection alloc] init];
    [section03 setBackgroundColor:sectionsColor];
    [section03 setItems:TakhDetails];
    [section03 setTitle:@"Takhmeen History"];
    [section03 setTitleColor:sectionTitleColor];
    [section03 setTitleFont:sectionTitleFont];
    [emTV addAccordionSection:section03];

    EMAccordionSection *section01 = [[EMAccordionSection alloc] init];
    [section01 setBackgroundColor:sectionsColor];
    [section01 setItems:DishName];
    [section01 setTitle:@"Payment History"];
    [section01 setTitleFont:sectionTitleFont];
    [section01 setTitleColor:sectionTitleColor];
    [emTV addAccordionSection:section01];
    
      EMAccordionSection *section02 = [[EMAccordionSection alloc] init];
    [section02 setBackgroundColor:sectionsColor];
    [section02 setItems:Anndescription];
    [section02 setTitle:@"Thaali Delivered"];
    [section02 setTitleColor:sectionTitleColor];
    [section02 setTitleFont:sectionTitleFont];
    [emTV addAccordionSection:section02];
    
    sections = [[NSArray alloc] initWithObjects:section03, section01, section02, nil];
    [self.view addSubview:emTV.tableView];
    
    [SVProgressHUD dismiss]; //new ali
}
- (void) viewDidAppear:(BOOL)animated {
    [self.view addSubview:emTV.tableView];
    // Setup the EMAccordionTableViewController
}
#pragma mark EMAccordionTableDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView==tableView1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            cell.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:243.0/255.0 blue:209.0/255.0 alpha:1.0];
        }
        [tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"bgs5.png"]]]];
        //    cell.textLabel.textColor=[UIColor colorWithRed:57.0/255.0 green:109.0/255.0 blue:163.0/255.0 alpha:1];
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        UILabel *lblline=[[UILabel alloc]initWithFrame:CGRectMake(0, 42, cell.frame.size.width, 2)];
        lblline.text=@"";
        lblline.backgroundColor=[UIColor blackColor];
        // lblline.backgroundColor=[UIColor colorWithRed:53.0/255.0 green:78.0/255.0 blue:111.0/255.0 alpha:1.0];
        
        UILabel *lbllinecolor=[[UILabel alloc]initWithFrame:CGRectMake(44,0, cell.frame.size.width-44,cell.frame.size.height)];
        lblline.text=@"";
        lbllinecolor.backgroundColor=[UIColor whiteColor];
        //[cell addSubview:lbllinecolor];
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 42, 42)];
        [cell addSubview:lblline];
        
        if(indexPath.row==0)
        {
            cell.textLabel.text = @"        DashBoard";
            // UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
            img.image=[UIImage imageNamed:@"dashboard.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"        Profile";
            //UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
            img.image=[UIImage imageNamed:@"user-profiles.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 2) {
            cell.textLabel.text = @"        Thali Stop/Inc/Dec";
            //UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
            img.image=[UIImage imageNamed:@"thali-stop.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 3) {
            cell.textLabel.text = @"        Menu List";
            // UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
            img.image=[UIImage imageNamed:@"menus.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 4) {
            cell.textLabel.text = @"        Feedback";
            // UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
            img.image=[UIImage imageNamed:@"thali-stop.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 5) {
            cell.textLabel.text = @"        Miqaat Calendar";
            // UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
            img.image=[UIImage imageNamed:@"thali-calender.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 6) {
            cell.textLabel.text = @"        Mannat";
            // UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
            img.image=[UIImage imageNamed:@"mannat.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 7) {
            cell.textLabel.text = @"        Mannat Report";
            // UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
            img.image=[UIImage imageNamed:@"mannat-reports.png"];
            [cell addSubview:img];
        }
        else if (indexPath.row == 8) {
            cell.textLabel.text = @"        Change Password";
            // UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
            img.image=[UIImage imageNamed:@"changepwd.png"];
            [cell addSubview:img];
        }

        else  {
            cell.textLabel.text = @"        Logout";
            //UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
            img.image=[UIImage imageNamed:@"logouts.png"];
            [cell addSubview:img];
        }
        return cell;
        
    }
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"emCell"];
        [cell setBackgroundColor:[UIColor clearColor]];
        NSMutableArray *items = [self dataFromIndexPath:indexPath];
        
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 310, 30)];
        [titleLbl setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        titleLbl.textColor=[UIColor blackColor];
        [titleLbl setText:[items objectAtIndex:indexPath.row]];
        [titleLbl setBackgroundColor:[UIColor clearColor]];
        
        [[cell contentView] addSubview:titleLbl];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView==tableView1)
    {
        return 45;
    }
    else
    {
        return 30.0f;
    }

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableView1)
    {
        [SVProgressHUD showProgress:0 status:@"Loading"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            cell.backgroundColor = [UIColor clearColor];
        }
        
        if(indexPath.row==0)
        {
            HomePage *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"HomePage"];
            [self presentViewController:FeesScreen animated:NO completion:nil];
        }
        if (indexPath.row==1)
        {
            ProfilePage *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfilePage"];
            [self presentViewController:FeesScreen animated:NO completion:nil];
        }
        else if (indexPath.row==2)
        {
            ThaliManagePage *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"ThaliManagePage"];
            [self presentViewController:FeesScreen animated:NO completion:nil];
        }
        else if (indexPath.row==3)
        {
            MenuListPage *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"MenuListPage"];
            [self presentViewController:FeesScreen animated:NO completion:nil];
            
        }
        else if (indexPath.row==4)
        {
            FeedbackPage *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"FeedbackPage"];
            [self presentViewController:FeesScreen animated:NO completion:nil];
            
        }
        else if (indexPath.row==5)
        {
            MiquatCalenderPage *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"MiquatCalenderPage"];
            [self presentViewController:FeesScreen animated:NO completion:nil];
            
        }
        else if (indexPath.row==6)
        {
            MannatPage *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"MannatPage"];
            [self presentViewController:FeesScreen animated:NO completion:nil];
            
        }
        else if (indexPath.row==7)
        {
            MannatReport *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"MannatReport"];
            [self presentViewController:FeesScreen animated:NO completion:nil];
            
        }
        else if (indexPath.row==8)
        {
            ChangePwd *ChangePwdScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePwd"];
            [self presentViewController:ChangePwdScreen animated:NO completion:nil];
        }
        else
        {
                    SAkViewController *reg2=[self.storyboard instantiateViewControllerWithIdentifier:@"SAkViewController"];
                    [self presentViewController:reg2 animated:NO completion:nil];
                    prefs = [NSUserDefaults standardUserDefaults];
                    [prefs setBool:NO forKey:@"boolVal"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [SVProgressHUD dismiss];
        }
        //[SVProgressHUD dismiss];
        
    }
    else
    {
        
    }//    EMAccordionSection *section = [sections objectAtIndex:indexPath.section];
//    NSMutableArray *items = [self dataFromIndexPath:indexPath];
//    
//    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"FMB" message:[[NSString alloc] initWithFormat:@"%@ : %@", section.title, [items objectAtIndex:indexPath.row]] delegate:NULL cancelButtonTitle:NULL otherButtonTitles:@"OK", nil];
//    [av show];
}

- (NSMutableArray *) dataFromIndexPath: (NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return TakhDetails;
    else if (indexPath.section == 1)
        return DishName;
    else if (indexPath.section == 2)
        return Anndescription;
    return NULL;
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnOpenMenu:(id)sender {
    [self.sideBar show];
    view3.frame=CGRectMake(self.view.frame.size.width*0.75,0,self.view.bounds.size.width,self.view.bounds.size.height);
    btnclk=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.75, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [btnclk addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnclk];
}
- (IBAction)btn_EditProfile:(id)sender {
    [emTV.tableView removeFromSuperview];
    view_EditProfile.hidden = NO;
}
- (IBAction)btn_ClickedUpdate:(id)sender {
    if ([txt_Name.text  isEqual: @""]) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"FMB" message:@"Please enter name" delegate:NULL cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [av show];
    }else if ([txt_Mohalla.text  isEqual: @""]) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"FMB" message:@"Please enter mohalla" delegate:NULL cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [av show];
    }else if ([txt_MobileNo.text  isEqual: @""]) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"FMB" message:@"Please enter mobile no" delegate:NULL cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [av show];
    }else if ([txt_Email.text  isEqual: @""]) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"FMB" message:@"Please enter email" delegate:NULL cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [av show];
    } else if(![Validate isValidEmailAddress:txt_Email.text]) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"FMB" message:@"Invalid Email Id." delegate:NULL cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [av show];
        
    }else{
        [self webservice_UpdateProfile];
    }
}
- (IBAction)btn_ClickedCancel:(id)sender {
    view_EditProfile.hidden = YES;
    [self.view addSubview:emTV.tableView];
}
-(void)webservice_UpdateProfile{
    
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@EditProfile?Name=%@&MobileNo=%@&Email=%@&MohallaID=%@&MuminMaster_Id=%@",[[Singleton sharedSingleton] getBaseURL],txt_Name.text,txt_MobileNo.text,txt_Email.text,MohallaID,MuminId];
    //NSLog(myRequestString1);
    //    NSString *myRequestString1 = [NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/FMBPROFILE?company_id=%@&Sabeel_NO=%@",Companyid,Sabeelno];
    
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str1];
    NSData * data=[NSData dataWithContentsOfURL:url1];
    NSError * error;
    NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    NSString *webStatus = [json1 objectForKey:@"status"];
    if ([webStatus  isEqual: @"YES"]){
        view_EditProfile.hidden = YES;
         lblName.text = txt_Name.text;
          lblMobileNo.text = txt_MobileNo.text;
         lblMohalla.text = txt_Mohalla.text;
          lblEmail.text = txt_Email.text;
        [self.view addSubview:emTV.tableView];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FMB" message:[json1 objectForKey:@"responce"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (IBAction)btnLogOut:(id)sender {
    UIViewController *reg2=[self.storyboard instantiateViewControllerWithIdentifier:@"SAkViewController"];
    [self.navigationController pushViewController:reg2 animated:YES];
    prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:NO forKey:@"boolVal"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (IBAction)btnCollapse:(id)sender {
    
    if(p==0)
    {
        [viewprofile setHidden:YES];
        float n=0;
        NSLog(@"%f",n);
        if (IS_IPHONE_5)
        {
            n=82.0;
        }
        else
        {
            n=68;
        }
        NSLog(@"%f",viewprofile.bounds.origin.y);
        NSLog(@"%f",viewprofile.frame.size.height);
        [tableView setFrame:CGRectMake(0,n, 320, self.view.bounds.size.height - n)];
        //tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,n, 320, self.view.bounds.size.height - n) style:UITableViewStylePlain];
        [imgOpenClose setImage:[UIImage imageNamed:@"closedIcon.png"]];
        p=1;
    }
    else
    {
        float n=0;
        NSLog(@"%f",n);
        if (IS_IPHONE_5)
        {
            n=85.0+viewprofile.frame.size.height;
        }
        else
        {
            n=72+viewprofile.frame.size.height;
        }
        NSLog(@"%f",viewprofile.bounds.origin.y);
        NSLog(@"%f",viewprofile.frame.size.height);
        [viewprofile setHidden:NO];
        [imgOpenClose setImage:[UIImage imageNamed:@"openedIcon.png"]];
        [tableView setFrame:CGRectMake(0,n,320, self.view.bounds.size.height - n)];
        p=0;
    }
}

-(IBAction)aMethod:(id)sender
{
    view3.frame=CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height);
    [self.sideBar dismiss];
    [btnclk removeFromSuperview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==tableView1)
    {
        return 10;
    }
    else
    {
        return 1;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView==tableView1)
    {
        return 45;
    }
    else
    {
        return 30.0f;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView==tableView1)
    {
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,50)];
        //customView.backgroundColor=[UIColor colorWithRed:71.0/255.0 green:69.0/255.0 blue:41.0/255.0 alpha:1];
        customView.backgroundColor= [UIColor colorWithRed:255.0/255.0 green:244.0/255.0 blue:209.0/255.0 alpha:1.0];
        return customView;
    }
    else
    {
        return nil;
    }
}

-(void)ProfileMenu{
    arryEjamaatno=[[NSMutableArray alloc]init];
    arrySabeelno=[[NSMutableArray alloc]init];
    arryThalino=[[NSMutableArray alloc]init];
    arryCount=[[NSMutableArray alloc]init];
    arryName=[[NSMutableArray alloc]init];
    arryAddress=[[NSMutableArray alloc]init];
    arryMobileno=[[NSMutableArray alloc]init];
    arryMohalla=[[NSMutableArray  alloc]init];
    arryEmail=[[NSMutableArray alloc]init];
    arryTakhmeenhoob=[[NSMutableArray alloc]init];
    arryDueamt=[[NSMutableArray alloc]init];
    arryProfileimg=[[NSMutableArray alloc]init];
    arryDelivery=[[NSMutableArray alloc]init];
    
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@FMBPROFILE?CompanyId=%@&MuminMatser_Id=%@",[[Singleton sharedSingleton] getBaseURL],Companyid,MuminId];
    //NSLog(myRequestString1);
//    NSString *myRequestString1 = [NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/FMBPROFILE?company_id=%@&Sabeel_NO=%@",Companyid,Sabeelno];
    
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str1];
    NSData * data=[NSData dataWithContentsOfURL:url1];
    NSError * error;
    NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    NSString *webStatus = [json1 objectForKey:@"status"];
    
    if ([webStatus  isEqual: @"YES"]){
        [arryEjamaatno addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"EjamaatNo"]]];
        [lblEjamaatNo setText:[NSString stringWithFormat:@"%@",arryEjamaatno[0]]];
        
        [arrySabeelno addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"SabeelNo"]]];
        [lblSabeelNo setText:[NSString stringWithFormat:@"%@",arrySabeelno[0]]];
        
        [arryThalino addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"ThaaliNo"]]];
        [lblThaliNo setText:[NSString stringWithFormat:@"%@",arryThalino[0]]];
        
        //[arryCount addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"ThaaliCategory"]]];
        [arryCount addObject:[prefs stringForKey:@"ThaliTotal"]];
        
        [lblCount setText:[NSString stringWithFormat:@"%@",arryCount[0]]];
        
        [arryName addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"FirstName"]]];
        [lblName setText:[NSString stringWithFormat:@"%@",arryName[0]]];
        txt_Name.text = lblName.text;
        
        [arryAddress addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"Address"]]];
        [lblAddress setText:[NSString stringWithFormat:@"%@",arryAddress[0]]];
        
        [arryMobileno addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"Mobile"]]];
        [lblMobileNo setText:[NSString stringWithFormat:@"%@",arryMobileno[0]]];
        txt_MobileNo.text = lblMobileNo.text;
        
        [arryMohalla addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"Mohalla"]]];
        [lblMohalla setText:[NSString stringWithFormat:@"%@",arryMohalla[0]]];
        txt_Mohalla.text = lblMohalla.text;
        
        [arryEmail addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"Email"]]];
        [lblEmail setText:[NSString stringWithFormat:@"%@",arryEmail[0]]];
        txt_Email.text = lblEmail.text;
        
        [arryTakhmeenhoob addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"ThakhmeenHoob"]]];
        [lblTakhmeenHoob setText:[NSString stringWithFormat:@"%@",arryTakhmeenhoob[0]]];
    
        [arryDueamt addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"DueAmopunt"]]];
        [lblDueAmt setText:[NSString stringWithFormat:@"%@",arryDueamt[0]]];
        
        
        
        [arrySabeelno addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"SabeelNo"]]];
        [lblSabeelNo setText:[NSString stringWithFormat:@"%@",arrySabeelno[0]]];
        
        [arryThalino addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"ThaaliNo"]]];
        [lblThaliNo setText:[NSString stringWithFormat:@"%@",arryThalino[0]]];
        
        //[arryCount addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"ThaaliCategory"]]];
        [arryCount addObject:[prefs stringForKey:@"ThaliTotal"]];
        [lblCount setText:[NSString stringWithFormat:@"%@",arryCount[0]]];
        
        [arryName addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"FirstName"]]];
        [lblName setText:[NSString stringWithFormat:@"%@",arryName[0]]];
        
        [arryAddress addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"Address"]]];
        [lblAddress setText:[NSString stringWithFormat:@"%@",arryAddress[0]]];
        
        [arryMobileno addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"Mobile"]]];
        [lblMobileNo setText:[NSString stringWithFormat:@"%@",arryMobileno[0]]];
        
        [arryMohalla addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"Mohalla"]]];
        [lblMohalla setText:[NSString stringWithFormat:@"%@",arryMohalla[0]]];

        
        [arryEmail addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"Email"]]];
        [lblEmail setText:[NSString stringWithFormat:@"%@",arryEmail[0]]];
        
        [arryTakhmeenhoob addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"ThakhmeenHoob"]]];
        [lblTakhmeenHoob setText:[NSString stringWithFormat:@"%@",arryTakhmeenhoob[0]]];
        
        [arryDueamt addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"DueAmopunt"]]];
        [lblDueAmt setText:[NSString stringWithFormat:@"%@",arryDueamt[0]]];
        
        //NSLog([NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"ImagePath"]]);
      //  [arryProfileimg addObject:[NSString stringWithFormat:@""]]http://fmbapp.com/images/556601.png;
        [arryProfileimg addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"ImagePath"]]];
        NSString *str=[NSString stringWithFormat:@"%@",arryProfileimg[0]];
        NSURL * imageURL = [NSURL URLWithString:str];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        // img1= [UIImage imageWithData:imageData];
        imgProfile.image = [UIImage imageWithData:imageData];
        
        
        
        [arryDelivery addObject:[NSString stringWithFormat:@"%@",[[json1 valueForKey:@"Post"]objectForKey:@"Status"]]];
        NSString *str1=[NSString stringWithFormat:@"%@",arryDelivery[0]];
        if([str1 isEqual:@"Y"])
        {
            [imgDelivery setImage:[UIImage imageNamed:@"Check.png"]];
        }
        else{
            [imgDelivery setImage:[UIImage imageNamed:@"UnCheck.png"]];
        }
    }
}
-(void)TodaysMenu{
    DishName = [[NSMutableArray alloc]init];
    arrreceiptno= [[NSMutableArray alloc]init];
    arrrecipedta=[[NSMutableArray alloc]init];
    arrpayment= [[NSMutableArray alloc]init];
    TakhDetails =[[NSMutableArray alloc] init];
    arrTakhYear =[[NSMutableArray alloc] init];
     arrTakhAmt =[[NSMutableArray alloc] init];
     arrTakhPaid =[[NSMutableArray alloc] init];
     arrTakhDue =[[NSMutableArray alloc] init];
    // [SVProgressHUD showProgress:0 status:@"Loading"];
    [DishName addObject:@"Receipt No               Receipt Date                 Payment"];
     NSString *myRequestString1 = [NSString stringWithFormat:@"%@RECEIPT_DATA?companyid=%@&muminmasterid=%@",[[Singleton sharedSingleton] getBaseURL],Companyid,MuminId];
    
//    NSString *myRequestString1 = [NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/RECEIPT_DATA?companyid=%@&SabeelNo=%@",Companyid,Sabeelno];
    //NSString *myRequestString1 = [NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/RECEIPT_DATA?companyid=4&SabeelNo=cj011"];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str1];
    NSData * data=[NSData dataWithContentsOfURL:url1];
    NSError * error;
    NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    NSString *webStatus = [json1 objectForKey:@"status"];
    if ([webStatus  isEqual: @"YES"]){
        for(int i=0;i<[[json1 valueForKey:@"Post"]count];i++){
            [arrrecipedta addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"receiptdate"]]];
            [arrreceiptno addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"ReceiptNo"]]];
            [arrpayment addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"amount"]]];
            
            [DishName addObject:[NSString stringWithFormat:@"%@                         %@                    %@",[arrreceiptno objectAtIndex:i],[arrrecipedta objectAtIndex:i],[arrpayment objectAtIndex:i]]];
        }
    }
    else{
        
    }
    
    [TakhDetails addObject:@"Takh.Year       Takh Amt.         Paid             Due"];
    NSString *myRequestString2  = [NSString stringWithFormat:@"%@Mumin_Curr_Prev_Amount?companyid=%@&muminmasterid=%@",[[Singleton sharedSingleton] getBaseURL],Companyid,MuminId];
    NSLog(@"in loading takh details");
    NSLog(@"%@",myRequestString2);
    //    NSString *myRequestString1 = [NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/RECEIPT_DATA?companyid=%@&SabeelNo=%@",Companyid,Sabeelno];
    //NSString *myRequestString1 = [NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/RECEIPT_DATA?companyid=4&SabeelNo=cj011"];
    NSString *str2 = [myRequestString2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url2 = [NSURL URLWithString:str2];
    NSData * data2=[NSData dataWithContentsOfURL:url2];
    NSError * error2;
    NSDictionary *json2 = [NSJSONSerialization JSONObjectWithData:data2 options: NSJSONReadingMutableContainers error: &error2];
    NSString *webStatus2 = [json2 objectForKey:@"status"];

    if ([webStatus2  isEqual: @"YES"]){
        for(int i=0;i<[[json2 valueForKey:@"Post"]count];i++){
            [arrTakhYear addObject:[NSString stringWithFormat:@"%@",[[[json2 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"YearName"]]];
            [arrTakhAmt addObject:[NSString stringWithFormat:@"%@",[[[json2 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"TakhMeen"]]];
            [arrTakhPaid    addObject:[NSString stringWithFormat:@"%@",[[[json2 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Paid"]]];
            [arrTakhDue    addObject:[NSString stringWithFormat:@"%@",[[[json2 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Due"]]];
            /*amt=0;
            @try {
            tmp =  [NSString stringWithFormat:@"%@", [[[json2 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"TakhMeen"]];
                amt = [tmp doubleValue];
                NSLog(@"after amt 1 ");
            tmp= [NSString stringWithFormat:@"%@",[[[json2 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Paid"]];
                amt -= [tmp doubleValue];
                NSLog(@"after amt 2 ");
            }
            @catch(NSException *ex) {
            }*/
            [TakhDetails addObject:[NSString stringWithFormat:@"%@     %@      %@        %@"  ,[arrTakhYear objectAtIndex:i],[arrTakhAmt objectAtIndex:i],[arrTakhPaid objectAtIndex:i],[arrTakhDue objectAtIndex:i]]];
        }
    }
}
-(void)Announcement{
    Anndescription = [[NSMutableArray alloc]init];
    //    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //    NSString *id1 = [prefs stringForKey:@"id"];
    
    // [SVProgressHUD showProgress:0 status:@"Loading"];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@THAALIDIST?company_id=%@&muminmasterid=%@",[[Singleton sharedSingleton] getBaseURL],Companyid,MuminId];
    
//    NSString *myRequestString1 = [NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/THAALIDIST?company_id=%@&SabeelNo=%@",Companyid,Sabeelno];
   // NSString *myRequestString1 = [NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/THAALIDIST?company_id=4&SabeelNo=cj011"];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str1];
    NSData * data=[NSData dataWithContentsOfURL:url1];
    NSError * error;
    NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    NSString *webStatus = [json1 objectForKey:@"status"];
    if ([webStatus  isEqual: @"YES"])
    {
        for(int i=0;i<[[json1 valueForKey:@"Post"]count];i++)
        {
            [Anndescription addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"ThaaliDate"]]];
        }
    }
    else{
        
    }
}
-(void)GetMohalla{//http://services.saksolution.com/FMBService_New1.asmx/BindMohallaDetails?Company_Id=1
    arr_Mohaalla = [[NSMutableArray alloc]init];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@BindMohallaDetails?Company_Id=%@",[[Singleton sharedSingleton] getBaseURL],Companyid];
     NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str1];
    NSData * data=[NSData dataWithContentsOfURL:url1];
    NSError * error;
    NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    NSString *webStatus = [json1 objectForKey:@"status"];
    if ([webStatus  isEqual: @"YES"])
    {
        arr_Mohaalla = [[json1 objectForKey:@"Post"]mutableCopy];
        for (int i = 0; i <arr_Mohaalla.count; i++) {
            if ([[[arr_Mohaalla objectAtIndex:i] objectForKey:@"Mohalla"] isEqual: txt_Mohalla.text]) {
                MohallaID = [NSString stringWithFormat:@"%@",[[arr_Mohaalla objectAtIndex:i]objectForKey:@"Mohalla_Id"]];
                break;

            }else{
                
            }
        }
    }
    else{
        
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)doneClicked:(id)sender{
    [self.view endEditing:true];
}
- (IBAction)btn_ClickedGetMohalla:(id)sender {
    [self showPopUpWithTitle:@"Select Mohalla" withOption:[arr_Mohaalla valueForKey:@"Mohalla"] xy:CGPointMake(16, 140) size:CGSizeMake(290, 320) isMultiple:NO];
}
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:NO];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    [Dropobj SetBackGroundDropDwon_R:0.0 G:108.0 B:194.0 alpha:0.70];
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    txt_Mohalla.text = [[arr_Mohaalla objectAtIndex:anIndex] objectForKey:@"Mohalla"];
    MohallaID = [[arr_Mohaalla objectAtIndex:anIndex]objectForKey:@"Mohalla_Id"];
}

@end
