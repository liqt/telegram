//
//  TGSEnterPasscodeView.m
//  Telegram
//
//  Created by keepcoder on 19.05.15.
//  Copyright (c) 2015 keepcoder. All rights reserved.
//

#import "TGSEnterPasscodeView.h"
#import "BTRButton.h"
#import "BTRSecureTextField.h"
#import "TMAttributedString.h"
#import "TGSAppManager.h"
#import "NSStringCategory.h"
#import "TGS_MTNetwork.h"
@interface TGSEnterPasscodeView ()
@property (nonatomic,strong) NSSecureTextField *secureField;
@property (nonatomic,strong) BTRButton *enterButton;
@end

@implementation TGSEnterPasscodeView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(instancetype)initWithFrame:(NSRect)frameRect {
    if(self = [super initWithFrame:frameRect]) {
        
        
        
        self.backgroundColor = [NSColor whiteColor];
        
        self.secureField = [[BTRSecureTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 30)];
        
        
        NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] init];
        
        [attrs appendString:NSLocalizedString(@"Passcode.EnterPlaceholder", nil) withColor:NSColorFromRGB(0xc8c8c8)];
        
        [attrs setAttributes:@{NSFontAttributeName:[NSFont fontWithName:@"HelveticaNeue" size:12]} range:attrs.range];
        
        [[self.secureField cell] setPlaceholderAttributedString:attrs];
        
        [attrs setAlignment:NSCenterTextAlignment range:attrs.range];
        
        // [[self.secureField cell] setPlaceholderAttributedString:attrs];
        
        [self.secureField setAlignment:NSLeftTextAlignment];
        
        [self.secureField setCenterByView:self];
        
        [self.secureField setBordered:NO];
        [self.secureField setDrawsBackground:YES];
        
        [self.secureField setBackgroundColor:NSColorFromRGB(0xF1F1F1)];
        
        [self.secureField setFocusRingType:NSFocusRingTypeNone];
        
        [self.secureField setBezeled:NO];
        
        
        self.secureField.wantsLayer = YES;
        self.secureField.layer.cornerRadius = 4;
        
        //  self.secureField.layer.masksToBounds = YES;
        
        
        [self.secureField setAction:@selector(checkPassword)];
        [self.secureField setTarget:self];
        
        [self.secureField setFont:[NSFont fontWithName:@"HelveticaNeue" size:14]];
        [self.secureField setTextColor:DARK_BLACK];
        
        [self.secureField setCenterByView:self];
        
        
        [self addSubview:self.secureField];
        
        
        weak();
        
         self.enterButton = [[BTRButton alloc] initWithFrame:NSMakeRect(0, 0, image_PasslockEnter().size.width, image_PasslockEnter().size.height)];
        
        [self.enterButton setImage:image_PasslockEnter() forControlState:BTRControlStateNormal];
        [self.enterButton setImage:image_PasslockEnterHighlighted() forControlState:BTRControlStateHover];
        
        [self.enterButton addBlock:^(BTRControlEvents events) {
            
            [weakSelf checkPassword];
            
        } forControlEvents:BTRControlEventClick];
        
        
        [self.enterButton setFrameOrigin:NSMakePoint(NSMaxX(self.secureField.frame) + 20, NSMinY(self.secureField.frame) + 3)];
        
        [self addSubview:self.enterButton];
    }
    
    return self;
}

-(void)checkPassword {
    
     NSString *hash = [self.secureField.stringValue md5];
    
    BOOL result = _passlockResult(YES,hash);
    
    if(!result) {
        [self.secureField performShake:nil];
    } else {
        [TGSAppManager hidePasslock];
    }
    
    return;
}

@end