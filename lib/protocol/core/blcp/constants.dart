/// Constants of the Tieba chat/IM subsystem.
///
/// Ported from `aiotieba/core/blcp/const.py` and `aiotieba/const.py`
/// (Unlicense).
library;

import '../constants.dart';

/// Tieba IM app id.
const int chatAppId = 10773430;

/// IM SDK version, used by the business-plane payloads.
const int chatSdkVersion = 11250036;

/// LCP SDK version, used by the LCM login and token requests.
const String lcpSdkVersion = '3460016';

/// Client version reported by the chat APIs.
const String chatVersion = TiebaConstants.latestVersion;
