//
//  ViewController.m
//  DrawLinegit
//
//  Created by Hadi Hatunoglu on 06/06/13.
//  Copyright (c) 2013 Hadi Hatunoglu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    self.navigationItem.title=@"Draw Line";
    aView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44)];
    aView.backgroundColor=[UIColor whiteColor];
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,320,380)];
    imageView.backgroundColor=[UIColor orangeColor];
    [imageView setUserInteractionEnabled:YES];
    [aView addSubview:imageView];
    startPointlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 382.5,155, 30)];
    startPointlabel.backgroundColor=[UIColor blackColor];
    startPointlabel.textColor=[UIColor whiteColor];
    [aView addSubview:startPointlabel];
    endPointLabel=[[UILabel alloc]initWithFrame:CGRectMake(165, 382.5, 155, 30)];
    endPointLabel.backgroundColor=[UIColor blackColor];
    endPointLabel.textColor=[UIColor whiteColor];
    [aView addSubview:endPointLabel];
    [self.view addSubview:aView];
    
    UIBarButtonItem *cancelbuuton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTheLine)];
    self.navigationItem.rightBarButtonItem=cancelbuuton;

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[[event allTouches]anyObject];
    lastPoint=[touch  locationInView:aView];
    NSLog(@"touches begin X=%f,Y=%f",lastPoint.x,lastPoint.y);
    startPointlabel.text=[NSString stringWithFormat:@"X=%0.2f,Y=%0.2f",lastPoint.x,lastPoint.y];
    
    
    UIButton *but=[[UIButton alloc]init];
    [but setFrame:CGRectMake(lastPoint.x, lastPoint.y, 10, 10)];
    [imageView addSubview:but];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[[event allTouches]anyObject];
    CGPoint loaction=[touch  locationInView:aView];
    NSLog(@"touches Moved X=%f,Y=%f",loaction.x,loaction.y);
    if (touch.view==imageView) {
        
		UIGraphicsBeginImageContext(imageView.frame.size);
		[imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
		CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
		CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 4.0);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(),[UIColor purpleColor].CGColor);
        
		CGContextBeginPath(UIGraphicsGetCurrentContext());
		CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), loaction.x, loaction.y);
		CGContextStrokePath(UIGraphicsGetCurrentContext());
		imageView.image = UIGraphicsGetImageFromCurrentImageContext();
		lastPoint = loaction;
		UIGraphicsEndImageContext();
    }
    
    
    
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[[event allTouches]anyObject];
    CGPoint loaction=[touch  locationInView:aView];
    NSLog(@"touches Ended X=%f,Y=%f",loaction.x,loaction.y);
    endPointLabel.text=[NSString stringWithFormat:@"X=%0.2f,Y=%0.2f",loaction.x,loaction.y];
    UIButton *but=[[UIButton alloc]init];
    [but setFrame:CGRectMake(loaction.x, loaction.y, 10, 10)];
    [imageView addSubview:but];
}
-(void)cancelTheLine
{
    imageView.image=nil;
    startPointlabel.text=nil;
    endPointLabel.text=nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    if (interfaceOrientation==UIInterfaceOrientationPortrait) {
        return YES;
    }else if (interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
    {
        return YES;
    }else
        return NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
