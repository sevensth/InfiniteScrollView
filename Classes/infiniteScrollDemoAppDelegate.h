//
//  infiniteScrollDemoAppDelegate.h
//  infiniteScrollDemo
//
//  Created by ethan on 11-11-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface infiniteScrollDemoAppDelegate : NSObject <UIApplicationDelegate, UIScrollViewDelegate> {
	IBOutlet UIScrollView *scrollView;
	UIView	*article1;
	UIView	*article2;
	UIView	*article3;
	
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

