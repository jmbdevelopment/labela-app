//
//  ViewController.m
//  LabelA
//
//  
//
//

static NSString * const kBeaconUUID = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D";
// Blue Beacon Info
static NSString * const kBlueBeaconName = @"Blue Beacon";
static int const kBlueMajor = 42919;
static int const kBlueMinor = 44220;
// Green Beacon Info
static NSString * const kGreenBeaconName = @"Green Beacon";
static int const kGreenMajor = 43244;
static int const kGreenMinor = 21752;

static NSString * const firstPosition = @"firstPosition";
static NSString * const secondPosition = @"secondPosition";
static NSString * const thirdPosition = @"thirdPosition";

#import "ViewController.h"
#import "TriangleObject.h"

@implementation ViewController

@synthesize beaconViewController;
@synthesize triangles;
@synthesize buttons;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBeacons];
    
    [self addPolygonContainer];
    [self drawTrianglesInView];
    
    //start timer for animation
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0
                                                  target:self
                                                selector:@selector(animateAtIntervals)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void) animateAtIntervals
{
    // send the trianglecoordinates to animate function
    [self animatePoints:self.triangleCoordinates];
}

// function takes array of coordinates as parameter for animating, how you retrieve them beforehand is up to you
// all done in one loop because points won't animate at the same time otherwise, animation has to end before more points can be manipulated
-(void)animatePoints:(NSArray *)animationCoordinates
{
    // array that holds all animation values (which position that should animate, and a random number)
    NSMutableArray *totalAnimationValues = [[NSMutableArray alloc] init];
    NSMutableArray *totalButtonAnimationValues = [[NSMutableArray alloc] init];
    
    //NSMutableDictionary *inventory = [[NSMutableDictionary alloc] initWithObjects:@[[NSNumber numberWithFloat:f], @2] forKeys:@[@"referencePosition", @"3"]];
    
    NSMutableArray *randomNumbers = [[NSMutableArray alloc] init];
    
    // create equal randomnumbers for amount of coordinates so animation is random for each coordinate
    for(int i=0;i<[self.triangleCoordinates count];i++)
    {
        NSNumber *randomNum = [NSNumber numberWithInt:arc4random() % 30];
        [randomNumbers addObject:randomNum];
    }
    
    for(int k=0;k<[triangles count];k++)
    {
        // empty animationValues array
        [totalAnimationValues removeAllObjects];
        
        for(int i=0;i<[self.triangleCoordinates count];i++)
        {
            // check if current triangle coordinates match any of the coordinates in the triangleCoordinates array
            if([triangles[k] firstX] == [self.triangleCoordinates[i][0] integerValue] && [triangles[k] firstY] == [self.triangleCoordinates[i][1] integerValue])
            {
                // animate FIRST point of object
                [totalAnimationValues addObject:@[firstPosition, randomNumbers[i]]];
            }else if([triangles[k] secondX] == [self.triangleCoordinates[i][0] integerValue] && [triangles[k] secondY] == [self.triangleCoordinates[i][1] integerValue])
            {
                // animate SECOND point of object
                [totalAnimationValues addObject:@[secondPosition, randomNumbers[i]]];
            }else if([triangles[k] thirdX] == [self.triangleCoordinates[i][0] integerValue] && [triangles[k] thirdY] == [self.triangleCoordinates[i][1] integerValue])
            {
                // animate THIRD point of object
                [totalAnimationValues addObject:@[thirdPosition, randomNumbers[i]]];
            }
            
            
            // animate buttons in last part of the loop so that all points can animate simultaneously
            if(k==[triangles count]-1)
            {
                
                for(int g=0;g<[buttons count];g++)
                {
                    // empty animationValues array
                    [totalButtonAnimationValues removeAllObjects];
                    BOOL fifthPoint = NO;
                    
                    for(int l=0;l<[self.triangleCoordinates count];l++)
                    {
                        
                        if([buttons[g] firstX] == [self.triangleCoordinates[l][0] integerValue] && [buttons[g] firstY] == [self.triangleCoordinates[l][1] integerValue])
                        {
                            // animate FIRST point of object
                            [totalButtonAnimationValues addObject:@[firstPosition, randomNumbers[l]]];
                        }else if([buttons[g] secondX] == [self.triangleCoordinates[l][0] integerValue] && [buttons[g] secondY] == [self.triangleCoordinates[l][1] integerValue])
                        {
                            //animate SECOND point of object
                            [totalButtonAnimationValues addObject:@[secondPosition, randomNumbers[l]]];
                        }else if([buttons[g] thirdX] == [self.triangleCoordinates[l][0] integerValue] && [buttons[g] thirdY] == [self.triangleCoordinates[l][1] integerValue])
                        {
                            // animate THIRD point of object
                            [totalButtonAnimationValues addObject:@[thirdPosition, randomNumbers[l]]];
                        }
                        
                        // last button has a fifth drawpoint
                        if(g==[buttons count]-1)
                        {
                            fifthPoint = YES;
                        }
                        
                        // call animate funtion on ButtonObject
                        [buttons[g] animateObject:totalButtonAnimationValues drawFifthPoint:fifthPoint];
                    }
                    
                }
                
            }
        }
        
        // call animate function on TriangleObject
        [triangles[k] animateObject:totalAnimationValues];
    }
}

