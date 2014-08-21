//
//  BYLBadgeViewLayer_Tests.m
//  BYLBadgeView
//
//  Created by James Richard on 1/15/14.
//  Copyright (c) 2014 James Richard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BYLBadgeViewLayer.h"

@interface BYLLayerDelegate : NSObject
@property (nonatomic) BOOL returnsAction;
@end

@implementation BYLLayerDelegate
- (id <CAAction>) actionForLayer:(CALayer *)layer forKey:(NSString *)event {
  return self.returnsAction ? [CABasicAnimation animationWithKeyPath:event] : [NSNull null];
}
@end

@interface BYLBadgeViewLayer_Tests : XCTestCase

@end

@implementation BYLBadgeViewLayer_Tests
#pragma mark - Making a new layer
- (void) testInitWithLayer_copiesBadge {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  badgeLayer.badge = @"20";
  BYLBadgeViewLayer *copiedLayer = [[BYLBadgeViewLayer alloc] initWithLayer:badgeLayer];
  XCTAssertEqual(copiedLayer.badge, @"20", @"Copied layer did not copy the badge");
}

- (void) testInitWithLayer_copiesBadgeRadius {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  badgeLayer.badgeRadius = 30.0f;
  BYLBadgeViewLayer *copiedLayer = [[BYLBadgeViewLayer alloc] initWithLayer:badgeLayer];
  XCTAssertEqual(copiedLayer.badgeRadius, 30.0f, @"Copied layer did not copy the badge radius");
}

- (void) testInitWithLayer_copiesTextAttributes {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  NSDictionary *expected = [self defaultAttributesWithTextSize:16.0f];
  badgeLayer.badgeTextAttributes = expected;
  BYLBadgeViewLayer *copiedLayer = [[BYLBadgeViewLayer alloc] initWithLayer:badgeLayer];
  XCTAssertEqualObjects(copiedLayer.badgeTextAttributes, expected, @"Copied layer did not copy text attributes");
}

- (void) testInit_defaultsBadgeTextColorToWhite {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  XCTAssertEqualObjects([UIColor colorWithCGColor:badgeLayer.badgeTextColor], [UIColor whiteColor], @"Initial badge text color is not white");
}

- (void) testInitWithCoder_defaultsBadgeTextColorToWhite {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] initWithCoder:nil];
  XCTAssertEqualObjects([UIColor colorWithCGColor:badgeLayer.badgeTextColor], [UIColor whiteColor], @"Initial badge text color is not white");
}

#pragma mark - Redisplaying
- (void) testNeedsDisplay_forBadge_isTrue {
  XCTAssertTrue([BYLBadgeViewLayer needsDisplayForKey:@"badge"], @"Badge should require redisplay");
}

- (void) testNeedsDisplay_forBadgeTextAttributes_isTrue {
  XCTAssertTrue([BYLBadgeViewLayer needsDisplayForKey:@"badgeTextAttributes"], @"Badge Text Attributes should require redisplay");
}

- (void) testNeedsDisplay_forBadgeTextColor_isTrue {
  XCTAssertTrue([BYLBadgeViewLayer needsDisplayForKey:@"badgeTextColor"], @"Badge Text Color should require redisplay");
}

- (void) testNeedsDisplay_forBadgeBackgroundColor_isTrue {
  XCTAssertTrue([BYLBadgeViewLayer needsDisplayForKey:@"badgeBackgroundColor"], @"Badge Background Color should require redisplay");
}

- (void) testNeedsDisplay_forBadgeRadius_isTrue {
  XCTAssertTrue([BYLBadgeViewLayer needsDisplayForKey:@"badgeRadius"], @"Badge Radius should require redisplay");
}

- (void) testNeedsDisplayForBoundsChange_isTrue {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  XCTAssertTrue([badgeLayer needsDisplayOnBoundsChange], @"Badge should be redrawn when bounds changed");
}

#pragma mark - Implicit Animations
- (void) testActionForKey_badge_withNullDelegateResponse_isNull {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  BYLLayerDelegate *delegate = [[BYLLayerDelegate alloc] init];
  badgeLayer.delegate = delegate;
  XCTAssertEqualObjects([badgeLayer actionForKey:@"badge"], nil, @"Expected there not be an animation for property");
}

- (void) testActionForKey_badge_withAnimationDelegateResponse_isProperAnimation {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  badgeLayer.badge = @"50";
  BYLLayerDelegate *delegate = [[BYLLayerDelegate alloc] init];
  delegate.returnsAction = YES;
  badgeLayer.delegate = delegate;
  CABasicAnimation *expectedAnimation = [CABasicAnimation animationWithKeyPath:@"badge"];
  expectedAnimation.fromValue = @"50";
  CABasicAnimation *animation = (CABasicAnimation*)[badgeLayer actionForKey:@"badge"];
  XCTAssertEqualObjects(animation.fromValue, expectedAnimation.fromValue, @"Animations from values do not match");
  XCTAssertEqualObjects(animation.keyPath, expectedAnimation.keyPath, @"Animations keyPath values do not match");
}

- (void) testActionForKey_badgeRadius_withNullDelegateResponse_isNull {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  BYLLayerDelegate *delegate = [[BYLLayerDelegate alloc] init];
  badgeLayer.delegate = delegate;
  XCTAssertEqualObjects([badgeLayer actionForKey:@"badgeRadius"], nil, @"Expected there not be an animation for property");
}

