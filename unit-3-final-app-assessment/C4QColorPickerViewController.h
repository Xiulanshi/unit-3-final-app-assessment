//
//  C4QColorPickerViewController.h
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPickerDelegate <NSObject>

-(void)userDidSelectRedButton:(UIColor *)red;
-(void)userDidSelectGreenButton:(UIColor *)green;
-(void)userDidSelectBlueButton:(UIColor *)blue;

@end

@interface C4QColorPickerViewController : UIViewController

@property (weak,nonatomic) id <ColorPickerDelegate> delegate;

@end
