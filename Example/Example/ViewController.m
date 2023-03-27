//
//  ViewController.m
//  Example
//
//  Created by luoshimei on 2023/3/27.
//

#import "ViewController.h"
#import <JYCycleScrollView/JYCycleScrollView.h>

@interface ViewController ()
@property (nonatomic, strong) JYCycleScrollView *cycleScrollView;
@property (nonatomic, assign) BOOL isTianjia;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"CycleScrollView";
    JYCycleScrollView *cycleScrollView = [[JYCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    cycleScrollView.imageNamesArray = @[@"1.jpeg", @"2.jpeg", @"3.jpeg", @"4.jpeg", @"5.jpeg"].mutableCopy;
    cycleScrollView.center = self.view.center;
    cycleScrollView.tapEventBlock = ^(NSUInteger index) {
        NSLog(@"index:%zd", index);
    };
    self.cycleScrollView = cycleScrollView;
    [self.view addSubview:cycleScrollView];
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

@end