- (void) testActionForKey_badgeRadius_withAnimationDelegateResponse_isProperAnimation {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  badgeLayer.badgeRadius = 5.0f;
  BYLLayerDelegate *delegate = [[BYLLayerDelegate alloc] init];
  delegate.returnsAction = YES;
  badgeLayer.delegate = delegate;
  CABasicAnimation *expectedAnimation = [CABasicAnimation animationWithKeyPath:@"badgeRadius"];
  expectedAnimation.fromValue = @5.0f;
  CABasicAnimation *animation = (CABasicAnimation*)[badgeLayer actionForKey:@"badgeRadius"];
  XCTAssertEqualObjects(animation.fromValue, expectedAnimation.fromValue, @"Animations from values do not match");
  XCTAssertEqualObjects(animation.keyPath, expectedAnimation.keyPath, @"Animations keyPath values do not match");
}

- (void) testActionForKey_badgeTextColor_withNullDelegateResponse_isNull {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  BYLLayerDelegate *delegate = [[BYLLayerDelegate alloc] init];
  badgeLayer.delegate = delegate;
  XCTAssertEqualObjects([badgeLayer actionForKey:@"badgeTextColor"], nil, @"Expected there not be an animation for property");
}

- (void) testActionForKey_badgeTextColor_withAnimationDelegateResponse_isProperAnimation {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  badgeLayer.badgeTextColor = [UIColor blueColor].CGColor;
  BYLLayerDelegate *delegate = [[BYLLayerDelegate alloc] init];
  delegate.returnsAction = YES;
  badgeLayer.delegate = delegate;
  CABasicAnimation *expectedAnimation = [CABasicAnimation animationWithKeyPath:@"badgeTextColor"];
  expectedAnimation.fromValue = (id)[UIColor blueColor].CGColor;
  CABasicAnimation *animation = (CABasicAnimation*)[badgeLayer actionForKey:@"badgeTextColor"];
  XCTAssertEqualObjects([UIColor colorWithCGColor:(CGColorRef)animation.fromValue], [UIColor colorWithCGColor:(CGColorRef)expectedAnimation.fromValue], @"Animations from values do not match");
  XCTAssertEqualObjects(animation.keyPath, expectedAnimation.keyPath, @"Animations keyPath values do not match");
}

- (void) testActionForKey_badgeBackgroundColor_withNullDelegateResponse_isNull {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  BYLLayerDelegate *delegate = [[BYLLayerDelegate alloc] init];
  badgeLayer.delegate = delegate;
  XCTAssertEqualObjects([badgeLayer actionForKey:@"badgeBackgroundColor"], nil, @"Expected there not be an animation for property");
}

- (void) testActionForKey_badgeBackgroundColor_withAnimationDelegateResponse_isProperAnimation {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  badgeLayer.badgeBackgroundColor = [UIColor blueColor].CGColor;
  BYLLayerDelegate *delegate = [[BYLLayerDelegate alloc] init];
  delegate.returnsAction = YES;
  badgeLayer.delegate = delegate;
  CABasicAnimation *expectedAnimation = [CABasicAnimation animationWithKeyPath:@"badgeBackgroundColor"];
  expectedAnimation.fromValue = (id)[UIColor blueColor].CGColor;
  CABasicAnimation *animation = (CABasicAnimation*)[badgeLayer actionForKey:@"badgeBackgroundColor"];
  XCTAssertEqualObjects([UIColor colorWithCGColor:(CGColorRef)animation.fromValue], [UIColor colorWithCGColor:(CGColorRef)expectedAnimation.fromValue], @"Animations from values do not match");
  XCTAssertEqualObjects(animation.keyPath, expectedAnimation.keyPath, @"Animations keyPath values do not match");
}

#pragma mark - Accessors
- (void) testBadgeTextAttributes_defaultsToBlackBodyStyle {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  NSDictionary *expected = [self defaultAttributes];
  XCTAssertEqualObjects(badgeLayer.badgeTextAttributes, expected, @"Badge text attributes did not match");
}

- (void) testSetBadgeTextColor_updatesAttributesDictionary {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  NSMutableDictionary *expected = [[self defaultAttributes] mutableCopy];
  expected[NSForegroundColorAttributeName] = [UIColor redColor];
  badgeLayer.badgeTextColor = [UIColor redColor].CGColor;
  XCTAssertEqualObjects(badgeLayer.badgeTextAttributes, expected, @"Badge text did not update");
}

- (void) testBadgeTextColor_usesAttributesDictioanry {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  UIColor *expected = [self defaultAttributes][NSForegroundColorAttributeName];
  XCTAssertEqualObjects([UIColor colorWithCGColor:badgeLayer.badgeTextColor], expected, @"Badge text did not use attributes dictionary");
}

- (void) testSettingBadgeTextAttributes_updatesBadgeTextColor {
  BYLBadgeViewLayer *badgeLayer = [[BYLBadgeViewLayer alloc] init];
  NSDictionary *attributes =  @{
                                NSFontAttributeName: [UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody] size:12.0],
                                NSForegroundColorAttributeName: [UIColor redColor]
                                };
  badgeLayer.badgeTextAttributes = attributes;
  XCTAssertEqualObjects(attributes[NSForegroundColorAttributeName], [UIColor colorWithCGColor:badgeLayer.badgeTextColor], @"Badge Text Color was not updated");
}

#pragma mark - Test Helpers
- (NSDictionary *) defaultAttributes {
  return [self defaultAttributesWithTextSize:6.0f];
}

- (NSDictionary *) defaultAttributesWithTextSize:(CGFloat)size {
  return @{
           NSFontAttributeName: [UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody] size:size],
           NSForegroundColorAttributeName: [UIColor whiteColor]
           };
}

@end
