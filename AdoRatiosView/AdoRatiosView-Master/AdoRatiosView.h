
#import <UIKit/UIKit.h>

@interface AdoRatiosView : UIView
@property (nonatomic,strong) NSArray  <NSString  *> *buttonTitles;
@property (nonatomic,strong) NSArray  <UIColor   *> *buttonColors;
@property (nonatomic,strong) NSArray  <UIColor   *> *buttonTitleColors;
@property (nonatomic,strong) NSArray  <NSNumber  *> *buttonRatios;
@property (nonatomic,assign) CGFloat  JZG_BorderWidth;
@property (nonatomic,assign) CGFloat  JZG_MinimumSpacing;
@property (nonatomic,strong) UIColor  *JZG_BorderColor;
@property (nonatomic,strong) UIFont   *JZG_ButtonFont;
//为了满足一些特殊需求家的参数   把点击不同view上的的index区分开来
@property (nonatomic,assign) NSInteger   JZG_BeginIndex;
@property (nonatomic,copy)void (^hitIndexBlock)(NSInteger index);

- (void)replaceButtonTitle:(NSString *)buttonTitle atIndex:(NSInteger)index;
- (void)replaceButtonColor:(UIColor  *)buttonColor atIndex:(NSInteger)index;
@end
