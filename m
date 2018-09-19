From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Skip uid registry when
	metadata key is 0
Date: Wed, 19 Sep 2018 11:53:30 -0400
Message-ID: <20180919155328.GD2836__26838.7389755391$1537372301$gmane$org@gmail.com>
References: <20180911000915.29177-1-jonathan.rajotte-julien@efficios.com>
 <20180911000915.29177-3-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by lists.lttng.org (Postfix) with ESMTPS id 42Fkt62XfbzxR3
 for <lttng-dev@lists.lttng.org>; Wed, 19 Sep 2018 11:53:34 -0400 (EDT)
Received: by mail-qk1-f196.google.com with SMTP id b19-v6so3265164qkc.6
 for <lttng-dev@lists.lttng.org>; Wed, 19 Sep 2018 08:53:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180911000915.29177-3-jonathan.rajotte-julien@efficios.com>
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
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuMTEsIHN0YWJsZS0yLjEwLCBhbmQgc3RhYmxlLTIu
OS4KClRoYW5rcywKSsOpcsOpbWllCgpPbiBNb24sIFNlcCAxMCwgMjAxOCBhdCAwODowOToxM1BN
IC0wNDAwLCBKb25hdGhhbiBSYWpvdHRlIHdyb3RlOgo+IEEgdmFsdWUgb2YgemVybyBmb3IgdGhl
IG1ldGFkYXRhIGtleSBpbmRpY2F0ZSB0aGF0IG1ldGFkYXRhIHdhcyBuZXZlcgo+IGNyZWF0ZWQv
cHVzaGVkIHRvIHRoZSBjb25zdW1lci4KPiAKPiBUaGlzIGNhbiBvY2N1ciBpbiBzY2VuYXJpbyB3
ZXJlIGEgdHJhY2tlciBpcyBwcmVzZW50IHNpbmNlIG1ldGFkYXRhCj4gbWlnaHQgbmV2ZXIgYmUg
Y3JlYXRlZC9wdXNoZWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9u
YXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBzcmMvYmluL2x0dG5n
LXNlc3Npb25kL3VzdC1hcHAuYyB8IDUgKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1hcHAu
YyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXN0LWFwcC5jCj4gaW5kZXggNWNmOTA0OTM5Li41
MmQxZGE3ODcgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3QtYXBwLmMK
PiArKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1hcHAuYwo+IEBAIC01OTc1LDYgKzU5
NzUsMTEgQEAgaW50IHVzdF9hcHBfc25hcHNob3RfcmVjb3JkKHN0cnVjdCBsdHRfdXN0X3Nlc3Np
b24gKnVzZXNzLAo+ICAJCQlzdHJ1Y3QgYnVmZmVyX3JlZ19jaGFubmVsICpyZWdfY2hhbjsKPiAg
CQkJc3RydWN0IGNvbnN1bWVyX3NvY2tldCAqc29ja2V0Owo+ICAKPiArCQkJaWYgKCFyZWctPnJl
Z2lzdHJ5LT5yZWcudXN0LT5tZXRhZGF0YV9rZXkpIHsKPiArCQkJCS8qIFNraXAgc2luY2Ugbm8g
bWV0YWRhdGEgaXMgcHJlc2VudCAqLwo+ICsJCQkJY29udGludWU7Cj4gKwkJCX0KPiArCj4gIAkJ
CS8qIEdldCBjb25zdW1lciBzb2NrZXQgdG8gdXNlIHRvIHB1c2ggdGhlIG1ldGFkYXRhLiovCj4g
IAkJCXNvY2tldCA9IGNvbnN1bWVyX2ZpbmRfc29ja2V0X2J5X2JpdG5lc3MocmVnLT5iaXRzX3Bl
cl9sb25nLAo+ICAJCQkJCXVzZXNzLT5jb25zdW1lcik7Cj4gLS0gCj4gMi4xNy4xCj4gCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
