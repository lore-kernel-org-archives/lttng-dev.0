Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB37C433EF
	for <lttng-dev@archiver.kernel.org>; Fri, 25 Feb 2022 14:21:23 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4K4sQT0vXNz3lB;
	Fri, 25 Feb 2022 09:21:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1645798882;
	bh=8H01h/prX1p9/eGEGdrNhyRVhoVQw0PW8izaqXBYQWk=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qyKAAHJ1r0ILdMAyLMLgFndphzkEmt7gJ+rUYG2wJCHw+erTb4eCsT9cHDUlfk2RH
	 fj/TXDD3c45MWdlxzLVZi+umeUShDnRIYyI+snb0QCB9RlaeR711rTqRE2g7E7fTcw
	 D0IxcGIal0/JbQKfzU3AuemzIY7IDsAPfEDzX7X336hmM+b4Xj6CL9aCOhsyCj89Av
	 ysf8c7vaUxiXL6x4f1r8AKwiHZEsQQi7pYSXI4qCjHcqLMIvqLZJ0fPD5rGBIO8aCx
	 Ad2wYwbMvhygY8Yg7U6IDTuFMoPHaNZN25NLMyJAf/A07RV93NJwH00QI6hEuddRlr
	 5frEx7FjJD8AA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4K4sQR4r3Wz3Y5
 for <lttng-dev@lists.lttng.org>; Fri, 25 Feb 2022 09:21:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 589C23E3C91
 for <lttng-dev@lists.lttng.org>; Fri, 25 Feb 2022 09:21:13 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Fvu0av1yXHt6; Fri, 25 Feb 2022 09:21:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 655DC3E3B4A;
 Fri, 25 Feb 2022 09:21:12 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 655DC3E3B4A
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id UvxFCM2E27DN; Fri, 25 Feb 2022 09:21:12 -0500 (EST)
Received: from x (unknown [129.222.204.93])
 by mail.efficios.com (Postfix) with ESMTPSA id 123383E3C8E;
 Fri, 25 Feb 2022 09:21:11 -0500 (EST)
Date: Fri, 25 Feb 2022 09:21:11 -0500
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20220225142111.GC1861057@x>
References: <e706d6c8-edea-4f26-a9e2-4a66f067204e.zhenyu.ren@aliyun.com>
 <cbf6b471-85d1-46f5-b10b-2a643b79433c.zhenyu.ren@aliyun.com>
 <c0e023fd-bd52-4125-9e50-c096167386ff.zhenyu.ren@aliyun.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c0e023fd-bd52-4125-9e50-c096167386ff.zhenyu.ren@aliyun.com>
