# aiotieba 4.8.2 → Dart 全量协议层

> 参考实现：https://github.com/lumina37/aiotieba 4.8.2（Unlicense，public domain）。
> 状态：aiotieba 的 API 模块与核心能力已全部移植；现有 Flutter UI 仍未改动。
> 规模：119 个手写 Dart 文件 / 约 14,551 行；64 份 proto；15 个协议测试文件 / 97 个用例。
> 完整模块清单：[port-checklist.md](port-checklist.md)。

## 一、目录

| 路径 | 内容 |
| --- | --- |
| lib/protocol/core/ | Account、Config、常量、枚举、异常、签名、HTTP、cache、crypto |
| lib/protocol/core/blcp/ | BLCP TLS 传输、LCP 帧、RPC、心跳、聊天加密 |
| lib/protocol/core/ws/ | WebSocket 握手、加密帧、消息 id、RSA |
| lib/protocol/generated/ | 由 proto/ 生成的 Dart protobuf 类 |
| lib/protocol/models/ | 统一领域模型与各接口模型 |
| lib/protocol/api/ | 各模块对应的请求构造与解析 |
| lib/protocol/client.dart | TiebaClient（HTTP 全量入口） |
| lib/protocol/api/chat_client.dart | TiebaChatClient（聊天/IM 聚合入口） |
| proto/ | 从 aiotieba 复制的 .proto schema |
| test/protocol/ | 签名、crypto、模型、HTML、fixture、聊天测试 |
| tool/ | smoke、capture_fixtures、compare_legacy |

## 二、传输

| 类型 | 地址 | 关键点 |
| --- | --- | --- |
| APP 表单 | tiebac.baidu.com | 参数按 (key, value) 排序后 md5(... + tiebaclient!!!) |
| APP protobuf | tiebac.baidu.com?cmd=... | x_bd_data_type: protobuf，multipart boundary -*_r1999 |
| WEB | tieba.baidu.com | Cookie（BDUSS/STOKEN）、PC salt、GBK/UTF-8 自动解码 |
| BLCP | common.lcs.baidu.com:443 | TLS、lcp\x01 帧、RpcMeta、gzip |
| WebSocket | im.tieba.baidu.com:8000 | im_version=2.3、加密帧、ping 180s |

## 三、核心能力

- Account：BDUSS/STOKEN、android_id、uuid、cuid、client_id、sample_id、cuid_galaxy2、c3_aid、tbs、baidu_id、zid、ws_sec_key、zid_sec_key、bduk/uk/trigger_id。
- crypto：CRC32、XXH32、base32、helios、cuid_galaxy2、c3_aid、rc4_42、enuid、AES-CBC/PKCS7、user_id2bduk/bduk2user_id。
- init：init_zid（sofire + AES + gzip）、init_baidu_id（BAIDUID cookie）、sync（client_id/sample_id）。
- HTTP：三种传输、原始响应/响应头、代理、超时、GBK 解码、ForumInfoCache。
- 聊天：BlcpCore、WsCore、TiebaChatClient、私信/群消息/吧群/推送。

## 四、API 覆盖

全部 105 个 aiotieba API 模块均有 Dart 函数/模型，按组列出：

- 吧与帖：get_forum、get_forum_detail、get_forum_level、get_tab_map、get_square_forums、get_threads、get_posts、get_comments、get_last_replyers、get_user_forum_info、get_recom_status、get_statistics。
- 搜索：search_in_forum、search_global。
- 用户：profile/get_uinfo_profile、get_homepage、get_uinfo_getUserInfo_web、get_uinfo_getuserinfo_app、get_uinfo_panel、get_uinfo_userCard、get_uinfo_user_json、get_selfinfo_initNickname、get_selfinfo_moindex、tieba_uid2user_info、get_user_contents（threads/posts）、get_user_contents_pc、get_follow_forums_pc、get_self_follow_forums、get_follows、get_fans、get_blacklist、get_blacklist_old、get_dislike_forums。
- 通知：get_ats、get_replys。
- 吧务：get_bawu_info、get_bawu_memberlist、get_bawu_blacklist、get_bawu_perm、get_bawu_postlogs、get_bawu_userlogs、add_bawu、del_bawu、set_bawu_perm、add/del_bawu_blacklist、get_blocks、get_recovers、get_recover_info、get_unblock_appeals、handle_unblock_appeals、recover。
- 写操作：agree 四态、sign_forum/s、sign_growth、follow/unfollow forum/user、remove_fan、del_post/s、del_thread/s、block/unblock、set_profile、set_nickname_old、set_thread_privacy、add/del_blacklist_old、set_blacklist、dislike/undislike_forum、recommend、top/good/ungood/move、add_poll。
- 图片：get_images（返回字节；不移植 OpenCV 解码）。
- 登录：login、sync、init_zid、init_baidu_id。
- 聊天：get_lcm_token、login_blcp_lcm/im/cloud_ctrl、upload_ws_sec、get_cid、get_roomlist_by_fid、get_chatroom_detail、fetch_chatroom_msg、send_chatroom_msg、get_group_msg、send_msg、set_msg_readed、join_chatroom、push_notify。

