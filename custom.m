
//
//  custom.m
//  SmartSchool
//
//  Created by apple on 15/08/14.
//  Copyright (c) 2014 SAK Solutions. All rights reserved.
//

#import "custom.h"

@implementation custom
@synthesize dishsegment,objbtnDropDown;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
