//
//  Triangle.h
//  LabelA
//
//
//  
//

#import <UIKit/UIKit.h>

@interface TriangleObject : UIView

@property float *triangleColor;
@property (nonatomic) CGFloat *triangleSize;
@property (nonatomic) CAShapeLayer *maskLayer;

-(void) setTriangleParameters:(float)firstX firstYPosition:(float)firstY secondXposition:(float)secondX secondYPosition:(float)secondY thirdXPosition:(float)thirdX thirdYPosition:(float)thirdY triangleColor:(NSArray *)triangleColor;
-(UIBezierPath *)drawTriangle:(float)firstX firstYPosition:(float)firstY secondXposition:(float)secondX secondYPosition:(float)secondY thirdXPosition:(float)thirdX thirdYPosition:(float)thirdY;
-(void) animateObject:(NSMutableArray *)animationValues;

@property (nonatomic) float firstX;
@property (nonatomic) float firstY;

@property (nonatomic) float secondX;
@property (nonatomic) float secondY;

@property (nonatomic) float thirdX;
@property (nonatomic) float thirdY;

@end
