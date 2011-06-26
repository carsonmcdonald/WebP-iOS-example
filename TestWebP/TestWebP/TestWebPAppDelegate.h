//
//  TestWebPAppDelegate.h
//  TestWebP
//
// Created by Carson McDonald on 06/01/2011.
// Copyright 2011 Carson McDonald. See LICENSE file.
//

#import <UIKit/UIKit.h>

@interface TestWebPAppDelegate : NSObject <UIApplicationDelegate, UIPickerViewDataSource, UIPickerViewDelegate> 
{
    UIImageView *testImageView;
    UIPickerView *imagePickerView;
    UIScrollView *imageScrollView;
    
    NSArray *webpImages;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UIImageView *testImageView;
@property (nonatomic, retain) IBOutlet UIPickerView *imagePickerView;
@property (nonatomic, retain) IBOutlet UIScrollView *imageScrollView;

@end
