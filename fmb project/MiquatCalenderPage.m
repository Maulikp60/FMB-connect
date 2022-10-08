//
//  MiquatCalenderPage.m
//  FMB Salumber
//
//  Created by SMB-Mobile01 on 5/11/15.
//  Copyright (c) 2015 SAK. All rights reserved.
//

#import "MiquatCalenderPage.h"
#import "custom.h"
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

@interface MiquatCalenderPage ()<CDRTranslucentSideBarDelegate>
{
    NSMutableArray *arrMonth,*arrMonth1;
    NSInteger ip,ip1;
    NSDateComponents* components;
    NSUserDefaults *prefs;
    NSString *Companyid,*Sabeelno;
    UIButton *btnclk;
    UITableView *tableView1;
    NSString *EnglishMonth;
    NSMutableArray *arrMiqaatName,*arrName,*arrHijariDate,*arrEnglishdate,*arrjamantype;

}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@end

@implementation MiquatCalenderPage

- (void)viewDidLoad {
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

    arrMonth1=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
//     arrMonth1=[[NSMutableArray alloc]initWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
    
    arrMonth=[[NSMutableArray alloc]initWithObjects:@"Moharram",@"Safar",@"Rabi ul-Awwal",@"Rabi ul-Akhar",@"Jamad il Awwal",@"Jamad il Akhar",@"Rajab",@"Shaban",@"Ramazan",@"Shawaal",@"Zilqad",@"Zilhaj", nil];
    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    prefs = [NSUserDefaults standardUserDefaults];
    Companyid = [prefs stringForKey:@"CompanyId"];
    Sabeelno = [prefs stringForKey:@"Sabeelno"];

    NSDate *currentDate = [NSDate date];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
  components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate];
    // Get necessary date components
    
    [components month]; //gives you month
    ip=[components month];
    
   
    
    NSCalendar *islamicCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSIslamicCalendar];
    
    NSDate *today = [NSDate date];
    [islamicCalendar rangeOfUnit:NSDayCalendarUnit startDate:&today interval:NULL forDate:today];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setCalendar:islamicCalendar];
    //[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    //english output
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    NSString * islamicDateString = [dateFormatter stringFromDate:today];
    ip1 = [[[islamicDateString componentsSeparatedByString:@"/"] objectAtIndex:0]integerValue];
    NSLog(@"%ld", (long)ip1);
     txtMonth.text=[arrMonth objectAtIndex:ip1-1];
    EnglishMonth=[arrMonth1 objectAtIndex:ip1-1];

    [self getCalenderDetail];
 //   NSLog(@"%ld",(long)ip);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
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
- (IBAction)btnLogout:(id)sender {
    UIViewController *reg2=[self.storyboard instantiateViewControllerWithIdentifier:@"SAkViewController"];
    [self.navigationController pushViewController:reg2 animated:YES];
    prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:NO forKey:@"boolVal"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (IBAction)btnClickedNext:(id)sender {
    ip1++;
    if (ip1 > 12)
    {
        ip1=1;
    }
    else
    {
        
    }
    
    
    txtMonth.text=[arrMonth objectAtIndex:ip1-1];
    EnglishMonth=[arrMonth1 objectAtIndex:ip1-1];
    [self getCalenderDetail];
}

- (IBAction)btnClickedPrevious:(id)sender {
    ip--,ip1--;
    
    if (ip1 == 0)
    {
        ip1=12;
    }
    else
    {
        
    }
    txtMonth.text=[arrMonth objectAtIndex:ip1-1];
    EnglishMonth=[arrMonth1 objectAtIndex:ip1-1];
    [self getCalenderDetail];
    
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
        return arrMiqaatName.count;
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
        static NSString *MyIdentifier = @"Cell";
        custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (ce == nil){
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        }
        ce.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:243.0/255.0 blue:209.0/255.0 alpha:1.0];
        ce.lblName1.text=[NSString stringWithFormat:@"%@",arrMiqaatName[indexPath.row]];
       // [ce.lblName1 setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        ce.lblName1.textColor=[UIColor blackColor];
        
        ce.lblName.text=[NSString stringWithFormat:@"%@",arrName[indexPath.row]];
        ce.lblName.textColor=[UIColor blackColor];
       // [ce.lblName setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        
        ce.lblHijriDate.text=[NSString stringWithFormat:@"%@",arrHijariDate[indexPath.row]];
        ce.lblHijriDate.textColor=[UIColor blackColor];
       // [ce.lblHijriDate setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        
        ce.lblNiyatDate.text=[NSString stringWithFormat:@"%@",arrEnglishdate[indexPath.row]];
        ce.lblNiyatDate.textColor=[UIColor blackColor];
      //  [ce.lblName setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        
        ce.lblJamatType.text=[NSString stringWithFormat:@"%@",arrjamantype[indexPath.row]];
        ce.lblJamatType.textColor=[UIColor blackColor];
        //[ce.lblHijriDate setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
         //   ce.selectionStyle = UITableViewCellSelectionStyleNone;
        return ce;
    }
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView==tableView1)
    {
        return 45;
    }
    else
    {
        return 116;
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
        
    }
    
}
-(void)getCalenderDetail
{
    [SVProgressHUD showProgress:0 status:@"Loading"];
    arrMiqaatName=[[NSMutableArray alloc]init];
    arrName=[[NSMutableArray alloc]init];
    arrHijariDate=[[NSMutableArray alloc]init];
    arrEnglishdate=[[NSMutableArray alloc]init];
    arrjamantype=[[NSMutableArray alloc]init];
    
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@Miqaat_Calender?company_id=%@&Month=%@",[[Singleton sharedSingleton] getBaseURL],Companyid,EnglishMonth];
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:str1];
    NSData * data=[NSData dataWithContentsOfURL:url1];
    NSError * error;
    NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    NSString *webStatus = [json1 objectForKey:@"status"];
    if ([webStatus  isEqual: @"YES"]){
        for(int i=0;i<[[json1 valueForKey:@"Post"]count];i++)
        {
            [arrMiqaatName addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"MiqaatName"]]];
            [arrName addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Name"]]];
            [arrHijariDate addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"HijariDate"]]];
            [arrEnglishdate addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Englishdate"]]];
            [arrjamantype addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"jamantype"]]];
        }
    }
    else
    {
        
    }
    [tblMiquatCalender reloadData];
    [SVProgressHUD dismiss];
}
@end
