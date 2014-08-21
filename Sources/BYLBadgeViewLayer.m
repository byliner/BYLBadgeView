//
//  BYLBadgeViewLayer.m
//  BYLBadgeView
//
//  Created by James Richard on 1/15/14.
//  Copyright (c) 2014 James Richard. All rights reserved.
//

#import "BYLBadgeViewLayer.h"

@interface BYLBadgeViewLayer () {
  NSMutableDictionary * __strong _badgeTextAttributes;
}
@end

@implementation BYLBadgeViewLayer
@dynamic badge, badgeTextColor, badgeBackgroundColor, badgeRadius;

#pragma mark - Instantiation

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

- (void) setup {
  self.badgeTextColor = [UIColor whiteColor].CGColor;
  self.badgeBackgroundColor = [UIColor blackColor].CGColor;
  self.badgeRadius = 7.0f;
}

- (instancetype) initWithLayer:(id)layer {
  if (self = [super initWithLayer:layer]) {
    if ([layer isKindOfClass:[BYLBadgeViewLayer class]]) {
      BYLBadgeViewLayer *badgeLayer = layer;
      self.badge = badgeLayer.badge;
      self.badgeRadius = badgeLayer.badgeRadius;
      self.badgeTextColor = badgeLayer.badgeTextAttributes[NSForegroundColorAttributeName] ? [badgeLayer.badgeTextAttributes[NSForegroundColorAttributeName] CGColor]: [UIColor blackColor].CGColor;
      _badgeTextAttributes = [badgeLayer.badgeTextAttributes mutableCopy];
    }
  }
  
  return self;
}

#pragma mark - Listening for animations
+ (BOOL)needsDisplayForKey:(NSString *)key {
  if ([key isEqualToString:@"badge"]) {
    return YES;
  } else if ([key isEqualToString:@"badgeTextAttributes"]) {
    return YES;
  } else if ([key isEqualToString:@"badgeTextColor"]) {
    return YES;
  } else if ([key isEqualToString:@"badgeBackgroundColor"]) {
    return YES;
  } else if ([key isEqualToString:@"badgeRadius"]) {
    return YES;
  }
  
  return [super needsDisplayForKey:key];
}

- (BOOL) needsDisplayOnBoundsChange {
  return YES;
}

- (id<CAAction>)actionForKey:(NSString *)key {
  // We have to do some things a bit differently to get our animation to match up with what's passed into the UIView method.
  // We'll ask for a action to the bounds key, as we know that's a valid key. If it returns non-null then we know that UIKit is being operated on
  // within a animation block. Without this check, we're always animating. We also do this because the returned animation contains all the
  // information passed into the animation block. We're going to use this animation so we can match what the user wants. Then we'll just update
  // the needed information. We'll do this for each of our animatable properties
  if ([key isEqualToString:@"badge"]) {
    id <CAAction> action = [self.delegate actionForLayer:self forKey:@"bounds"];
    if (action && (NSNull *)action != [NSNull null]) {
      CABasicAnimation *animation = (CABasicAnimation*)action;
      animation.fromValue = [self valueForKey:@"badge"];
      animation.keyPath = @"badge";
      return animation;
    }
  } else if ([key isEqualToString:@"badgeTextColor"]) {
    id <CAAction> action = [self.delegate actionForLayer:self forKey:@"bounds"];
    if (action && (NSNull *)action != [NSNull null]) {
      CABasicAnimation *animation = (CABasicAnimation *)action;
      animation.fromValue = (id)self.badgeTextColor;
      animation.keyPath = @"badgeTextColor";
      return animation;
    }
  } else if ([key isEqualToString:@"badgeBackgroundColor"]) {
    id <CAAction> action = [self.delegate actionForLayer:self forKey:@"bounds"];
    if (action && (NSNull *)action != [NSNull null]) {
      CABasicAnimation *animation = (CABasicAnimation*)action;
      animation.fromValue = (id)self.badgeBackgroundColor;
      animation.keyPath = @"badgeBackgroundColor";
      return animation;
    }
  } else if ([key isEqualToString:@"badgeRadius"]) {
    id <CAAction> action = [self.delegate actionForLayer:self forKey:@"bounds"];
    if (action && (NSNull *)action != [NSNull null]) {
      CABasicAnimation *animation = (CABasicAnimation *)action;
      animation.fromValue = [self valueForKey:@"badgeRadius"];
      animation.keyPath = @"badgeRadius";
      return animation;
    }
  }
  
  return [super actionForKey:key];
}


#pragma mark - Drawing
- (void) drawInContext:(CGContextRef)ctx {
  [super drawInContext:ctx];
  CGRect rect = CGContextGetClipBoundingBox(ctx);

  NSString *badge = [NSString stringWithFormat:@"%@", self.badge];
  NSMutableDictionary *attributes = [[self badgeTextAttributes] mutableCopy];
  if (self.badgeTextColor)
    attributes[NSForegroundColorAttributeName] = [UIColor colorWithCGColor:self.badgeTextColor];
  
  CGSize textSize = [badge sizeWithAttributes:attributes];
  CGRect textRect = CGRectMake(CGRectGetMidX(rect) - textSize.width / 2, CGRectGetMidY(rect) - textSize.height / 2, textSize.width, textSize.height);
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.badgeRadius];
  UIGraphicsPushContext(ctx);
  [[UIColor colorWithCGColor:self.badgeBackgroundColor] setFill];
  [path fill];
  [badge drawInRect:textRect withAttributes:attributes];
  UIGraphicsPopContext();
}

#pragma mark - Accessor Overrides
- (NSDictionary *) badgeTextAttributes {
  if (!_badgeTextAttributes) {
    _badgeTextAttributes = [NSMutableDictionary dictionaryWithObject:[UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody]
                                                                                           size:6.0f]
                                                              forKey:NSFontAttributeName];
  }
  
  if (self.badgeTextColor)
    _badgeTextAttributes[NSForegroundColorAttributeName] = [UIColor colorWithCGColor:self.badgeTextColor];
  
  return [_badgeTextAttributes copy];
}

- (void) setBadgeTextAttributes:(NSDictionary *)badgeTextAttributes {
  UIColor *textColor = badgeTextAttributes[NSForegroundColorAttributeName];
  if (textColor)
    self.badgeTextColor = textColor.CGColor;
  
  NSMutableDictionary *mutableAttributes = [badgeTextAttributes mutableCopy];
  [mutableAttributes removeObjectForKey:NSForegroundColorAttributeName];
  [mutableAttributes removeObjectForKey:NSBackgroundColorAttributeName];
  _badgeTextAttributes = mutableAttributes;
}

@end
