//
//  CircleClickView.m
//  CircleClickView
//
//  Created by guodong on 15/4/18.
//  Copyright (c) 2015年 guodong. All rights reserved.
//

#import "CircleClickView.h"
#import <QuartzCore/QuartzCore.h>
#define PI 3.14159265358979323846

@interface CircleClickView ()
{
    CGMutablePathRef grayCirclePath;

    CGMutablePathRef centerCirclePath;
}
@end



#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )

/** Radians to Degrees **/
#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

@implementation CircleClickView


- (id)initWithFrame:(CGRect)frame andCompletionHandler:(EdgeSelectBlock)edgeBlock andCenterBolock:(CenterSelectBlock)centerBlock
{
    self = [self initWithFrame:frame];
    if (self) {
        // Initialization code
        self.edgeBlock = edgeBlock;
        self.centerBlock = centerBlock;
    }
    return self;
}

-(CGMutablePathRef)createPath:(CGMutablePathRef)path withAngle:(float)angle1 andAngle:(float)angle2 andCenter:(CGPoint)center andRadius:(float)radius{
    CGPathMoveToPoint(CGPathCreateMutable(), &CGAffineTransformIdentity, center.x, center.y);
    //get a current angle. for now it's hardcoded
    
    //radius = 0.97*radius;
    //0 and 45
    angle1 = degreesToRadians(angle1);
    angle2 = degreesToRadians(angle2);
    
    CGPoint start = [self pointOnCircleWithCenter:center radius:radius andAngle:angle1];
    CGPoint end = [self pointOnCircleWithCenter:center radius:radius andAngle:angle2];
    
    CGPathMoveToPoint(path, &CGAffineTransformIdentity, center.x, center.y);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, start.x,start.y);
    CGPathAddArc(path, &CGAffineTransformIdentity, center.x, center.y, radius, angle1,angle2, false);
    
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, end.x, end.y);
    CGPathCloseSubpath(path);
    return path;
}

-(CGMutablePathRef)createEdgePathwithAngle:(float)angle1 andAngle:(float)angle2 andCenter:(CGPoint)center andRadius:(float)radius{
    CGMutablePathRef path  = CGPathCreateMutable();
    //CGPathMoveToPoint(path, &CGAffineTransformIdentity, center.x, center.y);
    //get a current angle. for now it's hardcoded
    
    //radius = 0.97*radius;
    //0 and 45
    angle1 = degreesToRadians(angle1);
    angle2 = degreesToRadians(angle2);
    
    CGPathAddArc(path, &CGAffineTransformIdentity, center.x, center.y, radius, angle1,angle2, false);
    //CGPathCloseSubpath(path);
    return path;
}

/*calculates coordinates of circle's point*/
-(CGPoint)pointOnCircleWithCenter:(CGPoint)center radius:(int)r andAngle:(float)a{
    float x = center.x + r * cos(a);
    float y = center.y + r * sin(a);
    return CGPointMake(x, y);
}

-(NSMutableArray *)contentArray
{
    if(!_contentArray)
    {
        _contentArray = [NSMutableArray array];
        //        NSDictionary *contentDic = [contentDic objectForKey:@"个人身份"];
        //        contentDic = [contentDic objectForKey:@"教育信息"];
        //
        //        [_contentArray ]
        
        NSArray *temp = @[@"个人身份",@"教育信息",@"拍照认证",@"绑定银行卡",@"联系人"];
//        NSArray *temp = @[@"个人身份",@"教育信息",@"拍照认证"];
        _contentArray = (NSMutableArray *)temp;
        
    }
    return _contentArray;
}

-(NSMutableArray *)edgePathArray
{
    if(!_edgePathArray)
    {
        _edgePathArray = [NSMutableArray array];
        for(int i = 0;i<self.contentArray.count;i++)
        {
            int blockNum = (int)self.contentArray.count;
            
            float unitAra = 360/blockNum;
            

            
            
            
//            CGMutablePathRef path =   [self createPath:CGPathCreateMutable() withAngle:i*unitAra - 90 andAngle:(i + 1 )*unitAra -90 andCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2)  andRadius:140 -2];
            
            CGMutablePathRef path = [self createEdgePathwithAngle:i*unitAra - 90 andAngle:(i + 1 )*unitAra -90 andCenter:CGPointMake(self.bounds.size.width/2,self.bounds.size.width/2) andRadius:140 - 8];
            
            //  [_pathArray addObject:(__bridge  id)path];
            
            
            
            
            // [_pathArray addObject:[UIBezierPath bezierPathWithCGPath:path]];
            NSValue *tt  = [NSValue valueWithPointer:path];
            [_edgePathArray addObject:tt];
        }
    }
    return _edgePathArray;
}


