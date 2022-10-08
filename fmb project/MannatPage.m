//
//  MannatPage.m
//  FMB Salumber
//
//  Created by SMB-Mobile01 on 5/12/15.
//  Copyright (c) 2015 SAK. All rights reserved.
//

#import "MannatPage.h"
#import "custom.h"
#import "SVProgressHUD.h"
#import "CDRTranslucentSideBar.h"
#import "ProfilePage.h"
#import "HomePage.h"
#import "MenuListPage.h"
#import "MiquatCalenderPage.h"
#import "MannatPage.h"
#import "MannatReport.h"
#import "FeedbackPage.h"
#import "ThaliManagePage.h"
#import "SAkViewController.h"
#import "Singleton.h"
#import "ChangePwd.h"

@interface MannatPage ()<CDRTranslucentSideBarDelegate>{
    NSUserDefaults *prefs;
    NSString *Companyid,*Sabeelno,*PastDate,*Niyattypeid,*dateFo,*MuminId;
    NSMutableArray *arrid,*arrname,*arrAmount;
    NSString *Name,*Amount;
    int a1,b1;
    BOOL chk,test;
    UIButton *btnclk;
    UITableView *tableView1;
    int amo;
}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@end

@implementation MannatPage

- (void)viewDidLoad {
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

   
    
    [txtNoOfThali addTarget:self
                      action:@selector(textFieldDidChange:)
            forControlEvents:UIControlEventEditingChanged];
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    txtAmount.inputAccessoryView = keyboardDoneButtonView;
    txtNoOfThali.inputAccessoryView = keyboardDoneButtonView;
    
    // Do any additional setup after loading the view.
}
- (IBAction)doneClicked:(id)sender{
    [self.view endEditing:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    prefs = [NSUserDefaults standardUserDefaults];
    Companyid = [prefs stringForKey:@"CompanyId"];
    Sabeelno = [prefs stringForKey:@"Sabeelno"];
    MuminId=[prefs stringForKey:@"muminmasterid"];
    [self GetType];

    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd,yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    txtDate.text=dateString;
    PastDate=dateString;
    chk=YES;
    test=YES;
    int Thaali = [[txtNoOfThali text] floatValue];
    int Amount1 = [[txtAmount text] floatValue];
    
    int TotalAmount = Thaali * Amount1;
    
    txtAmount.text=[NSString stringWithFormat:@"%d",TotalAmount];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnClickedMenu:(id)sender {
    [self.sideBar show];
    view3.frame=CGRectMake(self.view.frame.size.width*0.75,0,self.view.bounds.size.width,self.view.bounds.size.height);
    btnclk=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.75, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [btnclk addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnclk];
}

- (IBAction)btnClickedLogout:(id)sender
{
    UIViewController *reg2=[self.storyboard instantiateViewControllerWithIdentifier:@"SAkViewController"];
    [self.navigationController pushViewController:reg2 animated:YES];
    prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:NO forKey:@"boolVal"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (IBAction)btnSubmit:(id)sender {
    [SVProgressHUD showProgress:0 status:@"Loading"];
    if([txtMannatType.text isEqual:@""] || [txtDate.text isEqual:@""] || [txtAmount.text isEqual:@""] || [txtNiyatname.text isEqual:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter All Information!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd,yyyy"];
        
        NSDate *date1 = [dateFormatter dateFromString:txtDate.text];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        dateFo = [dateFormatter stringFromDate:date1];
        
         NSString *myRequestString1 =[NSString stringWithFormat:@"%@InsertNonFmbMuminApp?NiyatType_Id=%@&Takhmeen=%@&MuminMaster_Id=%@&Date=%@&Company_Id=%@&NiyatName=%@",[[Singleton sharedSingleton] getBaseURL],Niyattypeid,txtAmount.text,MuminId,dateFo,Companyid,txtNiyatname.text];
        
//        NSString *myRequestString1 =[NSString stringWithFormat:@"http://192.168.1.23//FMB-Webservice/FMBServiceNew.asmx/InsertNonFmb?NiyatType_Id=%@&Takhmeen=%@&SabeelNo=%@&Date=%@&Company_Id=%@&NiyatName=%@",Niyattypeid,txtAmount.text,Sabeelno,dateFo,Companyid,txtNiyatname.text];
        
        NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url1 = [NSURL URLWithString:str1];
        NSData * data=[NSData dataWithContentsOfURL:url1];
        NSError * error;
        NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        
        NSString *webStatus = [json1 objectForKey:@"status"];
        if ([webStatus  isEqual: @"YES"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Submit Successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtAmount setText:@"0"];
            Niyattypeid = [arrid objectAtIndex:0];
            //[txtDate setText:PastDate];
            [txtNiyatname setText:@""];
            [tblType setHidden:YES];
            test=YES;
            txtMannatType.text=[arrname objectAtIndex:0];
            txtNoOfThali.text = @"1";
            txtNiyatname.text = @"";
            NSDate *today = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"MMM dd,yyyy"];
            NSString *dateString = [dateFormat stringFromDate:today];
            txtDate.text=dateString;
            PastDate=dateString;
            
            
        }
        else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Submit Unsuccessful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        [SVProgressHUD dismiss];
    }
    [SVProgressHUD dismiss];

}

- (IBAction)btnClickedType:(id)sender {
    tblType.hidden=NO;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles{
    txtDate.text=[titles componentsJoinedByString:@" - "];
    //txtDate.text=PastDate;
    //[self a];
//    if (a1 > b1){
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Thali Date can't be greater than Current Date" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        txtDate.text=PastDate;
//    }
//    else{
//        }
}

- (IBAction)btnClickedDate:(id)sender {
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Date Picker" delegate:self];
    [picker setTag:1];
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [picker show];

    
}
-(void)a{
    NSString *str1 = txtDate.text; /// here this is your date with format yyyy-MM-dd
    NSString *str2=PastDate;
    
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
    
    a1=[a intValue];
    b1=[b intValue];
}

-(void)GetType{
    txtMannatType.text=@"";
    arrid=[[NSMutableArray alloc]init];
    arrname=[[NSMutableArray alloc]init];
    arrAmount=[[NSMutableArray alloc]init];
    
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@Niyat_Type_Bind?Company_Id=%@",[[Singleton sharedSingleton] getBaseURL],Companyid];
    
//    NSString *myRequestString1 = [NSString stringWithFormat:@"http://192.168.1.23/FMB-//Webservice/FMBServiceNew.asmx/Niyat_Type_Bind"];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str1];
    NSData * data=[NSData dataWithContentsOfURL:url1];
    NSError * error;
    NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    NSString *webStatus = [json1 objectForKey:@"status"];
    if ([webStatus  isEqual: @"YES"]){
        for(int i=0;i<[[json1 valueForKey:@"Post"]count];i++){
            [arrid addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Niyat_Type_Id"]]];
            [arrname addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Niyat_Type_Name"]]];
            [arrAmount addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"DefaultAmount"]]];
        }
        Name = [arrname objectAtIndex:0];
        Amount=[arrAmount objectAtIndex:0];
        txtMannatType.text=Name;
        txtAmount.text=Amount;
        Niyattypeid = [arrid objectAtIndex:0];
        
    }
    else
    {
        
    }
    [tblType reloadData];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)textFieldDidChange:(id)sender
{
    int Thaali = [[txtNoOfThali text] floatValue];
    //int Amount1 = [[txtAmount text] floatValue];
   
    int TotalAmount = Thaali * amo;
    
    txtAmount.text=[NSString stringWithFormat:@"%d",TotalAmount];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
        return arrid.count;
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
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld",(long)indexPath.row]];
        if (cell==Nil){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld",(long)indexPath.row]];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
        cell.textLabel.textColor=[UIColor darkGrayColor];
        cell.textLabel.text=[arrname objectAtIndex:indexPath.row];
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
        txtMannatType.text=[arrname objectAtIndex:indexPath.row];
        amo=[[arrAmount objectAtIndex:indexPath.row]floatValue];
        txtAmount.text=[NSString stringWithFormat:@"%d",amo];

        Niyattypeid=[arrid objectAtIndex:indexPath.row];
        if([txtMannatType.text isEqual:@"Mannat"])
        {
            txtNoOfThali.hidden=NO;
            lblNoOfThali.hidden=NO;
            lbl2.hidden=NO;
            
            lblAmount.frame=CGRectMake(11,201,69,21);
            lbl3.frame=CGRectMake(99,201,16,21);
            txtAmount.frame=CGRectMake(113,197,196,30);
            
            lblDate.frame=CGRectMake(11,247,42,21);
            lbl5.frame=CGRectMake(99,245,16,21);
            txtDate.frame=CGRectMake(120,245,150,30);
            
            lblRemark.frame=CGRectMake(11,292,86,21);
            lbl4.frame=CGRectMake(99,292,16,21);
            txtNiyatname.frame=CGRectMake(113,288,196,30);
            
            imgDate.frame=CGRectMake(113,243,196,30);
            imgDateIcon.frame=CGRectMake(276, 243, 30, 30);
            btnObjDate.frame=CGRectMake(113, 243, 196, 30);
            
        }
        else
        {
            txtNoOfThali.hidden=YES;
            lblNoOfThali.hidden=YES;
            lbl2.hidden=YES;
            
            lblAmount.frame=CGRectMake(lblNoOfThali.frame.origin.x,lblNoOfThali.frame.origin.y, lblNoOfThali.frame.size.width, lblNoOfThali.frame.size.height);
            lbl3.frame=CGRectMake(lbl2.frame.origin.x,lbl2.frame.origin.y, lbl2.frame.size.width, lbl2.frame.size.height);
            txtAmount.frame=CGRectMake(txtNoOfThali.frame.origin.x,txtNoOfThali.frame.origin.y, txtNoOfThali.frame.size.width, txtNoOfThali.frame.size.height);
            
            lblDate.frame=CGRectMake(11,201,69,21);
            lbl5.frame=CGRectMake(99,201,16,21);
            txtDate.frame=CGRectMake(120,197,150,30);
            
            lblRemark.frame=CGRectMake(11,247,86,21);
            lbl4.frame=CGRectMake(99,245,16,21);
            txtNiyatname.frame=CGRectMake(113,243,196,30);
            
            imgDate.frame=CGRectMake(113,197,196,30);
            imgDateIcon.frame=CGRectMake(276, 197, 30, 30);
            btnObjDate.frame=CGRectMake(113, 197, 196, 30);
        }
        [tblType setHidden:YES];

    }
    
}

@end
