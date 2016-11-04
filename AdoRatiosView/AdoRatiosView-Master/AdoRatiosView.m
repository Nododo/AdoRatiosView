
#import "AdoRatiosView.h"
#import "Masonry.h"


@implementation AdoRatiosView

- (void)setButtonTitles:(NSArray<NSString *> *)buttonTitles {
    NSAssert(buttonTitles.count, @"不能少于一个~");
    _buttonTitles = buttonTitles;
    for (NSString *title in _buttonTitles) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)setButtonColors:(NSArray<UIColor *> *)buttonColors {
    NSAssert(_buttonTitles.count == buttonColors.count, @"颜色个数和颜色标题");
    _buttonColors = buttonColors;
    for (int i = 0; i < _buttonColors.count; i ++) {
        UIButton *btn = self.subviews[i];
        [btn setBackgroundColor:_buttonColors[i]];
    }
}

- (void)setButtonTitleColors:(NSArray<UIColor *> *)buttonTitleColors {
    NSAssert(_buttonTitles.count == buttonTitleColors.count, @"颜色个数和颜色标题");
    _buttonTitleColors = buttonTitleColors;
    for (int i = 0; i < _buttonTitleColors.count; i ++) {
        UIButton *btn = self.subviews[i];
        [btn setTitleColor:_buttonTitleColors[i] forState:UIControlStateNormal];
    }
}

- (void)setButtonRatios:(NSArray<NSNumber *> *)buttonRatios {
    NSAssert(_buttonTitles.count == buttonRatios.count, @"比例个数和颜色标题");
    _buttonRatios = buttonRatios;
    [self setNeedsDisplay];
}

- (void)layoutSubviews {
    if (self.subviews.count == 1) {
        UIView *v = self.subviews[0];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [super layoutSubviews];
        return;
    }
    
    if (!_buttonRatios) {
        [self.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:self.JZG_MinimumSpacing leadSpacing:0 tailSpacing:0];
    } else {
        UIView *prev;
        for (int i = 0; i < self.subviews.count; i++) {
            UIView *v = self.subviews[i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                if (prev) {
                    make.left.equalTo(prev.mas_right).offset(self.JZG_MinimumSpacing);
                    make.width.equalTo(self).multipliedBy([_buttonRatios[i] floatValue]).offset(- self.JZG_MinimumSpacing);
                    if (i == self.subviews.count - 1) {//last one
                        make.right.equalTo(self).offset(0);
                    }
                }
                else {//first one
                    make.left.equalTo(self).offset(0);
                    make.width.equalTo(self).multipliedBy([_buttonRatios[i] floatValue]);
                }
                
            }];
            prev = v;
        }
    }
    [self.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
    }];
    [super layoutSubviews];
}

- (void)setJZG_BorderWidth:(CGFloat)JZG_BorderWidth {
    _JZG_BorderWidth = JZG_BorderWidth;
    self.layer.borderWidth = _JZG_BorderWidth;
}

- (void)setJZG_MinimumSpacing:(CGFloat)JZG_MinimumSpacing {
    _JZG_MinimumSpacing = JZG_MinimumSpacing;
    [self setNeedsDisplay];
}

- (void)setJZG_BorderColor:(UIColor *)JZG_BorderColor {
    _JZG_BorderColor = JZG_BorderColor;
    self.layer.borderColor = JZG_BorderColor.CGColor;
}

- (void)btnClick:(UIButton *)btn {
    NSInteger index = [self.subviews indexOfObject:btn] + self.JZG_BeginIndex;
    if (self.hitIndexBlock) {
        self.hitIndexBlock(index);
    }
}

- (void)setJZG_ButtonFont:(UIFont *)JZG_ButtonFont {
    _JZG_ButtonFont = JZG_ButtonFont;
    for (int i = 0; i < self.subviews.count; i ++) {
        UIButton *btn = self.subviews[i];
        btn.titleLabel.font = _JZG_ButtonFont;
    }
}

- (void)replaceButtonTitle:(NSString *)buttonTitle atIndex:(NSInteger)index {
    NSAssert(index < _buttonTitles.count, @"标题个数和颜色标题");
    UIButton *btn = self.subviews[index];
    [btn setTitle:buttonTitle forState:UIControlStateNormal];
}
- (void)replaceButtonColor:(UIColor  *)buttonColor atIndex:(NSInteger)index {
    NSAssert(index < _buttonTitles.count, @"颜色个数和颜色标题");
    UIButton *btn = self.subviews[index];
    [btn setBackgroundColor:buttonColor];
}

@end
