//
//  IconsTestStyleSheet.m
//  TTCatalog
//
//  Created by Savanah Cummings on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IconsTestStyleSheet.h"


@implementation IconsTestStyleSheet

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)iconButtonImage:(UIControlState)state {
  TTStyle* style =
    [TTBoxStyle styleWithMargin:UIEdgeInsetsMake(7, 0, 11, 0) next:
    [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
    [TTImageStyle styleWithImageURL:nil defaultImage:nil contentMode:UIViewContentModeScaleToFill
                  size:CGSizeZero next:nil]]];

  if (state == UIControlStateHighlighted || state == UIControlStateSelected) {
      [style addStyle:
        [TTBlendStyle styleWithBlend:kCGBlendModeSourceAtop next:
        [TTSolidFillStyle styleWithColor:RGBACOLOR(0,0,0,0.5) next:nil]]];
  }

  return style;
}

@end
