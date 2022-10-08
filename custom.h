//
//  custom.h
//  SmartSchool
//
//  Created by apple on 15/08/14.
//  Copyright (c) 2014 SAK Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface custom : UITableViewCell{
    
    IBOutlet UISegmentedControl *dishsegment;
}
@property (strong, nonatomic) IBOutlet UILabel *lblName1;
@property (strong, nonatomic) IBOutlet UILabel *lblNiyatName;
@property (strong, nonatomic) IBOutlet UILabel *lblTakhmeen;
@property (strong, nonatomic) IBOutlet UILabel *lblNiyatDate;
@property (strong, nonatomic) IBOutlet UILabel *lblHijriDate;
@property (strong, nonatomic) IBOutlet UILabel *lblPaid;
@property (strong, nonatomic) IBOutlet UILabel *lblDue;
@property (strong, nonatomic) IBOutlet UILabel *lblJamatType;
@property (strong, nonatomic) IBOutlet UILabel *lblStartStopdate;
@property (strong, nonatomic) IBOutlet UILabel *lblReasonthali;
@property (strong, nonatomic) IBOutlet UILabel *lblPopup;
@property (strong, nonatomic) IBOutlet UILabel *lblStopDate1;

@property (strong, nonatomic) IBOutlet UIButton *btnobjDelete;
@property (strong, nonatomic) IBOutlet UILabel *lblSabeelno;
@property (strong, nonatomic) IBOutlet UILabel *lblMenuDate;
@property (strong, nonatomic) IBOutlet UILabel *lblMenuDay;
@property (strong, nonatomic) IBOutlet UILabel *lblMenuList;
@property (strong, nonatomic) IBOutlet UILabel *lblitemname;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segitem;
@property (strong, nonatomic)IBOutlet UISegmentedControl *dishsegment;
@property (strong, nonatomic) IBOutlet UIButton *objbtnDropDown;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UITextField *txtDropDown;
@property (strong, nonatomic) IBOutlet UILabel *lblNumber;
@end
