//
//  IconsTableViewCell.m
//  TTCatalog
//
//  Created by Savanah Cummings on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IconsTableViewCell.h"
#import "Three20UI/TTLauncherButton.h"

static const CGFloat kSpacing = 20;
static const CGFloat kDefaultThumbSize = 75;
static const CGFloat kLabelOffset = 65;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation IconsTableViewCell

@synthesize buttons     = _buttons;
@synthesize iconSize    = _iconSize;
@synthesize iconOrigin  = _iconOrigin;
@synthesize labelOrigin = _labelOrigin;
@synthesize columnCount = _columnCount;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
  if (self = [super initWithStyle:style reuseIdentifier:identifier]) {
    _buttons = [[NSMutableArray alloc] init];
    _labels = [[NSMutableArray alloc] init];
    _iconSize = kDefaultThumbSize;
    _iconOrigin = CGPointMake(kSpacing, 0);
    _labelOrigin = CGPointMake(kSpacing, kLabelOffset);

    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }

  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_icons);
  TT_RELEASE_SAFELY(_buttons);
  TT_RELEASE_SAFELY(_labels);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutIconViews {
  CGRect iconFrame = CGRectMake(self.iconOrigin.x, self.iconOrigin.y,
                                 self.iconSize, self.iconSize);

  for (TTLauncherButton * button in _buttons) {
    button.frame = iconFrame;
    iconFrame.origin.x += kSpacing + self.iconSize;
  }

  CGRect labelFrame = CGRectMake(self.labelOrigin.x, self.labelOrigin.y,
                                 self.iconSize, self.iconSize);
  for (UILabel * label in _labels) {
    label.frame = labelFrame;
    labelFrame.origin.x += kSpacing + self.iconSize;
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];
  [self layoutIconViews];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setIcons:(NSArray *)icons {
  if (_icons != icons) {
    [_icons release];
    _icons = [icons retain];

    //!! could maybe be more efficient to reuse, if we could figure out the button target action removal -- sic
    for(UIView * button in _buttons) {
      [button removeFromSuperview];
    }
    [_buttons removeAllObjects];
    [_labels removeAllObjects];

    TTStyle* style =
      [TTBoxStyle styleWithMargin:UIEdgeInsetsMake(-7, 0, 11, 0) next:
      [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
      [TTImageStyle styleWithImageURL:nil defaultImage:nil contentMode:UIViewContentModeScaleToFill
                    size:CGSizeZero next:nil]]];

    for(id<Icon> icon in icons) {
      TTButton * button = [TTButton buttonWithStyle:@"iconButtonImage:" title:icon.name];
      [button setImage:icon.imageURL forState:UIControlStateNormal];

      [button addTarget:icon.target action:icon.targetAction
            forControlEvents:UIControlEventTouchUpInside];
      [self.contentView addSubview:button];
      [_buttons addObject:button];
      
      UILabel* label = [[[UILabel alloc] init] autorelease];
      label.text = icon.name;
      label.font = [UIFont boldSystemFontOfSize:10];
      label.backgroundColor = [UIColor clearColor];
      label.textColor = RGBCOLOR(81,95,122);
      label.shadowColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
      label.shadowOffset = CGSizeMake(0,1);
      label.textAlignment = UITextAlignmentCenter;
      label.numberOfLines = 4;
      [self.contentView addSubview:label];
      [_labels addObject:label];
    }
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)object {
  return _icons;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  [self setIcons:object];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setIconSize:(CGFloat)iconSize {
  _iconSize = iconSize;
  [self setNeedsLayout];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setIconOrigin:(CGPoint)iconOrigin {
  _iconOrigin = iconOrigin;
  [self setNeedsLayout];
}

@end
