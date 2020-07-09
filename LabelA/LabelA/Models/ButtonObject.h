//
//  ButtonObject.h
//  LabelA
//
//  
//
//

#import <UIKit/UIKit.h>

@interface ButtonObject : UIView

-(void) setButtonParameters:(float)firstX firstYPosition:(float)firstY secondXposition:(float)secondX secondYPosition:(float)secondY thirdXPosition:(float)thirdX thirdYPosition:(float)thirdY fourthXPosition:(float)fourthX fourthYPosition:(float)fourthY fifthXPosition:(float)fifthX fifthYPosition:(float)fifthY drawFifthPoint:(BOOL)shouldDrawFifthPoint buttonColor:(NSArray *)buttonColor;
-(UIBezierPath *)drawButton:(float)firstX firstYPosition:(float)firstY secondXposition:(float)secondX secondYPosition:(float)secondY thirdXPosition:(float)thirdX thirdYPosition:(float)thirdY fourthXPosition:(float)fourthX fourthYPosition:(float)fourthY fifthXPosition:(float)fifthX fifthYPosition:(float)fifthY drawFifthPoint:(BOOL)shouldDrawFifthPoint;

-(void) animateObject:(NSMutableArray *)animationValues drawFifthPoint:(BOOL)hasFifthPoint;

@property (nonatomic) float firstX;
@property (nonatomic) float firstY;

@property (nonatomic) float secondX;
@property (nonatomic) float secondY;

@property (nonatomic) float thirdX;
@property (nonatomic) float thirdY;

@property (nonatomic) float fourthX;
@property (nonatomic) float fourthY;

@property (nonatomic) float fifthX;
@property (nonatomic) float fifthY;

@end
