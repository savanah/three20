//
//  DetailViewController.m
//  TTCatalog
//
//  Created by Savanah Cummings on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"


@implementation DetailViewController

@synthesize identifier = _identifier;

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithId:(NSString*)identifier {
  if (self = [super init]) {
    self.identifier = identifier;
  }
  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_identifier);
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)loadView {
  [super loadView];

  CGFloat square = 80;
  int x = (self.view.width / 2) - (square / 2);
  CGRect frame = CGRectMake(x, 60, square, square);
  
  TTImageView * image = [[[TTImageView alloc] initWithFrame:frame] autorelease];
  image.urlPath = @"http://assets-test.cruvee.com/vinpass/passes/u-8b951291e6bf4ea9ba5f5d4c327ce83a.png";
  [self.view addSubview:image];

  frame = CGRectMake(10, 180, self.view.width-20, 100);

  TTLabel * label = [[[TTLabel alloc] initWithFrame:frame] autorelease];
  label.text = _identifier;
  // label.style = [[TTStyleSheet globalStyleSheet] photoCaption];
  label.style = [TTSolidFillStyle styleWithColor:[UIColor colorWithWhite:0 alpha:0.5] next:
  [TTFourBorderStyle styleWithTop:RGBACOLOR(0, 0, 0, 0.5) width:1 next:
  [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(8, 8, 8, 8) next:
  [TTTextStyle styleWithFont: [UIFont boldSystemFontOfSize:18] // TTSTYLEVAR(photoCaptionFont)
                       color: TTSTYLEVAR(photoCaptionTextColor)
             minimumFontSize: 0
                 shadowColor: TTSTYLEVAR(photoCaptionTextShadowColor)
                shadowOffset: TTSTYLEVAR(photoCaptionTextShadowOffset)
               textAlignment: UITextAlignmentCenter
           verticalAlignment: UIControlContentVerticalAlignmentCenter
               lineBreakMode: UILineBreakModeTailTruncation
               numberOfLines: 6
                        next: nil]]]];
  
  [self.view addSubview:label];
}

- (void)viewWillAppear:(BOOL)animated {
//  TTStyledTextLabel* label = (TTStyledTextLabel*)[self.view viewWithTag:42];
//  label.html = _text;
}

@end
