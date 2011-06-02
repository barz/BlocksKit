//
//  UIWebView+BlocksKit.m
//  BlocksKit
//

#import "UIWebView+BlocksKit.h"
#import "NSObject+AssociatedObjects.h"

@interface UIWebView (BlocksKitPrivate)
@property (retain) NSMutableDictionary *blocks;
@end

@implementation UIWebView (BlocksKit)

static char *kWebViewBlockDictionaryKey = "UIWebViewBlockHandlers"; 
static NSString *kWebViewShouldStartBlockKey = @"UIWebViewShouldStartBlock";
static NSString *kWebViewDidStartBlockKey = @"UIWebViewDidStartBlock";
static NSString *kWebViewDidFinishBlockKey = @"UIWebViewDidFinishBlock";
static NSString *kWebViewDidErrorBlockKey = @"UIWebViewDidErrorBlock";

#pragma mark Delegates

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    BKWebViewStartBlock block = [self.blocks objectForKey:kWebViewShouldStartBlockKey];
    if (block && (![block isEqual:[NSNull null]]))
        return block(request, navigationType);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    BKBlock block = [self.blocks objectForKey:kWebViewDidStartBlockKey];
    if (block && (![block isEqual:[NSNull null]]))
        block();
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    BKBlock block = [self.blocks objectForKey:kWebViewDidFinishBlockKey];
    if (block && (![block isEqual:[NSNull null]]))
        block();
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    BKErrorBlock block = [self.blocks objectForKey:kWebViewDidErrorBlockKey];
    if (block && (![block isEqual:[NSNull null]]))
        block(error);
}

#pragma mark Properties

- (NSMutableDictionary *)blocks {
    NSMutableDictionary *blocks = [self associatedValueForKey:kWebViewBlockDictionaryKey];
    if (!blocks) {
        blocks = [[NSMutableDictionary alloc] initWithCapacity:4];
        self.blocks = blocks;
        [blocks release];
    }
    return blocks;
}

- (void)setBlocks:(NSMutableDictionary *)blocks {
    [self associateValue:blocks withKey:kWebViewBlockDictionaryKey];
}

- (BKWebViewStartBlock)shouldStartLoadBlock {
    return [self.blocks objectForKey:kWebViewShouldStartBlockKey];    
}

- (void)setShouldStartLoadBlock:(BKWebViewStartBlock)block {
    if (self.delegate != self)
        self.delegate = self;
    [self.blocks setObject:(block ? [[block copy] autorelease] : [NSNull null]) forKey:kWebViewShouldStartBlockKey];
}

- (BKBlock)didStartLoadBlock {
    return [self.blocks objectForKey:kWebViewDidStartBlockKey];
}

- (void)setDidStartLoadBlock:(BKBlock)block {
    if (self.delegate != self)
        self.delegate = self;    
    [self.blocks setObject:(block ? [[block copy] autorelease] : [NSNull null]) forKey:kWebViewDidStartBlockKey];
}

- (BKBlock)didFinishLoadBlock {
    return [self.blocks objectForKey:kWebViewDidFinishBlockKey];
}

- (void)setDidFinishLoadBlock:(BKBlock)block {
    if (self.delegate != self)
        self.delegate = self;    
    [self.blocks setObject:(block ? [[block copy] autorelease] : [NSNull null]) forKey:kWebViewDidFinishBlockKey];
}

- (BKErrorBlock)didFinishWithErrorBlock {
    return [self.blocks objectForKey:kWebViewDidErrorBlockKey];
}

- (void)setDidFinishWithErrorBlock:(BKErrorBlock)block {
    if (self.delegate != self)
        self.delegate = self;    
    [self.blocks setObject:(block ? [[block copy] autorelease] : [NSNull null]) forKey:kWebViewDidErrorBlockKey];
}

@end