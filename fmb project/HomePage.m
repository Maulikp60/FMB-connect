//
//  HomePage.m
//  Fmb
//
//  Created by SMB-Mobile01 on 9/6/14.
//  Copyright (c) 2014 SAK. All rights reserved.
//

#import "HomePage.h"
#import "CDRTranslucentSideBar.h"
#import "ThaliManagePage.h"
#import "ProfilePage.h"
#import "MenuListPage.h"
#import "MiquatCalenderPage.h"
#import "MannatPage.h"
#import "MannatReport.h"
#import "FeedbackPage.h"
#import "SAkViewController.h"
#import "Singleton.h"
#import "ChangePwd.h"

#define kTableHeaderHeight 40.0f
#define kTableRowHeight 20.0f

@interface HomePage ()<CDRTranslucentSideBarDelegate>{
     EMAccordionTableViewController *emTV;
    NSMutableArray *arr_catIds;
    NSMutableArray *arr_catNames;
    NSMutableArray *arrcount1;
    
    NSMutableArray *DishName;
    NSMutableArray *Anndescription;
    NSMutableArray *AnnAttachment;
    NSMutableArray *arrcount;
    NSDictionary *json;
    int k;
    NSUserDefaults *prefs;
    NSString *Companyid,*Sabeelno,*Password,*MuminId,*attach_link;
    NSString *myString;
    UIAlertView *alert;
    UIButton *btnclk;
    UITableView *tableView1;
}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@end

