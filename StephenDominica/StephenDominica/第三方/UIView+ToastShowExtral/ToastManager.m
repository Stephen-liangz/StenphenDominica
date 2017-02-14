//
//  ToastManager.m
//  ToastDemo
//
//  Created by YiJianJun on 14-7-24.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import "ToastManager.h"

@interface ToastManager (){
    NSTimer *_showTimer;
}

@end
@implementation ToastManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    _settings = [ToastSettings defaultToastSettings];
}

+ (instancetype)toastManager{
    return [[self alloc] init];
}

#pragma mark - Toast Methods

- (void)makeToast:(NSString *)message {
    [self makeToast:message duration:_settings.toastDefaultDuration position:_settings.toastDefaultPosition];
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(Toast_Position)position {
    [self makeToast:message duration:duration position:position title:nil];
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(Toast_Position)position title:(NSString *)title {
    [self makeToast:message duration:duration position:position title:title image:nil];
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(Toast_Position)position image:(UIImage *)image {
    [self makeToast:message duration:duration position:position title:nil image:image];
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration  position:(Toast_Position)position title:(NSString *)title image:(UIImage *)image {
    UIView *toast = [self viewForMessage:message title:title image:image];
    [self showToast:toast duration:duration position:position];
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval centerPoint:(CGPoint)centerPoint{
    [self makeToast:message duration:interval centerPoint:centerPoint title:nil];
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval centerPoint:(CGPoint)centerPoint image:(UIImage *)image{
    [self makeToast:message duration:interval centerPoint:centerPoint title:nil image:image];
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval centerPoint:(CGPoint)centerPoint title:(NSString *)title{
    [self makeToast:message duration:interval centerPoint:centerPoint title:title image:nil];
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval centerPoint:(CGPoint)centerPoint title:(NSString *)title image:(UIImage *)image{
    UIView *toast = [self viewForMessage:message title:title image:image];
    [self showToast:toast duration:interval centerPoint:centerPoint];
}

- (void)showToast:(UIView *)toast {
    [self showToast:toast duration:_settings.toastDefaultDuration position:_settings.toastDefaultPosition];
}

- (void)showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(Toast_Position)point {
    _toastPosition = point;
    [self showToast:toast duration:duration centerPoint:[self centerPointForPosition:point withToast:toast]];
}

- (void)showToast:(UIView *)toast duration:(NSTimeInterval)duration centerPoint:(CGPoint)centerPoint{
    _showCenterPoint = centerPoint;
    _toastView = toast;
    toast.center = _showCenterPoint;
    toast.alpha = 0.0;
    
    if (_settings.toastHidesOnTap && /* DISABLES CODE */ (NO)) {
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleToastTapped:)];
        [toast addGestureRecognizer:recognizer];
        toast.userInteractionEnabled = YES;
        toast.exclusiveTouch = YES;
    }
    
    if(!_showInView || ![_showInView isKindOfClass:[UIView class]]){
        _showInView = [[UIApplication sharedApplication] windows][0];
    }
    
    [_showInView addSubview:toast];
    
    [UIView animateWithDuration:_settings.toastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         if(_showTimer){
                             if([_showTimer isValid]){
                                 [_showTimer invalidate];
                             }
                             _showTimer = nil;
                         }
                         if(duration > 0){
                             _showTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(toastTimerDidFinish:) userInfo:toast repeats:NO];
                         }
                         // associate the timer with the toast view
                         //                         objc_setAssociatedObject (toast, &toastTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                     }];
}

- (void)hideToast{
    if(_toastView){
        [self hideToast:_toastView];
    }
}

- (void)hideToast:(UIView *)toast {
    if(!toast){
        return;
    }
    if(_toastIsHiding || _toastHidden){
        return;
    }
    
    _toastIsHiding = YES;
    [UIView animateWithDuration:_settings.toastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         _toastHidden = YES;
                         toast.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [toast removeFromSuperview];
                     }];
}

#pragma mark - Events

- (void)toastTimerDidFinish:(NSTimer *)timer {
    [self hideToast:(UIView *)timer.userInfo];
}

- (void)handleToastTapped:(UITapGestureRecognizer *)recognizer {
//    NSTimer *timer = (NSTimer *)objc_getAssociatedObject(self, &toastTimerKey);
    if(_showTimer){
        if([_showTimer isValid]){
            [_showTimer invalidate];
        }
    }
    
    __weak id tapView = recognizer.view;
    if(tapView){
        [self hideToast:tapView];
    }
}

#pragma mark - Toast Activity Methods

- (void)makeToastActivity {
    [self makeToastActivity:_settings.toastActivityDefaultPosition];
}

- (void)makeToastActivity:(Toast_Position)position {
    // sanity
//    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &toastActivityViewKey);
    if (_toastView){
        [_toastView removeFromSuperview];
        _toastView = nil;
    }
    
    UIView *activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _settings.toastActivityWidth, _settings.toastActivityHeight)];
    activityView.center = [self centerPointForPosition:position withToast:activityView];
    activityView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:_settings.toastOpacity];
    activityView.alpha = 0.0;
    activityView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    activityView.layer.cornerRadius = _settings.toastCornerRadius;
    
    if (_settings.toastDisplayShadow) {
        activityView.layer.shadowColor = [UIColor blackColor].CGColor;
        activityView.layer.shadowOpacity = _settings.toastShadowOpacity;
        activityView.layer.shadowRadius = _settings.toastShadowRadius;
        activityView.layer.shadowOffset = _settings.toastShadowOffset;
    }
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.center = CGPointMake(activityView.bounds.size.width / 2, activityView.bounds.size.height / 2);
    [activityView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    // associate the activity view with self
//    objc_setAssociatedObject (self, &toastActivityViewKey, activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    _toastView = activityView;
    
    if(!_showInView || ![_showInView isKindOfClass:[UIView class]]){
        _showInView = [[UIApplication sharedApplication] windows][0];
    }
    
    [_showInView addSubview:_toastView];
    
    [UIView animateWithDuration:_settings.toastFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _toastView.alpha = 1.0;
                     } completion:nil];
}

- (void)hideToastActivity {
    //UIView *existingActivityView = _toastView;//(UIView *)objc_getAssociatedObject(self, &toastActivityViewKey);
    if (_toastView) {
        [UIView animateWithDuration:_settings.toastFadeDuration
                              delay:0.0
                            options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             _toastView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             if([_toastView gestureRecognizers].count){
                                 [_toastView removeGestureRecognizer:[_toastView gestureRecognizers][0]];
                             }
                             [_toastView removeFromSuperview];
                             _toastView = nil;
                             //objc_setAssociatedObject (self, &toastActivityViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         }];
    }
}

#pragma mark - Helpers

- (CGPoint)centerPointForPosition:(Toast_Position)point withToast:(UIView *)toast {
    CGPoint center;
    
    if(!_showInView || ![_showInView isKindOfClass:[UIView class]]){
        _showInView = [[UIApplication sharedApplication] windows][0];
    }
    
    switch(point) {
        // convert string literals @"top", @"bottom", @"center", or any point wrapped in an NSValue object into a CGPoint
        case Toast_Position_Top:
            center = CGPointMake(_showInView.bounds.size.width/2, (toast.frame.size.height / 2) + _settings.toastVerticalPadding);
            break;
        case Toast_Position_Bottom:
            center = CGPointMake(_showInView.bounds.size.width/2, (_showInView.bounds.size.height - (toast.frame.size.height / 2)) - _settings.toastVerticalPadding - 20);
            break;
        case Toast_Position_Center:
            center = CGPointMake(_showInView.bounds.size.width / 2, _showInView.bounds.size.height / 2);
            break;
        default:
            center = [self centerPointForPosition:_settings.toastDefaultPosition withToast:toast];
    }
    
    return center;
    
//    } else if ([point isKindOfClass:[NSValue class]]) {
//        return [point CGPointValue];
//    }
//    
//    NSLog(@"Warning: Invalid position for toast.");
//    return [self centerPointForPosition:_settings.toastDefaultPosition withToast:toast];
}

- (CGSize)sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
        CGRect boundingRect = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    }
    
    return [string sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
}

- (UIView *)viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    // sanity
    if((message == nil) && (title == nil) && (image == nil)) return nil;
    
    // dynamically build a toast view with any combination of message, title, & image.
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    // create the parent view
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = _settings.toastCornerRadius;
    
    if (_settings.toastDisplayShadow) {
        wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
        wrapperView.layer.shadowOpacity = _settings.toastShadowOpacity;
        wrapperView.layer.shadowRadius = _settings.toastShadowRadius;
        wrapperView.layer.shadowOffset = _settings.toastShadowOffset;
    }
    
    wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:_settings.toastOpacity];
    
    if(image != nil) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(_settings.toastHorizontalPadding, _settings.toastVerticalPadding, _settings.toastImageViewWidth, _settings.toastImageViewHeight);
    }
    
    CGFloat imageWidth, imageHeight, imageLeft;
    
    // the imageView frame values will be used to size & position the other views
    if(imageView != nil) {
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = _settings.toastHorizontalPadding;
    } else {
        imageWidth = imageHeight = imageLeft = 0.0;
    }
    
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = _settings.toastMaxTitleLines;
        titleLabel.font = [UIFont boldSystemFontOfSize:_settings.toastFontSize];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        // size the title label according to the length of the text
        CGSize maxSizeTitle = CGSizeMake((_showInView.bounds.size.width * _settings.toastMaxWidth) - imageWidth, _showInView.bounds.size.height * _settings.toastMaxHeight);
        CGSize expectedSizeTitle = [self sizeForString:title font:titleLabel.font constrainedToSize:maxSizeTitle lineBreakMode:titleLabel.lineBreakMode];
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = _settings.toastMaxMessageLines;
        messageLabel.font = [UIFont systemFontOfSize:_settings.toastFontSize];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        // size the message label according to the length of the text
        CGSize maxSizeMessage = CGSizeMake((_showInView.bounds.size.width * _settings.toastMaxWidth) - imageWidth, _showInView.bounds.size.height * _settings.toastMaxHeight);
        CGSize expectedSizeMessage = [self sizeForString:message font:messageLabel.font constrainedToSize:maxSizeMessage lineBreakMode:messageLabel.lineBreakMode];
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    // titleLabel frame values
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    if(titleLabel != nil) {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = _settings.toastVerticalPadding;
        titleLeft = imageLeft + imageWidth + _settings.toastHorizontalPadding;
    } else {
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    
    // messageLabel frame values
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;
    
    if(messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = imageLeft + imageWidth + _settings.toastHorizontalPadding;
        messageTop = titleTop + titleHeight + _settings.toastVerticalPadding;
    } else {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }
    
    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    
    // wrapper width uses the longerWidth or the image width, whatever is larger. same logic applies to the wrapper height
    CGFloat wrapperWidth = MAX((imageWidth + (_settings.toastHorizontalPadding * 2)), (longerLeft + longerWidth + _settings.toastHorizontalPadding));
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + _settings.toastVerticalPadding), (imageHeight + (_settings.toastVerticalPadding * 2)));
    
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if(titleLabel != nil) {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        [wrapperView addSubview:titleLabel];
    }
    
    if(messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    if(imageView != nil) {
        [wrapperView addSubview:imageView];
    }
    
    _toastView = wrapperView;
    return wrapperView;
}

