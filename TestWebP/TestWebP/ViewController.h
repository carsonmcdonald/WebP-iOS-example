#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIApplicationDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *imagePickerView;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

@end
