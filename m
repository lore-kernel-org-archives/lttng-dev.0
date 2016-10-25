From: Nathan Lynch <nathan_lynch@mentor.com>
Subject: [RFC/PATCH 1/3] babeltrace: use AM_TESTS_ENVIRONMENT
	for tests
Date: Tue, 25 Oct 2016 10:34:25 -0500
Message-ID: <1477409667-8309-2-git-send-email-nathan_lynch__267.230548388575$1477409703$gmane$org@mentor.com>
References: <1477409667-8309-1-git-send-email-nathan_lynch@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id DDCABA2F42
 for <lttng-dev@lists.lttng.org>; Tue, 25 Oct 2016 15:34:45 +0000 (UTC)
Received: from svr-orw-mbx-02.mgc.mentorg.com ([147.34.90.202])
 by relay1.mentorg.com with esmtp
 id 1bz3kK-0001X4-Mf from Nathan_Lynch@mentor.com
 for lttng-dev@lists.lttng.org; Tue, 25 Oct 2016 08:34:36 -0700
In-Reply-To: <1477409667-8309-1-git-send-email-nathan_lynch@mentor.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

RXhwb3J0IGNvbnZlbmllbnQgdmFyaWFibGVzIGZyb20gdGhlIGJ1aWxkIHN5c3RlbSBpbnRvIHRo
ZSBydW50aW1lCmVudmlyb25tZW50IG9mIHRoZSB0ZXN0Y2FzZXMsIHNvIHRoYXQgZmV3ZXIgdGVz
dCBzY3JpcHRzIG5lZWQgdG8gYmUKZ2VuZXJhdGVkIGF0IGNvbmZpZ3VyZSB0aW1lIHVzaW5nIEF1
dG9jb25mIHZhcmlhYmxlIHN1YnN0aXR1dGlvbnMuCgpUaGlzIG1ha2VzIGl0IGxlc3MgdGVkaW91
cyB0byBhZGQgYW5kIHdvcmsgb24gdGVzdGNhc2VzIGluIHNjcmlwdApmb3JtLgoKVGhlIHVzZXIg
Y2FuIHN1cHBsZW1lbnQgb3Igb3ZlcnJpZGUgc2V0dGluZ3MgaW4gQU1fVEVTVFNfRU5WSVJPTk1F
TlQKYnkgdXNpbmcgVEVTVFNfRU5WSVJPTk1FTlQgb24gdGhlIGNvbW1hbmQgbGluZS4KClNpZ25l
ZC1vZmYtYnk6IE5hdGhhbiBMeW5jaCA8bmF0aGFuX2x5bmNoQG1lbnRvci5jb20+Ci0tLQogdGVz
dHMvTWFrZWZpbGUuYW0gfCAxMiArKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvTWFrZWZpbGUuYW0gYi90ZXN0cy9NYWtlZmls
ZS5hbQppbmRleCBlZGE5ZjIzNTEzMTAuLjI4Y2IyZWNhNzc3MCAxMDA2NDQKLS0tIGEvdGVzdHMv
TWFrZWZpbGUuYW0KKysrIGIvdGVzdHMvTWFrZWZpbGUuYW0KQEAgLTI5LDMgKzI5LDE1IEBAIGVu
ZGlmCiBpZiBVU0VfUFlUSE9OCiBURVNUUyArPSBiaW4vaW50ZXJzZWN0aW9uL3Rlc3RfbXVsdGlf
dHJhY2VfaW50ZXJzZWN0aW9uLnB5CiBlbmRpZgorCitBTV9URVNUU19FTlZJUk9OTUVOVCA9IFwK
KwlhYnNfdG9wX3NyY2Rpcj0nJChhYnNfdG9wX3NyY2RpciknOyBleHBvcnQgYWJzX3RvcF9zcmNk
aXIgOyBcCisJYWJzX3RvcF9idWlsZGRpcj0nJChhYnNfdG9wX2J1aWxkZGlyKSc7IGV4cG9ydCBh
YnNfdG9wX2J1aWxkZGlyIDsgXAorCVRBUExJQj0nJChhYnNfdG9wX3NyY2RpciknL3Rlc3RzL3V0
aWxzL3RhcC90YXAuc2ggOyBleHBvcnQgVEFQTElCIDsgXAorCUNURl9UUkFDRVM9JyQoYWJzX3Rv
cF9zcmNkaXIpJy90ZXN0cy9jdGYtdHJhY2VzIDsgZXhwb3J0IENURl9UUkFDRVMgOyBcCisJQkFC
RUxUUkFDRV9CSU49JyQoYWJzX3RvcF9idWlsZGRpciknL2NvbnZlcnRlci9iYWJlbHRyYWNlIDsg
XAorCWV4cG9ydCBCQUJFTFRSQUNFX0JJTiA7IFwKKwlERUJVR19JTkZPX0RBVEE9JyQoYWJzX3Rv
cF9zcmNkaXIpJy90ZXN0cy9kZWJ1Zy1pbmZvLWRhdGEgOyBcCisJZXhwb3J0IERFQlVHX0lORk9f
REFUQSA7IFwKKwlHUkVQPSckKEdSRVApJyA7IGV4cG9ydCBHUkVQOyBcCisJU0VEPSckKFNFRCkn
IDsgZXhwb3J0IFNFRDsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