- (void) addPolygonContainer
{
    // create container for triangles to be added
    _polygonContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _polygonContainer.opaque = NO;
    [self.view addSubview:_polygonContainer];
}

-(void) drawTrianglesInView
{
    int screenWidth = self.view.frame.size.width;
    self.triangles = [NSMutableArray array];
    self.buttons = [NSMutableArray array];
    
    // first triangle left (triangleColor: R, G, B, Alpha) GROUP 1
    [self addTriangle:50 firstYPos:200 secondXPos:-10 secondYPos:370 thirdXPos:100 thirdYPos:340 triangleColor:@[@108.0f, @172.9f, @9.0f, @0.8f]];
    [self addTriangle:50 firstYPos:200 secondXPos:-10 secondYPos:370 thirdXPos:-20 thirdYPos:240 triangleColor:@[@129.0f, @188.0f, @25.0f, @0.8f]];
    [self addTriangle:50 firstYPos:200 secondXPos:-30 secondYPos:245 thirdXPos:-50 thirdYPos:130 triangleColor:@[@129.0f, @188.0f, @25.0f, @0.8f]];
    [self addTriangle:50 firstYPos:200 secondXPos:40 secondYPos:100 thirdXPos:-130 thirdYPos:70 triangleColor:@[@129.0f, @188.0f, @25.0f, @0.8f]];
    [self addTriangle:50 firstYPos:200 secondXPos:175 secondYPos:210 thirdXPos:40 thirdYPos:100 triangleColor:@[@129.0f, @188.0f, @25.0f, @0.7f]];
    [self addTriangle:50 firstYPos:200 secondXPos:175 secondYPos:210 thirdXPos:100 thirdYPos:340 triangleColor:@[@125.0f, @187.0f, @25.0f, @0.8f]];
    
    // GROUP 2 (above right button) top, right, bottom right
    [self addTriangle:175 firstYPos:210 secondXPos:40 secondYPos:100 thirdXPos:270 thirdYPos:140 triangleColor:@[@129.0f, @188.0f, @25.0f, @0.8f]];
    [self addTriangle:175 firstYPos:210 secondXPos:270 secondYPos:140 thirdXPos:screenWidth+30 thirdYPos:210 triangleColor:@[@129.0f,@188.0f,@25.0f, @0.7f]];
    [self addTriangle:175 firstYPos:210 secondXPos:screenWidth+30 secondYPos:210 thirdXPos:screenWidth+30 thirdYPos:400 triangleColor:@[@129.0f, @188.0f, @25.0f, @0.8f]];
    
    // GROUP 3 three triangles right corner (left, middle, right)
    [self addTriangle:200 firstYPos:370 secondXPos:190 secondYPos:530 thirdXPos:130 thirdYPos:465 triangleColor:@[@109.0f, @176.0f ,@40.0f, @1.0f]];
    [self addTriangle:200 firstYPos:370 secondXPos:screenWidth+10 secondYPos:490 thirdXPos:190 thirdYPos:490 triangleColor:@[@107.0f, @175.0f, @41.0f, @1.0f]];
    [self addTriangle:200 firstYPos:370 secondXPos:screenWidth+10 secondYPos:330 thirdXPos:screenWidth+10 thirdYPos:490 triangleColor:@[@110.0f, @173.0f, @40.0f, @1.0f]];
    
    // GROUP 4 extra triangles left, right (bottom - clipped) with touch point
    [self addTriangle:130 firstYPos:465 secondXPos:125 secondYPos:480 thirdXPos:145 thirdYPos:480 triangleColor:@[@109.0f, @176.0f, @40.0f, @1.0f]];
    [self addTriangle:130 firstYPos:465 secondXPos:0 secondYPos:800 thirdXPos:0 thirdYPos:440 triangleColor:@[@109.0f, @176.0f, @40.0f, @1.0f]];
    
    // shape with no touch point
    [self addTriangle:screenWidth+30 firstYPos:90 secondXPos:270 secondYPos:140 thirdXPos:screenWidth+30 thirdYPos:210 triangleColor:@[@129.0f,@188.0f,@25.0f, @0.7f]];
    
    // big transparant shape top of the screen
    [self addTriangle:-800 firstYPos:-50 secondXPos:screenWidth+250 secondYPos:-50 thirdXPos:270 thirdYPos:140 triangleColor:@[@129.0f,@188.0f,@25.0f, @0.5f]];
    
    // button shape (top right)
    [self addButton:200 firstYPos:370 secondXPos:100 secondYPos:340 thirdXPos:175 thirdYPos:210 fourthXPos:screenWidth+10 fourthYPos:330 fifthXPos:0 fifthYPos:0 drawFifthPoint:NO buttonColor:@[@106.0f, @169.0f, @33.0f] withTag:1];
    
    // button shape (bottom left)
    [self addButton:200 firstYPos:370 secondXPos:130 secondYPos:465 thirdXPos:0 thirdYPos:450 fourthXPos:0 fourthYPos:350 fifthXPos:100 fifthYPos:340 drawFifthPoint:YES buttonColor:@[@110.0f, @170.0f, @34.0f, @1.0f] withTag:2];
    
    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    //[[self view] addGestureRecognizer:tap];
    
    // add triangles with touchpoints to an array
    //(first object: TriangleObject that has touchpoint, second object: which point of the triangle: 1, 2, 3)
    NSArray *references = [[NSArray alloc] initWithObjects:
                           @[triangles[0], [NSNumber numberWithInt:1]],
                           @[triangles[6], [NSNumber numberWithInt:1]],
                           @[triangles[9], [NSNumber numberWithInt:1]],
                           @[triangles[12], [NSNumber numberWithInt:1]],
                           nil];
    
    
    self.triangleCoordinates = [[NSMutableArray alloc] init];
    //self.triangleDictCoordinates = [[NSMutableDictionary alloc] init];
    
    for(int i=0;i<[references count];i++)
    {
        int tempNumber = [references[i][1] integerValue];
        [self.triangleCoordinates addObject:[self getReferencePosition:references[i][0] fromPoint:tempNumber]];
        //[self.triangleDictCoordinates setObject:@[triangles[0], [NSNumber numberWithInt:1]] forKey:@[@"triangle",@"animationPoint"]];
    }
    
    //NSLog(@"%@", self.triangleDictCoordinates);
}

