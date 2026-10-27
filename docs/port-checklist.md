# aiotieba 全量移植清单

> 参考 aiotieba 4.8.2（Unlicense）。
> DONE = 已存在 Dart API 函数/模型且可编译；真实登录态网络行为见文档末尾的验证边界。

## 覆盖统计

- aiotieba API 模块：105 个（含 get_user_contents/profile 等子包）
- Dart 手写协议文件：118 个，约 14,337 行
- protobuf schema：64 份；生成 Dart 文件：193 个
- 协议测试：9 个文件 / 83 个用例
- 额外核心目录：_classdef（共享模型语义）、_protobuf（schema）

## 模块清单

| 模块 | 状态 |
| --- | --- |
| add_bawu | DONE |
| add_bawu_blacklist | DONE |
| add_blacklist_old | DONE |
| add_poll | DONE |
| agree | DONE |
| block | DONE |
| del_bawu | DONE |
| del_bawu_blacklist | DONE |
| del_blacklist_old | DONE |
| del_post | DONE |
| del_posts | DONE |
| del_thread | DONE |
| del_threads | DONE |
| dislike_forum | DONE |
| fetch_chatroom_msg | DONE |
| follow_forum | DONE |
| follow_user | DONE |
| get_ats | DONE |
| get_bawu_blacklist | DONE |
| get_bawu_info | DONE |
| get_bawu_memberlist | DONE |
| get_bawu_perm | DONE |
| get_bawu_postlogs | DONE |
| get_bawu_userlogs | DONE |
| get_blacklist | DONE |
| get_blacklist_old | DONE |
| get_blocks | DONE |
| get_chatroom_detail | DONE |
| get_cid | DONE |
| get_comments | DONE |
| get_dislike_forums | DONE |
| get_fans | DONE |
| get_fid | DONE |
| get_follow_forums | DONE |
| get_follow_forums_pc | DONE |
| get_follows | DONE |
| get_forum | DONE |
| get_forum_detail | DONE |
| get_forum_level | DONE |
| get_group_msg | DONE |
| get_images | DONE |
| get_last_replyers | DONE |
| get_lcm_token | DONE |
| get_member_users | DONE |
| get_posts | DONE |
| get_rank_forums | DONE |
| get_rank_users | DONE |
| get_recom_status | DONE |
| get_recover_info | DONE |
| get_recovers | DONE |
| get_replys | DONE |
| get_roomlist_by_fid | DONE |
| get_self_follow_forums | DONE |
| get_selfinfo_initNickname | DONE |
| get_selfinfo_moindex | DONE |
| get_square_forums | DONE |
| get_statistics | DONE |
| get_tab_map | DONE |
| get_threads | DONE |
| get_uinfo_getUserInfo_web | DONE |
| get_uinfo_getuserinfo_app | DONE |
| get_uinfo_panel | DONE |
| get_uinfo_userCard | DONE |
| get_uinfo_user_json | DONE |
| get_unblock_appeals | DONE |
| get_user_contents | DONE |
| get_user_contents_pc | DONE |
| get_user_forum_info | DONE |
| good | DONE |
| handle_unblock_appeals | DONE |
| init_baidu_id | DONE |
| init_zid | DONE |
| join_chatroom | DONE |
| login | DONE |
| login_blcp_cloud_ctrl | DONE |
| login_blcp_im | DONE |
| login_blcp_lcm | DONE |
| move | DONE |
| profile | DONE |
| push_notify | DONE |
| recommend | DONE |
| recover | DONE |
| remove_fan | DONE |
| search_global | DONE |
| search_in_forum | DONE |
| send_chatroom_msg | DONE |
| send_msg | DONE |
| set_bawu_perm | DONE |
| set_blacklist | DONE |
| set_msg_readed | DONE |
| set_nickname_old | DONE |
| set_profile | DONE |
| set_thread_privacy | DONE |
| sign_forum | DONE |
| sign_forums | DONE |
| sign_growth | DONE |
| sync | DONE |
| tieba_uid2user_info | DONE |
| top | DONE |
| unblock | DONE |
| undislike_forum | DONE |
| unfollow_forum | DONE |
| unfollow_user | DONE |
| ungood | DONE |
| upload_ws_sec | DONE |

## 核心与子包

| 内容 | 状态 |
| --- | --- |
| core/account（全部派生字段） | DONE |
| core/http/net/config（三种传输、代理、超时） | DONE |
| core/blcp（TLS、LCP 帧、RPC、心跳） | DONE |
| core/websocket（握手、加密帧、消息 id） | DONE |
| helper/crypto（cuid_galaxy2/c3_aid/rc4_42/enuid/bduk） | DONE |
| init_zid / init_baidu_id / sync | DONE |
| profile/get_uinfo_profile / profile/get_homepage | DONE |
| get_user_contents/get_threads / get_posts | DONE |
| get_user_contents_pc/get_posts | DONE |
| _classdef / _protobuf | 已生成/已使用 |
| ForumInfoCache | DONE |

## 验证边界

- 公开接口已用真实网络 smoke（吧、帖、楼层、楼中楼、搜索、用户资料、主页、排行、图片、crypto、zid、BAIDUID）。
- 需要 BDUSS/STOKEN 的接口与全部写操作：实现完成、编译通过、参数校验测试通过；未在仓库内用真实账号执行。
- 聊天/BLCP/WS：编译与 28 个单测通过；无真实登录态，未做服务器联调。
- enuid 的服务器接受度未实测（仅 cloud-control 使用，失败会记录到 cloudControlError，不影响 IM 登录）。
- uploadWsSec(full: true) 需要 zid/sampleId/baiduId，已由 init 流程补齐；未做真实 full 握手。
