//
//  Triangle.m
//  LabelA
//
//
//  
//

#import "TriangleObject.h"
#import <QuartzCore/QuartzCore.h>
#import "PointObject.h"

@interface TriangleObject ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic) CFTimeInterval firstTimestamp;
@property (nonatomic) CFTimeInterval displayLinkTimestamp;
@property (nonatomic) NSUInteger loopCount;
@property (nonatomic) CAShapeLayer *shapeLayer;

@end

static NSString * const firstPosition = @"firstPosition";
static NSString * const secondPosition = @"secondPosition";
static NSString * const thirdPosition = @"thirdPosition";

//static CGFloat const kSeconds = 20.25;

@implementation TriangleObject

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // make view transparent
        self.opaque = NO;
        
      //[self startDisplayLink];
        //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
        //[self addGestureRecognizer:tap];
    }
    return self;
}



-(void) viewTapped:(UITapGestureRecognizer *)sender
{
    //[self animateObject:arc4random() % 30 secondRandomNumber:0 thirdRandomNumber:0 xIdentifier:@"" yIdentifier:@""];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

}

-(void) setTriangleParameters:(float)firstX firstYPosition:(float)firstY secondXposition:(float)secondX secondYPosition:(float)secondY thirdXPosition:(float)thirdX thirdYPosition:(float)thirdY triangleColor:(NSArray *)triangleColor
{
    self.firstX = firstX;
    self.firstY = firstY;
    
    self.secondX = secondX;
    self.secondY = secondY;
    
    self.thirdX = thirdX;
    self.thirdY = thirdY;
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(0, 0, 100.0f, 100.0f);
    self.shapeLayer.path = [[self drawTriangle:firstX firstYPosition:firstY secondXposition:secondX secondYPosition:secondY thirdXPosition:thirdX thirdYPosition:thirdY] CGPath];
    //self.shapeLayer.fillColor = [UIColor greenColor].CGColor;
    
    self.shapeLayer.fillColor = [UIColor colorWithRed:[triangleColor[0] floatValue]/255.0f
                                                green:[triangleColor[1] floatValue]/255.0f
                                                 blue:[triangleColor[2] floatValue]/255.0f
                                                alpha:[triangleColor[3] floatValue]].CGColor;
    
    [self.shapeLayer setStrokeColor:[UIColor colorWithRed:149.0f/255.0f
                                                    green:197.0f/255.0f
                                                     blue:65.0f/255.0f
                                                    alpha:1.0f].CGColor];
    
    [self.shapeLayer display];
    [self.layer addSublayer:self.shapeLayer];
}

// function that overwrites drawRect functionality - related to CAShapeLayer objects
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
}

- (UIBezierPath *) drawTriangle:(float)firstX firstYPosition:(float)firstY secondXposition:(float)secondX secondYPosition:(float)secondY thirdXPosition:(float)thirdX thirdYPosition:(float)thirdY
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(firstX, firstY)];
    [path addLineToPoint:CGPointMake(secondX, secondY)];
    [path addLineToPoint:CGPointMake(thirdX, thirdY)];
    [path closePath];
    
    return path;
}

- (void)applyBasicAnimation:(CABasicAnimation *)animation toLayer:(CAShapeLayer *)layer
{
    //set the from value (using presentation layer if available)
    animation.fromValue = [layer.presentationLayer ?: layer valueForKeyPath:animation.keyPath];
    //update the property in advance
    //note: this approach will only work if toValue != nil
    [CATransaction setAnimationDuration:4];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setAnimationTimingFunction:
     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [layer setValue:animation.toValue forKeyPath:animation.keyPath];
    [CATransaction commit];
    //apply animation to layer
    [layer addAnimation:animation forKey:nil];
}

-(void) animateObject:(NSMutableArray *)animationValues
{
    NSInteger firstX=0, secondX=0, thirdX=0, firstY=0, secondY=0, thirdY=0;
    
    for(int i=0;i<[animationValues count];i++)
    {
        if (animationValues[i][0] == firstPosition) {
            firstX = [animationValues[i][1] intValue];
            firstY = [animationValues[i][1] intValue];
        } else if (animationValues[i][0] == secondPosition) {
            secondX = [animationValues[i][1] intValue];
            secondY = [animationValues[i][1] intValue];
        } else if (animationValues[i][0] == thirdPosition){
            thirdX = [animationValues[i][1] intValue];
            thirdY = [animationValues[i][1] intValue];
        }
    }
    
    //UIBezierPath *newPath = [self drawTriangle:40 firstYPosition:300 secondXposition:70 secondYPosition:200 thirdXPosition:100 thirdYPosition:220];
    UIBezierPath *newPath = [self drawTriangle:self.firstX+firstX
                                firstYPosition:self.firstY+firstY
                               secondXposition:self.secondX+secondX
                               secondYPosition:self.secondY+secondY
                                thirdXPosition:self.thirdX+thirdX
                                thirdYPosition:self.thirdY+thirdY];
    //BOOL result = value ? YES : NO;
    
    
    
    //commit the transaction
    //[CATransaction commit];
    
    //UIColor *color = [UIColor colorWithRed:149.0f/255.0f
    //                                 green:120.0f/255.0f
    //                                  blue:40.0f/255.0f
    //                                 alpha:1.0];
    
    //create a basic animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    //animation.keyPath = @"fillColor";
    //animation.toValue = (__bridge id)color.CGColor;
    
    animation.keyPath = @"path";
    
    animation.toValue = (id) [newPath CGPath];
    
    [self applyBasicAnimation:animation toLayer:self.shapeLayer];
    
    //apply animation to layer
    //[self.shapeLayer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"finished.");
}

@end
