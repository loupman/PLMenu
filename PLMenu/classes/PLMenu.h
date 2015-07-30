//
//  CSMenu.h
//  landlord
//
//  Created by Philip Lee on 15/5/6.
//  Copyright (c) 2015年 hky. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@class PLMenu;

@protocol PLMenuProtocol <NSObject>

@optional
-(void) menuWillDismiss:(PLMenu *)menu;

@required
- (void) didSelectRowOnIndexPath:(NSIndexPath *)indexPath withTitle:(NSString *) title;

@end

@interface PLMenu : UIView <UITableViewDataSource, UITableViewDelegate> {
    UIControl *overlayView;
}

@property(nonatomic, assign) id<PLMenuProtocol> delegate;

- (instancetype) initWithDelegate:(id)del menuItems:(NSArray *)menuItems selectedItem:(NSString *) selectedItem;
- (instancetype) initWithDelegate:(id)del menuItems:(NSArray *)menuItems images:(NSArray *) images;

- (void) showInView:(UIView *) view;

- (void) dismiss;

@end

