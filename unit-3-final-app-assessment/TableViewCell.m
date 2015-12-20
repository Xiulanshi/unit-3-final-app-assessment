//
//  TableViewCell.m
//  unit-3-final-app-assessment
//
//  Created by Xiulan Shi on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)AddButtonTapped:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *starWarsKey = @"MovieKey";
    
    [defaults setObject:@"Star Wars" forKey:starWarsKey];
    
    if ([defaults objectForKey:starWarsKey]) {
        NSLog(@"Let's go home early...");
    } else {
        NSLog(@"Let's keep going...");
    }
    
    NSArray *arr = @[];
    NSMutableArray *mArr = [arr mutableCopy];
    [mArr addObject:@"butt"];

}

@end
