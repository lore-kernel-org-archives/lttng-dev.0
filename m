From: Eugene Ivanov <Eugene.Ivanov@orc-group.com>
Subject: Composition of objects and call_rcu() inside helper
	thread
Date: Mon, 7 Dec 2015 15:09:38 +0000
Message-ID: <ADB30B76-2E72-4DBE-80BD-642912C0BEDF__9327.32923324711$1449501066$gmane$org@orc-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx03.orcsoftware.com ([194.14.211.251]
 helo=nan.ad.orcsoftware.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Eugene.Ivanov@orc-group.com>) id 1a5xQ5-0006ZS-E0
 for lttng-dev@lists.lttng.org; Mon, 07 Dec 2015 10:09:49 -0500
Content-Language: en-US
Content-ID: <B981B2928FE4874DB3DAD6FA5A889653@orc-group.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGksDQoNCkkgaGF2ZSByY3VsZmhhc2ggd2hpY2ggY29udGFpbnMgb2JqZWN0cyB3aXRoIHJjdWxm
aGFzaGVzLiBXaGVuIEkgZGVzdHJ1Y3Qg4oCcYmln4oCdIG1hcCBpdCB1c2VzIGNhbGxfcmN1KCkg
Zm9yIGV2ZXJ5IGl0ZW0uIFdoZW4gaW50ZXJuYWwgaGFzaGVzIGFyZSBkZXN0cnVjdGVkIHRoZXkg
dXNlIGNhbGxfY3UoKSB0b28uIEl0IHNlZW1zIHRoYXQgdG8gd2FpdCB1bnRpbCBldmVyeXRoaW5n
IGlzIGRlc3RydWN0ZWQgSSBuZWVkIHR3byBiYXJyaWVycyBhdCB0aGUgZW5kIG9mIHRoZSBiaWcg
aGFzaCBkZXN0cnVjdG9yLiBCdXQgaG93IGNhbiBzb21lb25lIGhhbmRsZSBkZWVwZXIgaGllcmFy
Y2h5PyBJcyB0aGVyZSBhbnkgd2F5IHRvIGRldGVybWluZSB0aGF0IGl0IGlzIGhlbHBlciB0aHJl
YWQgdG8gbm90IHVzZSBjYWxsX3JjdSgpIGFuZCBkZXN0cnVjdCBldmVyeXRoaW5nIGluIHBsYWNl
Pw0KDQoNCkJlc3QgcmVnYXJkcywNCkV1Z2VuZSBJdmFub3YNCg0KDQoNCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCg0KVGhpcyBlLW1haWwgaXMgY29uZmlkZW50aWFsIGFuZCBt
YXkgY29udGFpbiBsZWdhbGx5IHByaXZpbGVnZWQgaW5mb3JtYXRpb24uIEl0IGlzIGludGVuZGVk
IG9ubHkgZm9yIHRoZSBhZGRyZXNzZWVzLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFp
bCBpbiBlcnJvciwga2luZGx5IG5vdGlmeSB1cyBpbW1lZGlhdGVseSBieSB0ZWxlcGhvbmUgb3Ig
ZS1tYWlsIGFuZCBkZWxldGUgdGhlIG1lc3NhZ2UgZnJvbSB5b3VyIHN5c3RlbS4NCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2Nn
aS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
