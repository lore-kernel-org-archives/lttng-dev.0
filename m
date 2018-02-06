From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: do not flag consumer as
 disabled on relayd comm failure
Date: Tue, 6 Feb 2018 11:55:15 -0500
Message-ID: <20180206165514.GA3966__49253.5849022262$1517936092$gmane$org@gmail.com>
References: <1516924647-22584-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 by lists.lttng.org (Postfix) with ESMTPS id 3zbVvC4Q6Lz1117
 for <lttng-dev@lists.lttng.org>; Tue,  6 Feb 2018 16:55:19 +0000 (UTC)
Received: by mail-qt0-x241.google.com with SMTP id t25so3160209qtg.3
 for <lttng-dev@lists.lttng.org>; Tue, 06 Feb 2018 08:55:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1516924647-22584-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuMTAsIGFuZCBzdGFibGUtMi45LgoKVGhhbmtzIQpK
w6lyw6ltaWUKCk9uIFRodSwgSmFuIDI1LCAyMDE4IGF0IDA2OjU3OjI3UE0gLTA1MDAsIEpvbmF0
aGFuIFJham90dGUgd3JvdGU6Cj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9u
YXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBzcmMvYmluL2x0dG5n
LXNlc3Npb25kL2NtZC5jIHwgMTAgKysrKystLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5n
LXNlc3Npb25kL2NtZC5jIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9jbWQuYwo+IGluZGV4IGEy
OTUwNTkuLjFlZGNmZmUgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9jbWQu
Ywo+ICsrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY21kLmMKPiBAQCAtOTIwLDcgKzkyMCw3
IEBAIHN0YXRpYyBpbnQgc2VuZF9jb25zdW1lcl9yZWxheWRfc29ja2V0KGVudW0gbHR0bmdfZG9t
YWluX3R5cGUgZG9tYWluLAo+ICAJLyogQ29ubmVjdCB0byByZWxheWQgYW5kIG1ha2UgdmVyc2lv
biBjaGVjayBpZiB1cmkgaXMgdGhlIGNvbnRyb2wuICovCj4gIAlyZXQgPSBjcmVhdGVfY29ubmVj
dF9yZWxheWQocmVsYXlkX3VyaSwgJnJzb2NrLCBjb25zdW1lcik7Cj4gIAlpZiAocmV0ICE9IExU
VE5HX09LKSB7Cj4gLQkJZ290byBlcnJvcjsKPiArCQlnb3RvIHJlbGF5ZF9jb21tX2Vycm9yOwo+
ICAJfQo+ICAJYXNzZXJ0KHJzb2NrKTsKPiAgCj4gQEAgLTk2MCwxMCArOTYwLDYgQEAgc3RhdGlj
IGludCBzZW5kX2NvbnN1bWVyX3JlbGF5ZF9zb2NrZXQoZW51bSBsdHRuZ19kb21haW5fdHlwZSBk
b21haW4sCj4gIAkgKi8KPiAgCj4gIGNsb3NlX3NvY2s6Cj4gLQkodm9pZCkgcmVsYXlkX2Nsb3Nl
KHJzb2NrKTsKPiAtCWZyZWUocnNvY2spOwo+IC0KPiAtZXJyb3I6Cj4gIAlpZiAocmV0ICE9IExU
VE5HX09LKSB7Cj4gIAkJLyoKPiAgCQkgKiBUaGUgY29uc3VtZXIgb3V0cHV0IGZvciB0aGlzIHNl
c3Npb24gc2hvdWxkIG5vdCBiZSB1c2VkIGFueW1vcmUKPiBAQCAtOTcyLDYgKzk2OCwxMCBAQCBl
cnJvcjoKPiAgCQkgKi8KPiAgCQljb25zdW1lci0+ZW5hYmxlZCA9IDA7Cj4gIAl9Cj4gKwkodm9p
ZCkgcmVsYXlkX2Nsb3NlKHJzb2NrKTsKPiArCWZyZWUocnNvY2spOwo+ICsKPiArcmVsYXlkX2Nv
bW1fZXJyb3I6Cj4gIAlyZXR1cm4gcmV0Owo+ICB9Cj4gIAo+IC0tIAo+IDIuNy40Cj4gCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
