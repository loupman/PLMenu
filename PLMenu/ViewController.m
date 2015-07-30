//
//  ViewController.m
//  PLMenu
//
//  Created by Philip Lee on 15/7/28.
//  Copyright (c) 2015年 Philip Lee. All rights reserved.
//

#import "ViewController.h"
#import "PLMenu.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<PLMenuProtocol>
{
    PLMenu *_menuWithMark;
}

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    [self.view addSubview: navigationBar];
    
    UIButton *navButton= [UIButton buttonWithType:UIButtonTypeContactAdd];
    [navButton addTarget:self action:@selector(showMenu1:) forControlEvents:UIControlEventTouchUpInside];
    navButton.tag = 1001;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    
    UINavigationItem * navigationBarTitle = [[UINavigationItem alloc] initWithTitle:@"PLMenu"];
    navigationBarTitle.rightBarButtonItem = item;
    
    [navigationBar pushNavigationItem: navigationBarTitle animated:YES];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    button.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
    button.layer.borderColor = [[UIColor blueColor] CGColor];
    button.layer.borderWidth = .5f;
    [button setTitle:@"显示菜单" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1002;
    
    [self.view addSubview:button];
}

-(void) showMenu:(UIButton *) sender
{
    PLMenu *_menu = [[PLMenu alloc] initWithDelegate:self menuItems:@[@"添加好友", @"扫一扫"] images:@[@"nav_bar_user_icon", @"nav_chat_end_relation"]];
    _menu.tag = sender.tag;
    [_menu showInView: sender];
}

-(void) showMenu1:(UIButton *) sender
{
    if (!_menuWithMark) {
        _menuWithMark = [[PLMenu alloc] initWithDelegate:self menuItems:@[@"添加好友", @"扫一扫"] selectedIndex:0];
    }
    _menuWithMark.tag = sender.tag;
    [_menuWithMark showInView: sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark PLMenuProtocol

-(void) menuWillDismiss:(PLMenu *)menu
{
    NSLog(@"----------menuWillDismiss-----------tag=%ld", menu.tag);
}

- (void) didSelectRowOnIndexPath:(NSIndexPath *)indexPath withTitle:(NSString *) title
{
    NSLog(@"----------didSelectRowOnIndexPath-----------row=%ld", [indexPath row]);
}
@end
