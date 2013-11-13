From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [lttng-tools PATCH 0/4] Update to utils_expand_path as
	realpath(3) for non-existing directories
Date: Wed, 13 Nov 2013 00:34:34 -0500
Message-ID: <1384320878-28808-1-git-send-email-raphael.beamonte__9206.64075897566$1384320953$gmane$org@gmail.com>
References: <20131112195134.GB12183@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1VgT6N-0004KD-8f
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 00:34:57 -0500
Received: by mail-ie0-f173.google.com with SMTP id x13so8889791ief.32
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 21:34:49 -0800 (PST)
In-Reply-To: <20131112195134.GB12183@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

RGF2aWQsCgpQbGVhc2UgZmluZCBoZXJlIGFuIHVwZGF0ZWQgc2VyaWVzIG9mIHBhdGNoZXMgZm9s
bG93aW5nIHlvdXIKcHJldmlvdXMgY29tbWVudHMuIFRoZXNlIHBhdGNoZXMgaW50cm9kdWNlIHVw
ZGF0ZWQgdmVyc2lvbnMgb2YgdGhlCnV0aWxzX3Jlc29sdmVfcmVsYXRpdmUgYW5kIHV0aWxzX2V4
cGFuZF9wYXRoIGZ1bmN0aW9ucywgYXMgd2VsbCBhcwp1bml0IHRlc3RzIHRvIHZlcmlmeSB0aGVp
ciBiZWhhdmlvci4KClRoYW5rcywKUmFwaGHDq2wKCgpSYXBoYcOrbCBCZWFtb250ZSAoNCk6CiAg
SW50cm9kdWNlIGEgbmV3IHV0aWxzX3Jlc29sdmVfcmVsYXRpdmUgZnVuY3Rpb24KICBUZXN0czog
QWRkIHRlc3RfdXRpbHNfcmVzb2x2ZV9yZWxhdGl2ZSB0byB1bml0IHRlc3RzCiAgQ29ycmVjdCB0
aGUgYmVoYXZpb3Igb2YgdGhlIHV0aWxzX2V4cGFuZF9wYXRoIGZ1bmN0aW9uCiAgVGVzdHM6IEFk
ZCB0ZXN0X3V0aWxzX2V4cGFuZF9wYXRoIHRvIHVuaXQgdGVzdHMKCiAuZ2l0aWdub3JlICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMiArCiBzcmMvY29tbW9uL3V0aWxzLmMgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDE1NCArKysrKysrKysrKysrKysrKysrKysrKy0tLS0KIHNy
Yy9jb21tb24vdXRpbHMuaCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxICsKIHRlc3RzL3Vu
aXQvTWFrZWZpbGUuYW0gICAgICAgICAgICAgICAgICAgfCAgIDIwICsrKy0KIHRlc3RzL3VuaXQv
dGVzdF91dGlsc19leHBhbmRfcGF0aC5jICAgICAgfCAgMTcwICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogdGVzdHMvdW5pdC90ZXN0X3V0aWxzX3Jlc29sdmVfcmVsYXRpdmUuYyB8ICAg
OTggKysrKysrKysrKysrKysrKysKIHRlc3RzL3VuaXRfdGVzdHMgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAyICsKIDcgZmlsZXMgY2hhbmdlZCwgNDIxIGluc2VydGlvbnMoKyksIDI2IGRl
bGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3VuaXQvdGVzdF91dGlsc19leHBh
bmRfcGF0aC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdW5pdC90ZXN0X3V0aWxzX3Jlc29s
dmVfcmVsYXRpdmUuYwoKLS0gCjEuNy4xMC40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
