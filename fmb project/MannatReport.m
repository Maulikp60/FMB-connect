//
//  MannatReport.m
//  FMB Salumber
//
//  Created by SMB-Mobile01 on 5/12/15.
//  Copyright (c) 2015 SAK. All rights reserved.
//

#import "MannatReport.h"
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

@interface MannatReport ()<CDRTranslucentSideBarDelegate>
{
    NSUserDefaults *prefs;
    NSString *Companyid,*Sabeelno,*MuminId;
    NSMutableArray *arrSabeelNo,*arrName,*arrNiyatTypeName,*arrTotal_Takhmeen_amnt,*arrDue,*arrPaid,*arrNiyatDate,*arrNiyathijriDate;
    UIButton *btnclk;
    UITableView *tableView1;

}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;

@end

@implementation MannatReport

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

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    prefs = [NSUserDefaults standardUserDefaults];
    Companyid = [prefs stringForKey:@"CompanyId"];
    Sabeelno = [prefs stringForKey:@"Sabeelno"];
    MuminId=[prefs stringForKey:@"muminmasterid"];

    [self GetMannatReport];
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
- (IBAction)btnClickedLogout:(id)sender {
    UIViewController *reg2=[self.storyboard instantiateViewControllerWithIdentifier:@"SAkViewController"];
    [self.navigationController pushViewController:reg2 animated:YES];
    prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:NO forKey:@"boolVal"];
    [[NSUserDefaults standardUserDefaults]synchronize];
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
        return arrSabeelNo.count;

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
        static NSString *MyIdentifier = @"Cell";
        custom *ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (ce == nil){
            ce = (custom *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        }
        ce.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:243.0/255.0 blue:209.0/255.0 alpha:1.0];
        ce.lblSabeelno.text=[NSString stringWithFormat:@"%@",arrSabeelNo[indexPath.row]];
        ce.lblName1.text=[NSString stringWithFormat:@"%@",arrName[indexPath.row]];
        ce.lblNiyatName.text=[NSString stringWithFormat:@"%@",arrNiyatTypeName[indexPath.row]];
        ce.lblTakhmeen.text=[NSString stringWithFormat:@"%@",arrTotal_Takhmeen_amnt[indexPath.row]];
        ce.lblPaid.text=[NSString stringWithFormat:@"%@",arrPaid[indexPath.row]];
        ce.lblDue.text=[NSString stringWithFormat:@"%@",arrDue[indexPath.row]];
        ce.lblNiyatDate.text=[NSString stringWithFormat:@"%@",arrNiyatDate[indexPath.row]];
        ce.lblHijriDate.text=[NSString stringWithFormat:@"%@",arrNiyathijriDate[indexPath.row]];
        //    ce.lblMenuList.textColor=[UIColor blackColor];
        //    [ce.lblMenuList setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        ce.selectionStyle = UITableViewCellSelectionStyleNone;
        return ce;
    }
}
//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if(tableView==tableView1)
//    {
//        return 45;
//    }
//    else
//    {
//        return 0;
//    }
//}

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


-(void)GetMannatReport{
    
    arrSabeelNo=[[NSMutableArray alloc]init];
    arrName=[[NSMutableArray alloc]init];
    arrNiyatTypeName=[[NSMutableArray alloc]init];
    arrTotal_Takhmeen_amnt=[[NSMutableArray alloc]init];
    arrPaid=[[NSMutableArray alloc]init];
    arrDue=[[NSMutableArray alloc]init];
    arrNiyatDate=[[NSMutableArray alloc]init];
    arrNiyathijriDate=[[NSMutableArray alloc]init];
   
     NSString *myRequestString1 = [NSString stringWithFormat:@"http://services.saksolution.com/FMBservicenew.asmx/Mannat_Report?MuminMaster_Id=%@&Company_Id=%@",MuminId,Companyid];
    
//    NSString *myRequestString1 = [NSString stringWithFormat:@"http://192.168.1.23/FMB-//Webservice/FMBServiceNew.asmx/Mannat_Report?SabeelNo=sak009&Company_Id=20"];
    
    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str1];
    NSData * data=[NSData dataWithContentsOfURL:url];
    NSError * error;
    NSDictionary *dictionary2 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    
    if ([[dictionary2 valueForKey:@"status"] isEqualToString:@"YES"] )
    {
        NSMutableArray *arr=[dictionary2 valueForKey:@"Post"];
        
        for(int i=0;i<arr.count;i++)
        {
            [arrSabeelNo addObject:[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i]valueForKey:@"SabeelNo"]]];
            [arrName addObject:[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i]valueForKey:@"Name"]]];
            [arrNiyatTypeName addObject:[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i]valueForKey:@"NiyatTypeName"]]];
            [arrTotal_Takhmeen_amnt addObject:[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i]valueForKey:@"Total_Takhmeen_amnt"]]];
            [arrPaid addObject:[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i]valueForKey:@"Paid"]]];
            [arrDue addObject:[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i]valueForKey:@"Due"]]];
            [arrNiyatDate addObject:[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i]valueForKey:@"NiyatDate"]]];
            [arrNiyathijriDate addObject:[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i]valueForKey:@"NiyathijriDate"]]];
            
        }
        
    }
    else
    {
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Data Not Found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        //        [alert show];
    }
    [tblMannatReport reloadData];
    [SVProgressHUD dismiss];
    
    
    
    
   
//    NSString *myRequestString1 =[NSString stringWithFormat:@"http://192.168.1.23/FMB-Webservice/FMBServiceNew.asmx/Mannat_Report?SabeelNo=sak009&Company_Id=20"];//,Sabeelno, Companyid];
//    NSString *str1 = [myRequestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url1 = [NSURL URLWithString:str1];
//    NSData * data=[NSData dataWithContentsOfURL:url1];
//    NSError * error;
//    NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
//    NSString *webStatus = [json1 objectForKey:@"status"];
//    if ([webStatus  isEqual: @"YES"])
//    {
//        for(int i=0;i<[[json1 valueForKey:@"Post"]count];i++){
//            [arrSabeelNo addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"SabeelNo"]]];
//            [arrName addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Name"]]];
//            [arrNiyatTypeName addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"NiyatTypeName"]]];
//            [arrTotal_Takhmeen_amnt addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Total_Takhmeen_amnt"]]];
//            [arrPaid addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Paid"]]];
//            [arrDue addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"Due"]]];
//            [arrNiyatDate addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"NiyatDate"]]];
//            [arrNiyathijriDate addObject:[NSString stringWithFormat:@"%@",[[[json1 valueForKey:@"Post"]objectAtIndex:i]valueForKey:@"NiyathijriDate"]]];
//        }
//        [tblMannatReport reloadData];
//    }
    //[SVProgressHUD dismiss];
}

@end
