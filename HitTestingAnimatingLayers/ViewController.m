//
//  ViewController.m
//  HitTestingAnimatingLayers
//
//  Created by tianpengfei on 16/4/6.
//  Copyright © 2016年 tianpengfei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(strong,nonatomic)CALayer *movingLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initLayer];
}
-(void)initLayer{

    CALayer * movingLayer = [CALayer layer];
    [movingLayer setBounds: CGRectMake(0, 0,88, 88)];
    [movingLayer setBackgroundColor:[UIColor orangeColor].CGColor];
    [movingLayer setPosition:CGPointMake(64, 64)];
    // Additional styling of the layer ...
    [[[self view] layer] addSublayer:movingLayer];
    [self setMovingLayer:movingLayer];
    
    CAKeyframeAnimation * moveLayerAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [moveLayerAnimation setValues:[NSArray arrayWithObjects: [NSValue valueWithCGPoint:CGPointMake(100, 100)],[NSValue valueWithCGPoint:CGPointMake(150, 150)],[NSValue valueWithCGPoint:CGPointMake(200, 200)],[NSValue valueWithCGPoint:CGPointMake(100, 400)], nil]];
    
    [moveLayerAnimation setDuration:3.0];
    [moveLayerAnimation setRepeatCount:HUGE_VALF];
    [moveLayerAnimation setAutoreverses:YES];
    [moveLayerAnimation setTimingFunction: [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [moveLayerAnimation setCalculationMode:kCAAnimationCubic];
    [[self movingLayer] addAnimation:moveLayerAnimation forKey:@"move"];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressedLayer:)]];
    
}
-(void)setMovingLayer:(CALayer *)movingLayer{

    _movingLayer = movingLayer;
}
- (IBAction)pressedLayer:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint touchPoint = [gestureRecognizer locationInView:[self view]];
    
    if ([[[self movingLayer] presentationLayer] hitTest:touchPoint]) {
        [self blinkLayerWithColor:[UIColor yellowColor]];
    } else if ([[self movingLayer] hitTest:touchPoint]) {
        [self blinkLayerWithColor:[UIColor redColor]];
    }
}
- (void)blinkLayerWithColor:(UIColor *)color {
    CABasicAnimation * blinkAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    [blinkAnimation setDuration:0.1];
    [blinkAnimation setAutoreverses:YES];
    [blinkAnimation setFromValue:(id)[[self movingLayer] backgroundColor]];
    [blinkAnimation setToValue:(id)color.CGColor];
    
    [[self movingLayer] addAnimation:blinkAnimation forKey:@"blink"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
