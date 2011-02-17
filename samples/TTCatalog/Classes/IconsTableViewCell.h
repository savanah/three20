//
//  IconsTableViewCell.h
//  TTCatalog
//
//  Created by Savanah Cummings on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>
#import "Three20UI/TTTableViewCell.h"

// The "object" the data source is expected to supply to this table is an NSArray of Icon
//! This needs a better name and a better home -- sic
@protocol Icon <NSObject>
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * URL;
@end

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

@interface IconsTableViewCell : TTTableViewCell {

    NSMutableArray* _icons; // the NSArray of Icon that is our "object"
    NSMutableArray* _buttons; // TTButtons
    NSMutableArray* _labels; // UILabels

    CGFloat         _iconSize;
    CGPoint         _iconOrigin;
    CGPoint         _labelOrigin;
    NSInteger       _columnCount;

}

@property (nonatomic, retain) NSMutableArray* buttons;
@property (nonatomic)         CGFloat     iconSize;
@property (nonatomic)         CGPoint     iconOrigin;
@property (nonatomic)         CGPoint     labelOrigin;
@property (nonatomic)         NSInteger   columnCount;

@end
