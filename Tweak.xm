#import <Foundation/Foundation.h>
#import "Source/UI/UI.h"
#import "Source/SettingKey.h"

%hook LineConfigurations
- (id) configMap {
	NSMutableDictionary *dict = [%orig mutableCopy];

	if ([menu getToggleValue:0 withTitle:KEY_REMOVE_VOOM_TAB] == YES ){
		// VOOM(タイムライン)タブ削除
		[dict setObject:@"N" forKey:@"main_tab.show_timeline_2018"];
	}

  if ([menu getToggleValue:0 withTitle:KEY_REMOVE_CALL_TAB] == YES ){
    // 通話タブ削除
    [dict setObject:@"N" forKey:@"main_tab.show_calltab"];
  }

  if ([menu getToggleValue:0 withTitle:KEY_REMOVE_NEWS_TAB] == YES ){
    // ニュースタブ削除
    [dict setObject:@"N" forKey:@"main_tab.newstab"];
  }
  if ([menu getToggleValue:0 withTitle:KEY_REMOVE_AD_TALK_LIST] == YES ){
    // トーク一覧の広告削除
    [dict setObject:@"N" forKey:@"function.chattab.talkhead"];
  }

  if ([menu getToggleValue:0 withTitle:KEY_REMOVE_AD_OPENCHAT] == YES ){
    // OpenChatの広告削除
    [dict setObject:@"N" forKey:@"function.square.chatroom.header_ad.enabled"];
    [dict setObject:@"" forKey:@"function.square.chatroom.header_ad.type.private"];
    [dict setObject:@"" forKey:@"function.square.chatroom.header_ad.type.public"];
    [dict setObject:@"N" forKey:@"function.square.chatroom.integration_ad.enabled"];
    [dict setObject:@"N" forKey:@"function.square.note.header_ad.enabled"];
    [dict setObject:@"N" forKey:@"function.square.thread_space.header_ad.enabled"];
    [dict setObject:@"N" forKey:@"function.square.your_threads.header_ad.enabled"];
  }

  if ([menu getToggleValue:0 withTitle:KEY_REMOVE_AD_ALBUM] == YES ){
    // アルバムの広告削除
    [dict setObject:@"N" forKey:@"function.album.ad.enabled"];
    [dict setObject:@"N" forKey:@"function.moa.album.ad.enabled"];
  }

  if ([menu getToggleValue:0 withTitle:KEY_HOME_MINOR_REGION] == YES ){
    // ホームタブを昔に戻す
    [dict setObject:@"Y" forKey:@"function.hometab.minorregions"];
  }
	return dict;
}
%end

void setupModMenu() {
  menu = [ModMenu shared]; // Init the menu

  // load saved settings
  [menu loadSettings];

  // Welcome message - optional
  [menu showMessage:[NSString
                        stringWithFormat:@"LINE %s Mod Menu!", Version]
           duration:3.0
            credits:[NSString stringWithFormat:@"Developed by %s", Author]];

  // Configure menu
  menu.maxButtons = 2; // Max button surrounding the hub button | By default is 6 [MAX 6]

  // Setup default - optional
  [menu addDefaultOptions:DebugMode];

  // Setup options main customization
  NSString *logMessage = [NSString stringWithFormat:@"settings: %@", [menu getSettingValues]];
  [menu addDebugLog:logMessage];

  [menu addToggle:KEY_REMOVE_VOOM_TAB initialValue:[menu getToggleValue:0 withTitle:KEY_REMOVE_VOOM_TAB] forCategory:0];
  [menu addToggle:KEY_REMOVE_CALL_TAB initialValue:[menu getToggleValue:0 withTitle:KEY_REMOVE_CALL_TAB] forCategory:0];
  [menu addToggle:KEY_REMOVE_NEWS_TAB initialValue:[menu getToggleValue:0 withTitle:KEY_REMOVE_NEWS_TAB] forCategory:0];
  [menu addToggle:KEY_REMOVE_AD_TALK_LIST initialValue:[menu getToggleValue:0 withTitle:KEY_REMOVE_AD_TALK_LIST] forCategory:0];
  [menu addToggle:KEY_REMOVE_AD_OPENCHAT initialValue:[menu getToggleValue:0 withTitle:KEY_REMOVE_AD_OPENCHAT] forCategory:0];
  [menu addToggle:KEY_REMOVE_AD_ALBUM initialValue:[menu getToggleValue:0 withTitle:KEY_REMOVE_AD_ALBUM] forCategory:0];
  [menu addToggle:KEY_HOME_MINOR_REGION initialValue:[menu getToggleValue:0 withTitle:KEY_HOME_MINOR_REGION] forCategory:0];
}

void waitBeforeLaunch() {
  dispatch_after(
      dispatch_time(DISPATCH_TIME_NOW, (int64_t)(WAIT * NSEC_PER_SEC)),
      dispatch_get_main_queue(), ^{

        // Setup ModMenu
        setupModMenu();
      });
}

static void didFinishLaunching(CFNotificationCenterRef center, void *observer,
                               CFStringRef name, const void *object,
                               CFDictionaryRef info) {
  waitBeforeLaunch();
}

void launchEvent() {
  // Add observer for app launch
  CFNotificationCenterAddObserver(
      CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching,
      (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL,
      CFNotificationSuspensionBehaviorDrop);
}

// Entry point
__attribute__((constructor)) static void initialize() { launchEvent(); }