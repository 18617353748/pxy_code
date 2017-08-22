//
//  LGIntroductionViewController.m
//
//  Created by square on 15/1/21.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import "ZWIntroductionViewController.h"

@interface ZWIntroductionViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *backgroundViews;
@property (nonatomic, strong) NSArray *scrollViewPages;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger centerPageIndex;

@end

@implementation ZWIntroductionViewController

- (void)dealloc
{
    self.view = nil;
}

- (id)initWithCoverImageNames:(NSArray *)coverNames
{
    if (self = [super init]) {
        [self initSelfWithCoverNames:coverNames backgroundImageNames:nil];
    }
    return self;
}

- (id)initWithCoverImageNames:(NSArray *)coverNames backgroundImageNames:(NSArray *)bgNames
{
    if (self = [super init]) {
        [self initSelfWithCoverNames:coverNames backgroundImageNames:bgNames];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (id)initWithCoverImageNames:(NSArray *)coverNames backgroundImageNames:(NSArray *)bgNames button:(UIButton *)button
{
    if (self = [super init]) {
        [self initSelfWithCoverNames:coverNames backgroundImageNames:bgNames];
        self.enterButton = button;
    }
    return self;
}

- (void)initSelfWithCoverNames:(NSArray *)coverNames backgroundImageNames:(NSArray *)bgNames
{
    self.coverImageNames = coverNames;
    self.backgroundImageNames = bgNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackgroundViews];
    
    self.pagingScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.pagingScrollView.delegate = self;
    self.pagingScrollView.pagingEnabled = YES;
    self.pagingScrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.pagingScrollView];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:[self frameOfPageControl]];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    //[self.view addSubview:self.pageControl];
    #pragma mark  出口触发事件
    if (!self.enterButton) {
        self.enterButton = [UIButton new];
        //[self.enterButton setTitle:NSLocalizedString(@"Enter", nil) forState:UIControlStateNormal];
        //self.enterButton.layer.borderWidth = 0.5;
        //self.enterButton.layer.borderColor = [UIColor whiteColor].CGColor;
        
        //self.enterButton.backgroundColor = [UIColor blackColor];
    }
    
    [self.enterButton addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];
    self.enterButton.frame = [self frameOfEnterButton];
    self.enterButton.alpha = 0;
    [self.view addSubview:self.enterButton];
    
    //self.enterButton.backgroundColor = K_VIEW_BG_COLOR;
    
    //添加跳过按钮
    [self.view addSubview: self.tiaoGuoButton];
    
    
    [self reloadPages];
}

- (void)addBackgroundViews
{
    CGRect frame = self.view.bounds;
    NSMutableArray *tmpArray = [NSMutableArray new];
    [[[[self backgroundImageNames] reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:obj]];
        imageView.frame = frame;
        imageView.tag = idx + 1;
        [tmpArray addObject:imageView];
        [self.view addSubview:imageView];
    }];

    self.backgroundViews = [[tmpArray reverseObjectEnumerator] allObjects];
}

- (void)reloadPages
{
    self.pageControl.numberOfPages = [[self coverImageNames] count];
    self.pagingScrollView.contentSize = [self contentSizeOfScrollView];
    
    __block CGFloat x = 0;
    [[self scrollViewPages] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        obj.frame = CGRectOffset(obj.frame, x, 0);
        [self.pagingScrollView addSubview:obj];
        
        x += obj.frame.size.width;
    }];

    // fix enterButton can not presenting if ScrollView have only one page
    if (self.pageControl.numberOfPages == 1) {
        self.enterButton.alpha = 1;
        self.pageControl.alpha = 0;
    }
    
    // fix ScrollView can not scrolling if it have only one page
    if (self.pagingScrollView.contentSize.width == self.pagingScrollView.frame.size.width) {
        self.pagingScrollView.contentSize = CGSizeMake(self.pagingScrollView.contentSize.width + 1, self.pagingScrollView.contentSize.height);
    }
}

- (CGRect)frameOfPageControl
{
    return CGRectMake(0, self.view.bounds.size.height - 30, self.view.bounds.size.width, 30);
}
#pragma mark - 自定义点击按钮 大小
- (CGRect)frameOfEnterButton
{
//    CGSize size = self.enterButton.bounds.size;
//    if (CGSizeEqualToSize(size, CGSizeZero)) {
//        size = CGSizeMake(self.view.frame.size.width * 0.6, 40);
//    }
//    return CGRectMake(self.view.frame.size.width / 2 - size.width / 2, self.pageControl.frame.origin.y - size.height, size.width, size.height);
    
    
    
    return CGRectMake(0,K_HEIGHT-110, K_WIDTH, 110);
    
    
    
    CGFloat height = K_MAIN_SCREEN.size.height;
    if (height>=736) { // 6s
        return  CGRectMake((K_WIDTH - 186.66) * 0.5, K_HEIGHT - 196.66  , 186.66, 40);
    }else if(height>=667){//6
        return  CGRectMake((K_WIDTH-180) * 0.5, K_HEIGHT - 180  , 134, 40);
    }else if(height>=568){//5,5s 640 X 1136
        return  CGRectMake((K_WIDTH-120) * 0.5, K_HEIGHT - 130  , 120, 35);
    }else{// 4, 4s 640 X 960
        return CGRectMake((K_WIDTH - 120) * 0.5 , K_HEIGHT - 110, 120, 30);
    }
    return CGRectZero;
    
}

