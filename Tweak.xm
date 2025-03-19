#import <Foundation/Foundation.h>
#include <objc/runtime.h>

%hook LineConfigurations
- (id) configMap {
	NSMutableDictionary *dict = [%orig mutableCopy];
	// VOOM(タイムライン)タブ削除
	[dict setObject:@"N" forKey:@"main_tab.show_timeline_2018"];

	// 通話タブ削除
	[dict setObject:@"N" forKey:@"main_tab.show_calltab"];

	// ニュースタブ削除
	[dict setObject:@"N" forKey:@"main_tab.newstab"];

	// トーク一覧の広告削除
	[dict setObject:@"N" forKey:@"function.chattab.talkhead"];

	// OpenChatの広告削除
	[dict setObject:@"N" forKey:@"function.square.chatroom.header_ad.enabled"];
	[dict setObject:@"" forKey:@"function.square.chatroom.header_ad.type.private"];
	[dict setObject:@"" forKey:@"function.square.chatroom.header_ad.type.public"];
	[dict setObject:@"N" forKey:@"function.square.chatroom.integration_ad.enabled"];
	[dict setObject:@"N" forKey:@"function.square.note.header_ad.enabled"];
	[dict setObject:@"N" forKey:@"function.square.thread_space.header_ad.enabled"];
	[dict setObject:@"N" forKey:@"function.square.your_threads.header_ad.enabled"];

	// アルバムの広告削除
	[dict setObject:@"N" forKey:@"function.album.ad.enabled"];
	[dict setObject:@"N" forKey:@"function.moa.album.ad.enabled"];

	// ホームタブを昔に戻す
	[dict setObject:@"Y" forKey:@"function.hometab.minorregions"];
	return dict;
}
%end
