//
//  ThaliStart.m
//  Fmb
//
//  Created by SMB-Mobile01 on 10/9/14.
//  Copyright (c) 2014 SAK. All rights reserved.
//

#import "ThaliStart.h"
#import "ASIFormDataRequest.h"
#import "NXJsonParser.h"
#import "Reachability.h"

@interface ThaliStart (){
    int b1,c1,d1,e1;
    BOOL chk,test;
    NSString *StartDate;
    NSUserDefaults *prefs;
    NSString *Companyid,*Sabeelno,*PastDate,*Firstname,*Email;
}
@property (strong, nonatomic) CCKFNavDrawer *rootNav;
@property(nonatomic,strong)id <SKPSMTPMessageDelegate> delegate;
@property(nonatomic,strong)SKPSMTPMessage *testMsg;
@end

@implementation ThaliStart

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    prefs = [NSUserDefaults standardUserDefaults];
    Companyid = [prefs stringForKey:@"Companyid"];
    Sabeelno = [prefs stringForKey:@"Sabeelno"];
    Firstname=[prefs stringForKey:@"FirstName"];
    Email=[prefs stringForKey:@"Email"];
    txvrReason.text = @"Enter Reason";
    txvrReason.textColor = [UIColor darkGrayColor];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSDate *today = [NSDate date];
    today=[today dateByAddingTimeInterval:60*60*24];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd,yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    txtStartDate.text=dateString;
    PastDate=dateString;
    chk=YES;
    test=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnOpenMenu:(id)sender {
    [txvrReason resignFirstResponder];
    NSArray  *menuNames = [NSArray arrayWithObjects:@"home.png",@"profile.png",@"thalimanageselect.png",@"menu.png",@"feedback.png",@"homeselect.png",@"profile.png",@"thalimanage.png", nil];
    [self.rootNav drawerToggle:menuNames];
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
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        [txvrReason resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView{
    if (test==YES){
        txvrReason.text = @"";
        test=NO;
    }
    else if([txvrReason.text isEqualToString:@"Enter Reason"]){
        txvrReason.text=@"";
    }
    txvrReason.textColor = [UIColor darkGrayColor];
    chk=NO;
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView{
    if(txvrReason.text.length == 0){
        txvrReason.textColor = [UIColor lightGrayColor];
        txvrReason.text = @"Enter Reason";
        [txvrReason resignFirstResponder];
    }
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles{
    txtStartDate.text=[titles componentsJoinedByString:@" - "];
    [self a];
    if (d1 < e1){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Inform Before 24 Hours" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        txtStartDate.text=PastDate;
        }
    else{
        
        }
}
-(void)a
{
    NSString *str1 = txtStartDate.text; /// here this is your date with format yyyy-MM-dd
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
    
    d1=[a intValue];
    e1=[b intValue];

}
- (IBAction)btnStartDate:(id)sender {
    
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Date Picker" delegate:self];

    [picker setTag:1];
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [picker show];

}

- (IBAction)btnSubmit:(id)sender {
    if (chk==YES){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter Reason" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txvrReason.text isEqual:@"Enter Reason"]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter Reason" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txvrReason.text isEqual:@""]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter Reason" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        [txvrReason resignFirstResponder];
        [SVProgressHUD showProgress:0 status:@"Loading"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd,yyyy"];
        
        NSDate *date1 = [dateFormatter dateFromString:txtStartDate.text];
        
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat    :@"yyyy-MM-dd"];
        
        StartDate = [dateFormatter stringFromDate:date1];
        
        NSString *appurl =[NSString stringWithFormat:@"http://services.saksolution.com/FMBService_New1.asmx/Thaali_START_STOP?CompanyId=%@&SabeelNo=%@&NewStopDate=%@&reason=%@",Companyid,Sabeelno,StartDate,txvrReason.text];
        
        NSString *str1 = [appurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url1 = [NSURL URLWithString:str1];
        NSData * data=[NSData dataWithContentsOfURL:url1];
        NSError * error;
        NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        
        
        NSString *webStatus = [json1 objectForKey:@"status"];
        
        if ([webStatus  isEqual: @"YES"])
        {
            [self sendMessageInBack1];
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
	
    NSString *str = [NSString stringWithFormat:@"Salam,\nI my name %@, my Sabil No %@\nI want to start my thali from %@.\nReason:%@ \n\nRegards\n%@",Firstname,Sabeelno,txtStartDate.text,txvrReason.text,Firstname];
    
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
    txvrReason.text=@"";
    [SVProgressHUD dismiss];
}

-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
     message=nil;
    [SVProgressHUD dismiss];
	
}
- (IBAction)btnCancel:(id)sender {
    txtStartDate.text=PastDate;
    txvrReason.text=@"";
}

- (IBAction)btnLogOut:(id)sender {
    UIViewController *reg2=[self.storyboard instantiateViewControllerWithIdentifier:@"SAkViewController"];
    [self.navigationController pushViewController:reg2 animated:YES];
    prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:NO forKey:@"boolVal"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}



@end
