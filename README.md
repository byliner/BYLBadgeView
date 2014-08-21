# BYLBadgeView [![Build Status](https://travis-ci.org/scondoo/BYLBadgeView.png?branch=master)](https://travis-ci.org/scondoo/BYLBadgeView)
A badge view using TextKit APIs for rendering the badge that supports animations and UIAppearance.

## Requirements

BYLBadgeView requires iOS7+.

## Installation

Using cocoapods:

```ruby
pod 'BYLBadgeView', :git => 'https://github.com/scondoo/BYLBadgeView.git'
```

To use without cocoapods copy the files under the Sources directory into your project.

## Usage

To use instantate the view and add it as a subview to the view you'd like to be placed within. The badge view calculates an intrinsict content size, and I recommend just adding enough constraints to position it where you'd like. Here's how to add it to a button and place it in the top-right corner of the button:

```objc
BYLBadgeView *badgeView = [[BYLBadgeView alloc] initWithBadge:@"20"];
badgeView.translatesAutoresizingMaskIntoConstraints = NO;
badgeView.opaque = NO;
badgeView.layer.zPosition = 10; // UIButton subviews are added later so we need to ensure this one is in front
[self.badgedButton addSubview:badgeView]; // Created from IB
[self.badgedButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[badgeView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(badgeView)]];
[self.badgedButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[badgeView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(badgeView)]];
```

### Setting Badge Text Color

You can set the badge text color with both the badgeTextColor property or by setting the NSForegroundColorAttributeName key in the badgeTextAttributes. The badgeTextColor property exists to allow implicit animations. More on [animations below](#animations).

## UIAppearance

The BYLBadgeView supports the UIAppearance proxy for badgeRadius, badgeTextAttributes, badgeBackgroundColor, and badgeTextColor. Here's an example applying style to all badges contained within a UIButton:

```objc
[[BYLBadgeView appearanceWhenContainedIn:[UIButton class], nil] setBadgeBackgroundColor:[UIColor redColor]];
[[BYLBadgeView appearanceWhenContainedIn:[UIButton class], nil] setBadgeTextColor:[UIColor purpleColor]];
[[BYLBadgeView appearanceWhenContainedIn:[UIButton class], nil] setBadgeRadius:10.0f];
NSDictionary *titleAttributes = @{NSFontAttributeName: [UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleSubheadline] size:8.0f]};
[[BYLBadgeView appearanceWhenContainedIn:[UIButton class], nil] setBadgeTextAttributes:titleAttributes];
```

## Animations

The BYLBadgeView supports implicit animations on the badgeTextColor, badgeBackgroundColor, and badgeRadius properties. Here's an example:

```objc
self.animatingBadgeView.badge = @"500"; // self.animatingBadgeView was previously instantated
[UIView animateWithDuration:5.0f delay:0.0f options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionRepeat animations:^{
  self.animatingBadgeView.badgeTextColor = [UIColor blueColor];
  self.animatingBadgeView.badgeBackgroundColor = [UIColor orangeColor];
} completion:nil];
```

## Caveats

-[NSString drawInRect:withAttributes:] behaves oddly with the NSBackgroundColorAttributeName key set on the textAttributes dictionary. Because of that, if that key exists in the badgeTextAttributes dictionary it will be removed when set. 
