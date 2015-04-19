//
//  CircleClickView.h
//  CircleClickView
//
//  Created by guodong on 15/4/18.
//  Copyright (c) 2015年 guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIProgressStatus)
{
    NoneFinishd = 0,
    FirstFinishd  =  1<< 0,
    SecondFinishd =  1<< 1,
    ThirdFinishd  =  1<< 2,
    ForthFinishd  =  1<< 3,
    FivthFinishd  =  1<< 4,
};


//typedef NS_OPTIONS(NSUInteger, UIViewAutoresizing) {
//    UIViewAutoresizingNone                 = 0,
//    UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
//    UIViewAutoresizingFlexibleWidth        = 1 << 1,
//    UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
//    UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
//    UIViewAutoresizingFlexibleHeight       = 1 << 4,
//    UIViewAutoresizingFlexibleBottomMargin = 1 << 5
//};


@interface CircleClickView : UIView

@property (nonatomic,strong) NSMutableArray *contentArray;

@property (nonatomic,strong) NSMutableArray *pathArray;

@property (nonatomic,strong) NSMutableArray *edgePathArray;

@property (nonatomic,assign) int clickWhich;

@property (nonatomic,assign) BOOL isClickCenter;

@property (nonatomic) UIProgressStatus status;

-(CGMutablePathRef)createPath:(CGMutablePathRef)path withAngle:(float)angle1 andAngle:(float)angle2 andCenter:(CGPoint)center andRadius:(float)radius;

-(CGMutablePathRef)createEdgePathwithAngle:(float)angle1 andAngle:(float)angle2 andCenter:(CGPoint)center andRadius:(float)radius;

typedef void (^EdgeSelectBlock)(int which);

typedef void (^CenterSelectBlock)(void);

- (id)initWithFrame:(CGRect)frame andCompletionHandler:(EdgeSelectBlock)edgeBlock andCenterBolock:(CenterSelectBlock)centerBlock;

@property (nonatomic,weak) EdgeSelectBlock edgeBlock;
@property (nonatomic,weak) CenterSelectBlock centerBlock;
@end
