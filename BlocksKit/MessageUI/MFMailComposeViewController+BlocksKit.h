//
//  MFMailComposeViewController+BlocksKit.h
//  BlocksKit
//

#import <MessageUI/MessageUI.h>

/** MFMailComposeViewController with block callbacks.

 If you provide a completion handler to an instance of
 MFMailComposeViewController but do not implement a delegate callback for
 mailComposeController:didFinishWithResult:error:, the mail compose view
 controller will automatically be dismissed if it was launched modally.

 Created by [Igor Evsukov](https://github.com/evsukov89) and contributed to
 BlocksKit.

 @warning MFMailComposeViewController is only available on a platform with MessageUI.
 */
@interface MFMailComposeViewController (BlocksKit)

/**  The block fired on the dismissal of the mail composition interface.

 This block callback is an analog for the
 mailComposeController:didFinishWithResult:error:method
 of MFMailComposeViewControllerDelegate.
*/
typedef void (^BKMailComposeDidFinishBlock)(MFMailComposeViewController* mailViewController, MFMailComposeResult result, NSError* error);   // Hsoi 2013-11-22 - added

@property (nonatomic, copy, setter = bk_setCompletionBlock:) BKMailComposeDidFinishBlock bk_completionBlock;

@end
