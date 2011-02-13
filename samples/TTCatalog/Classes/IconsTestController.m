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

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#import "IconsTableViewCell.h"
@interface TestIcon : NSObject<Icon> {
  NSString * name;
  NSString * imageURL;
  id target;
  SEL targetAction;
}
+(TestIcon*)iconWithName:(NSString*)name URL:(NSString*)url target:(id)target targetAction:(SEL)targetAction;
@end

@implementation TestIcon
@synthesize name, imageURL, target, targetAction;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithName:(NSString*)_name URL:(NSString*)_imageURL target:(id)_target targetAction:(SEL)_targetAction {
  if (self = [self init]) {
    self.name = _name;
    self.imageURL = _imageURL;
    self.target = _target;
    self.targetAction = _targetAction;
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
+(TestIcon*)iconWithName:(NSString*)_name URL:(NSString*)_imageURL target:(id)_target targetAction:(SEL)_targetAction {
  return [[[self alloc] initWithName:_name URL:_imageURL target:_target targetAction:_targetAction] autorelease];
}

@end

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation IconsTestController
- (void)viewDidLoad {

  //! In a real app this would be elsewhere ... applicationdelegate maybe? -- sic
  [TTStyleSheet setGlobalStyleSheet: [[[IconsTestStyleSheet alloc] init] autorelease]];

  NSMutableArray * rows = [NSMutableArray arrayWithCapacity:10];
  {
    NSMutableArray * cells = [NSMutableArray arrayWithCapacity:3];
    [cells addObject:[TestIcon iconWithName:@"Alsace, Great Whites" URL:@"http://assets-test.cruvee.com/vinpass/passes/u-573a9c2296884c2c810a13b11ddae170.png" target:nil targetAction:nil]];
    [cells addObject:[TestIcon iconWithName:@"Beaujolais, Cru Master" URL:@"http://assets-test.cruvee.com/vinpass/passes/u-39c0f94a3c984f0bab19134c37b9d902.png" target:nil targetAction:nil]];
    [cells addObject:[TestIcon iconWithName:@"Burgundy: 1000 Years of Heritage" URL:@"http://assets-test.cruvee.com/vinpass/passes/u-7dbe323e3f01461f8849a0cff42e2861.png" target:nil targetAction:nil]];
    [rows addObject:cells];
  }

  {
    NSMutableArray * cells = [NSMutableArray arrayWithCapacity:3];
    [cells addObject:[TestIcon iconWithName:@"Champagne: Drinking Stars" URL:@"http://assets-test.cruvee.com/vinpass/passes/u-27510b8c319f4d4e85e51fa31b5fdfaf.png" target:nil targetAction:nil]];
    [cells addObject:[TestIcon iconWithName:@"Languedoc-Roussillon: Yours to Discover" URL:@"http://assets-test.cruvee.com/vinpass/passes/u-784d31a0d7a1452da08e1d676771315a.png" target:nil targetAction:nil]];
    [cells addObject:[TestIcon iconWithName:@"Life gets better with Bordeaux" URL:@"http://assets-test.cruvee.com/vinpass/passes/u-79cc5d61461f450db7f85ddd062717a1.png" target:nil targetAction:nil]];
    [rows addObject:cells];
  }

  {
    NSMutableArray * cells = [NSMutableArray arrayWithCapacity:3];
    [cells addObject:[TestIcon iconWithName:@"Provence: la Vie en Rosé" URL:@"http://assets-test.cruvee.com/vinpass/passes/u-de5fc9de144148c7bc244c0b0f941b13.png" target:nil targetAction:nil]];
    [cells addObject:[TestIcon iconWithName:@"Rhône Valley Wines: Always Right" URL:@"http://assets-test.cruvee.com/vinpass/passes/u-c59ea1651f664b0784bec5cafd3291f1.png" target:nil targetAction:nil]];
    [cells addObject:[TestIcon iconWithName:@"Southwest: A New Direction for French Wine" URL:@"http://assets-test.cruvee.com/vinpass/passes/u-892d66decfb54125bc22b9224256aa5e.png" target:nil targetAction:nil]];
    [rows addObject:cells];
  }

  {
    NSMutableArray * cells = [NSMutableArray arrayWithCapacity:3];
    [cells addObject:[TestIcon iconWithName:@"The Loire: A River of Wine" URL:@"http://assets-test.cruvee.com/vinpass/passes/u-5b8aa2e67b314e96aa9c7d3158cd71f7.png" target:nil targetAction:nil]];
    [cells addObject:[TestIcon iconWithName:@"Tour de France" URL:@"http://assets-test.cruvee.com/vinpass/passes/u-8b951291e6bf4ea9ba5f5d4c327ce83a.png" target:nil targetAction:nil]];
    [rows addObject:cells];
  }

  self.dataSource = [TTListDataSource dataSourceWithItems:rows];

  [_dataSource setCellClass:@"IconsTableViewCell" forItemClass:NSStringFromClass([rows class])];
}
@end
