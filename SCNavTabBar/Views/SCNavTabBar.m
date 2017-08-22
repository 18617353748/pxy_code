//
//  SCNavTabBar.m
//  SCNavTabBarController
//
//  Created by ShiCang on 14/11/17.
//  Copyright (c) 2014年 SCNavTabBarController. All rights reserved.
//

#import "SCNavTabBar.h"
#import "CommonMacro.h"
#import "SCPopView.h"

@interface SCNavTabBar () <SCPopViewDelegate>
{
    UIScrollView    *_navgationTabBar;      // all items on this scroll view
    UIImageView     *_arrowButton;          // arrow button
    
    UIView          *_line;                 // underscore show which item selected
    UIImageView     *_backgroundLine;
    SCPopView       *_popView;              // when item menu, will show this view
    
    NSMutableArray  *_items;                // SCNavTabBar pressed item
    NSArray         *_itemsWidth;           // an array of items' width
    BOOL            _showArrowButton;       // is showed arrow button
    BOOL            _popItemMenu;           // is needed pop item menu
    BOOL            moreItemFlag;
    CGFloat         _pj_width;
}

@end

@implementation SCNavTabBar

- (id)initWithFrame:(CGRect)frame showArrowButton:(BOOL)show
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _showArrowButton = show;
        [self initConfig];
    }
    return self;
}

#pragma mark -
#pragma mark - Private Methods

- (void)initConfig
{
    _items = [@[] mutableCopy];
    _arrowImage = [UIImage imageNamed:SCNavTabbarSourceName(@"arrow.png")];
    
    [self viewConfig];
    [self addTapGestureRecognizer];
}

- (void)viewConfig
{
    CGFloat functionButtonX = _showArrowButton ? (SCREEN_WIDTH - ARROW_BUTTON_WIDTH) : SCREEN_WIDTH;
    if (_showArrowButton)
    {
        _arrowButton = [[UIImageView alloc] initWithFrame:CGRectMake(functionButtonX, DOT_COORDINATE, ARROW_BUTTON_WIDTH, ARROW_BUTTON_WIDTH)];
        _arrowButton.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _arrowButton.image = _arrowImage;
        _arrowButton.userInteractionEnabled = YES;
        [self addSubview:_arrowButton];
        [self viewShowShadow:_arrowButton shadowRadius:20.0f shadowOpacity:20.0f];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(functionButtonPressed)];
        [_arrowButton addGestureRecognizer:tapGestureRecognizer];
    }

    _navgationTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, DOT_COORDINATE, functionButtonX, NAV_TAB_BAR_HEIGHT)];
    _navgationTabBar.showsHorizontalScrollIndicator = NO;
    [self addSubview:_navgationTabBar];
    
    //[self viewShowShadow:self shadowRadius:10.0f shadowOpacity:10.0f];
}

- (void)showLineWithButtonWidth:(CGFloat)width
{
    //修改自定义样式
    _backgroundLine = [[UIImageView alloc] initWithFrame:CGRectMake(2.0f, NAV_TAB_BAR_HEIGHT - 1.0f, (width ) * (_items.count + 2), 1.0f)];
    #pragma mark - 底部线条默认颜色
    _backgroundLine.backgroundColor = K_FONT_GRAY2_COLOR;
    _backgroundLine.alpha = 0.5;
    [_navgationTabBar addSubview:_backgroundLine];
    
    CGFloat mywidth = moreItemFlag ? (_pj_width) : (width - 4.0);
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(2.0f, NAV_TAB_BAR_HEIGHT - 2.0f, mywidth, 2.0f)];
    #pragma mark - 修改底部滚动线条颜色
    _line.backgroundColor = K_NAV_BG_COLOR;
    [_navgationTabBar addSubview:_line];
}

