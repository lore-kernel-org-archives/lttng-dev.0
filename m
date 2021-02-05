Return-Path: <SRS0=twZ6=HH=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B71C433DB
	for <lttng-dev@archiver.kernel.org>; Fri,  5 Feb 2021 11:05:38 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A2064F9E
	for <lttng-dev@archiver.kernel.org>; Fri,  5 Feb 2021 11:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A2064F9E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DXCJH4653z18b3;
	Fri,  5 Feb 2021 06:05:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1612523136;
	bh=FfASjrUjy75A4Dq6sBeN6WJLTt34fsWYaYyskyvZFu0=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=fcpe50Hg0p++hvyQUznAKF3DyGASctN/gdyI6tfkdwO1ZtUKE4qACCvH95GCYlK3R
	 nwmjpZGmJQmYcrQA82UJc4Nv0AThFhJOqh8AKS+likXCxqYt+13zCA4nRDwd4/7jz+
	 YDp3YrkmgUIo2yQ2CceWv5MywriC3rwnMyBDXOU6SyaFng72RPb1IpZLB4rYFywKao
	 rXencwcjtUKmE9xmTS14Ki5SLjACWH7XcA6SCBLyWcET6klgMh9MTqVlWFoD9HHkR1
	 iHuNj6jYpwCrijd1oN0JiTEUawruuFOIfHhCd7KHAqJicWXpWwFCSCyoQa5ljaHnJj
	 bfthrfy7jIr3w==
Received: from sainfoin-smtp-out.extra.cea.fr (sainfoin-smtp-out.extra.cea.fr
 [132.167.192.228])
 by lists.lttng.org (Postfix) with ESMTPS id 4DXCJF2fKCz184D
 for <lttng-dev@lists.lttng.org>; Fri,  5 Feb 2021 06:05:33 -0500 (EST)
Received: from pisaure.intra.cea.fr (pisaure.intra.cea.fr [132.166.88.21])
 by sainfoin-sys.extra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with
 ESMTP id 115B5Prc014222; Fri, 5 Feb 2021 12:05:25 +0100
Received: from pisaure.intra.cea.fr (localhost [127.0.0.1])
 by localhost (Postfix) with SMTP id 36DA9207F76;
 Fri,  5 Feb 2021 12:05:25 +0100 (CET)
Received: from muguet1-smtp-out.intra.cea.fr (muguet1-smtp-out.intra.cea.fr
 [132.166.192.12])
 by pisaure.intra.cea.fr (Postfix) with ESMTP id 28EE0207F0E;
 Fri,  5 Feb 2021 12:05:25 +0100 (CET)
Received: from [10.11.241.235] ([10.11.241.235])
 by muguet1-sys.intra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP
 id 115B5PDS001783; Fri, 5 Feb 2021 12:05:25 +0100
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <386C5D4D5C53C24CBC2C60CAAFD2136A5B4A40A0@EXDAG0-B1.intra.cea.fr>
 <CAB4xu_0dP0Hu9pcu7v12c6mjaaTVSrocDZ3f4gJHDge+xzD0jQ@mail.gmail.com>
