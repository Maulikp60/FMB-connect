//
//  FeedbackPage.m
//  Fmb
//
//  Created by SMB-Mobile01 on 9/6/14.
//  Copyright (c) 2014 SAK. All rights reserved.
//

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
#import "Singleton.h"
#import "SAkViewController.h"
#import "ChangePwd.h"
#import "SVProgressHUD.h"

@interface FeedbackPage ()<CDRTranslucentSideBarDelegate>{
    NSMutableArray *arryMealId,*arryMealName,*arrdishname,*arrQueId,*arrans,*arransid,*arransflag,*arrpoorname,*arrpoorid,*arrsendans,*arrimg,*arrsendoptionid,*arrsendansid,*arrQueName,*OptionName,*OptionId;
    NSArray *arrpoorflag;
    NSUserDefaults *prefs;
    NSString *Companyid,*Sabeelno,*selectmenu,*MealName,*PastDate,*MuminId;
    NSInteger j,k,o1;
    int h,a1,b1;
    int p,r;
    NSArray *myWords,*myWordsid;
    UIAlertView *alert1;
    NSString *name,*thalidate,*Firstname,*Email;
    UIButton *btnclk;
    UITableView *tableView1;
}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@property(nonatomic,strong)SKPSMTPMessage *testMsg;
@end

