//
//  TableViewCellDelegate.h
//  unit-3-final-app-assessment
//
//  Created by Xiulan Shi on 12/20/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewCell.h"

@class TableViewCell;


@protocol TableViewCellDelegate <NSObject>

- (void)catFactsTableViewCellDidSaveFact:(TableViewCell *)catCell;

@end
