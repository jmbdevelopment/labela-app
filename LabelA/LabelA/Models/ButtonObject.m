//
//  ButtonObject.m
//  LabelA
//
//  
//
//

#import "ButtonObject.h"

@interface ButtonObject()

@property (nonatomic) CAShapeLayer *shapeLayer;

@end

static NSString * const firstPosition = @"firstPosition";
static NSString * const secondPosition = @"secondPosition";
static NSString * const thirdPosition = @"thirdPosition";

@implementation ButtonObject

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // make view transparent
        self.opaque = NO;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
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

-(void) animateObject:(NSMutableArray *)animationValues drawFifthPoint:(BOOL)hasFifthPoint
{
    NSInteger firstX=0, secondX=0, thirdX=0, firstY=0, secondY=0, thirdY=0, fourthX=0, fourthY=0, fifthX=0, fifthY=0;
    
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
    
    UIBezierPath *newPath = [self drawButton:self.firstX+firstX
                              firstYPosition:self.firstY+firstY
                             secondXposition:self.secondX+secondX
                             secondYPosition:self.secondY+secondY
                              thirdXPosition:self.thirdX+thirdX
                              thirdYPosition:self.thirdY+thirdY
                             fourthXPosition:self.fourthX+fourthX
                             fourthYPosition:self.fourthY+fourthY
                              fifthXPosition:self.fifthX+fifthX
                              fifthYPosition:self.fifthY+fifthY
                              drawFifthPoint:hasFifthPoint];
    
    
    //create a basic animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    animation.keyPath = @"path";
    
    animation.toValue = (id) [newPath CGPath];
    
    [self applyBasicAnimation:animation toLayer:self.shapeLayer];
}

-(void) setButtonParameters:(float)firstX firstYPosition:(float)firstY secondXposition:(float)secondX secondYPosition:(float)secondY thirdXPosition:(float)thirdX thirdYPosition:(float)thirdY fourthXPosition:(float)fourthX fourthYPosition:(float)fourthY fifthXPosition:(float)fifthX fifthYPosition:(float)fifthY drawFifthPoint:(BOOL)shouldDrawFifthPoint buttonColor:(NSArray *)buttonColor
{
    self.firstX = firstX;
    self.firstY = firstY;
    
    self.secondX = secondX;
    self.secondY = secondY;
    
    self.thirdX = thirdX;
    self.thirdY = thirdY;
    
    self.fourthX = fourthX;
    self.fourthY = fourthY;
    
    self.fifthX = fifthX;
    self.fifthY = fifthY;
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(0, 0, 100.0f, 100.0f);
    self.shapeLayer.path = [[self drawButton:firstX firstYPosition:firstY secondXposition:secondX secondYPosition:secondY thirdXPosition:thirdX thirdYPosition:thirdY fourthXPosition:fourthX fourthYPosition:fourthY fifthXPosition:fifthX fifthYPosition:fifthY drawFifthPoint:shouldDrawFifthPoint] CGPath];
    
    // set the color of the object
    self.shapeLayer.fillColor = [UIColor colorWithRed:[buttonColor[0] floatValue]/255.0f
                                                green:[buttonColor[1] floatValue]/255.0f
                                                 blue:[buttonColor[2] floatValue]/255.0f
                                                alpha:1.0f].CGColor;
    
    // add the stroke to the object
    [self.shapeLayer setStrokeColor:[UIColor colorWithRed:149.0f/255.0f
                                                    green:197.0f/255.0f
                                                     blue:65.0f/255.0f
                                                    alpha:1.0f].CGColor];
    
    [self.shapeLayer display];
    [self.layer addSublayer:self.shapeLayer];
}

- (UIBezierPath *) drawButton:(float)firstX firstYPosition:(float)firstY secondXposition:(float)secondX secondYPosition:(float)secondY thirdXPosition:(float)thirdX thirdYPosition:(float)thirdY fourthXPosition:(float)fourthX fourthYPosition:(float)fourthY fifthXPosition:(float)fifthX fifthYPosition:(float)fifthY drawFifthPoint:(BOOL)shouldDrawFifthPoint
{
    // depending on how many points draw different shape
    if(shouldDrawFifthPoint)
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(firstX, firstY)];
        [path addLineToPoint:CGPointMake(secondX, secondY)];
        [path addLineToPoint:CGPointMake(thirdX, thirdY)];
        [path addLineToPoint:CGPointMake(fourthX, fourthY)];
        [path addLineToPoint:CGPointMake(fifthX, fifthY)];
        [path closePath];
        
        return path;
    }else{
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(firstX, firstY)];
        [path addLineToPoint:CGPointMake(secondX, secondY)];
        [path addLineToPoint:CGPointMake(thirdX, thirdY)];
        [path addLineToPoint:CGPointMake(fourthX, fourthY)];
        [path closePath];
        
        return path;
    }
}

// function that overwrites drawRect functionality - related to CAShapeLayer objects
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
}

@end
