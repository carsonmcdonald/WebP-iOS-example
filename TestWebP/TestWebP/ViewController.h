#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIApplicationDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate>

@property (retain, nonatomic) IBOutlet UIPickerView *imagePickerView;
@property (retain, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (retain, nonatomic) IBOutlet UIImageView *testImageView;

@end
