//
//  WebAddress.h
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-4.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#ifndef JIONGJIONG_WebAddress_h
#define JIONGJIONG_WebAddress_h

#define DZJVideoAddress(channelId) [@"http://api.3g.youku.com/layout/iphone/channel/subpage?brand=apple&btype=iPhone5%2C2&cid=94&deviceid=0f607264fc6318a92b9e13c65db7cd3c&guid=7066707c5bdc38af1621eaf94a6fe779&idfa=B12D79E1-1B9B-42A5-8A26-72A91994E0D0&image_hd=2&network=WiFi&operator=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A_46001&os=ios&os_ver=7.0.2&ouid=cfcb9d25ac2c37009a2fcd466e9e415ec0f2f3c4&pageNo=1&pid=69b81504767483cf" stringByAppendingString:[NSString stringWithFormat:@"&sub_channel_id=%@&sub_channel_type=2&vdid=D90BD0A3-5064-4290-ACE2-D9C853B809C8&ver=3.2.2",channelId]]

#define DZJVideoAddressDisplay() @"http://api.3g.youku.com/layout/iphone/channel/subpage?brand=apple&btype=iPhone3%2C1&cid=94&deviceid=0a917cb3946719cbb7875c987b7b3b44&guid=1d18190585614110990da6c67b41b2f7&idfa=EE313CC7-1B49-4780-8D0C-A8F004ECCE09&image_hd=2&network=WiFi&operator=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A_46001&os=ios&os_ver=6.1.3&ouid=7a7e0bba62d74644e8283f91a4b9457f8fbf26c6&pageNo=1&pid=69b81504767483cf&sub_channel_id=319&sub_channel_type=1&vdid=F0157255-6960-48CD-9374-92BABDD97A18&ver=3.2.2"
#define DZJVideoPlayAddress(videoID) [NSString stringWithFormat:@"http://pl.youku.com/playlist/m3u8?ts=22222265665&keyframe=1&vid=%@&type=flv",videoID]


#define DZJAddress(latitude,longitude) [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true",latitude,longitude]

#define Cachespath(name) [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:name]

#define jeffyAddress(page) [NSString stringWithFormat:@"http://m2.qiushibaike.com/article/list/day?count=30&page=%d",page]

#define PictureAndTextWeb(date,page) [NSString stringWithFormat:@"http://joke.zaijiawan.com/Joke/joke2.jsp?appname=readinggaoxiao&version=3.2&os=ios&hardware=iphone&sort=1&timestamp=%@&page=%d",date,page]

#define Original(_currentLoad)  NSString *urlString = [@"http://124.205.147.26/student/class_11/team_three/resource/AllPHP/hlSelectUserShareV2.php?count=" stringByAppendingString:[NSString stringWithFormat:@"%d",_currentLoad*10]]



#endif
