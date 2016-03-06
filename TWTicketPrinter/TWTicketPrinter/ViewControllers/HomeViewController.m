//
//  ViewController.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "HomeViewController.h"
#import "ReactiveCocoa.h"
#import "HomeViewModel.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *printBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSeg;
@property (weak, nonatomic) IBOutlet UITextView *resultsTextV;

@property (nonatomic, strong) HomeViewModel *viewModel;

@end

@implementation HomeViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bind];
    [self.viewModel segmentChanged:@(0)];
    
    self.resultsTextV.contentOffset = CGPointMake(0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Methods

- (void)bind {
    RAC(self.resultsTextV, text) = [RACObserve(self.viewModel,text) skip:1];

    @weakify(self);
    [[[self.typeSeg rac_signalForControlEvents:UIControlEventValueChanged]
     map:^id(id value) {
         UISegmentedControl *ctrl = value;
         return @(ctrl.selectedSegmentIndex);
     }]
     subscribeNext:^(id x) {
        @strongify(self);
         [self.viewModel segmentChanged:x];
     }];
}

#pragma mark - Getters & Setters

- (HomeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [HomeViewModel new];
    }
    return _viewModel;
}

@end
