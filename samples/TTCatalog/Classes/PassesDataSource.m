//
//  PassesDataSource.m
//  TTCatalog
//
//  Created by Savanah Cummings on 2/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PassesDataSource.h"
#import "PassesModel.h"

@implementation PassesDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
  if (self = [super init]) {
    self.model = [[PassesModel alloc] init];
  }

  return self;
}

- (PassesModel*)passesModel {
  return (PassesModel*)self.model;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {

  NSMutableArray * iconGroups = [NSMutableArray arrayWithCapacity:[self.passesModel.passGroups count]];
  for(NSArray * group in self.passesModel.passGroups) {
    int rowSize = 4;
    int totalPasses = [group count];
    NSMutableArray * rows = [NSMutableArray arrayWithCapacity:(totalPasses / rowSize)+1];

    int passIndex = 0;
    while(passIndex < totalPasses) {
      NSMutableArray * row = [NSMutableArray arrayWithCapacity:rowSize];
      for(int i=0; i<rowSize; i++) {
        if(passIndex < totalPasses)
          [row addObject:[group objectAtIndex:passIndex++]];      
      }
      [rows addObject:row];
    }
    [iconGroups addObject:rows];
  }

  [self setCellClass:@"IconsTableViewCell" forItemClass:NSStringFromClass([iconGroups class])]; //! really the class of one row, but whatever -- 20110217 sic
  self.items = iconGroups;
  self.sections = [self.passesModel.categoryNames mutableCopy];
  // self.items = rows;
}

@end
