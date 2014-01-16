//
//  BYLBadgeView.m
//  BYLBadgeView
//
//  Created by James Richard on 1/15/14.
//  Copyright (c) 2014 James Richard. All rights reserved.
//

#import "BYLBadgeView.h"
#import "BYLBadgeViewLayer.h"

@implementation BYLBadgeView
#pragma mark - Instantiation / Configuration
- (instancetype) initWithBadge:(NSUInteger)badge {
  if (self = [super init]) {
    [self setup];
    self.badgeLayer.badge = badge;
  }
  
  return self;
}

- (instancetype) init {
  if (self = [super init]) {
    [self setup];
  }
  
  return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self setup];
  }
  
  return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setup];
  }
  
  return self;
}

- (void) setup {
  self.layer.contentsScale = [UIScreen mainScreen].scale;
}

+ (Class) layerClass {
  return [BYLBadgeViewLayer class];
}

#pragma mark - Sizing
- (CGSize) intrinsicContentSize {
  NSString *badge = [NSString stringWithFormat:@"%d", self.badge];
  CGSize size = [badge sizeWithAttributes:[self badgeTextAttributes]];
  CGFloat maximumWidth = size.width + self.badgeRadius / 2;
  CGFloat minimumWidth = self.badgeRadius * 2;
  size.width = (maximumWidth > self.badgeRadius*2) ? maximumWidth : minimumWidth;
  size.height = MAX(size.height, minimumWidth);
  return size;
}

#pragma mark - Accessor Overrides
- (void) setBadge:(NSUInteger)badge {
  self.badgeLayer.badge = badge;
  [self invalidateIntrinsicContentSize];
}

- (NSUInteger) badge {
  return self.badgeLayer.badge;
}

- (UIColor *) badgeBackgroundColor {
  return [UIColor colorWithCGColor:self.badgeLayer.badgeBackgroundColor];
}

- (void) setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor {
  self.badgeLayer.badgeBackgroundColor = badgeBackgroundColor.CGColor;
}

- (void) setBadgeRadius:(CGFloat)badgeRadius {
  self.badgeLayer.badgeRadius = badgeRadius;
  [self invalidateIntrinsicContentSize];
}

- (CGFloat) badgeRadius {
  return self.badgeLayer.badgeRadius;
}

- (void) setBadgeTextAttributes:(NSDictionary *)badgeTextAttributes {
  self.badgeLayer.badgeTextAttributes = badgeTextAttributes;
  [self invalidateIntrinsicContentSize];
}

- (NSDictionary *) badgeTextAttributes {
  return self.badgeLayer.badgeTextAttributes;
}

- (void) setBadgeTextColor:(UIColor *)badgeTextColor {
  self.badgeLayer.badgeTextColor = badgeTextColor.CGColor;
}

- (UIColor *) badgeTextColor {
  return [UIColor colorWithCGColor:self.badgeLayer.badgeTextColor];
}

#pragma mark - Private Methods
- (BYLBadgeViewLayer *) badgeLayer {
  return (BYLBadgeViewLayer *)self.layer;
}

@end
