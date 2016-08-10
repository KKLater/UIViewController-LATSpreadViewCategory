//
//  MasterViewController.m
//  UIViewControllerSpreadViewCategoryDemo
//
//  Created by Later on 16/8/10.
//  Copyright © 2016年 Later. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "UIViewController+LATSpreadViewCategory.h"

@interface MasterViewController ()
@property (strong, nonatomic) UIView *navigationSpreadView;
@property (strong, nonatomic) UIButton *titleButton;
@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    
    self.titleButton.frame = CGRectMake(0, 0, 60, 30);
    self.navigationItem.titleView = self.titleButton;
    
    self.navigationSpreadView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 100);
    self.spreadView = self.navigationSpreadView;
    
    
    //自定义背景图
    /*
     UIView *back =  [[UIView alloc] initWithFrame:self.view.bounds];
     back.backgroundColor = [UIColor redColor];
     self.spreadBackView = back;
    */
    //给背景视图添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.spreadBackView addGestureRecognizer:tapGesture];
}
- (void)tap {
    __weak typeof(self)weakSelf = self;
    [self hideSpreadViewAnimation:^{
        weakSelf.titleButton.selected = !weakSelf.isSpreadViewShow;
    } completed:^{
        NSLog(@"isShow");
    }];
}
- (void)titleButtonClick {
    __weak typeof(self)weakSelf = self;
    if (self.isSpreadViewShow) {
        [self hideSpreadViewAnimation:^{
            weakSelf.titleButton.selected = !weakSelf.isSpreadViewShow;
        } completed:^{
            NSLog(@"isHide");
        }];
    } else {
        [self showSpreadViewAnimation:^{
            weakSelf.titleButton.selected = !weakSelf.isSpreadViewShow;
        } completed:^{
            NSLog(@"isShow");
        }];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
- (UIView *)navigationSpreadView {
    if (!_navigationSpreadView) {
        _navigationSpreadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100)];
        _navigationSpreadView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
    return _navigationSpreadView;
}
- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_titleButton setTitle:@"展开" forState:UIControlStateNormal];
        [_titleButton setTitle:@"收起" forState:UIControlStateSelected];
        [_titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_titleButton addTarget:self action:@selector(titleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleButton;
}
@end