-(NSMutableArray *)pathArray
{
    

    if(!_pathArray)
    {
         _pathArray = [NSMutableArray array];
        for(int i = 0;i<self.contentArray.count;i++)
        {
            //        CGPathCreateMutable() ;
            //        CGMutablePathRef = [self createPath:CGPathCreateMutable() withAngle:i*unitAra andAngle:(i + 1 )*unitAra andCenter:self.center andRadius:self.frame.size.width/2.0];
            //        CGMutablePathRef = [self C]
            // CGMutablePathRef = [self createPath:CGPathCreateMutable() withAngle:315 andAngle:360 andCenter:center andRadius:srednica/2.0];
            int blockNum = (int )self.contentArray.count;
            
            float unitAra = 360.0/blockNum;
            
//            float width = self.bounds.size.width;
//            
//            float height = self.bounds.size.height;
            
   
            
            CGMutablePathRef path =   [self createPath:CGPathCreateMutable() withAngle:i*unitAra - 90 andAngle:(i + 1 )*unitAra -90 andCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2)  andRadius:140 -10];

          //  [_pathArray addObject:(__bridge  id)path];
            
            
            

            // [_pathArray addObject:[UIBezierPath bezierPathWithCGPath:path]];
            NSValue *tt  = [NSValue valueWithPointer:path];
            [_pathArray addObject:tt];
        }
    }
        return _pathArray;
}



