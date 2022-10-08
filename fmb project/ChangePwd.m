//
//  ChangePwd.m
//  FMB Connect
//
//  Created by SMB-Mobile01 on 11/4/15.
//  Copyright (c) 2015 SAK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangePwd.h"
#import "FeedbackPage.h"
#import "custom.h"
#import "CDRTranslucentSideBar.h"
#import "ThaliManagePage.h"
#import "ProfilePage.h"
#import "MenuListPage.h"
#import "MiquatCalenderPage.h"
#import "MannatPage.h"
#import "MannatReport.h"
#import "FeedbackPage.h"
#import "HomePage.h"
#import "SAkViewController.h"

@interface ChangePwd()<CDRTranslucentSideBarDelegate>{
    BOOL chk,test;
    NSString *StartDate;
    NSUserDefaults *prefs;
    NSString *MuminId,*Companyid,*Sabeelno,*PastDate,*Firstname,*Email;
     UITableView *tableView1;
    int p,r;
    UIButton *btnclk;
}
@property (strong, nonatomic) CCKFNavDrawer *rootNav;
@property(nonatomic,strong)id <SKPSMTPMessageDelegate> delegate;
@property(nonatomic,strong)SKPSMTPMessage *testMsg;
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@end

@implementation ChangePwd
- (void)viewDidLoad
{
    [super viewDidLoad];
    [SVProgressHUD dismiss];

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
    p=0;
    r=10;
    
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    prefs = [NSUserDefaults standardUserDefaults];
    Companyid = [prefs stringForKey:@"Companyid"];
    Sabeelno = [prefs stringForKey:@"Sabeelno"];
    Firstname=[prefs stringForKey:@"FirstName"];
    Email=[prefs stringForKey:@"Email"];
    //txtOldPassword.text = @"Old Password";
    txtOldPassword.textColor = [UIColor darkGrayColor];
    MuminId=[prefs stringForKey:@"muminmasterid"];
    
    //txtNewPassword.text = @"New Password";
    txtNewPassword.textColor = [UIColor darkGrayColor];

    // Do any additional setup after loading the view.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)CCKFNavDrawerSelection:(NSInteger)selectionIndex{
    if (selectionIndex == 0){
        CCKFNavDrawer *HomePage = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePage"];
        HomePage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:HomePage animated:YES completion:nil];
    }
    else if (selectionIndex == 1){
        CCKFNavDrawer *ProfilePage = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfilePage"];
        ProfilePage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:ProfilePage animated:YES completion:nil];
    }
    else if (selectionIndex == 2){
    }
    else if (selectionIndex == 3){
        CCKFNavDrawer *MenuListPage = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuListPage"];
        MenuListPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:MenuListPage animated:YES completion:nil];
    }
    else if (selectionIndex == 4){
        CCKFNavDrawer *FeedbackPage = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedbackPage"];
        FeedbackPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:FeedbackPage animated:YES completion:nil];
    }
    else if (selectionIndex == 5){
        CCKFNavDrawer *MiquatCalenderPage = [self.storyboard instantiateViewControllerWithIdentifier:@"MiquatCalenderPage"];
        MiquatCalenderPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:MiquatCalenderPage animated:YES completion:nil];
    }
    else if (selectionIndex == 6){
        CCKFNavDrawer *MiquatCalenderPage = [self.storyboard instantiateViewControllerWithIdentifier:@"MannatPage"];
        MiquatCalenderPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:MiquatCalenderPage animated:YES completion:nil];
    }
    else if (selectionIndex == 7){
        CCKFNavDrawer *MiquatCalenderPage = [self.storyboard instantiateViewControllerWithIdentifier:@"MannatReport"];
        MiquatCalenderPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:MiquatCalenderPage animated:YES completion:nil];
    }
    
    else{
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     if (tableView==tableView1)
    {
        return 10;
    }
    else
    {
        return 3;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(tableView==tableView1)
    {
        return 45;
    }
    return YES;
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    if (tableView==tableView1)
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
            cell.textLabel.text = @"        Thali Start Stop";
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
    else{
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld",(long)indexPath.row]];
        if (cell==Nil){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld",(long)indexPath.row]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
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
        
    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
- (IBAction)btnOpenMenu:(id)sender {
    //[txvrReason resignFirstResponder];
   /* NSArray  *menuNames = [NSArray arrayWithObjects:@"home.png",@"profile.png",@"thalimanageselect.png",@"menu.png",@"feedback.png",@"homeselect.png",@"profile.png",@"thalimanage.png", nil];
    [self.rootNav drawerToggle:menuNames];*/
    [self.sideBar show];
    view3.frame=CGRectMake(self.view.frame.size.width*0.75,0,self.view.bounds.size.width,self.view.bounds.size.height);
    btnclk=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.75, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [btnclk addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnclk];

}
-(IBAction)aMethod:(id)sender
{
    view3.frame=CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height);
    [self.sideBar dismiss];
    [btnclk removeFromSuperview];
}
- (IBAction)btnSubmit:(id)sender {
   // NSString *oldpass = [prefs stringForKey:@"Password"];

    if (chk==YES){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter Old Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txtOldPassword.text isEqual:@"Old Password"]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter Old Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txtOldPassword.text isEqual:@""]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter Old Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(![txtOldPassword.text isEqual:[prefs stringForKey:@"Password"]]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Old Password Is Wrong" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
   else if([txtNewPassword.text isEqual:@""]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter New Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        [txtOldPassword resignFirstResponder];
        [SVProgressHUD showProgress:0 status:@"Loading"];
        /*NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd,yyyy"];
        
        NSDate *date1 = [dateFormatter dateFromString:txtStartDate.text];
        
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat    :@"yyyy-MM-dd"];
        
        StartDate = [dateFormatter stringFromDate:date1];*/
        
        NSString *appurl =[NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/ChangePasswordMumin?MuminMaster_Id=%@&oldPassword=%@&NewPassword=%@",MuminId,txtOldPassword.text,txtNewPassword.text];
        
        NSString *str1 = [appurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url1 = [NSURL URLWithString:str1];
        NSData * data=[NSData dataWithContentsOfURL:url1];
        NSError * error;
        NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        
        
        NSString *webStatus = [json1 objectForKey:@"status"];
        
        if ([webStatus  isEqual: @"YES"])
        {
            [self sendMessageInBack1];
            [prefs setObject:txtNewPassword.text forKey:@"Password"];
            txtNewPassword.text = @"";
            txtOldPassword.text = @"";
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Password has changed successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [SVProgressHUD dismiss];

        }
        else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:[json1 valueForKey:@"Post"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [SVProgressHUD dismiss];
        }
    }
}
- (void)sendMessageInBack1
{
    NSLog(@"Start Sending");
    _testMsg = [[SKPSMTPMessage alloc] init];
    _testMsg.relayHost = @"smtp.gmail.com";
    _testMsg.fromEmail =@"support@saksolution.com";
    _testMsg.toEmail =Email;
    // _testMsg.bccEmail =@"husainimohallah@gmail.com";
    _testMsg.login =@"support@saksolution.com";
    _testMsg.pass =@"Sak.1234";
   	_testMsg.requiresAuth = YES;
    _testMsg.subject = @"Inquiry Form";
    _testMsg.wantsSecure = YES;
    _testMsg.delegate = self;
    
    NSString *str = [NSString stringWithFormat:@"Salam %@,\nSabeel No %@\nYour Password Change request has been updated successfully \nNew Password:%@. \n\n\n\nRegards\n",Firstname,Sabeelno,txtNewPassword.text];
    
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                               
                               str,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    _testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
    [_testMsg send];
}
-(void)messageSent:(SKPSMTPMessage *)message{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Submit Successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    message=nil;
    test=YES;
    txtOldPassword.text=@"";
    [SVProgressHUD dismiss];
}

-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    message=nil;
    [SVProgressHUD dismiss];
    
}
- (IBAction)btnCancel:(id)sender {
    txtOldPassword.text=@"";
    txtNewPassword.text=@"";
}

- (IBAction)btnLogOut:(id)sender {
    UIViewController *reg2=[self.storyboard instantiateViewControllerWithIdentifier:@"SAkViewController"];
    [self.navigationController pushViewController:reg2 animated:YES];
    prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:NO forKey:@"boolVal"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


@end