- (CGFloat)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths
{
    //我改的部分
    CGFloat total_length = 0.0f;
    for (int i=0; i<widths.count; i++) {
        total_length += [widths[i] floatValue];
    }
    if (total_length<=self.frame.size.width) {
        moreItemFlag = YES;
        //小于屏幕大小，平分屏幕
        CGFloat buttonX = DOT_COORDINATE;
        CGFloat pj_width = self.frame.size.width/([_itemTitles count]);
        _pj_width = pj_width;
        for (NSInteger index = 0; index < [_itemTitles count]; index++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(index * pj_width, DOT_COORDINATE, pj_width, NAV_TAB_BAR_HEIGHT);
            [button setTitle:_itemTitles[index] forState:UIControlStateNormal];
            #pragma mark - 未选中按钮颜色
            [button setTitleColor:K_FONT_BLACK2_COLOR forState:UIControlStateNormal];
            [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [_navgationTabBar addSubview:button];
#pragma mark - 选择第一个按钮颜色
            if(index == 0){
                [button setTitleColor:K_NAV_BG_COLOR forState:UIControlStateNormal];
            }
            
            [_items addObject:button];
            buttonX += [widths[index] floatValue];
        }
        
        [self showLineWithButtonWidth:pj_width];
        return buttonX;
    }else{
        CGFloat buttonX = DOT_COORDINATE;
        for (NSInteger index = 0; index < [_itemTitles count]; index++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(buttonX, DOT_COORDINATE, [widths[index] floatValue], NAV_TAB_BAR_HEIGHT);
            [button setTitle:_itemTitles[index] forState:UIControlStateNormal];
            #pragma mark - 未选中按钮颜色
            [button setTitleColor:K_FONT_BLACK2_COLOR forState:UIControlStateNormal];
            [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
             button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [_navgationTabBar addSubview:button];
            #pragma mark - 选择第一个按钮 颜色
            if(index == 0){
                [button setTitleColor:K_NAV_BG_COLOR forState:UIControlStateNormal];
            }
            
            [_items addObject:button];
            buttonX += [widths[index] floatValue];
        }
        
        [self showLineWithButtonWidth:[widths[0] floatValue]];
        return buttonX;
    }//-end 我改的部分
    
    
    
    
  }

- (void)addTapGestureRecognizer
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(functionButtonPressed)];
    [_arrowButton addGestureRecognizer:tapGestureRecognizer];
}

- (void)itemPressed:(UIButton *)button
{
    NSInteger index = [_items indexOfObject:button];
    [_delegate itemDidSelectedWithIndex:index];
}

- (void)functionButtonPressed
{
    _popItemMenu = !_popItemMenu;
    [_delegate shouldPopNavgationItemMenu:_popItemMenu height:[self popMenuHeight]];
}

- (NSArray *)getButtonsWidthWithTitles:(NSArray *)titles;
{
    NSMutableArray *widths = [@[] mutableCopy];
    
    for (NSString *title in titles)
    {
        CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
        NSNumber *width = [NSNumber numberWithFloat:size.width + 40.0f];
        [widths addObject:width];
    }
    
    return widths;
}

- (void)viewShowShadow:(UIView *)view shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity
{
    view.layer.shadowRadius = shadowRadius;
    view.layer.shadowOpacity = shadowOpacity;
}

