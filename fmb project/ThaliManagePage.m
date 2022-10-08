//
//  ThaliManagePage.m
//  Fmb
//
//  Created by SMB-Mobile01 on 9/6/14.
//  Copyright (c) 2014 SAK. All rights reserved.
//

#import "ThaliManagePage.h"
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#import "Reachability.h"
#import "CDRTranslucentSideBar.h"
#import "ProfilePage.h"
#import "HomePage.h"
#import "MenuListPage.h"
#import "MiquatCalenderPage.h"
#import "MannatPage.h"
#import "MannatReport.h"
#import "FeedbackPage.h"
#import "SAkViewController.h"
#import "Singleton.h"
#import "ChangePwd.h"

@interface ThaliManagePage ()<CDRTranslucentSideBarDelegate>{
    int b1,c1,d1,e1;
    BOOL chk,test;
    NSString *FromDate,*ToDate,*Thalitypeid;
    NSUserDefaults *prefs;
    NSString *Companyid,*Sabeelno,*PastDate,*Firstname,*Email,*MuminId,*ThaliType,*ThaliTotal,*ThaliType_Id;
    int flag,flag1;
    UIButton *btnclk;
    UITableView *tableView1;
    NSMutableArray *arrThaliType_Id,*arrThaliType_Name,*arrStartDate,*arrStopDate,*arrReason,*arrId;
}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@property(nonatomic,strong)SKPSMTPMessage *testMsg;
@end

