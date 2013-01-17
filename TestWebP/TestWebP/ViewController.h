//
//  ViewController.h
//  TestWebP
//
//  Created by Carson on 1/17/13.
//  Copyright (c) 2013 Carson McDonald. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIApplicationDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate>

@property (retain, nonatomic) IBOutlet UIPickerView *imagePickerView;
@property (retain, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (retain, nonatomic) IBOutlet UIImageView *testImageView;

@end