@implementation FeedbackPage

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
    txtRemark.hidden=YES;
    p=0;
    r=10;
    
    [tblSelectType setHidden:YES];
    tblSelectType.layer.borderColor=[UIColor purpleColor].CGColor;
    tblSelectType.layer.borderWidth=1;
    tblSelectType.layer.cornerRadius=5;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    prefs = [NSUserDefaults standardUserDefaults];
    Companyid = [prefs stringForKey:@"CompanyId"];
    Sabeelno = [prefs stringForKey:@"Sabeelno"];
    Firstname=[prefs stringForKey:@"FirstName"];
    Email=[prefs stringForKey:@"Email"];
    MuminId=[prefs stringForKey:@"muminmasterid"];

    
    [btnObjSelectType setEnabled:YES];
    [btnObjThalidate setEnabled:YES];
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd,yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    txtThaliDate.text=dateString;
    PastDate=dateString;
    tblSelectType.hidden=YES;
    [self GetMealType];
    [self getmeal];
    [tblQuestion reloadData];
    h=0;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [tblSelectType setHidden:YES];
    [Dropobj fadeOut];
    [btnObjSelectType setEnabled:YES];
    [btnObjThalidate setEnabled:YES];
    
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
-(IBAction)aMethod:(id)sender
{
    view3.frame=CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height);
    [self.sideBar dismiss];
    [btnclk removeFromSuperview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==tblSelectType){
        return arryMealName.count;
    }
    else if(tableView==tblQuestion){
        return arrQueId.count-1;
    }
    else if (tableView==tableView1)
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
    
    if (tableView==tblSelectType){
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld",(long)indexPath.row]];
        if (cell==Nil){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld",(long)indexPath.row]];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
        cell.textLabel.textColor=[UIColor darkGrayColor];
        cell.textLabel.text=[arryMealName objectAtIndex:indexPath.row];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (tableView==tblQuestion){
        static NSString *MyIdentifier = @"Cell";
        custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (ce == nil){
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        }
        ce.txtDropDown.text=[arrsendans objectAtIndex:indexPath.row];
        ce.txtDropDown.tag=indexPath.row;
        ce.lblitemname.text=[arrQueName objectAtIndex:indexPath.row];
        ce.objbtnDropDown.tag=indexPath.row;
        [ce.objbtnDropDown addTarget:self action:@selector(btnDropDown:) forControlEvents:UIControlEventTouchUpInside];
           return ce;
    }
    else if (tableView==tableView1)
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
    else{
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld",(long)indexPath.row]];
        if (cell==Nil){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld",(long)indexPath.row]];
        }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    myWords = [[[arransid objectAtIndex:k] componentsSeparatedByString:@"~`"]mutableCopy];
    myWordsid=[[[arrans objectAtIndex:k]componentsSeparatedByString:@"~`"]mutableCopy];
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:myWords xy:point size:size isMultiple:NO];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    [Dropobj SetBackGroundDropDwon_R:0.0 G:108.0 B:194.0 alpha:0.70];
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    
    NSString *topname1=[myWords objectAtIndex:anIndex];
    
    NSString *topid=[myWordsid objectAtIndex:anIndex];
    
    [arrsendans replaceObjectAtIndex:k withObject:topname1];
    [arrsendansid replaceObjectAtIndex:k withObject:topid];
    [tblQuestion reloadData];
}
-(IBAction)btnDropDown:(id)sender{
 
        k= ((UIButton *)sender).tag;
        [Dropobj fadeOut];
        [self showPopUpWithTitle:@"Select Option" withOption:arransid xy:CGPointMake(16, 240) size:CGSizeMake(290, 320) isMultiple:NO];
    [btnObjSelectType setEnabled:NO];
    [btnObjThalidate setEnabled:NO];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag==4)
    {
        name = [alertView textFieldAtIndex:0].text;
        [arrsendans replaceObjectAtIndex:arrsendans.count-1 withObject:name];
        txtRemark.text = [alertView textFieldAtIndex:0].text;
        [tblQuestion reloadData];
    }
    else
    {
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==tblSelectType)
    {
        txtSelectType.text=[arryMealName objectAtIndex:indexPath.row];
        selectmenu=[arryMealId objectAtIndex:indexPath.row];
        [self getmeal];;
        [tblSelectType setHidden:YES];
        [btnObjSelectType setEnabled:NO];
    }
    else if (tableView==tableView1)
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
    else
    {
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles{
       txtThaliDate.text=[titles componentsJoinedByString:@" - "];
    [self a];
    if (a1 > b1){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Thali Date can't be greater than Current Date" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        txtThaliDate.text=PastDate;
        txtSelectType.text=@"";
        [btnObjSelectType setEnabled:NO];
        [tblQuestion setHidden:YES];
        [lblDishName setHidden:YES];
        [txtRemark setHidden:YES];
    }
    else{
        [self GetMealType];
        [tblQuestion setHidden:NO];
        [self getmeal];
        [lblDishName setHidden:NO];
        [txtRemark setHidden:NO];
    }
}

- (IBAction)btnThaliDate:(id)sender {
    [self.view endEditing:YES];
    
    
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Date Picker" delegate:self];
    [picker setTag:1];
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [picker show];

    [btnObjSelectType setEnabled:YES];
    [self GetMealType];
}

- (IBAction)btnSelectType:(id)sender {
    [btnObjThalidate setEnabled:NO];
    [self GetMealType];
    [self getmeal];
    tblSelectType.hidden=NO;
}

-(void)GetMealType{
    txtSelectType.text=@"";
    arryMealId=[[NSMutableArray alloc]init];
    arryMealName=[[NSMutableArray alloc]init];
    
     NSString *myRequestString1 = [NSString stringWithFormat:@"%@MEALTYPE?CompanyId=%@&date=%@",[[Singleton sharedSingleton] getBaseURL],Companyid,txtThaliDate.text];
//NSString *myRequestString1 = [NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/MEALTYPE?CompanyId=1&date=%@",Companyid,txtThaliDate.text];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str1];
    NSData * data=[NSData dataWithContentsOfURL:url1];
    NSError * error;
    NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    NSString *webStatus = [json1 objectForKey:@"status"];
    if ([webStatus  isEqual: @"YES"]){
        for(int i=0;i<[[json1 valueForKey:@"Post"]count];i++){
            [arryMealName addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"MealName"]]];
            [arryMealId addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"MealID"]]];
        }
        MealName = [arryMealName objectAtIndex:0];
        selectmenu=[arryMealId objectAtIndex:0];
        txtSelectType.text=MealName;
    }
    else
    {
        
    }
    [tblSelectType reloadData];
}
-(void)getmeal
{
    arrdishname=[[NSMutableArray alloc]init];
    arrans=[[NSMutableArray alloc]init];
    arransid=[[NSMutableArray alloc]init];
    arransflag=[[NSMutableArray alloc]init];
    arrpoorname=[[NSMutableArray alloc]init];
    arrpoorid=[[NSMutableArray alloc]init];
    arrsendoptionid=[[NSMutableArray alloc]init];
    OptionId=[[NSMutableArray alloc]init];
    OptionName=[[NSMutableArray alloc]init];
    arrsendansid=[[NSMutableArray alloc]init];
    arrsendans=[[NSMutableArray alloc]init];
    arrQueName=[[NSMutableArray alloc]init];
    arrQueId=[[NSMutableArray alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd,yyyy"];
    
    NSDate *date1 = [dateFormatter dateFromString:txtThaliDate.text];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    thalidate = [dateFormatter stringFromDate:date1];
    
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@BindFeedbackDetailsNew?companyId=%@&MealId=%@&MenuDate=%@",[[Singleton sharedSingleton] getBaseURL],Companyid,selectmenu,thalidate];
    //NSString *myRequestString1 = [NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/BindFeedbackDetailsNew?CompanyId=%@&MealId=%@&MenuDate=%@",Companyid,selectmenu,txtThaliDate.text];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str1];
    NSData * data=[NSData dataWithContentsOfURL:url1];
    NSError * error;
    NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    NSLog(@"%@",json1);
    
    NSString *webStatus = [json1 objectForKey:@"status"];
    if ([webStatus  isEqual: @"YES"]){
        for(int i=0;i<[[json1 valueForKey:@"Post"]count];i++){
            [arrdishname addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"DishName"]]];
            [lblDishName setText:[NSString stringWithFormat:@"Dish Name:%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"DishName"]]];
            NSMutableArray *arrquetype=[[NSMutableArray alloc]init];
            
            arrquetype=[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"QueType"];
            for (int n=0; n<arrquetype.count; n++){
                NSDictionary *dic=[arrquetype objectAtIndex:n];
                   [arrQueName addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"QueName"]]];
                    [arrQueId addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"QueId"]]];
                NSMutableArray *OptionDtl=[[NSMutableArray alloc]init];
                OptionDtl=[dic objectForKey:@"OptionDtl"];
                NSString *strOptionName;
                NSString *strOptionId;
                for (int o=0; o<OptionDtl.count; o++)
                {
                    NSMutableDictionary *dic1=[OptionDtl objectAtIndex:o];
                    if(o==0){
                        strOptionId=[dic1 objectForKey:@"OptionId"];
                        strOptionName=[dic1 objectForKey:@"OptionName"];
                        [arrsendans addObject:strOptionName];
                        [arrsendansid addObject:strOptionId];
                    }
                    else{
                        strOptionId=[NSString stringWithFormat:@"%@~`%@",strOptionId,[dic1 objectForKey:@"OptionId"]];
                        strOptionName=[NSString stringWithFormat:@"%@~`%@",strOptionName,[dic1 objectForKey:@"OptionName"]];
                    }
                }
                [arrans addObject:strOptionId];
                [arransid addObject:strOptionName];
                
            }
        }
        txtRemark.hidden=NO;
    }
    else
    {
        txtRemark.hidden=YES;
    }
    [tblQuestion reloadData];
}