@implementation HomePage
{
    NSArray *sections;
    CGFloat origin;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
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
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    prefs = [NSUserDefaults standardUserDefaults];
    Companyid = [prefs stringForKey:@"CompanyId"];
    Sabeelno = [prefs stringForKey:@"Sabeelno"];
    Password=[prefs stringForKey:@"Password"];
    MuminId=[prefs stringForKey:@"muminmasterid"];
    ChagePasswordView.hidden=YES;
    [self TodaysMenu];
    [self Announcement];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClickedSubmit:(id)sender {
    if([txtOldPassword.text isEqualToString:@""] && [txtNewPassword.text isEqualToString:@""] && [txtConfirmPassword.text isEqualToString:@""])
    {
        alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Empty Fields Are Not Allowed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (![txtOldPassword.text isEqualToString:Password])
    {
        alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter Your Correct Current Password !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
   /* else if ([txtNewPassword.text isEqualToString:@""])
    {
        alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter New Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([txtConfirmPassword.text isEqualToString:@""])
    {
        alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter Confirm Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(txtNewPassword.text.length<8 || txtNewPassword.text.length>16)
    {
        alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Password Must Be Between 8 To 16 Characters" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }*/
    
    else if (![txtNewPassword.text isEqualToString:txtConfirmPassword.text])
    {
        alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Password Did Not Match!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [SVProgressHUD showProgress:0 status:@"Loading"];
        NSString *myRequestString1 = [NSString stringWithFormat:@"%@ChangePassword?CompanyId=%@&SabeelNo=%@&Password=%@&NewPassword=%@",[[Singleton sharedSingleton] getBaseURL],Companyid,Sabeelno,txtOldPassword.text,txtNewPassword.text];
        NSURL *url = [NSURL URLWithString:myRequestString1];
        NSData * data=[NSData dataWithContentsOfURL:url];
        NSError * error;
        NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        
        NSString *webStatus = [json1 objectForKey:@"status"];
        if([webStatus isEqualToString:@"YES"]){
            alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:[json1 valueForKey:@"Post"]delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [txtConfirmPassword resignFirstResponder];
                prefs = [NSUserDefaults standardUserDefaults];
                [prefs setBool:YES forKey:@"boolValpas"];
                ChagePasswordView.hidden=YES;
                origin = 20.0f;
                if ([[UIDevice currentDevice].model hasPrefix:@"iPad"])
                    origin = 100.0f;
                float n=btnobjOpenMenu.layer.position.y+btnobjOpenMenu.frame.size.height-20;
                UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,n, 320, self.view.bounds.size.height - n) style:UITableViewStylePlain];
                [tableView setSectionHeaderHeight:kTableHeaderHeight];
                [tableView setBackgroundColor:[UIColor clearColor]];
               
                emTV = [[EMAccordionTableViewController alloc] initWithTable:tableView withAnimationType:EMAnimationTypeBounce];
                [emTV setDelegate:self];
                
                [emTV setClosedSectionIcon:[UIImage imageNamed:@"closedIcon"]];
                [emTV setOpenedSectionIcon:[UIImage imageNamed:@"openedIcon"]];
                // Section graphics
                UIColor *sectionsColor = [UIColor colorWithRed:71.0f/255.0f green:70.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
                UIColor *sectionTitleColor = [UIColor whiteColor];
                UIFont *sectionTitleFont = [UIFont fontWithName:@"Futura" size:24.0f];

                EMAccordionSection *section01 = [[EMAccordionSection alloc] init];
                [section01 setBackgroundColor:sectionsColor];
                [section01 setItems:DishName];
                [section01 setTitle:@"Today's Menu"];
                [section01 setTitleFont:sectionTitleFont];
                [section01 setTitleColor:sectionTitleColor];
                [emTV addAccordionSection:section01];
                
                EMAccordionSection *section02 = [[EMAccordionSection alloc] init];
                [section02 setBackgroundColor:sectionsColor];
                [section02 setItems:Anndescription];
                [section02 setTitle:@"Announcement"];
                [section02 setTitleColor:sectionTitleColor];
                [section02 setTitleFont:sectionTitleFont];
                [emTV addAccordionSection:section02];
                sections = [[NSArray alloc] initWithObjects:section01, section02, nil];
                [self.view addSubview:emTV.tableView];
            }
            else
            {
                alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:[json1 valueForKey:@"Post"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            [SVProgressHUD dismiss];
    }
}
- (IBAction)btnClickedCancel:(id)sender {
    prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:YES forKey:@"boolValpas"];
    ChagePasswordView.hidden=YES;
    origin = 20.0f;
    if ([[UIDevice currentDevice].model hasPrefix:@"iPad"])
        origin = 100.0f;
    float n=btnobjOpenMenu.layer.position.y+btnobjOpenMenu.frame.size.height-20;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,n, 320, self.view.bounds.size.height - n) style:UITableViewStylePlain];
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
    EMAccordionSection *section01 = [[EMAccordionSection alloc] init];
    [section01 setBackgroundColor:sectionsColor];
    [section01 setItems:DishName];
    [section01 setTitle:@"Today's Menu"];
    [section01 setTitleFont:sectionTitleFont];
    [section01 setTitleColor:sectionTitleColor];
    [emTV addAccordionSection:section01];
    
    EMAccordionSection *section02 = [[EMAccordionSection alloc] init];
    [section02 setBackgroundColor:sectionsColor];    [section02 setItems:Anndescription];
    [section02 setTitle:@"Announcement"];
    [section02 setTitleColor:sectionTitleColor];
    [section02 setTitleFont:sectionTitleFont];
    [emTV addAccordionSection:section02];
    
    sections = [[NSArray alloc] initWithObjects:section01, section02, nil];
    
    [self.view addSubview:emTV.tableView];
    
}

- (IBAction)btnOpenMenu:(id)sender {
    [self.sideBar show];
    view3.frame=CGRectMake(self.view.frame.size.width*0.75,0,self.view.bounds.size.width,self.view.bounds.size.height);
    btnclk=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.75, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [btnclk addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnclk];
//    NSArray  *menuNames = [NSArray arrayWithObjects:@"homeselect.png",@"profile.png",@"thalimanage.png",@"menu.png",@"feedback.png",@"homeselect.png",@"profile.png",@"thalimanage.png", nil];
//    [self.rootNav drawerToggle:menuNames];
    
}

- (IBAction)btnLogOut:(id)sender {
    
    UIViewController *reg2=[self.storyboard instantiateViewControllerWithIdentifier:@"SAkViewController"];
    [self.navigationController pushViewController:reg2 animated:YES];
    prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:NO forKey:@"boolVal"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if(textField == txtOldPassword)
    {
        [txtNewPassword becomeFirstResponder];
    }
    else if(textField == txtNewPassword)
    {
        [txtConfirmPassword becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void) viewDidAppear:(BOOL)animated {
    
    prefs = [NSUserDefaults standardUserDefaults];
    myString = [prefs stringForKey:@"boolValpas"];
    
    if ([myString isEqual: @"1"])
    {
        ChagePasswordView.hidden=YES;
        origin = 20.0f;
        if ([[UIDevice currentDevice].model hasPrefix:@"iPad"])
            origin = 100.0f;
        float n=btnobjOpenMenu.layer.position.y+btnobjOpenMenu.frame.size.height-20;
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,n, 320, self.view.bounds.size.height - n) style:UITableViewStylePlain];
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
        EMAccordionSection *section01 = [[EMAccordionSection alloc] init];
        [section01 setBackgroundColor:sectionsColor];
        [section01 setItems:DishName];
        [section01 setTitle:@"Today's Menu"];
        [section01 setTitleFont:sectionTitleFont];
        [section01 setTitleColor:sectionTitleColor];
        [emTV addAccordionSection:section01];
        
        EMAccordionSection *section02 = [[EMAccordionSection alloc] init];
        [section02 setBackgroundColor:sectionsColor];
        [section02 setItems:Anndescription];
        [section02 setTitle:@"Announcement"];
        [section02 setTitleColor:sectionTitleColor];
        [section02 setTitleFont:sectionTitleFont];
        [emTV addAccordionSection:section02];
        
        sections = [[NSArray alloc] initWithObjects:section01, section02, nil];
        
        [self.view addSubview:emTV.tableView];
    }
    
    else
    {
        [prefs setBool:YES forKey:@"boolValpas"];
        ChagePasswordView.hidden=NO;
    }

    // Setup the EMAccordionTableViewController
   
}

#pragma mark EMAccordionTableDelegate
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(tableView==tableView1)
    {
        return 54;
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
        [titleLbl setText:[items objectAtIndex:indexPath.row]];
        [titleLbl setBackgroundColor:[UIColor clearColor]];
        [titleLbl setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        titleLbl.textColor=[UIColor blackColor];
        
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
        
        
        EMAccordionSection *section = [sections objectAtIndex:indexPath.section];
        @try {
            NSMutableArray *items = [self dataFromIndexPath:indexPath];
            if ([[items objectAtIndex:indexPath.row]  isEqual: @"Menu is not available."]) {
                
            }else{
                if ([section.title  isEqual: @"Announcement"]) {
                    attach_link = [AnnAttachment objectAtIndex:indexPath.row];
                    if ([attach_link  isEqual: @""]) {
                        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"FMB" message:[[NSString alloc] initWithFormat:@"%@ : %@", section.title, [items objectAtIndex:indexPath.row]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [av show];
   
                    }else{
                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"FMB" message:[[NSString alloc] initWithFormat:@"%@ : %@", section.title, [items objectAtIndex:indexPath.row]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"View",@"Download", nil];
                    [av show];
                    av.tag = 101;
                    }
                }else{
                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"FMB" message:[[NSString alloc] initWithFormat:@"%@ : %@", section.title, [items objectAtIndex:indexPath.row]] delegate:NULL cancelButtonTitle:NULL otherButtonTitles:@"OK", nil];
                    [av show];

                }
            }
        }
        @catch(NSException *ex) {
            UIAlertView *av1 = [[UIAlertView alloc] initWithTitle:@"FMB" message:[[NSString alloc] initWithFormat:@"No data for %@", section.title] delegate:NULL cancelButtonTitle:NULL otherButtonTitles:@"OK", nil];
            [av1 show];        }
    }
    
}

- (NSMutableArray *) dataFromIndexPath: (NSIndexPath *)indexPath {
    if (indexPath.section == 0){
        if (DishName.count == 0) {
            UIAlertView *av1 = [[UIAlertView alloc] initWithTitle:@"FMB" message:[[NSString alloc] initWithFormat:@"No data for Today's Menu"] delegate:NULL cancelButtonTitle:NULL otherButtonTitles:@"OK", nil];
            [av1 show];

        }
        return DishName;
    }
    else if (indexPath.section == 1){
        return Anndescription;}
    return NULL;
}

-(void)TodaysMenu{
    @try {
    DishName = [[NSMutableArray alloc]init];
   // [SVProgressHUD showProgress:0 status:@"Loading"];
    
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@Menu_List?companyId=%@",[[Singleton sharedSingleton] getBaseURL],Companyid];
    
//    NSString *myRequestString1 = [NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/MENU_LIST?companyId=%@",Companyid];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str1];
    
    NSData * data=[NSData dataWithContentsOfURL:url1];
    
    NSError * error;
    
    NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    NSString *webStatus = [json1 objectForKey:@"status"];
    
    if ([webStatus  isEqual: @"YES"]){
        for(int i=0;i<[[json1 valueForKey:@"Post"]count];i++){
            [DishName addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"DishName"]]];
        }
    }else{
        [DishName addObject:@"Menu is not available."];
    }
    }
    @catch(NSException *ex) {
        UIAlertView *av1 = [[UIAlertView alloc] initWithTitle:@"FMB" message:[[NSString alloc] initWithFormat:@"No data for Today's Menu"] delegate:NULL cancelButtonTitle:NULL otherButtonTitles:@"OK", nil];
        [av1 show];
    }
}
-(void)Announcement
{
     NSString *appurl =[NSString stringWithFormat:@"%@ANNOUNCEMENT?companyId=%@&MuminMatser_Id=%@",[[Singleton sharedSingleton] getBaseURL],Companyid,MuminId];
    
//    NSString *appurl =[NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/ANNOUNCEMENT?companyId=%@",Companyid];
    
    NSURL *url = [NSURL URLWithString:appurl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    Anndescription=[[NSMutableArray alloc]init];
    AnnAttachment=[[NSMutableArray alloc] init];
    NSError *error = [request error];
    
    if (!error)
    {
        
        NSString *response = [request responseString];
        
        // NSLog(@"%@", response);
        
        NSError *parseError = nil;
        
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:response error:Nil];
        
        // Print the dictionary
        NSMutableDictionary *ab=[xmlDictionary objectForKey:@"string"];
        NSString *a=[ab objectForKey:@"text"];
        NSMutableArray *array=[[NSMutableArray alloc]init];
        
        array = [[a componentsSeparatedByString:@"~"]mutableCopy];
        NSLog(@"arr%@",array);
        a=[array objectAtIndex:1];
        
        NSData *data = [a dataUsingEncoding:NSUTF8StringEncoding];
        json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSString *webStatus = [json objectForKey:@"status"];
        
        if ([webStatus  isEqual: @"YES"])
        {
            for(int i=0;i<[[json valueForKey:@"Post"]count];i++){
                
                [Anndescription addObject:[NSString stringWithFormat:@"%@",[[[json valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Anndescription"]]];
                [AnnAttachment addObject:[NSString stringWithFormat:@"%@",[[[json valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Attatchment"]]];

            }
        }
        else
        {
            
        }
    }
}
#pragma mark - UIAlertViewDelegate Method
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 101) {
        if(buttonIndex == 0){
        }else if(buttonIndex == 1){
            [emTV.tableView removeFromSuperview];
            view_WebView.hidden = NO;
            [web_Display loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:attach_link]]];

        }else{
        }
    }
    else {
    }
}
#pragma mark - IBAction Method
- (IBAction)btn_ClickedDownload:(id)sender {
    
    NSURL  *url = [NSURL URLWithString:attach_link];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if ( urlData )
    {
        NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString  *documentsDirectory = [paths objectAtIndex:0];
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,attach_link];
        [urlData writeToFile:filePath atomically:YES];
        UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"FMB" message:@"Your File is Download." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert1 show];
    }
}
- (IBAction)btn_ClickedOk:(id)sender {
    view_WebView.hidden = YES;
    [self.view addSubview:emTV.tableView];
    
}

//-(void)Announcement{
//    Anndescription = [[NSMutableArray alloc]init];
//    //    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    //    NSString *id1 = [prefs stringForKey:@"id"];
//    
//    // [SVProgressHUD showProgress:0 status:@"Loading"];
//    NSString *myRequestString1 = [NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/ANNOUNCEMENT?companyId=%@",Companyid];
//    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url1 = [NSURL URLWithString:str1];
//    
//    NSData * data=[NSData dataWithContentsOfURL:url1];
//    
//    NSError * error;
//
//    NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
//    
//    NSString *webStatus = [json1 objectForKey:@"status"];
//    
//    if ([webStatus  isEqual: @"YES"]){
//        for(int i=0;i<[[json1 valueForKey:@"Post"]count];i++){
//            
//            [Anndescription addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Anndescription"]]];
//        }
//    }
//    else
//    {
//        
//    }
//}

@end
