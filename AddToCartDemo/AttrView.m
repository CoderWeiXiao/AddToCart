//
//  AttrView.m
//  AddToCartDemo
//
//  Created by a on 17/3/27.
//  Copyright © 2017年 a. All rights reserved.
//

#import "AttrView.h"

#define AttrBtnTag  100
@implementation AttrView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame andGoodAttr:(GoodsAttr *)goodsAttr{
    self=[super initWithFrame:frame];
    if (self) {
        
        _goodsAttr=goodsAttr;
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
        titleLB.text = goodsAttr.title;
        titleLB.textColor = [UIColor blackColor];
        titleLB.font = [UIFont systemFontOfSize:14];
        [self addSubview:titleLB];
        
        if (goodsAttr.attr.count==0) {
            titleLB.hidden=YES;
        }
        
        BOOL isLineReturn =NO;
        float x=10;
        float y=40;
        
        for (int i=0; i<goodsAttr.attr.count; i++) {
            
            Attr* attr=[goodsAttr.attr objectAtIndex:i];
            NSString* str=attr.attr_name;
            CGSize size=[str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
            
            if (size.width>self.width-20) {
                size.width=self.width-20;
            }
            
            if (x>(self.width-20-size.width-40)) {
                isLineReturn=YES;
                x=10;
                y+=30;
            }
            
            UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(x,y,size.width+30,25);
            [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitle:str forState:0];
            btn.layer.cornerRadius = 8;
            btn.layer.borderColor = [UIColor clearColor].CGColor;
            btn.layer.borderWidth = 0;
            [btn.layer setMasksToBounds:YES];
            
            [self addSubview:btn];
            btn.tag =i+AttrBtnTag;
            [btn addTarget:self action:@selector(touchbtn:) forControlEvents:UIControlEventTouchUpInside];
            x+=size.width+35;
        }
        
        y+=30;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, y+10, self.width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        if (goodsAttr.attr.count==0) {
            line.hidden=YES;
        }
        
        self.height=y+=11;
    }
    return self;
}

-(void)touchbtn:(UIButton *)btn
{
    
    if (!self.selectedBtn) {
        btn.selected=YES;
        btn.backgroundColor=[UIColor redColor];
        self.selectedBtn=btn;
    }else if (self.selectedBtn==btn){
        btn.selected=NO;
        btn.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        self.selectedBtn=nil;
    }else{
        self.selectedBtn.selected=NO;
        self.selectedBtn.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        
        btn.selected=YES;
        btn.backgroundColor=[UIColor redColor];
        self.selectedBtn=btn;
    }
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(clickAttrViewBtn)]) {
         [self.delegate clickAttrViewBtn];
    }
}



@end
