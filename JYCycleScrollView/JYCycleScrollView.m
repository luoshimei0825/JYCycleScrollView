//
//  JYCycleScrollView.h
//  JYCycleScrollView
//
//  Created by luoshimei on 2023/3/27.
//

#import "JYCycleScrollView.h"

#define JYIndexFlag 9999

@interface JYProxy : NSProxy
@property (nonatomic, weak) id target;
+ (instancetype)proxyWithTarget:(id)target;
@end

@implementation JYProxy

+ (instancetype)proxyWithTarget:(id)target {
    JYProxy *proxy = [JYProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end

@interface JYCycleScrollView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation JYCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _currentIndex = 1;
        
        _imageNamesArray = [NSMutableArray array];
        
        [self addScrollView];
        [self setupTimer];
        [self addPageControlView];
    }
    return self;
}

- (void)setImageNamesArray:(NSMutableArray<NSString *> *)imageNamesArray {
    _imageNamesArray = imageNamesArray;
    
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    [self addImageViewToScrollView];
}

- (void)addScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width * (self.imageNamesArray.count + 2), self.bounds.size.height);
    _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    [self addSubview:_scrollView];
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior =  UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)setupTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:[JYProxy proxyWithTarget:self] selector:@selector(autoScroll) userInfo:nil repeats:YES];
}

- (void)addImageViewToScrollView {
    UIButton *firstView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [firstView setBackgroundImage:[UIImage imageNamed:_imageNamesArray.lastObject] forState:UIControlStateNormal];
    firstView.adjustsImageWhenHighlighted = NO;
    firstView.tag = JYIndexFlag + _imageNamesArray.count;
    [firstView addTarget:self action:@selector(imageViewButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:firstView];

    for (NSInteger i = 1; i <= _imageNamesArray.count; i++) {
        UIButton *imageView = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width * i, 0, self.bounds.size.width, self.bounds.size.height)];
        imageView.adjustsImageWhenHighlighted = NO;
        [imageView setBackgroundImage:[UIImage imageNamed:_imageNamesArray[i - 1]] forState:UIControlStateNormal];
        imageView.tag = JYIndexFlag + i;
        [imageView addTarget:self action:@selector(imageViewButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:imageView];
    }

    UIButton *lastView = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width * (_imageNamesArray.count + 1), 0, self.bounds.size.width, self.bounds.size.height)];
    lastView.adjustsImageWhenHighlighted = NO;
    [lastView setBackgroundImage:[UIImage imageNamed:_imageNamesArray.firstObject] forState:UIControlStateNormal];
    lastView.tag = JYIndexFlag + 0;
    [lastView addTarget:self action:@selector(imageViewButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:lastView];
    
    self.pageControl.numberOfPages = _imageNamesArray.count;
    self.scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * (self.imageNamesArray.count + 2), self.bounds.size.height);
}

- (void)imageViewButtonHandler:(UIButton *)sender {
    NSUInteger index = sender.tag - JYIndexFlag - 1;
    if (self.tapEventBlock) {
        self.tapEventBlock(index);
    }
}

- (void)addPageControlView {
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 50, self.bounds.size.width, 50)];
    self.pageControl.numberOfPages = _imageNamesArray.count;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.userInteractionEnabled = NO;
    [self addSubview:self.pageControl];
}

- (void)autoScroll {
    NSInteger index = self.pageControl.currentPage + 1;
    CGPoint offset = CGPointMake((1 + index) * self.bounds.size.width, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)resumeTimer {
    if (![_timer isValid]) {
        return ;
    }

    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3.0 - 0.25]];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == self.bounds.size.width * (_imageNamesArray.count + 1)) {
        [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
    } else if(scrollView.contentOffset.x == 0) {
        [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width * (_imageNamesArray.count), 0) animated:NO];
    }

    self.pageControl.currentPage = (self.scrollView.contentOffset.x + self.bounds.size.width * 0.5) / self.bounds.size.width - 1;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setupTimer];
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"%s", __FUNCTION__);
}

@end
