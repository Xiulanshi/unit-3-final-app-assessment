//
//  ViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 11/30/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QViewController.h"
#import "C4QColorPickerViewController.h"
#import "C4QCatFactsTableViewController.h"


@interface C4QViewController ()<ColorPickerDelegate>

@end

@implementation C4QViewController

-(void)userDidSelectColor:(UIColor *)color {
    self.view.backgroundColor = color;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CatFacts"]) {
        C4QCatFactsTableViewController *vc = segue.destinationViewController;
        vc.viewController = self;

    } else {
    C4QColorPickerViewController *svc = segue.destinationViewController;
    svc.delegate = self;
    }
}




@end
