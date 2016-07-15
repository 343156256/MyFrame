//
//  ButtonsViewController.m
//  FSCalendar
//
//  Created by dingwenchao on 4/15/16.
//  Copyright © 2016 wenchaoios. All rights reserved.
//

#import "ButtonsViewController.h"

@interface ButtonsViewController ()

@end

@implementation ButtonsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"日历";
        [self.view setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.3]];
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
    
    // 450 for iPad and 300 for iPhone
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, (ScreenH-height)*0.5, view.frame.size.width, height)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.appearance.headerMinimumDissolvedAlpha = 0;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.frame = CGRectMake(0, (ScreenH-height)*0.5+5, 95, 34);
    previousButton.backgroundColor = [UIColor whiteColor];
    previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [previousButton setImage:[UIImage imageNamed:@"icon_prev"] forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previousButton];
    self.previousButton = previousButton;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)-95, (ScreenH-height)*0.5+5, 95, 34);
    nextButton.backgroundColor = [UIColor whiteColor];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    self.nextButton = nextButton;
    
}

- (void)previousClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.calendar dateBySubstractingMonths:1 fromDate:currentMonth];
    [self.calendar setCurrentPage:previousMonth animated:YES];
}

- (void)nextClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.calendar dateByAddingMonths:1 toDate:currentMonth];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}

#pragma mark - <FSCalendarDelegate>

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    NSLog(@"%s %@", __FUNCTION__, [calendar stringFromDate:date format:@"yyyy/MM/dd"]);
}

@end
