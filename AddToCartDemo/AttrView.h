//
//  AttrView.h
//  AddToCartDemo
//
//  Created by a on 17/3/27.
//  Copyright © 2017年 a. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsAttr.h"
#import "Attr.h"
#import "UIView+Frame.h"
@class AttrView;

@protocol AttrViewClickBtnDelegate <NSObject>
@optional
-(void)clickAttrViewBtn;
@end

@interface AttrView : UIView
@property(nonatomic,strong)UIButton* selectedBtn;
@property(nonatomic,strong)GoodsAttr* goodsAttr;
@property(nonatomic,weak)id<AttrViewClickBtnDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame andGoodAttr:(GoodsAttr*)goodsAttr;

@end
