//
//  ViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 11/30/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QViewController.h"
#import "C4QColorPickerViewController.h"

@interface C4QViewController ()<ColorPickerDelegate>

@end

@implementation C4QViewController

-(void)userDidSelectRedButton:(UIColor *)red{
    self.view.backgroundColor = [UIColor redColor];
}
-(void)userDidSelectGreenButton:(UIColor *)green{
    self.view.backgroundColor = [UIColor greenColor];
    
}
-(void)userDidSelectBlueButton:(UIColor *)blue{
    self.view.backgroundColor = [UIColor blueColor];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    C4QColorPickerViewController *svc = segue.destinationViewController;
    svc.delegate = self;
}


@end