- (IBAction)btnSubmit:(id)sender {
    [self send];
}

-(void)send{
    if (txtRemark.hidden==YES)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Select MealType" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txtRemark.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter Remarks" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        NSString *QueId;
        
        NSString *QuestionId;
        NSString *sendremark;
        
        for (int j1=0; j1<arrQueId.count-2; j1++)
        {
            if (j1==0)
            {
                sendremark=@"0";
            }
            else
            {
                sendremark=[NSString stringWithFormat:@"%@,0",sendremark];
            }
        }
        for (int j1=0; j1<arrQueId.count-2; j1++)
        {
            if (j1==0)
            {
                QueId=[arrQueId objectAtIndex:0];
            }
            else
            {
                QueId=[NSString stringWithFormat:@"%@,%@",QueId,[arrQueId objectAtIndex:j1]];
            }
            
        }
        QueId=[NSString stringWithFormat:@"%@,%@",QueId,[arrQueId objectAtIndex:arrQueId.count-1]];
        for (int j1=0; j1<arrQueId.count-2; j1++)
        {
            if (j1==0)
            {
                QuestionId=[arrsendansid objectAtIndex:0];
            }
            else
            {
                QuestionId=[NSString stringWithFormat:@"%@,%@",QuestionId,[arrsendansid objectAtIndex:j1]];
            }
        }
        [SVProgressHUD showProgress:0 status:@"Loading"];
        QuestionId=[NSString stringWithFormat:@"%@,0",QuestionId];
        sendremark=[NSString stringWithFormat:@"%@,%@",sendremark,name];
       
        NSString *myRequestString1 = [NSString stringWithFormat:@"%@FeedbackAnswersNew?MuminMaster_Id=%@&Answer=%@&QuestionId=%@&OptionId=%@&companyId=%@&ThaliDate=%@&MealType=%@",[[Singleton sharedSingleton] getBaseURL],MuminId,sendremark,QueId,QuestionId,Companyid,txtThaliDate.text,[arrsendansid objectAtIndex:arrQueId.count-2]];

        
//        NSString *myRequestString1 = [NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/FeedbackAnswersNew?SabeelNo=%@&Answer=%@&QuestionId=%@&OptionId=%@&companyId=%@&ThaliDate=%@&MealType=%@",Sabeelno,sendremark,QueId,QuestionId,Companyid,txtThaliDate.text,[arrsendansid objectAtIndex:arrQueId.count-2]];
        
        NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url1 = [NSURL URLWithString:str1];
        NSData * data=[NSData dataWithContentsOfURL:url1];
        NSError * error;
        NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd,yyyy"];
        
        NSDate *date1 = [dateFormatter dateFromString:txtThaliDate.text];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        thalidate = [dateFormatter stringFromDate:date1];
        
        NSString *webStatus = [json1 objectForKey:@"status"];
        if ([webStatus  isEqual: @"YES"]){
            [self sendMessageInBack];
            
        }
        else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Submit Unsuccessful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [SVProgressHUD dismiss];
        }
    }
}

