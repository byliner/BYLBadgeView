//
//  BYLBadgeView_Tests.m
//  BYLBadgeView
//
//  Created by James Richard on 1/15/14.
//  Copyright (c) 2014 James Richard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BYLBadgeView.h"
#import "BYLBadgeViewLayer.h"

@interface BYLBadgeView_Tests : XCTestCase

@end

@implementation BYLBadgeView_Tests
#pragma mark - Instantiation / Configuration
- (void) testInitWithBadge_setsBadge {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] initWithBadge:@"5"];
  XCTAssertEqual(badgeView.badge, @"5", @"Badge is not 5");
}

- (void) testLayerClass_isBadgeViewLayer {
  XCTAssertTrue([BYLBadgeView layerClass] == [BYLBadgeViewLayer class], @"Expected the layer class to be a BYLBadgeViewLayer");
}

- (void) testInit_setsLayerScaleCorrectly {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] init];
  XCTAssertEqual(badgeView.layer.contentsScale, [UIScreen mainScreen].scale, @"Layer is not scaled properly");
}

- (void) testInitWithFrame_setsLayerScaleCorrectly {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] initWithFrame:CGRectZero];
  XCTAssertEqual(badgeView.layer.contentsScale, [UIScreen mainScreen].scale, @"Layer is not scaled properly");
}

- (void) testInitWithCoder_setsLayerScaleCorrectly {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] initWithCoder:nil];
  XCTAssertEqual(badgeView.layer.contentsScale, [UIScreen mainScreen].scale, @"Layer is not scaled properly");
}

- (void) testInitWithBadge_setsLayerScaleCorrectly {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] initWithBadge:@"5"];
  XCTAssertEqual(badgeView.layer.contentsScale, [UIScreen mainScreen].scale, @"Layer is not scaled properly");
}

#pragma mark - Accessor Defaults
- (void) testBackgroundColor_defaultsToBlack {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] init];
  XCTAssertEqualObjects(badgeView.badgeBackgroundColor, [UIColor blackColor], @"Badge background color is not white");
}

- (void) testBadgeRadius_defaultsTo7 {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] init];
  XCTAssertEqual(badgeView.badgeRadius, 7.0f, @"Badge radius is not 7");
}

- (void) testBadgeTextAttributes_defaultsToBlackBodyStyle {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] init];
  NSDictionary *expected = [self defaultAttributes];
  XCTAssertEqualObjects(badgeView.badgeTextAttributes, expected, @"Badge text attributes did not match");
}

#pragma mark - Layer Forwarding
- (void) testSettingBadge_setsLayerBadge {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] init];
  badgeView.badge = @"5";
  BYLBadgeViewLayer *layer = (BYLBadgeViewLayer *)badgeView.layer;
  XCTAssertEqual(layer.badge, @"5", @"Layer did not get the badge set");
}

- (void) testSettingBadgeOnLayer_setsViewBadge {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] init];
  BYLBadgeViewLayer *layer = (BYLBadgeViewLayer *)badgeView.layer;
  layer.badge = @"5";
  XCTAssertEqual(badgeView.badge, @"5", @"Badge did not get the badge set");
}

- (void) testSettingBadgeTextAttributes_setsLayerBadgeTextAttributes {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] init];
  NSDictionary *expected = [self defaultAttributesWithTextSize:12.0f];
  badgeView.badgeTextAttributes = expected;
  BYLBadgeViewLayer *layer = (BYLBadgeViewLayer *)badgeView.layer;
  XCTAssertEqualObjects(layer.badgeTextAttributes, expected, @"Badge text attributes did not match");
}

- (void) testSettingBadgeTextAttributesOnLayer_setsViewTextAttributes {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] init];
  BYLBadgeViewLayer *layer = (BYLBadgeViewLayer *)badgeView.layer;
  NSDictionary *expected = [self defaultAttributesWithTextSize:13.0f];
  layer.badgeTextAttributes = expected;
  XCTAssertEqualObjects(badgeView.badgeTextAttributes, expected, @"Badge text attributes did not match");
}

- (void) testSettingBadgeTextColor_setsLayerBadgeTextColor {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] init];
  BYLBadgeViewLayer *layer = (BYLBadgeViewLayer *)badgeView.layer;
  badgeView.badgeTextColor = [UIColor redColor];
  XCTAssertEqualObjects([UIColor colorWithCGColor:layer.badgeTextColor], [UIColor redColor], @"Badge text color did not match");
}

- (void) testSettingBadgeTextColorOnLayer_setsViewBadgeTextColor {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] init];
  BYLBadgeViewLayer *layer = (BYLBadgeViewLayer *)badgeView.layer;
  layer.badgeTextColor = [UIColor redColor].CGColor;
  XCTAssertEqualObjects(badgeView.badgeTextColor, [UIColor redColor], @"Badge text color did not match");
}

- (void) testSettingBadgeBackgroundColor_setsLayerBadgeBackgroundColor {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] init];
  BYLBadgeViewLayer *layer = (BYLBadgeViewLayer *)badgeView.layer;
  badgeView.badgeBackgroundColor = [UIColor redColor];
  XCTAssertEqualObjects([UIColor colorWithCGColor:layer.badgeBackgroundColor], [UIColor redColor], @"Badge background color did not match");
}

- (void) testSettingBadgeBackgroundColorOnLayer_setsViewBadgeBackgroundColor {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] init];
  BYLBadgeViewLayer *layer = (BYLBadgeViewLayer *)badgeView.layer;
  layer.badgeBackgroundColor = [UIColor redColor].CGColor;
  XCTAssertEqualObjects(badgeView.badgeBackgroundColor, [UIColor redColor], @"Badge background color did not match");
}

- (void) testSettingBadgeRadius_setsLayerBadgeRadius {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] init];
  BYLBadgeViewLayer *layer = (BYLBadgeViewLayer *)badgeView.layer;
  badgeView.badgeRadius = 10.0f;
  XCTAssertEqual(layer.badgeRadius, 10.0f, @"Badge radius did not match");
}

- (void) testSettingBadgeRadiusOnLayer_setsViewBadgeRadius {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] init];
  BYLBadgeViewLayer *layer = (BYLBadgeViewLayer *)badgeView.layer;
  layer.badgeRadius = 9.0f;
  XCTAssertEqual(badgeView.badgeRadius, 9.0f, @"Badge radius did not match");
}

#pragma mark - Intrinsic Content Size
- (void) testIntrinsicContentSize_withDefaultText_isBadgeRadiusTimesTwo {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] initWithBadge:@"5"];
  CGSize expected = CGSizeMake(badgeView.badgeRadius * 2, badgeView.badgeRadius * 2);
  XCTAssertTrue(CGSizeEqualToSize(badgeView.intrinsicContentSize, expected), @"Intrinsic Content Size does not match");
}

- (void) testIntrinsicContentSize_withLargeText_fitsLargeText {
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] initWithBadge:@"55555"];
  badgeView.badgeTextAttributes = [self defaultAttributesWithTextSize:16.0f];
  CGSize textSize = [@"55555" sizeWithAttributes:badgeView.badgeTextAttributes];
  CGSize expected = CGSizeMake(textSize.width + badgeView.badgeRadius/2, textSize.height);
  XCTAssertTrue(CGSizeEqualToSize(badgeView.intrinsicContentSize, expected), @"Intrinsic Content Size does not match");
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