Subject: Re: [lttng-dev] 
 =?utf-8?b?5Zue5aSN77yaIOWbnuWkje+8miBzaG0gbGVhayBp?=
 =?utf-8?q?n_traced_application=3F?=
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgemhlbnl1LnJlbiwKClBsZWFzZSBvcGVuIGEgYnVnIG9uIG91ciBidWcgdHJhY2tlciBhbmQg
cHJvdmlkZSBhIHJlcHJvZHVjZXIgYWdhaW5zdCB0aGUgbGF0ZXN0CnN0YWJsZSB2ZXJzaW9uICgy
LjEzLngpLgoKaHR0cHM6Ly9idWdzLmx0dG5nLm9yZy8KClBsZWFzZSBmb2xsb3cgdGhlIGd1aWRl
bGluZXM6IGh0dHBzOi8vYnVncy5sdHRuZy5vcmcvI0J1Zy1yZXBvcnRpbmctZ3VpZGVsaW5lcwoK
Q2hlZXJzCgpPbiBGcmksIEZlYiAyNSwgMjAyMiBhdCAxMjo0NzozNFBNICswODAwLCB6aGVueXUu
cmVuIHZpYSBsdHRuZy1kZXYgd3JvdGU6Cj4gSGksIGx0dG5nLWRldiB0ZWFtIAo+ICAgIFdoZW4g
bHR0bmctc2Vzc2lvbmQgZXhpdHMsIHRoZSB1c3QgYXBwbGljYXRpb25zIHNob3VsZCBjYWxsIGx0
dG5nX3VzdF9vYmpkX3RhYmxlX293bmVyX2NsZWFudXAoKSBhbmQgY2xlYW4gdXAgYWxsIHNobSBy
ZXNvdXJjZSh1bm1hcCBhbmQgY2xvc2UpLiBIb3dlcnZlciBJIGRvIGZpbmQgdGhhdCB0aGUgdXN0
IGFwcGxpY2F0aW9ucyBrZWVwIG9wZW5pbmcgImFsbCIgb2YgdGhlIHNobSBmZHMoIi9kZXYvc2ht
L3VzdC1zaG0tY29uc3VtZXItODExMzIgKGRlbGV0ZWQpIikgYW5kIGRvIE5PVCBmcmVlIHNobS4K
PiAgICBJZiB3ZSBydW4gbHR0bmctc2Vzc2lvbmQgYWdhaW4sIHVzdCBhcHBsaWNhdGlvbnMgY2Fu
IGdldCBhIG5ldyBwaWVjZSBvZiBzaG0gYW5kIGEgbmV3IGxpc3Qgb2Ygc2htIGZkcyBzbyBkb3Vi
bGUgc2htIHVzYWdlcy4gVGhlbiBpZiB3ZSBraWxsIGx0dG5nLXNlc3Npb25kLCB3aGF0IHRoZSBt
b3N0bGlrZWx5IGhhcHBlbmVkIGlzIHVzdCBhcHBsaWNhdGlvbnMgY2xvc2UgdGhlIG5ldyBsaXN0
IG9mIHNobSBmZHMgYW5kIGZyZWUgbmV3IHNobSByZXNvdXJjZSBidXQga2VlcGluZyBvbGQgc2ht
IHN0aWxsLiBJbiBvdGhlciB3b3JkLCB3ZSBjYW4gbm90IGZyZWUgdGhpcyBwaWVjZSBvZiBzaG0g
dW5sZXNzIHdlIGtpbGxpbmcgdXN0IGFwcGxpY2F0aW9ucyEhIQo+ICAgU28gSXMgdGhlcmUgYW55
IHBvc3NpbGJlIHRoYXQgdXN0IGFwcGxpY2F0aW9ucyBmYWlsZWQgY2FsbGluZyBsdHRuZ191c3Rf
b2JqZF90YWJsZV9vd25lcl9jbGVhbnVwKCk/IERvIHlvdSBoYXZlIGV2ZXIgc2VlIHRoaXMgcHJv
YmxlbT8gRG8geW91IGhhdmUgYW55IGFkdmljZSB0byBmcmVlIHRoZSBzaG0gd2l0aG91dCBraWxs
bGluZyB1c3QgYXBwbGljYXRpb25zKEkgdHJpZWQgdG8gZGlnIGludG8ga2VybmVsIHNobV9vcGVu
IGFuZCAvZGV2L3NobSwgYnV0IG5vdCBmb3VuZCBhbnkgaWRlYXMpPwo+IAo+IFRoYW5rcyBpbiBh
ZHZhbmNlCj4gemhlbnl1LnJlbiAKPiAKPiAKPiAKPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiDlj5Hku7bkurrvvJp6
aGVueXUucmVuIHZpYSBsdHRuZy1kZXYgPGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc+Cj4g5Y+R
6YCB5pe26Ze077yaMjAyMuW5tDLmnIgyM+aXpSjmmJ/mnJ/kuIkpIDIzOjA5Cj4g5pS25Lu25Lq6
77yabHR0bmctZGV2IDxsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnPgo+IOS4u+OAgOmimO+8mlts
dHRuZy1kZXZdIOWbnuWkje+8miBzaG0gbGVhayBpbiB0cmFjZWQgYXBwbGljYXRpb24/Cj4gCj4g
PiJJIGZvdW5kIHRoZXNlIGl0ZW1zIGFsc28gZXhpc3QgaW4gYSB0cmFjZWQgYXBwbGljYXRpb24g
d2hpY2ggaXMgYSBsb25nLXRpbWUgcnVubmluZyBkYWVtb24iCj4gIEV2ZW4gaWYgbHR0bmctc2Vz
c2lvbmQgaGFzIGJlZW4ga2lsbGVkISEKPiAKPiBUaGFua3MKPiB6aGVueXUucmVuCj4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4g5Y+R5Lu25Lq677yaemhlbnl1LnJlbiB2aWEgbHR0bmctZGV2IDxsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnPgo+IOWPkemAgeaXtumXtO+8mjIwMjLlubQy5pyIMjPml6Uo5pif5pyf5LiJ
KSAyMjo0NAo+IOaUtuS7tuS6uu+8mmx0dG5nLWRldiA8bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9y
Zz4KPiDkuLvjgIDpopjvvJpbbHR0bmctZGV2XSBzaG0gbGVhayBpbiB0cmFjZWQgYXBwbGljYXRp
b24/Cj4gCj4gSGksIAo+ICAgIFRoZXJlIGFyZSBtYW55IGl0ZW1zIHN1Y2ggYXMgIi9kZXYvc2ht
L3VzdC1zaG0tY29uc3VtZXItODExMzIgKGRlbGV0ZWQpIiBleGlzdCBpbiBsdHRuZy1zZXNzaW9u
ZCBmZCBzcGFjZXMuIEkga25vdyBpdCBpcyB0aGUgcmVzdWx0IG9mIHNobV9vcGVuKCkgYW5kIHNo
bV91bmxuaWsoKSBpbiBjcmVhdGVfcG9zaXhfc2htKCkuIAo+ICAgIEhvd2V2ZXIsIHRvZGF5LCBJ
IGZvdW5kIHRoZXNlIGl0ZW1zIGFsc28gZXhpc3QgaW4gYSB0cmFjZWQgYXBwbGljYXRpb24gd2hp
Y2ggaXMgYSBsb25nLXRpbWUgcnVubmluZyBkYWVtb24uIFRoZSBtb3N0IGltcG9ydGFudCB0aGlu
ZyBJIGZvdW5kIGlzIHRoYXQgdGhlcmUgc2VlbXMgbm8gcmVsaWFibGUgd2F5IHRvIHJlbGVhc2Ug
c2hhcmUgbWVtb3J5Lgo+ICAgIEkgdHJpZWQgdG8ga2lsbCBsdHRuZy1zZXNzaW9uZCBidXQgbm90
IGFsd2F5cyByZWxlYXNlIHNoYXJlIG1lbW9yeS4gU29tZXRpbWVzIEkgbmVlZCB0byBraWxsIHRo
ZSB0cmFjZWQgYXBwbGljYXRpb24gdG8gZnJlZSBzaGFyZSBtZW1vcnkuLi4uQnV0IGl0IGlzIG5v
dCBhIGdvb2QgaWRlYSB0byBraWxsIHRoZXNlIGFwcGxpY2F0aW9ucy4KPiAgICBNeSBxdWVzdGlv
bnMgYXJlOiAKPiAgICAxLiBJcyB0aGVyZSBhbnkgd2F5IHRvIHJlbGVhc2Ugc2hhcmUgbWVtb3J5
IHdpdGhvdXQga2lsbGluZyBhbnkgdHJhY2VkIGFwcGxpY2F0aW9uPwo+ICAgIDIuIElzIGl0IG5v
cm1hbCB0aGF0IG1hbnkgaXRlbXMgc3VjaCBhcyAiL2Rldi9zaG0vdXN0LXNobS1jb25zdW1lci04
MTEzMiAoZGVsZXRlZCkiIGV4aXN0IGluIHRoZSB0cmFjZWQgYXBwbGljYXRpb24/Cj4gCj4gVGhh
bmtzCj4gemhlbnl1LnJlbgo+IAo+IAoKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgoKCi0tIApKb25hdGhhbiBSYWpvdHRlLUp1bGllbgpFZmZpY2lPUwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYg
bWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
