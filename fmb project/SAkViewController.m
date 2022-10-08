//
//  SAkViewController.m
//  Fmb
//
//  Created by SMB-Mobile01 on 9/6/14.
//  Copyright (c) 2014 SAK. All rights reserved.
//

#import "SAkViewController.h"
#import "HomePage.h"
#import "Singleton.h"

@interface SAkViewController ()

@end

@implementation SAkViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if(textField == txtSabeelno)
    {
        [txtPassword becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return YES;
}

- (IBAction)btnClickedLogin:(id)sender {
    [SVProgressHUD showProgress:0 status:@"Loading"];
    if([txtSabeelno.text isEqualToString:@""] || [txtPassword.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:@"Enter Valid Username and Password !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        //[SVProgressHUD showProgress:0 status:@"Loading"];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *setid=[prefs stringForKey:@"MyAppSpecificGloballyUniqueString"];
        NSString *str=[NSString stringWithFormat:@"%@MuminLogin?ItsNo=%@&Password=%@&deviceid=%@&devicetype=2",[[Singleton sharedSingleton] getBaseURL],txtSabeelno.text,txtPassword.text,setid];
       // NSString *str=[NSString stringWithFormat:@"http://mobile-app-developers-india.com/fmb/login.php?SabeelNo=%@&loginpwd=%@&deviceid=%@&devicetype=2&cmp=%@",txtSabeelno.text,txtPassword.text,setid,Companyid];
        NSURL *url = [NSURL URLWithString:str];
        NSData * data=[NSData dataWithContentsOfURL:url];
        NSError * error;
        NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        
        NSString *webStatus = [json1 objectForKey:@"status"];
        if([webStatus isEqualToString:@"YES"]){
            [prefs setValue:[json1 objectForKey:@"Post"] forKey:@"Post"];
            [prefs setValue:[json1 objectForKey:@"CompanyId"] forKey:@"CompanyId"];
            [prefs setValue:txtPassword.text forKey:@"Password"];
            [prefs setValue:[json1 objectForKey:@"Email"] forKey:@"Email"];
            [prefs setValue:[json1 objectForKey:@"FirstName"] forKey:@"FirstName"];
            [prefs setValue:[json1 objectForKey:@"cmp_email"] forKey:@"cmp_email"];
            [prefs setValue:[json1 objectForKey:@"muminmasterid"] forKey:@"muminmasterid"];
            [prefs setValue:[json1 objectForKey:@"ThaliType"] forKey:@"ThaliType"];
            [prefs setValue:[json1 objectForKey:@"ThaliTotal"] forKey:@"ThaliTotal"];
            [prefs setValue:[json1 objectForKey:@"ThaliType_Id"] forKey:@"ThaliType_Id"];
            prefs = [NSUserDefaults standardUserDefaults];
            [prefs setBool:YES forKey:@"boolVal"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             HomePage *FeesScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"HomePage"];
            [self presentViewController:FeesScreen animated:NO completion:nil];
        }
        else{
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FMB" message:[json1 objectForKey:@"responce"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [SVProgressHUD dismiss];
        }
    }
    [SVProgressHUD dismiss];
}
- (IBAction)btnClickedExit:(id)sender
{
    [txtSabeelno setText:@""];
    [txtPassword setText:@""];
}

- (IBAction)btnClickedForgotPassword:(id)sender
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"FMB"
                                         message:@"Forgot Password"
                                        delegate:self
                               cancelButtonTitle:@"Cancel"
                               otherButtonTitles:@"OK", nil];
    
    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [message setTag:1001];
    [[message textFieldAtIndex:0] setDelegate:self]; //you'll surely need it later
    [message show];
    [[message textFieldAtIndex:0] resignFirstResponder];
}
@end
