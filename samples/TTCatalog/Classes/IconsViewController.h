//
//  IconsViewController.h
//  TTCatalog
//
//  Created by Savanah Cummings on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>
#import "Three20UI/TTTableViewController.h"


@interface IconsViewController : TTTableViewController {
    id  _delegate;
}

@property (nonatomic, assign) id delegate;

@end