-(void)a{
    NSString *str1 = txtThaliDate.text; /// here this is your date with format yyyy-MM-dd
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

- (IBAction)btnCancel:(id)sender {
}
- (IBAction)btnClickedRemark:(id)sender {
    alert1 = [[UIAlertView alloc] initWithTitle:@"FMB"
                                        message:@""
                                       delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:Nil,nil];
    
    alert1.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert1.tag=4;
    [alert1 show];
}

- (IBAction)btnLogOut:(id)sender {
    UIViewController *reg2=[self.storyboard instantiateViewControllerWithIdentifier:@"SAkViewController"];
    [self.navigationController pushViewController:reg2 animated:YES];
    prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:NO forKey:@"boolVal"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (void)sendMessageInBack
{
	NSLog(@"Start Sending");
	_testMsg = [[SKPSMTPMessage alloc] init];
    _testMsg.relayHost = @"smtp.gmail.com";
	_testMsg.fromEmail =@"support@saksolution.com";
    _testMsg.ccEmail =Email;
    _testMsg.toEmail =[prefs objectForKey:@"cmp_email"];
    _testMsg.login =@"support@saksolution.com";
    _testMsg.pass =@"Sak.1234";
    
	_testMsg.requiresAuth = YES;
	_testMsg.subject = @"Inquiry Form";
	_testMsg.wantsSecure = YES;
	_testMsg.delegate = self;
    
    NSString *str = [NSString stringWithFormat:@"Salaam%@\n\n Thanks for your valuable feedback.\n\n    Sabeel No : %@\n\n    Thaali Date : %@\n\n    Food Quality Rating : %@\n    Spicy Rating : %@\n    Oily Rating : %@\n    Quantity Rating : %@\n    Delivery Rating :%@\n    Menu Rating : %@\n\n    Remarks : %@\n    Faiz ul Mawaid Al Burhaniyah",Firstname,Sabeelno,txtThaliDate.text,arrsendans[0],arrsendans[1],arrsendans[2],arrsendans[3],arrsendans[4],arrsendans[5],name];
    
	NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
							   
							   str,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    _testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
	[_testMsg send];
}
-(void)messageSent:(SKPSMTPMessage *)message{
    NSLog(@"delegate - message sent");
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Submit Succesfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    message=nil;
     [SVProgressHUD dismiss];
    [btnObjSelectType setEnabled:YES];
    [btnObjThalidate setEnabled:YES];
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd,yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    txtThaliDate.text=dateString;
    PastDate=dateString;
    lblDishName.text = @"";
    tblSelectType.hidden=YES;
    [self GetMealType];
    [self getmeal];
    [tblQuestion reloadData];
    h=0;
    txtRemark.text = @"";
}

-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    message=nil;
     [SVProgressHUD dismiss];
}


@end
