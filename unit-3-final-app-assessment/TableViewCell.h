//
//  TableViewCell.h
//  unit-3-final-app-assessment
//
//  Created by Xiulan Shi on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *catFactLabel;
@property (nonatomic) NSString *selectedCatFact;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