-(UIButton *)tiaoGuoButton{//右边底部按钮
    if (!_tiaoGuoButton) {
        _tiaoGuoButton = [[UIButton alloc] initWithFrame:CGRectMake(K_WIDTH - 15-40, K_HEIGHT - 10-20, 40, 25)];
        
        CGFloat height = K_MAIN_SCREEN.size.height;
        CGRect frame;
        if (height>=736) { // 6s
            frame =  CGRectMake(K_WIDTH - 15-50, K_HEIGHT - 10-20, 50, 25);
        }else if(height>=667){//6
            frame =  CGRectMake(K_WIDTH - 15-40, K_HEIGHT - 10-20, 40, 25);
        }else if(height>=568){//5,5s 640 X 1136
            frame =  CGRectMake(K_WIDTH - 15-40, K_HEIGHT - 10-20, 40, 25);
        }else{// 4, 4s 640 X 960
            frame =  CGRectMake(K_WIDTH - 15-40, K_HEIGHT - 10-20, 40, 25);
        }
        
        _tiaoGuoButton.frame = CGRectMake(0, 0, K_WIDTH, 150);
        [_tiaoGuoButton addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];
        //_tiaoGuoButton.backgroundColor = [UIColor blackColor];
    }
    
    return _tiaoGuoButton;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / self.view.frame.size.width;
    CGFloat alpha = 1 - ((scrollView.contentOffset.x - index * self.view.frame.size.width) / self.view.frame.size.width);
    
    if ([self.backgroundViews count] > index) {
        UIView *v = [self.backgroundViews objectAtIndex:index];
        if (v) {
            [v setAlpha:alpha];
        }
    }
    
    self.pageControl.currentPage = scrollView.contentOffset.x / (scrollView.contentSize.width / [self numberOfPagesInPagingScrollView]);
    
    [self pagingScrollViewDidChangePages:scrollView];
}
#pragma mark - 出口触发事件
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
        if (![self hasNext:self.pageControl]) {
            //[self enter:nil];
        }
    }
}

#pragma mark - UIScrollView & UIPageControl DataSource

- (BOOL)hasNext:(UIPageControl*)pageControl
{
    return pageControl.numberOfPages > pageControl.currentPage + 1;
}

- (BOOL)isLast:(UIPageControl*)pageControl
{
    return pageControl.numberOfPages == pageControl.currentPage + 1;
}

- (NSInteger)numberOfPagesInPagingScrollView
{
    return [[self coverImageNames] count];
}

- (void)pagingScrollViewDidChangePages:(UIScrollView *)pagingScrollView
{
    if ([self isLast:self.pageControl]) {
        if (self.pageControl.alpha == 1) {
            self.enterButton.alpha = 0;
            
            [UIView animateWithDuration:0.4 animations:^{
                self.enterButton.alpha = 1;
                self.pageControl.alpha = 0;
            }];
        }
    } else {
        if (self.pageControl.alpha == 0) {
            [UIView animateWithDuration:0.4 animations:^{
                self.enterButton.alpha = 0;
                self.pageControl.alpha = 1;
            }];
        }
    }
    
    //处理跳过按钮
    if ([self isLast:self.pageControl]) {//最后一张
        _tiaoGuoButton.hidden = YES;
    }else{
        _tiaoGuoButton.hidden = NO;
    }
    
}

- (BOOL)hasEnterButtonInView:(UIView*)page
{
    __block BOOL result = NO;
    [page.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj && obj == self.enterButton) {
            result = YES;
        }
    }];
    return result;
}

- (UIImageView*)scrollViewPage:(NSString*)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    CGSize size = {[[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height};
    imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, size.width, size.height);
    return imageView;
}

- (NSArray*)scrollViewPages
{
    if ([self numberOfPagesInPagingScrollView] == 0) {
        return nil;
    }
    
    if (_scrollViewPages) {
        return _scrollViewPages;
    }
    
    NSMutableArray *tmpArray = [NSMutableArray new];
    [self.coverImageNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIImageView *v = [self scrollViewPage:obj];
        [tmpArray addObject:v];
        
    }];
    
    _scrollViewPages = tmpArray;
    
    return _scrollViewPages;
}

- (CGSize)contentSizeOfScrollView
{
    UIView *view = [[self scrollViewPages] firstObject];
    return CGSizeMake(view.frame.size.width * self.scrollViewPages.count, view.frame.size.height);
}

#pragma mark - Action

- (void)enter:(id)object
{
    if (self.didSelectedEnter) {
        self.didSelectedEnter();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
