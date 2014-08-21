//
//  ViewController.m
//  BYLBadgeView
//
//  Created by James Richard on 1/15/14.
//  Copyright (c) 2014 James Richard. All rights reserved.
//

#import "ViewController.h"
#import "BYLBadgeView.h"
#import <QuartzCore/QuartzCore.h>
#import "BYLBadgeViewLayer.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet BYLBadgeView *badgeWithLargeText;
@property (weak, nonatomic) IBOutlet BYLBadgeView *badgeWithLargeTextAndRadius;
@property (weak, nonatomic) IBOutlet UIButton *badgedButton;
@property (weak, nonatomic) IBOutlet BYLBadgeView *animatingBadgeView;
@property (weak, nonatomic) IBOutlet BYLBadgeView *rapidlyAnimatingRadiusBadgeView;
@end

@implementation ViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.badgeWithLargeText.badgeTextAttributes = [self largeTextAttributes];
  self.badgeWithLargeTextAndRadius.badgeTextAttributes = [self largeTextAttributes];
  
  // Note that this badge has some different styling because it is using the appearance proxy defined in the AppDelegate
  BYLBadgeView *badgeView = [[BYLBadgeView alloc] initWithBadge:@"20"];
  badgeView.translatesAutoresizingMaskIntoConstraints = NO;
  badgeView.opaque = NO;
  badgeView.layer.zPosition = 10; // UIButton subviews are added later so we need to ensure this one is in front
  [self.badgedButton addSubview:badgeView];
  [self.badgedButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[badgeView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(badgeView)]];
  [self.badgedButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[badgeView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(badgeView)]];

  self.animatingBadgeView.badgeTextAttributes = [self textAttributesWithSize:14.0f];
  self.animatingBadgeView.backgroundColor = [UIColor clearColor];
  self.animatingBadgeView.badge = @"500";
  [UIView animateWithDuration:5.0f
                        delay:2.0f
                      options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionRepeat
                   animations:^{
    self.animatingBadgeView.badge = @"1000";
    self.animatingBadgeView.badgeTextColor = [UIColor blueColor];
    self.animatingBadgeView.badgeBackgroundColor = [UIColor orangeColor];
  }
                   completion:nil];
}

- (NSDictionary *) largeTextAttributes {
  return [self textAttributesWithSize:20.0f];
}

- (NSDictionary *) textAttributesWithSize:(CGFloat)size {
  return @{
           NSFontAttributeName: [UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody]
                                                      size:size],
           NSForegroundColorAttributeName: [UIColor whiteColor]
           };
}
@end
