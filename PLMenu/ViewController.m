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

@interface ViewController ()
{
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
    
    UIButton *navRightButton= [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightButton];
    [navRightButton addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    _navBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: navRightButton];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    button.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
    button.layer.borderColor = [[UIColor blueColor] CGColor];
    button.layer.borderWidth = .5f;
    [button setTitle:@"显示菜单" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

-(void) showMenu:(UIButton *) sender
{
    PLMenu *_menu = [[PLMenu alloc] initWithDelegate:self menuItems:@[@"添加好友", @"扫一扫"] images:@[@"nav_bar_user_icon", @"nav_chat_end_relation"]];
    //[self rotateImage:ANGLE_OF_ROTATE_MENU];
    [_menu showInView: sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
