//
//  BYLBadgeView.h
//  BYLBadgeView
//
//  Created by James Richard on 1/15/14.
//  Copyright (c) 2014 James Richard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYLBadgeView : UIView
@property (nonatomic, copy) NSString *badge;
@property (nonatomic, strong) UIColor *badgeBackgroundColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy) NSDictionary *badgeTextAttributes UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *badgeTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic) CGFloat badgeRadius UI_APPEARANCE_SELECTOR;

- (instancetype) initWithBadge:(NSString *)badge;
@end