@implementation ThaliManagePage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
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
    
    txvReason.text = @"Reason";
    txvReason.textColor = [UIColor darkGrayColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    prefs = [NSUserDefaults standardUserDefaults];
    Companyid = [prefs stringForKey:@"CompanyId"];
    Sabeelno = [prefs stringForKey:@"Post"];
    Firstname=[prefs stringForKey:@"FirstName"];
    Email=[prefs stringForKey:@"Email"];
    MuminId=[prefs stringForKey:@"muminmasterid"];
    ThaliType=[prefs stringForKey:@"ThaliType"];
    ThaliTotal=[prefs stringForKey:@"ThaliTotal"];
    ThaliType_Id=[prefs stringForKey:@"ThaliType_Id"];
    
    NSDate *today = [NSDate date];
    today=[today dateByAddingTimeInterval:60*60*24];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd,yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    txtFromDate.text=dateString;
    txtToDate.text=dateString;
    PastDate=dateString;
    chk=YES;
    test=YES;
    flag=0;
    lblDisplayThali.text=ThaliType;
    [self GetStopThaliReport];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnOpenMenu:(id)sender {
    [txvReason resignFirstResponder];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==tableView1)
    {
        return 10;
    }
    else if (tableView==tblPopup)
    {
        return arrThaliType_Id.count;
    }
    else
    {
        return arrStartDate.count;
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
    else if (tableView==tblPopup)
    {
        return 0;
    }
    else
    {
        return 0;
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
    else if (tableView==tblPopup)
    {
        return nil;
    }
    else
    {
        return nil;
    }

}
#pragma mark EMAccordionTableDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    else if (tableView==tblPopup)
    {
        static NSString *MyIdentifier = @"Cell";
        custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (ce == nil){
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        }
        ce.lblPopup.text=[NSString stringWithFormat:@"%@",arrThaliType_Name[indexPath.row]];
        //[ce.lblMenuDate setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        //ce.lblMenuDate.textColor=[UIColor blackColor];
        
        //ce.lblMenuDay.textColor=[UIColor blackColor];
        //[ce.lblMenuDay setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        //
        //        ce.lblMenuList.text=[NSString stringWithFormat:@"%@",MenuList[indexPath.row]];
        //        ce.lblMenuList.textColor=[UIColor blackColor];
        //        [ce.lblMenuList setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        //        ce.selectionStyle = UITableViewCellSelectionStyleNone;
        return ce;

    }
    else
    {
        static NSString *MyIdentifier = @"Cell";
        custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (ce == nil){
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        }
        ce.btnobjDelete.tag=indexPath.row;
        
        [ce.btnobjDelete addTarget:self
                           action:@selector(btnClickedDelete:)
                 forControlEvents:UIControlEventTouchUpInside];
        ce.lblStartStopdate.text=[NSString stringWithFormat:@"%@",arrStartDate[indexPath.row]];
        ce.lblStopDate1.text=[NSString stringWithFormat:@"%@",arrStopDate[indexPath.row]];
//        [ce.lblMenuDate setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
//        ce.lblMenuDate.textColor=[UIColor blackColor];
        
        ce.lblReasonthali.text=[NSString stringWithFormat:@"%@",arrReason[indexPath.row]];
//        ce.lblMenuDay.textColor=[UIColor blackColor];
//        [ce.lblMenuDay setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        
        return ce;
    }
}
- (IBAction)btnClickedDelete:(id)sender {
    
    NSInteger tags = ((UIButton *)sender).tag;
    if(flag==0)
    {
        NSString *myRequestString1 = [NSString stringWithFormat:@"%@DeleteStartStop_IncDesc?Identity=StartStop&Id=%@",[[Singleton sharedSingleton] getBaseURL],[arrId objectAtIndex:tags]];
        
        //    NSString *myRequestString1 = [NSString stringWithFormat:@"http://192.168.1.23/FMB-//Webservice/FMBServiceNew.asmx/Niyat_Type_Bind"];
        NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url1 = [NSURL URLWithString:str1];
        NSData * data=[NSData dataWithContentsOfURL:url1];
        NSError * error;
        NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        NSString *webStatus = [json1 objectForKey:@"status"];
        if ([webStatus  isEqual: @"YES"])
        {
            UIAlertView *alertDelete=[[UIAlertView alloc]initWithTitle:@"" message:@"Delete Successful" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertDelete show];
            [self GetStopThaliReport];

        }
        else
        {
            UIAlertView *alertDelete=[[UIAlertView alloc]initWithTitle:@"" message:@"Delete UnSuccessful" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertDelete show];
        }
        [tblPopup reloadData];
    }
    else
    {
        NSString *myRequestString1 = [NSString stringWithFormat:@"%@DeleteStartStop_IncDesc?Identity=IncDesc&Id=%@",[[Singleton sharedSingleton] getBaseURL],[arrId objectAtIndex:tags]];
        
        //    NSString *myRequestString1 = [NSString stringWithFormat:@"http://192.168.1.23/FMB-//Webservice/FMBServiceNew.asmx/Niyat_Type_Bind"];
        NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url1 = [NSURL URLWithString:str1];
        NSData * data=[NSData dataWithContentsOfURL:url1];
        NSError * error;
       json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        NSString *webStatus = [json1 objectForKey:@"status"];
        if ([webStatus  isEqual: @"YES"])
        {
            UIAlertView *alertDelete=[[UIAlertView alloc]initWithTitle:@"" message:@"Delete Successful" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertDelete show];
            [self GetIncDecThaliReport];
           
        }
        else
        {
            UIAlertView *alertDelete=[[UIAlertView alloc]initWithTitle:@"" message:@"Delete UnSuccessful" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertDelete show];
        }
        [tblPopup reloadData];
    }
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView==tableView1)
    {
        return 45;
    }
    else if (tableView==tblPopup)
    {
        return 30.0f;
    }
    else
    {
        return 51.0f;
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
    }
    else if(tableView==tblPopup)
    {
        txtNewThali.text=[arrThaliType_Name objectAtIndex:indexPath.row];
        Thalitypeid=[arrThaliType_Id objectAtIndex:indexPath.row];
        [tblPopup setHidden:YES];
    }
    else
    {
        
    }
        //[SVProgressHUD dismiss];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        [txvReason resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView{
    if (test==YES){
        txvReason.text = @"";
        test=NO;
    }
    else if([txvReason.text isEqualToString:@"Reason"]){
        txvReason.text=@"";
    }
    txvReason.textColor = [UIColor darkGrayColor];
    chk=NO;
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView{
    if(txvReason.text.length == 0){
        txvReason.textColor = [UIColor lightGrayColor];
        txvReason.text = @"Reason";
        [txvReason resignFirstResponder];
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles{
    switch (pickerView.tag){
        case 1: txtFromDate.text=[titles componentsJoinedByString:@" - "];
            txtToDate.text=[titles componentsJoinedByString:@" - "];break;
            
            //  case 1: [txtFromDate setTitle:[titles componentsJoinedByString:@" - "] forState:UIControlStateNormal]; break;
        case 2: txtToDate.text=[titles componentsJoinedByString:@" - "];break;
        default:
            break;
    }
    [self a];
    [self b];
    if (d1 < e1){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Inform Before 24 Hours" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        txtFromDate.text=PastDate;
        txtToDate.text=PastDate;
        
    }
    else if(b1>c1){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"To Date Can't be less than From Date" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        txtToDate.text=txtFromDate.text;
    }
}

-(void)a{
    NSString *str1 = txtToDate.text; /// here this is your date with format yyyy-MM-dd
    NSString *str2=txtFromDate.text;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"MMM dd,yyyy"]; //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date1 = [dateFormatter dateFromString:str1];
    NSDate *date2 = [dateFormatter dateFromString:str2];
    // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];// here set format which you want...
    
    NSString *a = [dateFormatter stringFromDate:date1];
    NSString *b = [dateFormatter stringFromDate:date2];
    
    a=[a stringByReplacingOccurrencesOfString:@"-" withString:@""];
    b=[b stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    b1=[b intValue];
    c1=[a intValue];
}

-(void)b{
    NSString *str1 = txtFromDate.text; /// here this is your date with format yyyy-MM-
    NSString *str2=PastDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd,yyyy"];
    NSDate *date1 = [dateFormatter dateFromString:str1];
    NSDate *date2 = [dateFormatter dateFromString:str2];
    // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];// here set format which you want...
    
    NSString *a = [dateFormatter stringFromDate:date1];
    NSString *b = [dateFormatter stringFromDate:date2];
    
    a=[a stringByReplacingOccurrencesOfString:@"-" withString:@""];
    b=[b stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    d1=[a intValue];
    e1=[b intValue];
}

- (IBAction)btnFromDate:(id)sender {
    [self.view endEditing:YES];
    UIButton *b1=sender;
    if(b1.tag==0){
        IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Date Picker" delegate:self];

        [picker setTag:1];
        [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
        [picker show];
    }
    else{
        IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Date Picker" delegate:self];

        [picker setTag:2];
        [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
        [picker show];
    }
}

- (IBAction)btnSubmit:(id)sender {
   // [SVProgressHUD showProgress:0 status:@"Loading"];
    if (chk==YES){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter Reason !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txvReason.text isEqual:@"Reason"]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter Reason !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txvReason.text isEqual:@""]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter Reason !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [SVProgressHUD showProgress:0 status:@"Loading"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd,yyyy"];
        
        NSDate *date1 = [dateFormatter dateFromString:txtFromDate.text];
        NSDate *date2 = [dateFormatter dateFromString:txtToDate.text];
        
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        FromDate = [dateFormatter stringFromDate:date1];
        ToDate = [dateFormatter stringFromDate:date2];
        if(flag==0)
        {
            
            NSString *appurl =[NSString stringWithFormat:@"%@Insert_StartStop_New?CompanyId=%@&MuminMaster_Id=%@&StartDate=%@&EndDate=%@&Reamrks=%@&SabeelNo=%@",[[Singleton sharedSingleton] getBaseURL],Companyid,MuminId,FromDate,ToDate,txvReason.text,Sabeelno];
            
//            NSString *appurl =[NSString stringWithFormat:@"%@START_STOP?companyid=%@&muminmasterid=%@&StartDate=%@&EndDate=%@&reason=%@",[[Singleton sharedSingleton] getBaseURL],Companyid,MuminId,FromDate,ToDate,txvReason.text];
            
//            NSString *appurl =[NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/START_STOP?companyid=%@&sabeelno=%@&StartDate=%@&EndDate=%@&reason=%@",Companyid,Sabeelno,FromDate,ToDate,txvReason.text];
            
            NSString *str1 = [appurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url1 = [NSURL URLWithString:str1];
            NSData * data=[NSData dataWithContentsOfURL:url1];
            NSError * error;
           json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
            NSString *webStatus = [json1 objectForKey:@"status"];
            
            if ([webStatus  isEqual: @"Yes"])
            {
                [self sendMessageInBack];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:[json1 objectForKey:@"responce"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [SVProgressHUD dismiss];
            }
            
            [self GetStopThaliReport];
        }
        else
        {
             NSString *appurl =[NSString stringWithFormat:@"%@Insert_IncreaseDesc_New?CompanyId=%@&MuminMaster_Id=%@&StartDate=%@&EndDate=%@&Reamrks=%@&ThaliType_Id=%@&OldThaliCount=%@&SabeelNo=%@",[[Singleton sharedSingleton] getBaseURL],Companyid,MuminId,FromDate,ToDate,txvReason.text,ThaliType_Id,Thalitypeid,Sabeelno];
            
//            http://192.168.1.23/FMB-Webservice/FMBServiceNew.asmx/Insert_Increase_Decrease?SabeelNo=sak009&StartDate=2015-05-15&EndDate=2015-06-15&Reason=test&NewThaaliCount=5&Company_Id=20
            
            NSString *str1 = [appurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url1 = [NSURL URLWithString:str1];
            NSData * data=[NSData dataWithContentsOfURL:url1];
            NSError * error;
            json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
            
            NSString *webStatus = [json1 objectForKey:@"status"];
            
            if ([webStatus  isEqual: @"Yes"])
            {
                               [txvReason setText:@""];
                [txtIncrease setText:@""];
                test=YES;
                 [self sendMessageInBack];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:[json1 objectForKey:@"responce"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [SVProgressHUD dismiss];
            }
            
            [self GetIncDecThaliReport];

        }
    }
}
-(void)GetThaliList
{
    arrThaliType_Id=[[NSMutableArray alloc]init];
    arrThaliType_Name=[[NSMutableArray alloc]init];
    
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@ThaliTypeList?CompanyId=%@",[[Singleton sharedSingleton] getBaseURL],Companyid];
    
    //    NSString *myRequestString1 = [NSString stringWithFormat:@"http://192.168.1.23/FMB-//Webservice/FMBServiceNew.asmx/Niyat_Type_Bind"];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str1];
    NSData * data=[NSData dataWithContentsOfURL:url1];
    NSError * error;
    json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    NSString *webStatus = [json1 objectForKey:@"status"];
    if ([webStatus  isEqual: @"YES"]){
        for(int i=0;i<[[json1 valueForKey:@"Post"]count];i++){
            [arrThaliType_Id addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"ThaliType_Id"]]];
            [arrThaliType_Name addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"ThaliType_Name"]]];
        }
        //txtNewThali.text = [arrThaliType_Name objectAtIndex:0];
    }
    else
    {
        
    }
    [tblPopup reloadData];
}
-(void)GetStopThaliReport
{
    arrStartDate=[[NSMutableArray alloc]init];
    arrStopDate=[[NSMutableArray alloc]init];
    arrReason=[[NSMutableArray alloc]init];
    arrId=[[NSMutableArray alloc]init];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@BindMuminThaliStopList?CompanyId=%@&MuminMaster_Id=%@",[[Singleton sharedSingleton] getBaseURL],Companyid,MuminId];
    
    //    NSString *myRequestString1 = [NSString stringWithFormat:@"http://192.168.1.23/FMB-//Webservice/FMBServiceNew.asmx/Niyat_Type_Bind"];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str1];
    NSData * data=[NSData dataWithContentsOfURL:url1];
    NSError * error;
    json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    NSString *webStatus = [json1 objectForKey:@"status"];
    if ([webStatus  isEqual: @"YES"]){
        for(int i=0;i<[[json1 valueForKey:@"Post"]count];i++){
            [arrStartDate addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"StartDate"]]];
            [arrStopDate addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"StopDate"]]];
            [arrReason addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Reason"]]];
            [arrId addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"DeleteId"]]];
        }
        flag=0;
        //txtNewThali.text = [arrThaliType_Name objectAtIndex:0];
    }
    else
    {
        
    }
    [tblThali reloadData];
}
-(void)GetIncDecThaliReport
{
    arrStartDate=[[NSMutableArray alloc]init];
    arrStopDate=[[NSMutableArray alloc]init];
    arrReason=[[NSMutableArray alloc]init];
    arrId=[[NSMutableArray alloc]init];
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@BindMumin_Increase_Decrease_List?CompanyId=%@&MuminMaster_Id=%@",[[Singleton sharedSingleton] getBaseURL],Companyid,MuminId];
    
    //    NSString *myRequestString1 = [NSString stringWithFormat:@"http://192.168.1.23/FMB-//Webservice/FMBServiceNew.asmx/Niyat_Type_Bind"];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str1];
    NSData * data=[NSData dataWithContentsOfURL:url1];
    NSError * error;
    json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    NSString *webStatus = [json1 objectForKey:@"status"];
    if ([webStatus  isEqual: @"YES"]){
        for(int i=0;i<[[json1 valueForKey:@"Post"]count];i++){
            [arrStartDate addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"StartDate"]]];
            [arrStopDate addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"StopDate"]]];
            [arrReason addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Reason"]]];
            [arrId addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"DeleteId"]]];
        }
        flag=1;
        //txtNewThali.text = [arrThaliType_Name objectAtIndex:0];
    }
    else
    {
        
    }
    [tblThali reloadData];
}


