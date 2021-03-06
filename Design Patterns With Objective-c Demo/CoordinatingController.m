//
//  CoordinatingController.m
//  Design Patterns With Objective-c Demo
//
//  Created by yubinqiang on 16/6/21.
//  Copyright © 2016年 Zeek. All rights reserved.
//

#import "CoordinatingController.h"
#import "PaletteViewController.h"
#import "CanvasViewController.h"
#import "ScribbleThumbnailCollectionViewController.h"
#import "ScribbleManager.h"
#import "UIView+Image.h"

@interface CoordinatingController ()
@property (strong, nonatomic) ScribbleManager *scribbleManager;
@end

@implementation CoordinatingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.canvasViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(CanvasViewController.class)];
    [self.view addSubview:self.canvasViewController.view];
    [self addChildViewController:self.canvasViewController];
    [self.canvasViewController didMoveToParentViewController:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.toolbarHidden = NO;
}

+ (CoordinatingController *)sharedCoordinatingController {
    static CoordinatingController *_coordinatingController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _coordinatingController = [[CoordinatingController alloc] init];
    });
    return _coordinatingController;
}

- (IBAction)requestViewChangedWithObject:(UIBarButtonItem *)sender {
    if (![sender isKindOfClass:UIBarButtonItem.class]) {
        assert(NO);
        return;
    }
    
    switch (((UIBarButtonItem *)sender).tag) {
        case kBarButtonItemTagDone: {
            
        }
            break;
        case kBarButtonItemTagSaveScribble:{
            [self saveSribble];
        }
            break;
        case kBarButtonItemTagOpenScribble: {
            ScribbleThumbnailCollectionViewController *thumbnailViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(ScribbleThumbnailCollectionViewController.class)];
            
            thumbnailViewController.scribbleManager = self.scribbleManager;
            self.activeViewController = thumbnailViewController;
        }
            break;
        case kBarButtonItemTagUnDo: {
            if (self.canvasViewController.undoManager.canUndo) {
                [self.canvasViewController.undoManager undo];
            }
            return;
        }
            break;
            
        case kBarButtonItemTagReDo: {
            if (self.canvasViewController.undoManager.canRedo) {
                [self.canvasViewController.undoManager redo];
            }
            return;
        }
            break;
        case kBarButtonItemTagTrash: {
            
        }
            break;
            
        case kBarButtonItemTagOpenPaletteView: {
            PaletteViewController *paletteViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(PaletteViewController.class)];
            self.activeViewController = paletteViewController;
        }
            break;
            
        default: {
            [self dismissViewControllerAnimated:YES completion:NULL];
            self.activeViewController = self.canvasViewController;
        }
            break;
    }
//    [self.canvasViewController presentViewController:self.activeViewController animated:YES completion:NULL];
    [self.navigationController pushViewController:self.activeViewController animated:YES];
}

- (void)saveSribble {
    [self.scribbleManager saveScribble:self.canvasViewController.scribble thumbnail:[self.view image]];
}

#pragma mark - Lazy
- (ScribbleManager *)scribbleManager {
    if (_scribbleManager == nil) {
        _scribbleManager = [[ScribbleManager alloc] init];
    }
    return _scribbleManager;
}
@end
