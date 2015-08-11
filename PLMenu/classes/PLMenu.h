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
@property(nonatomic, assign) BOOL hidesArrowWhenShowMenu;
@property(nonatomic, assign) NSInteger widthOfMenu;
//@property(nonatomic, assign) BOOL shouldShowCheckMarkAfterBeingSelected;


/**
 *  This method is used to create an instance with a check mark on a selected row
 *
 *  @param delegate     A delegate which implement PLMenuProtocol
 *  @param menuItems    Menu items to show
 *  @param index        Will show a checkmark in selected index for default.
 *
 *  @return PLMenu instance
 */

- (instancetype) initWithDelegate:(id)delegate menuItems:(NSArray *)menuItems selectedIndex:(NSInteger) index;

/**
 *  This method is used to create an instance with an image on the beginning of each row
 *  You can pass parameter images as an array of images or image urls.
 *
 *  @param delegate    A delegate which implement PLMenuProtocol
 *  @param menuItems   Menu items to show
 *  @param images      Images or image urls that will be shown on each row. can be nil
 *
 *  @return PLMenu instance
 */
- (instancetype) initWithDelegate:(id)delegate menuItems:(NSArray *)menuItems images:(NSArray *) images;

- (void) showInView:(UIView *) view;
- (void) showCloseInView:(UIView *) view; // 贴近view显示，view和menu之间没有空隙
- (void) dismiss;

@end

