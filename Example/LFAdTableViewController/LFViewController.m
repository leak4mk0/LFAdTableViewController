//
//  LFViewController.m
//  LFAdTableViewController
//
//  Created by leak4mk0 on 02/01/2015.
//  Copyright (c) 2015 leak4mk0. All rights reserved.
//

#import "LFViewController.h"
#import "UITableViewController+AdView.h"

@implementation LFViewController

- (void)viewDidLoad {
    UILabel *adView;

    [super viewDidLoad];

    adView = [[UILabel alloc] init];
    [adView setBackgroundColor:[UIColor blackColor]];
    [adView setFrame:CGRectMake(0, 0, 320, 50)];
    [adView setText:@"Ad"];
    [adView setTextColor:[UIColor whiteColor]];
    [adView setTextAlignment:NSTextAlignmentCenter];
    [self setAdView:adView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch ([indexPath section]) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    [self setAdIsShown:YES];

                    break;

                case 1:
                    [self setAdIsShown:NO];

                    break;

                default:
                    break;
            }

        default:
            break;
    }
}

@end
