//
//  TasksViewController.m
//  Everyday
//
//  Created by Eluss on 04/06/15.
//  Copyright (c) 2015 __eSAWProducts__. All rights reserved.
//


#import "TasksViewController.h"
#import "ALView+PureLayout.h"
#import "TasksDataSource.h"


@interface TasksViewController ()

@end

@implementation TasksViewController {
    TasksDataSource *_source;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupView {
    self.view.backgroundColor = [UIColor redColor];
    UITableView *tasksTableView = [UITableView new];
    [tasksTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"taskCell"];

    tasksTableView.delegate = self;
    _source = [TasksDataSource new];
    tasksTableView.dataSource = _source;

    [self.view addSubview:tasksTableView];
    [tasksTableView autoPinEdgesToSuperviewEdgesWithInsets:ALEdgeInsetsZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end