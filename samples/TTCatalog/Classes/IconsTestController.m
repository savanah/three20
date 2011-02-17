//
//  IconsTestController.m
//  TTCatalog
//
//  Created by Savanah Cummings on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IconsTestController.h"
#import "IconsTableViewCell.h"
#import "IconsTestStyleSheet.h"
#import "PassesDataSource.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#import "IconsTableViewCell.h"
@interface TestIcon : NSObject<Icon> {
  NSString * name;
  NSString * imageURL;
  NSString * URL;
  id target;
  SEL targetAction;
}
@end

@implementation TestIcon
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

  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+(TestIcon*)iconWithName:(NSString*)_name imageURL:(NSString*)_imageURL URL:(NSString*)_URL {
  return [[[self alloc] initWithName:_name imageURL:_imageURL URL:_URL] autorelease];
}

@end

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation IconsTestController
- (void)viewDidLoad {

  //! In a real app this would be elsewhere ... applicationdelegate maybe? -- sic
  [TTStyleSheet setGlobalStyleSheet: [[[IconsTestStyleSheet alloc] init] autorelease]];
#ifdef HARDCODE_PASSES
  NSMutableArray * rows = [NSMutableArray arrayWithCapacity:10];
  {
    NSMutableArray * cells = [NSMutableArray arrayWithCapacity:3];
    [cells addObject:[TestIcon iconWithName:@"Alsace, Great Whites" imageURL:@"http://assets-test.cruvee.com/vinpass/passes/u-573a9c2296884c2c810a13b11ddae170.png" URL:@"tt://icon/44"]];
    [cells addObject:[TestIcon iconWithName:@"Beaujolais, Cru Master" imageURL:@"http://assets-test.cruvee.com/vinpass/passes/u-39c0f94a3c984f0bab19134c37b9d902.png" URL:nil]];
    [cells addObject:[TestIcon iconWithName:@"Burgundy: 1000 Years of Heritage" imageURL:@"http://assets-test.cruvee.com/vinpass/passes/u-7dbe323e3f01461f8849a0cff42e2861.png" URL:nil]];
    [cells addObject:[TestIcon iconWithName:@"Champagne: Drinking Stars" imageURL:@"http://assets-test.cruvee.com/vinpass/passes/u-27510b8c319f4d4e85e51fa31b5fdfaf.png" URL:nil]];
    [rows addObject:cells];
  }

  {
    NSMutableArray * cells = [NSMutableArray arrayWithCapacity:3];
    [cells addObject:[TestIcon iconWithName:@"Champagne: Drinking Stars" imageURL:@"http://assets-test.cruvee.com/vinpass/passes/u-27510b8c319f4d4e85e51fa31b5fdfaf.png" URL:nil]];
    [cells addObject:[TestIcon iconWithName:@"Languedoc-Roussillon: Yours to Discover" imageURL:@"http://assets-test.cruvee.com/vinpass/passes/u-784d31a0d7a1452da08e1d676771315a.png" URL:nil]];
    [cells addObject:[TestIcon iconWithName:@"Life gets better with Bordeaux" imageURL:@"http://assets-test.cruvee.com/vinpass/passes/u-79cc5d61461f450db7f85ddd062717a1.png" URL:nil]];
    [cells addObject:[TestIcon iconWithName:@"Champagne: Drinking Stars" imageURL:@"http://assets-test.cruvee.com/vinpass/passes/u-27510b8c319f4d4e85e51fa31b5fdfaf.png" URL:nil]];
    [rows addObject:cells];
  }

  {
    NSMutableArray * cells = [NSMutableArray arrayWithCapacity:3];
    [cells addObject:[TestIcon iconWithName:@"Provence: la Vie en Rosé" imageURL:@"http://assets-test.cruvee.com/vinpass/passes/u-de5fc9de144148c7bc244c0b0f941b13.png" URL:nil]];
    [cells addObject:[TestIcon iconWithName:@"Rhône Valley Wines: Always Right" imageURL:@"http://assets-test.cruvee.com/vinpass/passes/u-c59ea1651f664b0784bec5cafd3291f1.png" URL:nil]];
    [cells addObject:[TestIcon iconWithName:@"Southwest: A New Direction for French Wine" imageURL:@"http://assets-test.cruvee.com/vinpass/passes/u-892d66decfb54125bc22b9224256aa5e.png" URL:nil]];
    [cells addObject:[TestIcon iconWithName:@"Champagne: Drinking Stars" imageURL:@"http://assets-test.cruvee.com/vinpass/passes/u-27510b8c319f4d4e85e51fa31b5fdfaf.png" URL:nil]];
    [rows addObject:cells];
  }

  {
    NSMutableArray * cells = [NSMutableArray arrayWithCapacity:3];
    [cells addObject:[TestIcon iconWithName:@"The Loire: A River of Wine" imageURL:@"http://assets-test.cruvee.com/vinpass/passes/u-5b8aa2e67b314e96aa9c7d3158cd71f7.png" URL:nil]];
    [cells addObject:[TestIcon iconWithName:@"Tour de France" imageURL:@"http://assets-test.cruvee.com/vinpass/passes/u-8b951291e6bf4ea9ba5f5d4c327ce83a.png" URL:nil]];
    [cells addObject:[TestIcon iconWithName:@"Champagne: Drinking Stars" imageURL:@"http://assets-test.cruvee.com/vinpass/passes/u-27510b8c319f4d4e85e51fa31b5fdfaf.png" URL:nil]];
    [rows addObject:cells];
  }

  self.dataSource = [TTListDataSource dataSourceWithItems:rows];
  [_dataSource setCellClass:@"IconsTableViewCell" forItemClass:NSStringFromClass([rows class])];
#else
  self.dataSource = [[[PassesDataSource alloc] init] autorelease];
#endif
}
@end
