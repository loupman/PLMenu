//
//  CSMenu.m
//  landlord
//
//  Created by Philip Lee on 15/5/6.
//  Copyright (c) 2015年 hky. All rights reserved.
//

#import "PLMenu.h"
#import "AppDelegate.h"

const NSInteger MENU_ITEM_HEIGHT       =  40;
const NSInteger MENU_WIDTH             =  135;
const NSInteger MENU_MAX_ITEM_NUMBER   =  6;

@implementation PLMenu {
    UITableView *menu;
    NSArray *titleItems;
    NSArray *titleImages;
    NSIndexPath *selectedIndex;
    NSIndexPath *previousSelectedIndex;
    
    UIImageView *imgViewSelectedItemCheckMark;
    UIImageView *imgViewArrow;
    
    BOOL isDisplayed;
}

- (instancetype) initWithDelegate:(id)delegate menuItems:(NSArray *)menuItems selectedIndex:(NSInteger) index{
    if (self = [self init]) {
        if (!menuItems) {
            NSLog(@"menuItems should not be nil.");
            return nil;
        }
        
        self.delegate = delegate;
        titleItems = menuItems;
        
        previousSelectedIndex = nil;
        selectedIndex = [NSIndexPath indexPathForRow:index inSection:0];
        
        [self initializer];
        [self addSubview: menu];
        [self addSubview:imgViewArrow];
        
        return self;
    }
    
    return nil;
}

- (instancetype) initWithDelegate:(id)delegate menuItems:(NSArray *)menuItems images:(NSArray *) images
{
    if (self = [self init]) {
        if (!menuItems) {
            NSLog(@"menuItems should not be nil.");
            return nil;
        }
        titleItems = menuItems;
        titleImages = images;
        self.delegate = delegate;
        
        previousSelectedIndex = nil;
        selectedIndex = nil;
        
        [self initializer];
        [self addSubview: menu];
        [self addSubview: imgViewArrow];
        
        return self;
    }
    
    return nil;
}

-(void) initializer
{
    imgViewSelectedItemCheckMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selected_icon"]];
    imgViewArrow = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"nav_menu_triangle_icon"]];
    
    self.frame = CGRectMake(0, 0, MENU_WIDTH, MENU_ITEM_HEIGHT * [titleItems count] + imgViewArrow.image.size.height - 2);
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 2;
    self.backgroundColor = [UIColor clearColor];
    self.layer.shadowColor = [[UIColor lightGrayColor] CGColor];
    self.layer.opacity = 0.5;
    self.layer.shadowRadius = 10;
    
    menu = [[UITableView alloc] initWithFrame:CGRectMake(0, imgViewArrow.image.size.height, MENU_WIDTH, MENU_ITEM_HEIGHT * [titleItems count]) style:UITableViewStyleGrouped];
    menu.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    menu.separatorColor = [UIColor darkGrayColor];
    menu.backgroundColor = [UIColor whiteColor];;
    menu.scrollEnabled = YES;
    if (titleItems && [titleItems count] >= MENU_MAX_ITEM_NUMBER) {
        menu.scrollEnabled = YES;
        menu.bounces = NO;
        menu.showsVerticalScrollIndicator = NO;
    }
    menu.delegate = self;
    menu.dataSource = self;
    menu.layer.masksToBounds = YES;
    menu.layer.cornerRadius = 2;
    
    [self initOverLayView];
}

