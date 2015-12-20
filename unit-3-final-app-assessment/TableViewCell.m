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
    
    if ([defaults objectForKey:@"savedFacts"]) {
        NSArray *catFactsArray = [defaults objectForKey:@"savedFacts"];
        NSMutableArray *catFactsMut = [catFactsArray mutableCopy];
        [catFactsMut addObject:self.selectedCatFact];
        NSArray *finalCatFactsArray = [catFactsMut copy];
        [defaults setObject:finalCatFactsArray forKey:@"savedFacts"];
    } else {
        NSArray *catFactsArray = [[NSArray alloc]initWithObjects:self.selectedCatFact, nil];
        [defaults setObject:catFactsArray forKey:@"savedFacts"];
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Saved" message:@"New Cat Fact Saved!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:okButton];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    

}

@end
