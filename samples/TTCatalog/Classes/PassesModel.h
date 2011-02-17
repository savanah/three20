//
//  PassesModel.h
//  TTCatalog
//
//  Created by Savanah Cummings on 2/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PassesModel : TTURLRequestModel {
    NSArray * _categoryNames;
    NSArray * _passGroups;
}

@property (nonatomic, retain) NSArray* categoryNames;
@property (nonatomic, retain) NSArray* passGroups;

@end
