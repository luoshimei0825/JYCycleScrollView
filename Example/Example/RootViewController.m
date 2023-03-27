//
//  RootViewController.m
//  Example
//
//  Created by luoshimei on 2023/3/26.
//

#import "RootViewController.h"
#import "ViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Example";
    self.view.backgroundColor = [UIColor cyanColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    [button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [button setTitle:@"Push" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    button.center = self.view.center;
    button.layer.borderWidth = 0.5;
    button.layer.cornerRadius = 3.0;
    button.layer.borderColor = UIColor.redColor.CGColor;
    [self.view addSubview:button];
}

- (void)push {
    ViewController *vc = ViewController.new;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
