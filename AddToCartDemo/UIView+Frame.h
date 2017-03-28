//
//  UIView+Frame.h
//  PerfectMall
//
//  Created by imac on 16/12/28.
//  Copyright © 2016年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign)CGPoint origin;
@property (nonatomic, assign)CGSize size;

@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat width;

@property (nonatomic, assign)CGFloat top;      //y
@property (nonatomic, assign)CGFloat left;     //x
@property (nonatomic, assign)CGFloat bottom;
@property (nonatomic, assign)CGFloat right;

@end