- (void) showInView:(UIView *) view
{
    if (![view respondsToSelector:@selector(frame)]) {
        NSLog(@"This is component don't have a frame property");
        return;
    }
    CGFloat marginToRight = 8;
    CGPoint viewRelativePos = [self relativePositionToScreenWithView:view];
    
    CGRect bounds = self.bounds;
    CGFloat x = kScreenWidth - marginToRight - bounds.size.width;
    if ((kScreenWidth - viewRelativePos.x) > bounds.size.width) {
        x = viewRelativePos.x + view.bounds.size.width/2 - bounds.size.width/2;
    }
    CGFloat y = viewRelativePos.y + view.bounds.size.height + imgViewArrow.bounds.size.height;
    self.frame = CGRectMake(x, y, bounds.size.width, bounds.size.height);
    
    CGFloat arrowx = viewRelativePos.x + view.bounds.size.width/2 - x - 12/2;
    imgViewArrow.frame = CGRectMake(arrowx, 0, 12, 10.5);
    
    isDisplayed = YES;
    [self show];
}

#pragma mark table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
    }
    
    cell.textLabel.text = titleItems[[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor whiteColor];
    UIImage *bg = [[UIImage imageNamed:@"nav_top_bg"] stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    [cell setBackgroundView: [[UIImageView alloc] initWithImage: bg]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (titleImages && [titleImages count] > [indexPath row]) {
        id image = titleImages[[indexPath row]];
        if ([image isKindOfClass:UIImage.class]) {
            cell.imageView.image = image;
        } else if ([image isKindOfClass:NSString.class]) {
            cell.imageView.image = [UIImage imageNamed:image];
        }
    }
    
    if (selectedIndex && [selectedIndex row] == [indexPath row]) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selected_icon"]];
        cell.textLabel.textColor = [UIColor yellowColor];
        previousSelectedIndex = indexPath;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MENU_ITEM_HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath;
    if ([self.delegate respondsToSelector:@selector(didSelectRowOnIndexPath:withTitle:)]) {
        [self.delegate didSelectRowOnIndexPath:indexPath withTitle:titleItems[[indexPath row]]];
    }
    [self dismiss];
}

-(void) initOverLayView
{
    overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [overlayView setBackgroundColor:[UIColor clearColor]];
    [overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

- (void)show
{
    if (menu) {
        [menu reloadData];
    }
    overlayView.hidden = NO;
    self.hidden = NO;
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app.window addSubview: overlayView];
    [app.window addSubview: self];
    
    [self fadeIn];
}

- (void)fadeIn
{
    self.userInteractionEnabled = YES;
    self.transform = CGAffineTransformMakeScale(.2f, .2f);
    self.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)fadeOut
{
    self.userInteractionEnabled = NO;
    self.alpha = 1.0;
    [UIView beginAnimations:@"HideMenu" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:.45f];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDidStopSelector:@selector(removeSelf)];
    self.alpha = 0;
    [UIView commitAnimations];
}

-(void) removeSelf
{
    [overlayView removeFromSuperview];
    [self removeFromSuperview];
}

-(void) dismiss
{
    if ([_delegate respondsToSelector:@selector(menuWillDismiss:)]) {
        [_delegate menuWillDismiss: self];
    }
    isDisplayed = NO;
    
    [self fadeOut];
}


-(void)viewDidLayoutSubviews
{
    if ([menu respondsToSelector:@selector(setSeparatorInset:)]) {
        [menu setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([menu respondsToSelector:@selector(setLayoutMargins:)]) {
        [menu setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

/**
 *  计算一个view相对于屏幕(去除顶部statusbar的20像素)的坐标, iOS7及以上的UIViewController.view是默认全屏的，要把这20像素考虑进去。
 */
- (CGPoint)relativePositionToScreenWithView:(UIView *)v
{
    BOOL iOS7 = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7;
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (!iOS7) {
        screenHeight -= 20;
    }
    UIView *view = v;
    CGFloat x = .0;
    CGFloat y = .0;
    while (view.frame.size.width != screenWidth || view.frame.size.height != screenHeight) {
        x += view.frame.origin.x;
        y += view.frame.origin.y;
        view = view.superview;
        if ([view isKindOfClass:[UIScrollView class]]) {
            x -= ((UIScrollView *) view).contentOffset.x;
            y -= ((UIScrollView *) view).contentOffset.y;
        }
    }
    return CGPointMake(x, y);
}

@end
