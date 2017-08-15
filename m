From: Jonah Graham <jonah@kichwacoders.com>
Subject: Status of MinGW support for babeltrace (either 1.x or
	2.x)
Date: Tue, 15 Aug 2017 17:12:30 +0100
Message-ID: <CAPmGMvh9C2E7y3uDkdHqTizkuPAd9nuPn4OvOjvjDyCqyxhCag__25462.2818007649$1502813773$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sasl.smtp.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
 by lists.lttng.org (Postfix) with ESMTPS id 3xWyJc6nzgzCd6
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 16:15:58 +0000 (UTC)
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
 by pb-smtp2.pobox.com (Postfix) with ESMTP id D315296542
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 12:13:11 -0400 (EDT)
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
 by pb-smtp2.pobox.com (Postfix) with ESMTP id CA8E396541
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 12:13:11 -0400 (EDT)
Received: from mail-it0-f46.google.com (unknown [209.85.214.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C45D96540
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 12:13:11 -0400 (EDT)
Received: by mail-it0-f46.google.com with SMTP id 76so6527100ith.0
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2017 09:13:11 -0700 (PDT)
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

SGVsbG8sCgpPdmVyIHRoZSB5ZWFycyBJIGhhdmUgc2VlbiBzb21lIGRpc2N1c3Npb25zIGFuZCBw
YXRjaGVzIGFib3V0IGdldHRpbmcKZnVsbCBNaW5HVyBzdXBwb3J0IGZvciBiYWJlbHRyYWNlLiBJ
IGFtIGludGVyZXN0ZWQgaW4gaWYgc29tZW9uZSBjYW4KcHJvdmlkZSBhbiBvdmVydmlldyBvZiB0
aGUgY3VycmVudCBzdGF0ZSBvZiBNaW5HVy4KCkkgaGF2ZSB0cmllZCB0byBidWlsZCAxLjUuMyBh
bmQgKHByb2JhYmx5IGFzIGV4cGVjdGVkKSB0aGVyZSBhcmUKbnVtZXJvdXMgY29tcGlsZSBpc3N1
ZXMgKGUuZy4gc3lzL21tYW4uaCkKCkkgaGF2ZSBnb3R0ZW4gZnVydGhlciB3aXRoIGN1cnJlbnQg
bWFzdGVyIChteSBwcmltYXJ5IGludGVyZXN0IGlzCmxpYmJhYmVsdHJhY2Ugc28gdGhlIGlzc3Vl
cyBJIGhhdmUgd2l0aCBjbGkvYmFiZWx0cmFjZS5jIGFuZAp0ZXN0cy90ZXN0X2N0Zl93cml0ZXIu
YyBkb24ndCBjb25jZXJuIG1lIHRvbyBtdWNoIHlldCkuIEhvd2V2ZXIgd2hlbiBJCnRyeSB0byBy
dW4gYSBzaW1wbGUgZXhhbXBsZSAodGhhdCB3b3JrcyBvbiBMaW51eCkgaXQgZmFpbHMgb24KYnRf
Y3RmX3N0cmVhbV9mbHVzaC4gSSB3aWxsIGRlYnVnIGZ1cnRoZXIgdG8gaWRlbnRpZnkgdGhlIHBy
b2JsZW0uCkhvd2V2ZXIgSWYgc29tZW9uZSBkb2VzIGhhdmUgYSBtaW5ndyBwb3J0IHdvcmtpbmcg
d2VsbCBhbnkgZ3VpZGFuY2Ugb24KYnVpbGRpbmcgd291bGQgYmUgbXVjaCBhcHByZWNpYXRlZC4K
ClRoYW5rcwpKb25haAoKCn5+fgpKb25haCBHcmFoYW0KS2ljaHdhIENvZGVycyBMdGQuCnd3dy5r
aWNod2Fjb2RlcnMuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpo
dHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2
Cg==
