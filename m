From: Marie Martin <marie.martin@polymtl.ca>
Subject: Writing from a trace to a new one with Babeltrace
	2.0.0-pre1 C API
Date: Thu, 29 Jun 2017 17:37:59 +0000
Message-ID: <20170629173759.Horde.kCuOU2mQOZ_Der3ikj7HkVm__28582.4212398895$1498758354$gmane$org@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 3wz6Xn6mMzzvBb
 for <lttng-dev@lists.lttng.org>; Thu, 29 Jun 2017 17:46:33 +0000 (UTC)
Received: from horde5.polymtl.ca (horde5.polymtl.ca [132.207.4.156])
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id v5THbxXZ022671
 for <lttng-dev@lists.lttng.org>; Thu, 29 Jun 2017 13:38:00 -0400
Content-Disposition: inline
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

SGkgZXZlcnlvbmUhCgpJJ20gdHJ5aW5nIHRvIHVzZSBCYWJlbHRyYWNlIDIuMC4wLXByZTEgQyBB
UEkgdG8gY29weSBzb21lIGV2ZW50cyBvZiAgCmFuIGV4aXN0aW5nIENURiB0cmFjZSAoZ2VuZXJh
dGVkIHdpdGggTFRUbmcpIGludG8gYSBuZXcgb25lLiBTbyBJIHdhcyAgCndvbmRlcmluZyBob3cg
SSBzaG91bGQgb3BlbiB0aGUgZXhpc3RpbmcgdHJhY2UgYW5kIGl0ZXJhdGUgb3ZlciBpdHMgIApl
dmVudHMsIGFzIHRoZXJlIGlzIG5vIG1ldGhvZCBidF9jdGZfaXRlcl9jcmVhdGUsICAKYnRfY3Rm
X2l0ZXJfcmVhZF9ldmVudCBhbmQgc3VjaCwgYW55bW9yZS4KCkJlZm9yZSwgd2l0aCB0aGUgMS41
IEFQSSwgSSB3YXMgcmVhZGluZyB0aGUgdHJhY2UgbGlrZSB0aGlzIDoKICAgICBzdHJ1Y3QgYnRf
Y29udGV4dCAqY3R4ID0gYnRfY29udGV4dF9jcmVhdGUoKTsKICAgICBpbnQgdHJhY2VfaWQgPSBi
dF9jb250ZXh0X2FkZF90cmFjZShjdHgsIHJlYWRfdHJhY2VfcGF0aCwgImN0ZiIsICAKTlVMTCwg
TlVMTCwgTlVMTCk7CiAgICAgc3RydWN0IGJ0X2N0Zl9pdGVyICppdGVyID0gYnRfY3RmX2l0ZXJf
Y3JlYXRlKGN0eCwgTlVMTCwgTlVMTCk7CiAgICAgd2hpbGUgKChjdGZfZXZlbnQgPSBidF9jdGZf
aXRlcl9yZWFkX2V2ZW50KGl0ZXIpKSkgeyAuLi4gfQoKSSdtIG5vdCBzdXJlIGFib3V0IHRoZSBw
cm9wZXIgd2F5IHRvIGRvIGl0IG5vdy4gSSB0cmllZCB0byByZXBsaWNhdGUgIApzb21lIG9mIHRo
ZSBjb2RlIGZyb20gYmFiZWx0cmFjZS5jIChlc3BlY2lhbGx5IHRoZSBjbWRfcnVuIGZ1bmN0aW9u
KSAgCmFuZCBJJ20gYWJsZSB0byBwcmludCBtZXRhZGF0YSBmcm9tIHRoZSB0cmFjZSAodXNpbmcg
IApidF9jb21wb25lbnRfY2xhc3NfcXVlcnkoc3JjX2NvbXBvbmVudF9jbGFzcywgIm1ldGFkYXRh
LWluZm8iLCBwYXJhbXMpICAKYWZ0ZXIgZ2V0dHRpbmcgdGhlIGN0ZiBwbHVnaW4gYW5kIHRoZSBz
b3VyY2UgY29tcG9uZW50KS4gQ2FuIEkgdXNlICAKcXVlcmllcyBpbiBhIHNpbWlsYXIgd2F5IHRv
IGFjY2VzcyB0cmFjZSBldmVudHMgZGF0YSA/CgpJIGFsc28gdHJpZWQgdG8gaW5zdGFudGlhdGUg
YSBuZXcgZ3JhcGgsIGFkZCB0aGUgY3RmIHBsdWdpbiBjb21wb25lbnRzICAKdG8gdGhlIGdyYXBo
IGFuZCBydW4gaXQsIGJ1dCBJIGRvbid0IGtub3cgaG93IHRvIGNvbGxlY3QgZXZlbnRzLgoKQWxz
bywgc2hvdWxkIEkgZGVmaW5lIG15IG93biBjdXN0b20gcGx1Z2luIGZvciB0aGF0IHB1cnBvc2Ug
PwoKVGhhbmtzLAoKTWFyaWUgTWFydGluCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
