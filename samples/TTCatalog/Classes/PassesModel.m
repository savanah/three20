//
//  PassesModel.m
//  TTCatalog
//
//  Created by Savanah Cummings on 2/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PassesModel.h"

#import <extThree20JSON/extThree20JSON.h>

//!!! parameterize creds and hostname here -- sic 20110217
static NSString* kPassesUrl = @"http://e7767bffd32748cd88a8d25f81d45d10:d4ea6253e7ae4b79bf4a5ddccb05dd9b@api.test.vinpass.com/v2/passes";

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#import "IconsTableViewCell.h"
@interface PassIcon : NSObject<Icon> {
  NSString * name;
  NSString * imageURL;
  NSString * URL;
}
+(PassIcon*)passIconFromDict:(NSDictionary*)pass;
@end

@implementation PassIcon
@synthesize name, imageURL, URL;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithName:(NSString*)_name imageURL:(NSString*)_imageURL URL:(NSString*)_URL {
  if (self = [self init]) {
    self.name = _name;
    self.imageURL = _imageURL;
    self.URL = _URL;
  }

  return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(name);
  TT_RELEASE_SAFELY(imageURL);
  TT_RELEASE_SAFELY(URL);

  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+(PassIcon*)passIconFromDict:(NSDictionary*)pass {
  NSString * passName = [pass objectForKey:@"name"];
  NSString * passImageURL = [pass objectForKey:@"imageURL"];
  NSString * passId = [pass objectForKey:@"passId"];

  NSString * ttUrl = [NSString stringWithFormat:@"tt://icon/%@", passId];

  return [[[self alloc] initWithName:passName imageURL:passImageURL URL:ttUrl] autorelease];
}

@end

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation PassesModel

@synthesize passGroups = _passGroups;
@synthesize categoryNames = _categoryNames;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
  if (self = [super init]) {
    //!! do something or delete the whole constructor -- sic
  }

  return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
  TT_RELEASE_SAFELY(_categoryNames);
  TT_RELEASE_SAFELY(_passGroups);
  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
  if (!self.isLoading) {

    TTURLRequest* request = [TTURLRequest
                             requestWithURL: kPassesUrl
                             delegate: self];

    request.cachePolicy = cachePolicy | TTURLRequestCachePolicyEtag;
    request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;

    TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
    request.response = response;
    TT_RELEASE_SAFELY(response);

    [request send];
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {

  TTURLJSONResponse* response = request.response;
  TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);

  NSDictionary* root = response.rootObject;
  TTDASSERT([[root objectForKey:@"passCategories"] isKindOfClass:[NSArray class]]);

  NSArray * categories = [root objectForKey:@"passCategories"];

  NSMutableArray * names = [NSMutableArray arrayWithCapacity:[categories count]];
  NSMutableArray * groups = [NSMutableArray arrayWithCapacity:[categories count]];

  for (NSDictionary * category in categories) {
    NSString * categoryName = [category objectForKey:@"passCategoryName"];
    [names addObject:categoryName];

    TTDASSERT([[category objectForKey:@"passes"] isKindOfClass:[NSArray class]]);
    NSArray * passes = [category objectForKey:@"passes"];
    NSMutableArray * passIcons = [NSMutableArray arrayWithCapacity:[passes count]];
    
    for (NSDictionary * pass in passes) {
      PassIcon * passIcon = [PassIcon passIconFromDict:pass];
      [passIcons addObject:passIcon];
    }
    [groups addObject:passIcons];
  }

  self.categoryNames = names;
  self.passGroups = groups;

  [super requestDidFinishLoad:request];
}

@end
