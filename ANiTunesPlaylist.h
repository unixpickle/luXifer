//
//  ANiTunesPlaylist.h
//  luXifer
//
//  Created by Alex Nichol on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ANiTunesPlaylist : NSObject {
	NSString * plName;
	BOOL visible;
	NSArray * plTrackIDs;
}
- (id)initWithDictionary:(NSDictionary *)dict;
@property (nonatomic, retain) NSString * plName;
@property (nonatomic, retain) NSArray * plTrackIDs;
@property (readwrite) BOOL visible;
@end