// function that retrieves x and y values for animation points
- (NSArray *) getReferencePosition:(TriangleObject *)reference fromPoint:(int)currentPoint
{
    NSInteger referenceX = 0, referenceY = 0;
    
    if(currentPoint==1){
        referenceX = [reference firstX];
        referenceY = [reference firstY];
    }else if(currentPoint==2){
        referenceX = [reference secondX];
        referenceY = [reference secondY];
    }else if(currentPoint==3){
        referenceX = [reference thirdX];
        referenceY = [reference thirdY];
    }
    
    NSArray *referencePoints = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt: referenceX], [NSNumber numberWithInt: referenceY], nil];
    
    return referencePoints;
}

- (void)tapped:(UITapGestureRecognizer *)sender
{
//    NSLog(@"tapped");
    CGPoint point = [sender locationInView:self.view];
    //NSLog(@"subviews: %i", _polygonContainer.subviews.count);
    for (UIView *view in _polygonContainer.subviews)
        if (view.tag == 1) {
//            if (CGRectContainsPoint(view.frame, point)) {
//                [view setBackgroundColor:[UIColor redColor]];
//                            NSLog(@"button 1");
//            }
            
            
        } else if (view.tag == 2){
            if (CGRectContainsPoint( view.frame, point)) {
                [view setBackgroundColor:[UIColor yellowColor]];
                NSLog(@"button 2");
            }
            
        }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    point = [self.view.layer convertPoint:point fromLayer:self.view.layer];
    
    if([self.view.layer containsPoint:point])
    {
        
    }
    
    //NSLog(@"x: %f y: %f",point.x, point.y);
}

