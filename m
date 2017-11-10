From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: fd of an elf object must be
 registered to the fd tracker
Date: Fri, 10 Nov 2017 11:10:28 -0500
Message-ID: <20171110161028.2ds7yhs5hwi5ltut__45907.184694852$1510330261$gmane$org@psrcode-TP-X230>
References: <20171109223621.29638-1-jonathan.rajotte-julien@efficios.com>
 <636768174.12689.1510322527590.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3yYQ481fgnz12Yb
 for <lttng-dev@lists.lttng.org>; Fri, 10 Nov 2017 16:10:31 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A46CF340374
 for <lttng-dev@lists.lttng.org>; Fri, 10 Nov 2017 16:11:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <636768174.12689.1510322527590.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gRnJpLCBOb3YgMTAsIDIwMTcgYXQgMDI6MDI6MDdQTSArMDAwMCwgTWF0aGlldSBEZXNub3ll
cnMgd3JvdGU6Cj4gPiBAQCAtMzEyLDkgKzMyMSwxNSBAQCBlcnJvcjoKPiA+IAlpZiAoZWxmKSB7
Cj4gPiAJCWZyZWUoZWxmLT5laGRyKTsKPiA+IAkJaWYgKGVsZi0+ZmQgPj0gMCkgewo+ID4gLQkJ
CWlmIChjbG9zZShlbGYtPmZkKSkgewo+ID4gKwkJCWx0dG5nX3VzdF9sb2NrX2ZkX3RyYWNrZXIo
KTsKPiA+ICsJCQlyZXQgPSBjbG9zZShlbGYtPmZkKTsKPiA+ICsJCQlpZiAoIXJldCkgewo+ID4g
KwkJCQlsdHRuZ191c3RfZGVsZXRlX2ZkX2Zyb21fdHJhY2tlcihlbGYtPmZkKTsKPiA+ICsJCQl9
IGVsc2Ugewo+ID4gKwkJCQlQRVJST1IoImNsb3NlIik7Cj4gPiAJCQkJYWJvcnQoKTsKPiA+IAkJ
CX0KPiA+ICsJCQlsdHRuZ191c3RfbG9ja19mZF90cmFja2VyKCk7Cj4gCj4gVGhpcyBhcHBlYXJz
IHRvIGJlIGEgZG91YmxlLWxvY2suCgpJIHdhcyB0ZXN0aW5nIHlvdS4uLiBtb3JlIHNlcmlvdXNs
eSBnb29kIGNhdGNoLgoKPiAKPiBIb3cgZGlkIHlvdSB0ZXN0IHRoaXMgY29kZSBwYXRoID8KCkkg
ZGlkIG5vdCB0ZXN0IHRoZSBlcnJvciBwYXRoLiBXaWxsIGJlIG1vcmUgY2FyZWZ1bCBpbiB0aGUg
ZnV0dXJlLgoKdjIgc2ltcGxpZnkgYWxsIG9mIHRoaXMgYnkgdXNpbmcgbHR0bmdfdXN0X2VsZl9k
ZXN0cm95IGRpcmVjdGx5LgoKQ2hlZXJzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