## 五、用法

~~~dart
import 'package:feiba/protocol/tieba_protocol.dart';

final client = TiebaClient();
final threads = await client.getThreads('原神');
final posts = await client.getPosts(threads.objs.first.tid);
final user = await client.getUserInfo(userId: 2213840917);
client.close();
~~~

登录 + 写操作 + 聊天：

~~~dart
final client = TiebaClient(
  account: TiebaAccount(bduss: bduss, stoken: stoken),
);
await client.login();          // userId + tbs
await client.signForum('原神');
await client.initZid();
await client.initBaiduId();

final chat = client.chat;
await chat.login();            // BLCP + IM
await chat.initWebSocket();    // WS + upload_ws_sec
final groups = await chat.getGroupMessages(<int>[123]);
await chat.sendMessage(456, 'hello');
await chat.close();
~~~

## 六、模型设计

- aiotieba 的 Contents_t / Contents_p / Contents_c 等多套重复类合并为 Contents + ContentsKind。
- 统一 TiebaUser、TiebaThread、TiebaPost、TiebaComment、TiebaPage；各接口的 PC/HTML/聊天模型放 models/ 下对应文件。
- 保留：@ 前缀剥离、回复 @user 前缀剥离、楼层页 has_more = current_page < total_page、帖子列表 pn=0 映射 current_page=1、图片去重。

## 七、验证

~~~bash
flutter analyze
flutter test
dart run tool/protocol_smoke.dart 原神
dart run tool/compare_legacy.dart 原神
dart run tool/capture_fixtures.dart
flutter build windows --debug
~~~

已实测：

- flutter analyze：No issues found
- flutter test：101 项全部通过（含 97 个协议用例）
- Windows debug 构建成功
- 公开接口 smoke：吧/帖/楼层/楼中楼（29 条，page 1/22，hasMore=true）、双搜索、用户资料/主页/主题帖、吧详情/11 分区、排行/会员榜（中文名正常）、粉丝列表（100/2520）、图片、crypto
- zid（87 字符）与 BAIDUID 真实获取
- WebSocket 的 RSA 公钥已按参考补全为 2048-bit，并有长度/输出块测试；聊天仍未做真实登录联调
- 新旧对照：旧 JSON 13 条 vs 新 protobuf 20 条，13 条 tid 全部重合；帖子页均 20 条，标题与首楼长度一致
- crypto 参考值：cuid_galaxy2 与 c3_aid 与 aiotieba C 扩展逐字节一致

## 八、验证边界

- 需要 BDUSS/STOKEN 的接口与全部写操作：实现/编译/参数校验完成，未在仓库内用真实账号执行。
- 聊天/BLCP/WS：编译与 31 个单测通过；无真实登录态，未做服务器联调。
- enuid 按参考 C 的零填充实现（42 字符 + 15 个 NUL）；cloud-control 的服务器接受度未实测，失败会记录到 cloudControlError，不影响 IM。
- core/net.py 没有单独 Dart 文件，其职责由 TiebaHttpCore + BlcpConfig/WsConfig 承担。
- get_images 返回原始字节，不移植 aiotieba 的 OpenCV 解码。
- 发帖/回帖不在 aiotieba 中，本项目也未实现。

## 九、新增接口

1. 若为 protobuf：把 .proto 放进 proto/，执行：
   ~~~bash
   protoc -I proto --dart_out=lib/protocol/generated proto/*.proto
   ~~~
2. 在 models/ 增加/复用模型。
3. 在 api/ 实现 fetchXxx / 写操作函数。
4. 在 client.dart 加方法，在 tieba_protocol.dart 导出。
5. 在 test/protocol/ 加模型/JSON/HTML 测试，在 tool/protocol_smoke.dart 加联调输出。