-(void) addButton:(float)firstX firstYPos:(float)firstY secondXPos:(float)secondX secondYPos:(float)secondY thirdXPos:(float)thirdX thirdYPos:(float)thirdY fourthXPos:(float)fourthX fourthYPos:(float)fourthY fifthXPos:(float)fifthX fifthYPos:(float)fifthY drawFifthPoint:(BOOL)shouldDrawFifthPoint buttonColor:(NSArray *)buttoncolor withTag:(NSInteger)tag
{
    CGRect viewRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	ButtonObject *buttonObject = [[ButtonObject alloc] initWithFrame:viewRect];
    buttonObject.tag = tag;
    
    [buttonObject setButtonParameters:firstX firstYPosition:firstY secondXposition:secondX secondYPosition:secondY thirdXPosition:thirdX thirdYPosition:thirdY fourthXPosition:fourthX fourthYPosition:fourthY fifthXPosition:fifthX fifthYPosition:fifthY drawFifthPoint:shouldDrawFifthPoint buttonColor:buttoncolor];
    
    // add ButtonObject to buttons Array
    [self.buttons addObject:buttonObject];
    
    [_polygonContainer addSubview:buttonObject];
}

// create triangle object and add objects to the container view
- (void) addTriangle:(float)firstX firstYPos:(float)firstY secondXPos:(float)secondX secondYPos:(float)secondY thirdXPos:(float)thirdX thirdYPos:(float)thirdY triangleColor:(NSArray *)triangleColor
{
    // create triangle
	CGRect viewRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	TriangleObject *triangleObject = [[TriangleObject alloc] initWithFrame:viewRect];
    
    [triangleObject setTriangleParameters:firstX firstYPosition:firstY secondXposition:secondX secondYPosition:secondY thirdXPosition:thirdX thirdYPosition:thirdY triangleColor:triangleColor];
    
    // add TriangleObject to triangles Array
    [self.triangles addObject:triangleObject];
	
    [_polygonContainer addSubview:triangleObject];
}

- (void) loginAnimation
{
    //CGRect viewRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

// ----------- [BEACON THINGS]-----------

- (void)addBeacons {
    [[BeaconController sharedInstance] addItemWithName:kGreenBeaconName uuid:[[NSUUID alloc] initWithUUIDString:kBeaconUUID] major:kGreenMajor minor:kGreenMinor];
    [[BeaconController sharedInstance] addItemWithName:kBlueBeaconName uuid:[[NSUUID alloc] initWithUUIDString:kBeaconUUID] major:kBlueMajor minor:kBlueMinor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)launchBeaconVC:(UIBarButtonItem *)sender {
    UIStoryboard *beaconStoryboard = [UIStoryboard storyboardWithName:@"Beacons" bundle:nil];
    beaconViewController = [beaconStoryboard instantiateViewControllerWithIdentifier:@"BeaconViewController"];
    [[self navigationController] pushViewController:beaconViewController animated:YES];
}

@end