- (void)drawRect:(CGRect)rect
{
    //    self.backgroundColor = [UIColor greenColor];
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    CGContextSetStrokeColorWithColor(context,[UIColor colorWithRed:(float)(170/255) green:(float)(170/255) blue:(float)(170/255) alpha:1].CGColor);
    
    CGContextSetRGBStrokeColor(context,(float)(215.0/255),(float)(215.0/255),(float)(215.0/255),1);
    
    //CGContextSetRGBStrokeColor(context,1,1,0,1);
    
    
    CGContextSetLineWidth(context,0.5);  //设置划线
    

    for(int i = 0;i<self.contentArray.count;i++)
    {
        CGContextAddPath(context, [[self.pathArray objectAtIndex:i] pointerValue]);
        
        if(self.clickWhich  > 0 && self.clickWhich == i +1)
        {
            CGContextSetRGBFillColor (context,  1, 1, 0, 1.0);//设置填充颜色
           
        }
        else
        {
           CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
        }
        CGContextDrawPath(context, kCGPathEOFillStroke); //绘制路径
       // CGContextFillPath(context);
    }
    // CGContextClosePath(context);
    
    
    grayCirclePath =  CGPathCreateMutable();
    float angle1 = degreesToRadians(0);
    float angle2 = degreesToRadians(359);
    
    
    CGPathAddArc(grayCirclePath, &CGAffineTransformIdentity, self.bounds.size.width/2, self.bounds.size.width/2, self.bounds.size.width/4,angle1,angle2, false);
    CGContextAddPath(context, grayCirclePath);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:237.0/255 green:237.0/255 blue:237.0/255 alpha:1] CGColor]);
    CGContextDrawPath(context, kCGPathEOFillStroke); //绘制路径
    
    
    
    centerCirclePath =  CGPathCreateMutable();
    
    CGPathAddArc(centerCirclePath, &CGAffineTransformIdentity, self.bounds.size.width/2, self.bounds.size.width/2, self.bounds.size.width/8 + 10,angle1,angle2, false);
    CGContextAddPath(context, centerCirclePath);
    if(self.isClickCenter)
    {
        CGContextSetRGBFillColor (context,  1, 1, 0, 1.0);//设置填充颜色
        
    }
    else
    {
        CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
        self.isClickCenter = NO;
    }
    CGContextDrawPath(context, kCGPathEOFillStroke); //绘制路径
    
    for(int i = 0;i<self.contentArray.count;i++)
    {
       int  rs =(1<<i)&(self.status);
        NSLog(@"rs:%ox",rs);
        
        if(rs >0)
        {
            CAShapeLayer *pathLayer = [CAShapeLayer layer];
            pathLayer.frame = self.bounds;
            pathLayer.path = [[self.edgePathArray objectAtIndex:i] pointerValue];
           
            if(i ==1)
            {
                pathLayer.strokeColor = [[UIColor colorWithRed:26/255.0 green:193/255.0 blue:166/255.0 alpha:1] CGColor];
            }
            else if(i == 4)
            {
                pathLayer.strokeColor = [[UIColor colorWithRed:74/255.0 green:194/255.0 blue:44/255.0 alpha:1] CGColor];
            }
            else
            {
                pathLayer.strokeColor = [[UIColor redColor] CGColor];
            }
            pathLayer.fillColor = nil;
            pathLayer.lineWidth = 4.0f;
            pathLayer.lineJoin = kCALineJoinBevel;
            
            [self.layer addSublayer:pathLayer];
            

            
            
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation.duration = 0.3;
            pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
            pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
            [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
        }
    }
    
    

    
//    pathLayer = [CAShapeLayer layer];
//    pathLayer.frame = self.bounds;
//    pathLayer.path = [[self.edgePathArray objectAtIndex:0] pointerValue];
//    pathLayer.strokeColor = [[UIColor redColor] CGColor];
//    pathLayer.fillColor = nil;
//    pathLayer.lineWidth = 4.0f;
//    pathLayer.lineJoin = kCALineJoinBevel;
//    
//    [self.layer addSublayer:pathLayer];
//    
//    
//    pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 0.3;
//    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if(CGPathContainsPoint(centerCirclePath,  &CGAffineTransformIdentity, point, YES))
    {
        self.isClickCenter = YES;
        [self setNeedsDisplay];
        return;
    }
    
    if(CGPathContainsPoint(grayCirclePath,  &CGAffineTransformIdentity, point, YES))
    {
        return;
    }
    
    
    for(int i = 0;i<self.pathArray.count;i++)
    {
    
    if(CGPathContainsPoint([[self.pathArray objectAtIndex:i] pointerValue],  &CGAffineTransformIdentity, point, YES)){
        self.clickWhich = i + 1;
        [self setNeedsDisplay];
    }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    if(CGPathContainsPoint(centerCirclePath,  &CGAffineTransformIdentity, point, YES) && self.isClickCenter == YES)
    {
        NSLog(@"respond center");
        if(_centerBlock)
        {
            _centerBlock();
        }
        [self resetData];
        return;
    }
    
    if(CGPathContainsPoint(grayCirclePath,  &CGAffineTransformIdentity, point, YES))
    {
        [self resetData];
        return;
    }
    
    
    for(int i = 0;i<self.pathArray.count;i++)
    {
        if(CGPathContainsPoint([[self.pathArray objectAtIndex:i] pointerValue],  &CGAffineTransformIdentity, point, YES)){
            if(i + 1 == self.clickWhich)
            {
                NSLog(@"responde");
                if(_edgeBlock)
                {
                    _edgeBlock(self.clickWhich);
                }
                
            }
            
        }
    }
    [self resetData];
}

-(void)resetData
{
    self.clickWhich = 0;
    self.isClickCenter = NO;
    [self setNeedsDisplay];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


//- (void)drawRect:(CGRect)rect
//{
//    self.backgroundColor = [UIColor greenColor];
//   CGContextRef context = UIGraphicsGetCurrentContext();
//// CGContextSetRGBFillColor (context,  1, 1, 1, 1.0);//设置填充颜色
//
//       CGContextClosePath(context);
//
//    CGContextSetLineWidth(context,1);  //设置划线
//   // CGContextSetRGBStrokeColor(context,1,1,1,1.0);
//    
//    CGContextSetStrokeColorWithColor(context,[UIColor colorWithRed:0 green:0 blue:1 alpha:1].CGColor);
//    
//    /*画扇形和椭圆*/
//    //画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形
//    UIColor *aColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
//    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
//    //以10为半径围绕圆心画指定角度扇形
//    CGContextMoveToPoint(context, self.bounds.size.width/2,self.bounds.size.height/2 );
//    CGContextAddArc(context, self.bounds.size.width/2, self.bounds.size.height/2, 140,  -60 * PI / 180, -120 * PI / 180, 1);
//    
//
//    
//
//    
//
//    
//    
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
//    
//    
//    aColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
//    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
//    CGContextMoveToPoint(context, self.bounds.size.width/2,self.bounds.size.height/2 );
//    CGContextAddArc(context, self.bounds.size.width/2, self.bounds.size.height/2, 80,  0 * PI / 180, 362* PI / 180, 0);
//       CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
//    
//    
////    UIBezierPath *path = [UIBezierPath bezierPath];
////    [path moveToPoint:CGPointMake(0.0,20.0)];
////    [path addLineToPoint:CGPointMake(120.0, 500.0)];
////    [path addLineToPoint:CGPointMake(220, 0)];
////    [path addLineToPoint:CGPointMake(310, 40)]; [path addLineToPoint:CGPointMake(280, 110)];
//    
////    CGContextMoveToPoint(context, self.bounds.size.width/2,self.bounds.size.height/2 );
////    CGContextAddArc(context, self.bounds.size.width/2, self.bounds.size.height/2, 140,  -60 * PI / 180, -120 * PI / 180, 1);
//
//         double TWO_M_PI = 2.0 * M_PI;
//         double startAngle = 0.75 * TWO_M_PI;
//         double endAngle = startAngle + TWO_M_PI;
//    
//    startAngle = (0) * PI / 180;
//    
//    endAngle =  (60) * PI / 180;
//    
//        CGFloat width = self.frame.size.width;
//        CGFloat borderWidth = 4;
//        UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2.0f, width/2.0f)
//                                              radius:width/2.0f
//                                          startAngle:startAngle
//                                            endAngle:endAngle
//                                           clockwise:YES];
//    
//    
//    
//
//    
//    
//    CAShapeLayer *pathLayer = [CAShapeLayer layer];
//    pathLayer.frame = self.bounds;
//      pathLayer.path = path2.CGPath;
//    pathLayer.strokeColor = [[UIColor redColor] CGColor];
//    pathLayer.fillColor = nil;
//    pathLayer.lineWidth = 2.0f;
//    pathLayer.lineJoin = kCALineJoinBevel;
//    
//    [self.layer addSublayer:pathLayer];
//    
//
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 2.0;
//    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
//
//}



 
////An opaque type that represents a Quartz 2D drawing environment.
////一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
//CGContextRef context = UIGraphicsGetCurrentContext();
//
///*写文字*/
//CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);//设置填充颜色
//UIFont  *font = [UIFont boldSystemFontOfSize:15.0];//设置
//[@"画圆：" drawInRect:CGRectMake(10, 20, 80, 20) withFont:font];
//[@"画线及孤线：" drawInRect:CGRectMake(10, 80, 100, 20) withFont:font];
//[@"画矩形：" drawInRect:CGRectMake(10, 120, 80, 20) withFont:font];
//[@"画扇形和椭圆：" drawInRect:CGRectMake(10, 160, 110, 20) withFont:font];
//[@"画三角形：" drawInRect:CGRectMake(10, 220, 80, 20) withFont:font];
//[@"画圆角矩形：" drawInRect:CGRectMake(10, 260, 100, 20) withFont:font];
//[@"画贝塞尔曲线：" drawInRect:CGRectMake(10, 300, 100, 20) withFont:font];
//[@"图片：" drawInRect:CGRectMake(10, 340, 80, 20) withFont:font];
//
///*画圆*/
////边框圆
//CGContextSetRGBStrokeColor(context,1,1,1,1.0);//画笔线的颜色
//CGContextSetLineWidth(context, 1.0);//线的宽度
////void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
//// x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
//CGContextAddArc(context, 100, 20, 15, 0, 2*PI, 0); //添加一个圆
//CGContextDrawPath(context, kCGPathStroke); //绘制路径
//
////填充圆，无边框
//CGContextAddArc(context, 150, 30, 30, 0, 2*PI, 0); //添加一个圆
//CGContextDrawPath(context, kCGPathFill);//绘制填充
//
////画大圆并填充颜
//UIColor*aColor = [UIColor colorWithRed:1 green:0.0 blue:0 alpha:1];
//CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
//CGContextSetLineWidth(context, 3.0);//线的宽度
//CGContextAddArc(context, 250, 40, 40, 0, 2*PI, 0); //添加一个圆
////kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
//CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
//
///*画线及孤线*/
////画线
//CGPoint aPoints[2];//坐标点
//aPoints[0] =CGPointMake(100, 80);//坐标1
//aPoints[1] =CGPointMake(130, 80);//坐标2
////CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
////points[]坐标数组，和count大小
//CGContextAddLines(context, aPoints, 2);//添加线
//CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
//
////画笑脸弧线
////左
//CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);//改变画笔颜色
//CGContextMoveToPoint(context, 140, 80);//开始坐标p1
////CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
////x1,y1跟p1形成一条线的坐标p2，x2,y2结束坐标跟p3形成一条线的p3,radius半径,注意, 需要算好半径的长度,
//CGContextAddArcToPoint(context, 148, 68, 156, 80, 10);
//CGContextStrokePath(context);//绘画路径
//
////右
//CGContextMoveToPoint(context, 160, 80);//开始坐标p1
////CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
////x1,y1跟p1形成一条线的坐标p2，x2,y2结束坐标跟p3形成一条线的p3,radius半径,注意, 需要算好半径的长度,
//CGContextAddArcToPoint(context, 168, 68, 176, 80, 10);
//CGContextStrokePath(context);//绘画路径
//
////右
//CGContextMoveToPoint(context, 150, 90);//开始坐标p1
////CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
////x1,y1跟p1形成一条线的坐标p2，x2,y2结束坐标跟p3形成一条线的p3,radius半径,注意, 需要算好半径的长度,
//CGContextAddArcToPoint(context, 158, 102, 166, 90, 10);
//CGContextStrokePath(context);//绘画路径
////注，如果还是没弄明白怎么回事，请参考：http://donbe.blog.163.com/blog/static/138048021201052093633776/
//
///*画矩形*/
//CGContextStrokeRect(context,CGRectMake(100, 120, 10, 10));//画方框
//CGContextFillRect(context,CGRectMake(120, 120, 10, 10));//填充框
////矩形，并填弃颜色
//CGContextSetLineWidth(context, 2.0);//线的宽度
//aColor = [UIColor blueColor];//blue蓝色
//CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
//aColor = [UIColor yellowColor];
//CGContextSetStrokeColorWithColor(context, aColor.CGColor);//线框颜色
//CGContextAddRect(context,CGRectMake(140, 120, 60, 30));//画方框
//CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
//
////矩形，并填弃渐变颜色
////关于颜色参考http://blog.sina.com.cn/s/blog_6ec3c9ce01015v3c.html
////http://blog.csdn.net/reylen/article/details/8622932
////第一种填充方式，第一种方式必须导入类库quartcore并#import <QuartzCore/QuartzCore.h>，这个就不属于在context上画，而是将层插入到view层上面。那么这里就设计到Quartz Core 图层编程了。
//CAGradientLayer *gradient1 = [CAGradientLayer layer];
//gradient1.frame = CGRectMake(240, 120, 60, 30);
//gradient1.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor,
//                    (id)[UIColor grayColor].CGColor,
//                    (id)[UIColor blackColor].CGColor,
//                    (id)[UIColor yellowColor].CGColor,
//                    (id)[UIColor blueColor].CGColor,
//                    (id)[UIColor redColor].CGColor,
//                    (id)[UIColor greenColor].CGColor,
//                    (id)[UIColor orangeColor].CGColor,
//                    (id)[UIColor brownColor].CGColor,nil];
//[self.layer insertSublayer:gradient1 atIndex:0];
////第二种填充方式
//CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
//CGFloat colors[] =
//{
//    1,1,1, 1.00,
//    1,1,0, 1.00,
//    1,0,0, 1.00,
//    1,0,1, 1.00,
//    0,1,1, 1.00,
//    0,1,0, 1.00,
//    0,0,1, 1.00,
//    0,0,0, 1.00,
//};
//CGGradientRef gradient = CGGradientCreateWithColorComponents
//(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));//形成梯形，渐变的效果
//CGColorSpaceRelease(rgb);
////画线形成一个矩形
////CGContextSaveGState与CGContextRestoreGState的作用
///*
// CGContextSaveGState函数的作用是将当前图形状态推入堆栈。之后，您对图形状态所做的修改会影响随后的描画操作，但不影响存储在堆栈中的拷贝。在修改完成后，您可以通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态。这种推入和弹出的方式是回到之前图形状态的快速方法，避免逐个撤消所有的状态修改；这也是将某些状态（比如裁剪路径）恢复到原有设置的唯一方式。
// */
//CGContextSaveGState(context);
//CGContextMoveToPoint(context, 220, 90);
//CGContextAddLineToPoint(context, 240, 90);
//CGContextAddLineToPoint(context, 240, 110);
//CGContextAddLineToPoint(context, 220, 110);
//CGContextClip(context);//context裁剪路径,后续操作的路径
////CGContextDrawLinearGradient(CGContextRef context,CGGradientRef gradient, CGPoint startPoint, CGPoint endPoint,CGGradientDrawingOptions options)
////gradient渐变颜色,startPoint开始渐变的起始位置,endPoint结束坐标,options开始坐标之前or开始之后开始渐变
//CGContextDrawLinearGradient(context, gradient,CGPointMake
//                            (220,90) ,CGPointMake(240,110),
//                            kCGGradientDrawsAfterEndLocation);
//CGContextRestoreGState(context);// 恢复到之前的context
//
////再写一个看看效果
//CGContextSaveGState(context);
//CGContextMoveToPoint(context, 260, 90);
//CGContextAddLineToPoint(context, 280, 90);
//CGContextAddLineToPoint(context, 280, 100);
//CGContextAddLineToPoint(context, 260, 100);
//CGContextClip(context);//裁剪路径
////说白了，开始坐标和结束坐标是控制渐变的方向和形状
//CGContextDrawLinearGradient(context, gradient,CGPointMake
//                            (260, 90) ,CGPointMake(260, 100),
//                            kCGGradientDrawsAfterEndLocation);
//CGContextRestoreGState(context);// 恢复到之前的context
//
////下面再看一个颜色渐变的圆
//CGContextDrawRadialGradient(context, gradient, CGPointMake(300, 100), 0.0, CGPointMake(300, 100), 10, kCGGradientDrawsBeforeStartLocation);
//
///*画扇形和椭圆*/
////画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形
//aColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
//CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
////以10为半径围绕圆心画指定角度扇形
//CGContextMoveToPoint(context, 160, 180);
//CGContextAddArc(context, 160, 180, 30,  -60 * PI / 180, -120 * PI / 180, 1);
//CGContextClosePath(context);
//CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
//
////画椭圆
//CGContextAddEllipseInRect(context, CGRectMake(160, 180, 20, 8)); //椭圆
//CGContextDrawPath(context, kCGPathFillStroke);
//
///*画三角形*/
////只要三个点就行跟画一条线方式一样，把三点连接起来
//CGPoint sPoints[3];//坐标点
//sPoints[0] =CGPointMake(100, 220);//坐标1
//sPoints[1] =CGPointMake(130, 220);//坐标2
//sPoints[2] =CGPointMake(130, 160);//坐标3
//CGContextAddLines(context, sPoints, 3);//添加线
//CGContextClosePath(context);//封起来
//CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
//
///*画圆角矩形*/
//float fw = 180;
//float fh = 280;
//
//CGContextMoveToPoint(context, fw, fh-20);  // 开始坐标右边开始
//CGContextAddArcToPoint(context, fw, fh, fw-20, fh, 10);  // 右下角角度
//CGContextAddArcToPoint(context, 120, fh, 120, fh-20, 10); // 左下角角度
//CGContextAddArcToPoint(context, 120, 250, fw-20, 250, 10); // 左上角
//CGContextAddArcToPoint(context, fw, 250, fw, fh-20, 10); // 右上角
//CGContextClosePath(context);
//CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
//
///*画贝塞尔曲线*/
////二次曲线
//CGContextMoveToPoint(context, 120, 300);//设置Path的起点
//CGContextAddQuadCurveToPoint(context,190, 310, 120, 390);//设置贝塞尔曲线的控制点坐标和终点坐标
//CGContextStrokePath(context);
////三次曲线函数
//CGContextMoveToPoint(context, 200, 300);//设置Path的起点
//CGContextAddCurveToPoint(context,250, 280, 250, 400, 280, 300);//设置贝塞尔曲线的控制点坐标和控制点坐标终点坐标
//CGContextStrokePath(context);
//
//
///*图片*/
//UIImage *image = [UIImage imageNamed:@"apple.jpg"];
//[image drawInRect:CGRectMake(60, 340, 20, 20)];//在坐标中画出图片
////    [image drawAtPoint:CGPointMake(100, 340)];//保持图片大小在point点开始画图片，可以把注释去掉看看
//CGContextDrawImage(context, CGRectMake(100, 340, 20, 20), image.CGImage);//使用这个使图片上下颠倒了，参考http://blog.csdn.net/koupoo/article/details/8670024
//
////    CGContextDrawTiledImage(context, CGRectMake(0, 0, 20, 20), image.CGImage);//平铺图
//*/



@end