@end

@implementation ToastSettings

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (void)setupDefaults{
    // general appearance
    _toastMaxWidth            = 0.8;      // 80% of parent view width
    _toastMaxHeight           = 0.8;      // 80% of parent view height
    _toastHorizontalPadding   = 10.0;
    _toastVerticalPadding     = 10.0;
    _toastCornerRadius        = 10.0;
    _toastOpacity             = 0.8;
    _toastFontSize            = 16.0;
    _toastMaxTitleLines       = 0;
    _toastMaxMessageLines     = 0;
    _toastFadeDuration = 0.2;
    
    // shadow appearance
    _toastShadowOpacity       = 0.8;
    _toastShadowRadius        = 6.0;
    _toastShadowOffset        = CGSizeMake(4.0, 4.0);
    _toastDisplayShadow       = YES;
    
    // display duration and position
    _toastDefaultPosition  = Toast_Position_Center;//@"bottom";
    _toastDefaultDuration  = 3.0;
    
    // image view size
    _toastImageViewWidth      = 80.0;
    _toastImageViewHeight     = 80.0;
    
    // activity
    _toastActivityWidth       = 100.0;
    _toastActivityHeight      = 100.0;
    _toastActivityDefaultPosition = Toast_Position_Center;
    
    // interaction
    _toastHidesOnTap             = YES;     // excludes activity views
}

+ (instancetype)defaultToastSettings{
    return [[self alloc] init];
}
@end