- (void)sendMessageInBack
{
	NSLog(@"Start Sending");
	_testMsg = [[SKPSMTPMessage alloc] init];
    _testMsg.relayHost = @"smtp.gmail.com";
	_testMsg.fromEmail =@"support@saksolution.com";
	_testMsg.ccEmail =[prefs objectForKey:@"Email"];
    _testMsg.toEmail =[prefs objectForKey:@"cmp_email"];
	_testMsg.login =@"support@saksolution.com";
	_testMsg.pass =@"Sak.1234";
   	_testMsg.requiresAuth = YES;
    if (flag == 0) {
        _testMsg.subject = @"Stop Thali";

    }else{
        _testMsg.subject = @"Inc/Dec Thali";

    }
	_testMsg.wantsSecure = YES;
	_testMsg.delegate = self;
	
    NSString *str = [NSString stringWithFormat:@"Salam,\nSabeel No: %@\nName: %@\nFrom Date: %@\nTo Date: %@.\nReason: %@\n",Sabeelno,Firstname,txtFromDate.text,txtToDate.text,txvReason.text];
    
	NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
							   
							   str,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    _testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
	[_testMsg send];
    [SVProgressHUD dismiss];
}
-(void)messageSent:(SKPSMTPMessage *)message{
    message=nil;
    txvReason.text = @"Reason";
    txvReason.textColor = [UIColor darkGrayColor];
    test=YES;
    NSDate *today = [NSDate date];
    today=[today dateByAddingTimeInterval:60*60*24];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd,yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    txtFromDate.text=dateString;
    txtToDate.text=dateString;
    PastDate=dateString;
//    lblDisplayThali.text=ThaliType;
     [SVProgressHUD dismiss];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Thali stopped succesfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
     message=nil;
     [SVProgressHUD dismiss];
}

