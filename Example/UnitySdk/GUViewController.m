//
//  GUViewController.m
//  UnitySdk
//
//  Created by pikacool1993 on 05/08/2020.
//  Copyright (c) 2020 pikacool1993. All rights reserved.
//

#import "GUViewController.h"
#import <PMDevice.h>

@interface GUViewController ()

@end

@implementation GUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"=======> \n %@", [PMDevice deviceLocalIP]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
