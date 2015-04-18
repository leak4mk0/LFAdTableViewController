//
//  UITableViewController+AdView.m
//  LFAdTableViewController
//
//  Created by leak4mk0 on 02/01/2015.
//  Copyright (c) 2015 leak4mk0. All rights reserved.
//

#import "UITableViewController+AdView.h"

#import "objc/runtime.h"

@implementation UITableViewController (AdView)

+ (void)load {
    Method viewDidLayoutSubviewsMethod;
    Method viewDidLayoutSubviewsWithAdViewMethod;

    viewDidLayoutSubviewsMethod = class_getInstanceMethod(
            [self class],
            @selector(viewDidLayoutSubviews)
    );
    viewDidLayoutSubviewsWithAdViewMethod = class_getInstanceMethod(
            [self class],
            @selector(viewDidLayoutSubviewsWithAdView)
    );
    if (class_addMethod(
            [self class],
            @selector(viewDidLayoutSubviews),
            method_getImplementation(viewDidLayoutSubviewsWithAdViewMethod),
            method_getTypeEncoding(viewDidLayoutSubviewsWithAdViewMethod)
    )) {
        class_replaceMethod(
                [self class],
                @selector(viewDidLayoutSubviewsWithAdView),
                method_getImplementation(viewDidLayoutSubviewsMethod),
                method_getTypeEncoding(viewDidLayoutSubviewsMethod)
        );
    } else {
        method_exchangeImplementations(
                viewDidLayoutSubviewsMethod,
                viewDidLayoutSubviewsWithAdViewMethod
        );
    }
}

#pragma clang diagnostic push
#pragma ide diagnostic ignored "InfiniteRecursion"
- (void)viewDidLayoutSubviewsWithAdView {
    [self viewDidLayoutSubviewsWithAdView];

    if ([self adView]) {
        if ([self adIsShown] && ![[self searchDisplayController] isActive]) {
            CGPoint point;

            if (![self adWasShown]) {
                UIEdgeInsets insets;

                insets = [[self tableView] contentInset];
                insets.bottom += [[self adView] frame].size.height;
                [[self tableView] setContentInset:insets];

                insets = [[self tableView] scrollIndicatorInsets];
                insets.bottom += [[self adView] frame].size.height;
                [[self tableView] setScrollIndicatorInsets:insets];

                [[self tableView] addSubview:[self adView]];

                [self setAdWasShown:YES];
            }

            point.x = [[self tableView] frame].size.width / 2;
            point.y = [[self tableView] frame].size.height
                    + [[self tableView] contentOffset].y
                    - [[self tableView] contentInset].bottom
                    + [[self adView] frame].size.height / 2;
            [[self adView] setCenter:point];
            [[self tableView] bringSubviewToFront:[self adView]];
        } else {
            CGPoint point;

            point.x = [[self tableView] frame].size.width / 2;
            point.y = [[self tableView] frame].size.height * 2;
            [[self adView] setCenter:point];
            [[self tableView] sendSubviewToBack:[self adView]];

            if ([self adWasShown]) {
                UIEdgeInsets insets;

                insets = [[self tableView] contentInset];
                insets.bottom -= [[self adView] frame].size.height;
                [[self tableView] setContentInset:insets];

                insets = [[self tableView] scrollIndicatorInsets];
                insets.bottom -= [[self adView] frame].size.height;
                [[self tableView] setScrollIndicatorInsets:insets];

                [[self adView] removeFromSuperview];

                [self setAdWasShown:NO];
            }
        }
    }
}
#pragma clang diagnostic pop

- (UIView *)adView {
    return objc_getAssociatedObject(self, @"adView");
}

- (void)setAdView:(UIView *)adView {
    objc_setAssociatedObject(self, @"adView", adView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    [[self tableView] setNeedsLayout];
    [[self tableView] layoutIfNeeded];
}

- (BOOL)adIsShown {
    return [objc_getAssociatedObject(self, @"adIsShown") boolValue];
}

- (void)setAdIsShown:(BOOL)adIsShown {
    objc_setAssociatedObject(self, @"adIsShown", @(adIsShown), OBJC_ASSOCIATION_COPY_NONATOMIC);

    [[self tableView] setNeedsLayout];
    [[self tableView] layoutIfNeeded];
}

- (BOOL)adWasShown {
    return [objc_getAssociatedObject(self, @"adWasShown") boolValue];
}

- (void)setAdWasShown:(BOOL)adWasShown {
    objc_setAssociatedObject(self, @"adWasShown", @(adWasShown), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
