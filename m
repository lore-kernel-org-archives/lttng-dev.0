From: Chris Cole <ccole@juniper.net>
Subject: undefined reference to `tracepoint_dlopen_ptr'
Date: Wed, 11 Jan 2017 22:04:57 +0000
Message-ID: <2795AB44-5DBF-485F-A104-89F79305BDE2__40895.0758552693$1484236756$gmane$org@juniper.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0135.outbound.protection.outlook.com [104.47.36.135])
 by lists.lttng.org (Postfix) with ESMTPS id 3tzpPl3MX5zkbx
 for <lttng-dev@lists.lttng.org>; Thu, 12 Jan 2017 14:42:16 +0000 (UTC)
Content-Language: en-US
Content-ID: <DCDD9F81D138324C88446F45235627FA@namprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

R3JlZXRpbmdzLg0KDQpTdW1tYXJ5IG9mIHdoYXQgSSdtIHRyeWluZyB0byBkbzoNCg0K4oCiIERl
ZmluZSBvbmUgb3IgbW9yZSB0cmFjZXBvaW50cw0K4oCiIExpbmsgdGhlIHRyYWNlcG9pbnRzIGlu
dG8gYSBzaGFyZWQgbGlicmFyeSBzbyB0aGF0IG11bHRpcGxlIGFwcGxpY2F0aW9ucyBjYW4gdXNl
IHRoZSBjb21tb24gdHJhY2Vwb2ludHMNCuKAoiBIYXZlIHRoZSBhcHBsaWNhdGlvbnMgaW5jbHVk
ZSB0aGUgZ2VuZXJhdGVkIGhlYWRlciBmaWxlIGluIG9yZGVyIHRvIHVzZSB0aGUgdHJhY2Vwb2lu
dChzKQ0KDQpXaGF0IEknbSBzZWVpbmc6DQoNCmV4YW1wbGUtbWFpbi5vOiBJbiBmdW5jdGlvbiBg
X190cmFjZXBvaW50X2NiX0xJQkxPR1RSQUNFX0dFTkVSSUNfVFJBQ0VQT0lOVFNfX19MSUJMT0dU
UkFDRV9HRU5FUklDX0VNRVJHJzoNCi9ob21lL2Njb2xlL3B1YmxpYy9wcjEyNDQ4NjQvLi9nZW5l
cmljX3RyYWNlcG9pbnRzLmhwcDoxMzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdHJhY2Vwb2lu
dF9kbG9wZW5fcHRyJw0KDQpEb2VzIHRoaXMgcmluZyBhIGJlbGw/IElzIHRoaXMgdXNlIGNhc2Ug
c3VwcG9ydGVkPyBQbGVhc2UgYWR2aXNlLg0KDQpDb3JkaWFsZW1lbnQsDQpDaHJpcw0KDQpleGFt
cGxlLW1haW4uY3BwOg0KDQojaW5jbHVkZSA8ZXhhbXBsZS1saWIuaD4gLyogZGVjbGFyZXMgdGhl
ICJmb28iIGZ1bmN0aW9uICovDQojaW5jbHVkZSA8Z2VuZXJpY190cmFjZXBvaW50cy5ocHA+IC8q
IHRoZSBnZW5lcmF0ZWQgdHJhY2Vwb2ludCBoZWFkZXIgKi8NCg0Kc3RhdGljIHZvaWQgYmFyKCkg
ew0KICAgIHRyYWNlcG9pbnQoTElCTE9HVFJBQ0VfR0VORVJJQ19UUkFDRVBPSU5UUywgTElCTE9H
VFJBQ0VfR0VORVJJQ19FTUVSRywgImJhciIpOw0KfQ0KDQppbnQNCm1haW4oaW50IGFyZ2MsIGNo
YXIgKmFyZ3ZbXSkNCnsNCiAgICBmb28oKTsNCiAgICBiYXIoKTsNCg0KICAgIHJldHVybiAwOw0K
fQ0KDQpleGFtcGxlLWxpYi5jcHA6DQoNCiNpbmNsdWRlIDxleGFtcGxlLWxpYi5oPg0KI2luY2x1
ZGUgPGdlbmVyaWNfdHJhY2Vwb2ludHMuaHBwPg0KDQojaW5jbHVkZSA8c3RkaW8uaD4NCg0Kdm9p
ZCBmb28oKSB7DQogICAgdHJhY2Vwb2ludChMSUJMT0dUUkFDRV9HRU5FUklDX1RSQUNFUE9JTlRT
LCBMSUJMT0dUUkFDRV9HRU5FUklDX0VNRVJHLCAiZm9vIik7DQogICAgcHJpbnRmKCJmb29cbiIp
Ow0KfQ0KDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