- (CGFloat)popMenuHeight
{
    CGFloat buttonX = DOT_COORDINATE;
    CGFloat buttonY = ITEM_HEIGHT;
    CGFloat maxHeight = SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - NAV_TAB_BAR_HEIGHT;
    for (NSInteger index = 0; index < [_itemsWidth count]; index++)
    {
        buttonX += [_itemsWidth[index] floatValue];
        
        @try {
            if ((buttonX + [_itemsWidth[index + 1] floatValue]) >= SCREEN_WIDTH)
            {
                buttonX = DOT_COORDINATE;
                buttonY += ITEM_HEIGHT;
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
    buttonY = (buttonY > maxHeight) ? maxHeight : buttonY;
    return buttonY;
}

- (void)popItemMenu:(BOOL)pop
{
    if (pop)
    {
        [self viewShowShadow:_arrowButton shadowRadius:DOT_COORDINATE shadowOpacity:DOT_COORDINATE];
        [UIView animateWithDuration:0.5f animations:^{
            _navgationTabBar.hidden = YES;
            _arrowButton.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2f animations:^{
                if (!_popView)
                {
                    _popView = [[SCPopView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, self.frame.size.height - NAVIGATION_BAR_HEIGHT)];
                    _popView.delegate = self;
                    _popView.itemNames = _itemTitles;
                    [self addSubview:_popView];
                }
                _popView.hidden = NO;
            }];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5f animations:^{
            _popView.hidden = !_popView.hidden;
            _arrowButton.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            _navgationTabBar.hidden = !_navgationTabBar.hidden;
            [self viewShowShadow:_arrowButton shadowRadius:20.0f shadowOpacity:20.0f];
        }];
    }
}

#pragma mark -
#pragma mark - Public Methods
- (void)setArrowImage:(UIImage *)arrowImage
{
    _arrowImage = arrowImage ? arrowImage : _arrowImage;
    _arrowButton.image = _arrowImage;
}

- (void)setCurrentItemIndex:(NSInteger)currentItemIndex
{
    _currentItemIndex = currentItemIndex;
    UIButton *button = _items[currentItemIndex];
    CGFloat flag = _showArrowButton ? (SCREEN_WIDTH - ARROW_BUTTON_WIDTH) : SCREEN_WIDTH;
    
    if (button.frame.origin.x + button.frame.size.width > flag)
    {
        CGFloat offsetX = button.frame.origin.x + button.frame.size.width - flag;
        if (_currentItemIndex < [_itemTitles count] - 1)
        {
            offsetX = offsetX + 40.0f;
        }
        
        [_navgationTabBar setContentOffset:CGPointMake(offsetX, DOT_COORDINATE) animated:YES];
    }
    else
    {
        [_navgationTabBar setContentOffset:CGPointMake(DOT_COORDINATE, DOT_COORDINATE) animated:YES];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        CGFloat mywidth = moreItemFlag ? (_pj_width) : ([_itemsWidth[currentItemIndex] floatValue] - 4.0f);
        CGFloat myx = (currentItemIndex == (_itemsWidth.count-1)) ? (button.frame.origin.x-2) : (button.frame.origin.x + 2.0f);
        if(currentItemIndex == _items.count - 1){
            mywidth = mywidth + 20;
        }
        _line.frame = CGRectMake(myx, _line.frame.origin.y,mywidth , _line.frame.size.height);
    }];
    
#pragma mark - 修改按钮颜色
    //修改一些按钮颜色
    [button setTitleColor:K_NAV_BG_COLOR forState:UIControlStateNormal];
    for (int k = 0; k<_items.count; k++) {
        if (k!=currentItemIndex) {
            UIButton *other = _items[k];
            #pragma mark - 未选中按钮颜色
            [other setTitleColor:K_FONT_BLACK2_COLOR forState:UIControlStateNormal];
        }
    }
    
}

- (void)updateData
{
    _arrowButton.backgroundColor = self.backgroundColor;
    
    _itemsWidth = [self getButtonsWidthWithTitles:_itemTitles];
    if (_itemsWidth.count)
    {
        CGFloat contentWidth = [self contentWidthAndAddNavTabBarItemsWithButtonsWidth:_itemsWidth];
        _navgationTabBar.contentSize = CGSizeMake(contentWidth, DOT_COORDINATE);
    }
}

- (void)refresh
{
    [self popItemMenu:_popItemMenu];
}

#pragma mark - SCFunctionView Delegate Methods
#pragma mark -
- (void)itemPressedWithIndex:(NSInteger)index
{
    [self functionButtonPressed];
    [_delegate itemDidSelectedWithIndex:index];
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
