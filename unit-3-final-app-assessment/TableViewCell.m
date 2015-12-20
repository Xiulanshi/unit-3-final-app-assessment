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
    
    // check to see if there is any savedFacts
    if ([defaults objectForKey:@"savedFacts"] == nil) {
        NSArray *catFactsArray = [[NSArray alloc]initWithObjects:self.selectedCatFact, nil];
        [defaults setObject:catFactsArray forKey:@"savedFacts"];
    }
    // if saved before, break
    NSArray *savedFacts = [defaults objectForKey:@"savedFacts"];
    BOOL savedBefore = NO;
    for (NSString *fact in savedFacts) {
        if ([fact isEqualToString:self.catFactLabel.text]) {
            savedBefore = YES;
            break;
        }
    }
    // add newSaveFacts
    if (savedBefore == NO) {
        NSArray *newSaveFacts = [savedFacts arrayByAddingObject:self.catFactLabel.text];
        [defaults setObject:newSaveFacts forKey:@"savedFacts"];
        [defaults synchronize];
    }

    // add alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Saved" message:@"New Cat Fact Saved!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:okButton];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    

}


@end