- (IBAction)btnCancel:(id)sender{
    txtNewThali.text = @"";
    txtFromDate.text=PastDate;
    txtToDate.text=PastDate;
    txvReason.text=@"";
}

- (IBAction)btnLogOut:(id)sender {
    UIViewController *reg2=[self.storyboard instantiateViewControllerWithIdentifier:@"SAkViewController"];
    [self.navigationController pushViewController:reg2 animated:YES];
    prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:NO forKey:@"boolVal"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (IBAction)btnClickedStart:(id)sender {
    flag=1;
    [lblOldThali setHidden:NO];
    [lblOldThali1 setHidden:NO];
    [imgIncreaseThali setHidden:NO];
    [lblIncreaseThali setHidden:NO];
    [txtIncrease setHidden:NO];

    lblTodate.text=@"From Date :";
    [lblFromdate setHidden:YES];
    [btnObjFromdate setHidden:YES];
    [txtFromDate setHidden:YES];
    [imgDateicon setHidden:YES];
    [imgFromdate setHidden:YES];
    [stepThali setHidden:YES];
    [lblThali setHidden:YES];
    [lblDisplayThali setHidden:YES];
    
    btnObjSubmit.frame =CGRectMake(18, 330, btnObjSubmit.frame.size.width, btnObjSubmit.frame.size.height);
    
    btnObjCancel.frame=CGRectMake(168, 330, btnObjSubmit.frame.size.width, btnObjSubmit.frame.size.height);
}

- (IBAction)btnClickedStop:(id)sender {
    flag=0;
     txvReason.text = @"Reason";
    [lblOldThali setHidden:YES];
    [lblOldThali1 setHidden:YES];
    [imgIncreaseThali setHidden:YES];
    [lblIncreaseThali setHidden:YES];
    [txtIncrease setHidden:YES];
    
   // lblTodate.text=@"To Date  :";
    
    [lblFromdate setHidden:NO];
    [btnObjFromdate setHidden:NO];
    [txtFromDate setHidden:NO];
    [imgDateicon setHidden:NO];
    [imgFromdate setHidden:NO];
    
    [imgNewThali setHidden:YES];
    [txtNewThali setHidden:YES];
    [btnObjNewThali setHidden:YES];
    [stepThali setHidden:YES];
    [lblThali setHidden:YES];
    [lblDisplayThali setHidden:YES];

    btnObjSubmit.frame =CGRectMake(18, 330, btnObjSubmit.frame.size.width, btnObjSubmit.frame.size.height);
    
    btnObjCancel.frame=CGRectMake(168, 330, btnObjSubmit.frame.size.width, btnObjSubmit.frame.size.height);
    [self GetStopThaliReport];
}

- (IBAction)btnClickedIncDec:(id)sender {
    flag = 1;
    txvReason.text = @"Reason";
    [lblOldThali setHidden:YES];
    [lblOldThali1 setHidden:YES];
    [imgIncreaseThali setHidden:YES];
    [lblIncreaseThali setHidden:YES];
    [txtIncrease setHidden:YES];
    
   // lblTodate.text=@"To Date     :";
    
    [lblFromdate setHidden:NO];
    [btnObjFromdate setHidden:NO];
    [txtFromDate setHidden:NO];
    [imgDateicon setHidden:NO];
    [imgFromdate setHidden:NO];
    
    [imgNewThali setHidden:NO];
    [txtNewThali setHidden:NO];
    [btnObjNewThali setHidden:NO];
    [stepThali setHidden:NO];
    [lblThali setHidden:NO];
    [lblDisplayThali setHidden:NO];
    
    btnObjSubmit.frame =CGRectMake(18, 380, btnObjSubmit.frame.size.width, btnObjSubmit.frame.size.height);
    
    btnObjCancel.frame=CGRectMake(168, 380, btnObjSubmit.frame.size.width, btnObjSubmit.frame.size.height);
    [self GetIncDecThaliReport];

}

- (IBAction)btnClickedNewThali:(id)sender {
    [tblPopup setHidden:NO];
    [self GetThaliList];
    [btnObjTrasparent setHidden:NO];
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:1.0];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[tblPopup layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
}

- (IBAction)btnTrasparent:(id)sender {
    [tblPopup setHidden:YES];
    [btnObjTrasparent setHidden:YES];
}
- (IBAction)valueChanged:(UIStepper *)sender
{
    double value = [sender value];
    
    [lblDisplayThali setText:[NSString stringWithFormat:@"%d", (int)value]];
}
@end
