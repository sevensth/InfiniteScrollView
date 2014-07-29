//
//  infiniteScrollDemoAppDelegate.m
//  infiniteScrollDemo
//
//  Created by ethan on 11-11-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "infiniteScrollDemoAppDelegate.h"

@implementation infiniteScrollDemoAppDelegate

@synthesize window;

#pragma mark -
#pragma mark UIScrollViewDelegate

#define SET_FRAME(ARTICLEX) x = ARTICLEX.frame.origin.x + increase;\
											if(x < 0) x = pageWidth * 2;\
											if(x > pageWidth * 2) x = 0.0f;\
											[ARTICLEX setFrame:CGRectMake(x, \
													ARTICLEX.frame.origin.y,\
													ARTICLEX.frame.size.width,\
													ARTICLEX.frame.size.height)]
//将三个view都向右移动，并更新三个指针的指向，article2永远指向当前显示的view，article1是左边的，article3是右边的
- (void)allArticlesMoveRight:(CGFloat)pageWidth {
    //上一篇
	/* 做一些文章相关的操作，这里Demo用颜色表示，就不需要了
    article3.articleIndex = article1.articleIndex - 1;
    if (article3.articleIndex < 0) {
        article3.articleIndex = [ViewSwitcher getInstance].articleCount - 1;
    }
	 */
    //[article1 reloadData]; 更新内容
    UIView *tmpView = article3;
    article3 = article2;
    article2 = article1;
    article1 = tmpView;
	
    float increase = pageWidth;
    CGFloat x = 0.0f;
    SET_FRAME(article3);
    SET_FRAME(article1);
    SET_FRAME(article2);
}
- (void)allArticlesMoveLeft:(CGFloat)pageWidth {
	/*
    article1.articleIndex = article3.articleIndex + 1;
    if (article1.articleIndex >= [ViewSwitcher getInstance].articleCount) {
        article1.articleIndex = 0;
    }
    [article3 reloadData];//[article2 resetView];[article3 resetView];
	 */
    UIView *tmpView = article1;
    article1 = article2;
    article2 = article3;
    article3 = tmpView;
	
    float increase = -pageWidth;
    CGFloat x = 0.0f;
    SET_FRAME(article2);
    SET_FRAME(article3);
    SET_FRAME(article1);
}
/*
 循环滚动
 每次滚动后都将scrollview的offset设置为中间的一页
 若本次滚动是向前一页滚动，则把三页都向后放置，最后一页放到开头
 若本次滚动是向后一页滚动，则把三页都向前放置，第一页放到末尾
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)theScrollView
{
    CGFloat pageWidth = theScrollView.frame.size.width;
    // 0 1 2
    int page = floor((theScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if(page == 1) {
        //用户拖动了，但是滚动事件没有生效
        return;
    } else if (page == 0) {
        [self allArticlesMoveRight:pageWidth];
    } else {
        [self allArticlesMoveLeft:pageWidth];
    }
    CGPoint p = CGPointZero;
    p.x = pageWidth;
    [theScrollView setContentOffset:p animated:NO];
    //[article1 resetView]; 更新内容
    //[article3 resetView]; 更新内容
}


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
	//不管多丑陋，反正就放到这里了，即使是创建个controller，我也懒得弄 - -
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*3, scrollView.frame.size.height);
    CGRect frame = scrollView.bounds;
    frame.origin.y = 0.0f;
	
    article1 = [[UIView alloc] initWithFrame:frame];
	article1.backgroundColor = [UIColor blueColor];
	
    article2 = [[UIView alloc] init];
    frame.origin.x += scrollView.frame.size.width;
    [article2 setFrame:frame];
	article2.backgroundColor = [UIColor redColor];
	
    article3 = [[UIView alloc] init];
    frame.origin.x += scrollView.frame.size.width;
    [article3 setFrame:frame];
	article3.backgroundColor = [UIColor yellowColor];
	
    [scrollView addSubview:article1];
    [scrollView addSubview:article2];
    [scrollView addSubview:article3];
	
    CGPoint p = CGPointZero;
    p.x = scrollView.frame.size.width;
    [scrollView setContentOffset:p animated:NO];
    //[article2 reloadData];
	
	
	
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
	[scrollView release];
    [super dealloc];
}


@end
