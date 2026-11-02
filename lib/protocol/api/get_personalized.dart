import '../core/constants.dart';
import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../generated/generated.dart' as pb;
import '../models/recommend.dart';
import '../models/thread.dart';
import '_common.dart';

/// Fetches the personalized home feed (15 threads per page on the official client).
Future<List<TiebaThread>> fetchPersonalized(
  TiebaHttpCore http, {
  int page = 1,
  int loadType = 1,
}) async {
  final request = pb.PersonalizedRequest();
  final data = request.ensureData();
  data.common = buildCommon(version: TiebaConstants.legacyVersion);
  data.loadType = loadType;
  data.pn = page;
  data.pageThreadCount = 11;
  data.needTags = 0;
  data.tagCode = 0;
  data.qType = 1;
  data.needForumlist = 0;
  data.newNetType = 1;
  data.newInstall = 0;
  data.requestTimes = 0;

  final bytes = await http.postProto(
    '/c/f/excellent/personalized',
    309264,
    request.writeToBuffer(),
  );
  final response = pb.PersonalizedResponse.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  return <TiebaThread>[
    for (final thread in response.data.threadList)
      TiebaThread.fromProto(thread),
  ];
}

/// Fetches the home hot list for one tab. The default tab is all.
Future<HotThreadPage> fetchHotThreads(
  TiebaHttpCore http, {
  String tabCode = 'all',
}) async {
  final request = pb.HotThreadListRequest();
  final data = request.ensureData();
  data.common = buildCommon(version: TiebaConstants.legacyVersion);
  data.tabId = '1';
  data.tabCode = tabCode;

  final bytes = await http.postProto(
    '/c/f/forum/hotThreadList',
    309661,
    request.writeToBuffer(),
  );
  final response = pb.HotThreadListResponse.fromBuffer(bytes);
  if (response.error.errorno != 0) {
    throw TiebaServerException(response.error.errorno, response.error.errmsg);
  }
  final page = response.data;
  return HotThreadPage(
    topics: <RecommendTopic>[
      for (final topic in page.topicList)
        RecommendTopic(
          id: topic.topicId.toInt(),
          name: topic.topicName,
          description: topic.topicDesc,
          discussNum: topic.discussNum.toInt(),
          tag: topic.tag,
          imageUrl: topic.topicPic.isEmpty ? null : topic.topicPic,
        ),
    ],
    tabs: <HotThreadTab>[
      for (final tab in page.hotThreadTabInfo)
        HotThreadTab(
          code: tab.tabCode.isEmpty ? '${tab.tabId}' : tab.tabCode,
          name: tab.tabName,
        ),
    ],
    threads: <TiebaThread>[
      for (final thread in page.threadInfo) TiebaThread.fromProto(thread),
    ],
  );
}