Message-ID: <6aaf6064-789b-8623-03b9-da9ff98242eb@cea.fr>
Date: Fri, 5 Feb 2021 12:05:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAB4xu_0dP0Hu9pcu7v12c6mjaaTVSrocDZ3f4gJHDge+xzD0jQ@mail.gmail.com>
Content-Language: en-US
Subject: Re: [lttng-dev] [barectf] model.emf.uri
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Ansgar Radermacher via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Ansgar Radermacher <ansgar.radermacher@cea.fr>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgUGhpbGlwcGUsCgp0aGFua3MgZm9yIHRoZSByZXNwb25zZS4gRm9yIHRoZSBtb21lbnQsIHRo
ZSB0cmFjZSB0cmFuc2Zvcm1hdGlvbiBhZGRzIAp0aGUgbW9kZWwuZW1mLnVyaSBkaXJlY3RseSB0
byB0aGUgbWV0YWRhdGEgZmlsZSBhZnRlciBnZW5lcmF0aW9uIHdpdGggCmJhcmVjdGYuIElmIHlv
dSBwb2ludCBtZSB0byB0aGUgcmlnaHQgc291cmNlcywgSSBtaWdodCBiZSBhYmxlIHRvIGFkZCBp
dCAKdG8gYmFyZWN0ZiAoaWYgcHJvZHVjaW5nIENURiAxLjggdHJhY2VzKS4gRG8geW91IGtub3cs
IGlmIG90aGVyIHRyYWNlIAp2aWV3ZXJzLCBub3RhYmx5IFRyYWNlQ29tcGFzcyB3aWxsIGNvbnRp
bnVlIHRvIHN1cHBvcnQgdGhlIG1vZGVsLmVtZi51cmkgCnRhZz8KCkJlc3QgcmVnYXJkcwoKQW5z
Z2FyCgpPbiAwMS8wMi8yMDIxIDE0OjAyLCBQaGlsaXBwZSBQcm91bHggd3JvdGU6Cj4gT24gTW9u
LCBGZWIgMSwgMjAyMSBhdCA0OjM5IEFNIFJBREVSTUFDSEVSIEFuc2dhciB2aWEgbHR0bmctZGV2
Cj4gPGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc+IHdyb3RlOgo+PiBIZWxsbywKPj4KPj4gd2Un
cmUgY3VycmVudGx5IHdvcmtpbmcgb24gQ1RGIGNvZGUgaW5zdHJ1bWVudGF0aW9uIGluIHRoZSBD
KysgY29kZSBnZW5lcmF0aW9uIGZyb20gUGFweXJ1cy4gVW5saWtlIGluIGEgcHJldmlvdXMgdmVy
c2lvbiwgd2UgdXNlIEJhcmVDVEYuCj4+Cj4+IEluIHRoaXMgY29udGV4dCwgdGhlIG1ldGFkYXRh
IHRhZyAibW9kZWwuZW1mLnVyaSIgY2FuIGNvbnRhaW4gdGhlIFVSSSBvZiB0aGUgZWxlbWVudCB0
byB0cmFjZS4gVGhpcyB3b3JrcyBmaW5lIGluIFRyYWNlQ29tcGFzcywgaWYgd2UgbWFudWFsbHkg
YWRkIHRoZSBVUkkgdG8gdGhlIG1ldGFkYXRhLCBhcyBzaG93biBiZWxvdy4gQnV0IEkgaGF2ZSBu
b3QgYmVlbiBhYmxlIHRvIGFkZCBhbiBlbnRyeSB0byBCYXJlQ1RGJ3MgY29uZmlnLnlhbWwgdGhh
dCBwcm9kdWNlcyB0aGUgbW9kZWwuZW1mLnVyaSBpbiB0aGUgZ2VuZXJhdGVkIG1ldGFkYXRhIGZp
bGUuIElzIGl0IHBvc3NpYmxlPwo+Pgo+PiBJIGNvdWxkIG5vdCBmaW5kIGFuIHN1aXRhYmxlIGV4
YW1wbGUgaW4gdGhlIGRvY3VtZW50YXRpb24gLSBJIGV4cGVyaW1lbnRlZCB3aXRoIHRoZSAic3Bl
Y2lmaWMtY29udGV4dC1maWVsZC10eXBlIiwgYnV0IGl0IGFsc28gYWRkcyBhIHBhcmFtZXRlciB0
byB0aGUgZ2VuZXJhdGVkIEMgY29kZSBmdW5jdGlvbnMgd2hpY2ggaXMgbm90IHdoYXQgSSB3YW50
Lgo+Pgo+IFRoYW5rIHlvdSBmb3Igd3JpdGluZyBBbnNnYXIuCj4KPiBBbHRob3VnaCBiYXJlY3Rm
IDMgZ2VuZXJhdGVzIHRyYWNlcnMgd2hpY2ggcHJvZHVjZSBDVEYgMS44IHRyYWNlcywgdGhlCj4g
dWx0aW1hdGUgZ29hbCBvZiB0aGUgcHJvamVjdCBpcyB0byBhZG9wdCBDVEYgMi4gVGhpcyBpcyB3
aHkgdGhlIG1vZGVsCj4gYW5kIHZvY2FidWxhcnkgb2YgaXRzIGNvbmZpZ3VyYXRpb24gZm9ybWF0
IGFyZSB2ZXJ5IGNsb3NlIHRvIHdoYXQncwo+IHByb3Bvc2VkIGluIENURjItUFJPUC0yLjAgWzFd
Lgo+Cj4gQ1RGIDIgaXMgbm90IHJlbGVhc2VkIHlldCBhcyB3ZSBzdGlsbCBuZWVkIHRvIGltcGxl
bWVudCBhbmQgZXhwZXJpbWVudAo+IHdpdGggQ1RGMi1QUk9QLTIuMCBpbiBvdXIgb3Blbi1zb3Vy
Y2UgdG9vbHMgKExUVG5nLCBCYWJlbHRyYWNlLCBhbmQKPiBiYXJlY3RmKSBiZWZvcmUgcHVibGlz
aGluZyBDVEYyLVNQRUMtMi4wLgo+Cj4gSW4gQ1RGIDIsIHdlIGRlY2lkZWQgdG8gcmVtb3ZlIHRo
ZSBFTUYgVVJJIGNvbmNlcHQgWzJdOgo+Cj4+IFRoZSBFTUYgVVJJIHByb3BlcnR5IGlzIHJlbW92
ZWQgZnJvbSB0aGUgZXZlbnQgcmVjb3JkIGNsYXNzLgo+Pgo+PiBUaGlzIEVjbGlwc2UgTW9kZWxp
bmcgRnJhbWV3b3JrIHByb3BlcnR5IGlzIG5vdCBjb21tb24gZW5vdWdoIGZvciB0aGUKPj4gQ29t
bW9uIFRyYWNlIEZvcm1hdC4KPj4KPj4gQSBwcm9kdWNlciBjYW4gc3RpbGwgd3JpdGUgc3VjaCBh
biBVUkkgYXMgYW4gZXZlbnQgcmVjb3JkIGNsYXNz4oCZcyB1c2VyCj4+IGF0dHJpYnV0ZS4KPiBJ
bmRlZWQsIHdlIGJlbGlldmUgdGhpcyBwcm9wZXJ0eSBpbiBDVEYgMS44IGlzIHRvbyBzcGVjaWZp
YyB0byByZW1haW4gYQo+IHBhcnQgb2YgdGhlIGNvcmUgc3BlY2lmaWNhdGlvbiBvZiBDVEYgMi4K
Pgo+IEFzIHRoZSBxdW90YXRpb24gYWJvdmUgaW5kaWNhdGVzLCB0aGUgYWx0ZXJuYXRpdmUgd2ls
bCBiZSB0byBzcGVjaWZ5IHRoZQo+IEVNRiBVUkkgYXMgYSBjdXN0b20gZXZlbnQgcmVjb3JkIGNs
YXNzIHVzZXIgYXR0cmlidXRlIFszXSwgdW5kZXIgYQo+IHNwZWNpZmljIG5hbWVzcGFjZS4gTXkg
Z3Vlc3MgaXMgdGhhdCBhbm90aGVyIHNwZWNpZmljYXRpb24gZG9jdW1lbnQgd2lsbAo+IGVtZXJn
ZSBmcm9tIHNvbWUgb3JnYW5pemF0aW9uIHRvIHNob3cgdGhlIGV4YWN0IG5hbWVzcGFjZSBhbmQg
dXNlcgo+IGF0dHJpYnV0ZSBuYW1lLiBJbiBiYXJlY3RmIDMsIGl0IGNvdWxkIGxvb2sgbGlrZSB0
aGlzIChldmVudCByZWNvcmQgdHlwZQo+IG9iamVjdCk6Cj4KPiAgICAgIG15LWV2ZW50Ogo+ICAg
ICAgICB1c2VyLWF0dHJpYnV0ZXM6Cj4gICAgICAgICAgZWNsaXBzZS5vcmc6Cj4gICAgICAgICAg
ICBlbWYtdXJpOgo+IHBsYXRmb3JtOi9yZXNvdXJjZS9EZW1vVHJhY2UvRGVtb1RyYWNlLnVtbCNf
QVZyZUptOWZFZXFKZUk4bWJMTFJjZwo+ICAgICAgICBwYXlsb2FkLWZpZWxkLXR5cGU6Cj4gICAg
ICAgICAgY2xhc3M6IHN0cnVjdHVyZQo+ICAgICAgICAgIG1lbWJlcnM6Cj4gICAgICAgICAgICAt
IG1zZzogc3RyaW5nCj4gICAgICAgICAgICAtIGlkOiB1aW50MzIKPgo+IFVuZm9ydHVuYXRlbHks
IHdlJ3JlIGN1cnJlbnRseSBpbiBhIHN0YWdlIG9mIHRyYW5zaXRpb24gZnJvbSBDVEYgMS44IHRv
Cj4gQ1RGIDIuIFdlIGNhbid0IGFkZCB0aGUgdXNlciBhdHRyaWJ1dGUgZmVhdHVyZSB1bnRpbCBD
VEYyLVNQRUMtMi4wIGlzCj4gcmF0aWZpZWQuCj4KPiBUaGF0IGJlaW5nIHNhaWQsIEkgY2FuIGFj
Y2VwdCB0aGF0IGJhcmVjdGYgMyBoYXMgdGhlIEVNRiBVUkkgZmVhdHVyZSwKPiBidXQgb25seSB3
aGVuIGl0IGdlbmVyYXRlcyBDVEYgMS44LXByb2R1Y2luZyB0cmFjZXJzLiBJIGRvbid0IGhhdmUg
dGltZQo+IHRvIGltcGxlbWVudCB0aGlzIGN1cnJlbnRseSwgYnV0IEkgd2lsbCBhY2NlcHQgYSBw
YXRjaC4gVGVsbCBtZSBpZiB5b3UKPiB3YW50IHRvIGRvIHRoaXM7IEknbGwgZ2l2ZSB5b3UgbW9y
ZSBkZXRhaWxzLgo+Cj4gQlIsCj4KPiBQaGlsCj4KPiBbMV06IGh0dHBzOi8vZGlhbW9uLm9yZy9j
dGYvZmlsZXMvQ1RGMi1QUk9QLTIuMHJBLmh0bWwKPiBbMl06IGh0dHBzOi8vZGlhbW9uLm9yZy9j
dGYvZmlsZXMvQ1RGMi1QUk9QLTIuMHJBLmh0bWwjX2NoYW5nZXNfc2luY2VfY3RmMQo+IFszXTog
aHR0cHM6Ly9kaWFtb24ub3JnL2N0Zi9maWxlcy9DVEYyLVBST1AtMi4wckEuaHRtbCN1c2VyLWF0
dHJzCj4KPj4gQmVzdCByZWdhcmRzCj4+Cj4+IEFuc2dhcgo+Pgo+Pgo+PiAuLi4KPj4gZXZlbnQg
ewo+PiAgICAgIHN0cmVhbV9pZCA9IDA7Cj4+ICAgICAgaWQgPSAxOwo+PiAgICAgIG5hbWUgPSAi
c3RhdGVfQzFfRmlyc3RTdGF0ZV9zdGF0ZSI7Cj4+ICAgICAgbW9kZWwuZW1mLnVyaSA9ICJwbGF0
Zm9ybTovcmVzb3VyY2UvRGVtb1RyYWNlL0RlbW9UcmFjZS51bWwjX0FWcmVKbTlmRWVxSmVJOG1i
TExSY2ciOwo+PiAgICAgIGZpZWxkcyA6PSBzdHJ1Y3Qgewo+PiAgICAgICAgICBzdHJpbmcgewo+
PiAgICAgICAgICAgICAgZW5jb2RpbmcgPSBVVEY4Owo+PiAgICAgICAgICB9IGluc3RhbmNlSWQ7
Cj4+ICAgICAgfSBhbGlnbigxKTsKPj4gfTsKPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+PiBsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCj4+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYKPiAuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
