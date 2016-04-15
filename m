From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [PATCH lttng-modules v4 0/5] Extract payload from
	polling syscalls
Date: Fri, 15 Apr 2016 16:37:16 -0400
Message-ID: <1460752641-28302-1-git-send-email-jdesfossez__42330.354874912$1460752672$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com (albert.ini-tech.com [192.99.35.19])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 2039BA2EF5
 for <lttng-dev@lists.lttng.org>; Fri, 15 Apr 2016 20:37:27 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

UGF0Y2ggc2VyaWUgdG8gZXh0cmFjdCB0aGUgcGF5bG9hZCBvZiB0aGUgcG9sbGluZyBzeXN0ZW0g
Y2FsbHMgb24geDg2IGFuZCBBUk0KKDMyIGFuZCA2NC1iaXQpLiBUaGUgY29uY2VybmVkIHN5c3Rl
bSBjYWxscyBhcmUgc2VsZWN0LCBwc2VsZWN0NiwgcG9sbCwgcHBvbGwsCmVwb2xsX2N0bCwgZXBv
bGxfd2FpdCwgZXBvbGxfcHdhaXQuCgpDaGFuZ2VzIGZyb20gdjM6CiAtIFVzZSBkeW5hbWljIGFs
bG9jYXRpb24gZm9yIHNlbGVjdAogLSBCdWdmaXggZnJvbSB2MyByZXZpZXcKIC0gQ2xlYW51cCBl
cG9sbF93YWl0IGVycm9yIGhhbmRsaW5nCgpDaGFuZ2VzIGZyb20gdjI6CiAtIE1ha2Ugc3VyZSBh
bGwgdXNlci1jb250cm9sbGVkIGRhdGEgaXMgaGFuZGxlZCBzYWZlbHkgaW4gdGhlIGtlcm5lbAog
LSBBbGxvY2F0ZSBtZW1vcnkgaW5zdGVhZCBvZiB1c2luZyB0aGUgc3RhY2sgZm9yIGFyYml0cmFy
aWx5IGxhcmdlIGRhdGEKIC0gT25seSBleHRyYWN0IHRoZSBzdGFuZGFyZCBldmVudCBmbGFncyBh
bmQgb3V0cHV0IHRoZSByYXcgZXZlbnQgdmFsdWUgYXMgaGV4CiAtIFZhcmlvdXMgYnVnZml4ZXMg
ZnJvbSB2MgoKSnVsaWVuIERlc2Zvc3NleiAoNSk6CiAgQWRkIGN0Zl9pbnRlZ2VyX2JpdGZpZWxk
X3R5cGUKICBFeHRyYWN0IHRoZSBGRCBzZXRzIGluIHNlbGVjdCBhbmQgcHNlbGVjdDYKICBFeHRy
YWN0IHRoZSBGRHMgYW5kIGZsYWdzIGZyb20gcG9sbCBhbmQgcHBvbGwKICBFeHRyYWN0IHRoZSBw
YXlsb2FkIGZvciBlcG9sbF9jdGwKICBFeHRyYWN0IHRoZSBwYXlsb2FkIG9mIGVwb2xsX3dhaXQv
ZXBvbGxfcHdhaXQKCiAuLi4vc3lzY2FsbHMvaGVhZGVycy9zeXNjYWxsc19wb2ludGVyc19vdmVy
cmlkZS5oICB8IDkzNiArKysrKysrKysrKysrKysrKysrKysKIHByb2Jlcy9sdHRuZy1ldmVudHMt
d3JpdGUuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgICA4ICsKIDIgZmlsZXMgY2hhbmdlZCwg
OTQ0IGluc2VydGlvbnMoKykKCi0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
