#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIApplicationDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *imagePickerView;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;
@property (weak, nonatomic) IBOutlet UISwitch *bypassFilteringSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *noFancyUpsamplingSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *useThreadsSwitch;

@end
