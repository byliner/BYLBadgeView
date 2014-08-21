//
//  BYLBadgeViewLayer.h
//  BYLBadgeView
//
//  Created by James Richard on 1/15/14.
//  Copyright (c) 2014 James Richard. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface BYLBadgeViewLayer : CALayer
@property (nonatomic, copy) NSString *badge;
@property (nonatomic, copy) NSDictionary *badgeTextAttributes;
@property (nonatomic) CGColorRef badgeTextColor;
@property (nonatomic) CGColorRef badgeBackgroundColor;
@property (nonatomic) CGFloat badgeRadius;
@end
