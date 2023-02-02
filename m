Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B41C05027
	for <lttng-dev@archiver.kernel.org>; Thu,  2 Feb 2023 16:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1675355135;
	bh=B2ArAx7I9xZAOxOLkyYbXwOa/Be1fL8HbVdGuCDvNK0=;
	h=Date:To:Cc:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=sd9ifRRbr2Qby21pCuezqOp0U5yzBga8Neba2t7mtWtAq/6KSjX70OenFG6F8YwyG
	 OzbvR0k/91XBBdXTvMs9HcOxzxqGxHW/T1dznp9rWIi5QvZOa/+TrQt72L9vIpthcT
	 Ux9u686EygtgVV0Xu6BprTzO5gzc7Q780SroYhJoj2k8sHA/K+HFtKOr8U7Ub4nUT3
	 hXKE59MrigLuSciKeBrdku8B+/H9w5JyptjOkCMxxGBCu4BLrZIHFyqdXyUIBvrZ7l
	 rfNgta2VUmd++1G4BpfIZ4qac+9bfIBtXkKAI7aBh8pZx3BJw/la4b1490Zn/6WtzC
	 lQIuh+hckggFA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4P73zz0zw0z1XpW;
	Thu,  2 Feb 2023 11:25:35 -0500 (EST)
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
 by lists.lttng.org (Postfix) with ESMTP id 4P73b80xFBz1XdM
 for <lttng-dev@lists.lttng.org>; Thu,  2 Feb 2023 11:07:31 -0500 (EST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtpfb2-g21.free.fr (Postfix) with ESMTP id 3F2B34DA8F
 for <lttng-dev@lists.lttng.org>; Thu,  2 Feb 2023 17:07:30 +0100 (CET)
Received: from zimbra43-e7.priv.proxad.net (unknown [172.20.243.193])
 by smtp1-g21.free.fr (Postfix) with ESMTP id C30F6B0053E;
 Thu,  2 Feb 2023 17:06:48 +0100 (CET)
Date: Thu, 2 Feb 2023 17:06:47 +0100 (CET)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <233483636.139091746.1675354007888.JavaMail.root@zimbra43-e7.priv.proxad.net>
In-Reply-To: <1512260626.80256142.1673861908243.JavaMail.root@zimbra43-e7.priv.proxad.net>
MIME-Version: 1.0
X-Originating-IP: [185.105.31.250]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Win)/7.2.0-GA2598)
X-Authenticated-User: chafraysse@free.fr
X-Mailman-Approved-At: Thu, 02 Feb 2023 11:25:33 -0500
Subject: Re: [lttng-dev] LTTng UST structure support
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
From: chafraysse--- via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: chafraysse@free.fr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGksCgpTbyBJIHdyb3RlIGEgZHJhZnQgb2YgUnVzdCBsaWIgYWJvdmUgY3RmLXdyaXRlciwgdXNp
bmcgdGhlIGFwaXMgYXMgZGVtb25zdHJhdGVkIGluIHRoZSBjdGYtd3JpdGVyIHRlc3QKRm9yIGRl
cGxveW1lbnQgSSB3YW50ZWQgdG8gdXNlICJsaWJiYWJlbHRyYWNlMi1jdGYtd3JpdGVyLnNvIiBp
biB0aGUgImxpYmJhYmVsdHJhY2UyLWRldiIgcGFja2FnZSBidXQgSSBjb3VsZCBub3QgbG9jYXRl
IHRoZSBtYXRjaGluZyBpbmNsdWRlcyBpbiB0aGVyZSBvciBpbiB0aGUgb3RoZXIgYmFiZWx0cmFj
ZSAyIHBhY2thZ2VzCkRpZCBJIG1pc3MgdGhlbSBzb21ld2hlcmUgPyBTaG91bGQgSSBoYXZlIHBs
dWdnZWQgaW4gYXQgYW5vdGhlciBsZXZlbCBpbiBiYWJlbHRyYWNlMiA/CgpCZXN0IHJlZ2FyZHMs
CgpDaGFybGVzCgotLS0tLSBNYWlsIG9yaWdpbmFsIC0tLS0tCkRlOiBjaGFmcmF5c3NlQGZyZWUu
ZnIKw4A6ICJNYXRoaWV1IERlc25veWVycyIgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNv
bT4KQ2M6IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKRW52b3nDqTogTHVuZGkgMTYgSmFudmll
ciAyMDIzIDEwOjM4OjI4Ck9iamV0OiBSZTogW2x0dG5nLWRldl0gTFRUbmcgVVNUIHN0cnVjdHVy
ZSBzdXBwb3J0CgpIaSBNYXRoaWV1LAoKVGhhbmtzIGZvciB5b3VyIHJlcGx5IDopCkknbGwgc3Rp
Y2sgdG8gYnQyIG1vZHVsZXMgaW4gdGhlIG1lYW50aW1lIHRoZW4KSSdsbCBhbHJlYWR5IGJlIHNh
dmluZyBhIHRvbiBvZiB0aW1lIHdpdGggdGhvc2UgYW5kIHRoZSBDVEYgc3BlYyB3aGljaCBpcyBn
cmVhdCAhCgpCZXN0IHJlZ2FyZHMsCgpDaGFybGVzCgotLS0tLSBNYWlsIG9yaWdpbmFsIC0tLS0t
CkRlOiAiTWF0aGlldSBEZXNub3llcnMiIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+
CsOAOiBjaGFmcmF5c3NlQGZyZWUuZnIsIGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKRW52b3nD
qTogSmV1ZGkgMTIgSmFudmllciAyMDIzIDIxOjEwOjU3Ck9iamV0OiBSZTogW2x0dG5nLWRldl0g
TFRUbmcgVVNUIHN0cnVjdHVyZSBzdXBwb3J0CgpPbiAyMDIzLTAxLTA5IDA5OjAyLCBjaGFmcmF5
c3NlLS0tIHZpYSBsdHRuZy1kZXYgd3JvdGU6Cj4gSGksCj4gCj4gSSdtIGxvb2tpbmcgZm9yIGEg
Q1RGIHdyaXRlciB0byBzZXJpYWxpemUgaW5zdHJ1bWVudGF0aW9ucyBpbiBhbiAKPiBlbWJlZGRl
ZCBMaW51eC9SdXN0IGZyYW1ld29yawo+IExUVG5nIFVTVCBsb29rZWQgbGlrZSBhIHZlcnkgc3Ry
b25nIG9wdGlvbiwgYnV0IEkgd2FudCB0byBzZXJpYWxpemUgCj4gc3RydWN0dXJlcyBhcyBDVEYg
Y29tcG91bmQgdHlwZSBzdHJ1Y3R1cmVzIGFuZCBJIGRpZCBub3Qgc2VlIHRob3NlIAo+IHN1cHBv
cnRlZCBpbiB0aGUgZG9jIG9yIGFwaQoKVGhpcyBpcyBjb3JyZWN0LiBJIGFtIGN1cnJlbnRseSB3
b3JraW5nIG9uIGEgbmV3IHByb2plY3QgY2FsbGVkIAoibGlic2lkZSIgKHNlZSBodHRwczovL2dp
dC5lZmZpY2lvcy5jb20vP3A9bGlic2lkZS5naXQ7YT1zdW1tYXJ5KSB3aGljaCAKZmVhdHVyZXMg
c3VwcG9ydCBmb3IgY29tcG91bmQgdHlwZXMuCgpIb3dldmVyLCB3ZSBzdGlsbCBuZWVkIHRvIGRv
IHRoZSBoZWF2eS1saWZ0aW5nIGltcGxlbWVudGF0aW9uIHdvcmsgb2YgCmludGVncmF0aW5nIHRo
aXMgd2l0aCBMVFRuZy1VU1QuIFRoaXMgaXMgdGhlIHBsYW4gdG93YXJkcyBzdXBwb3J0aW5nIApj
b21wb3VuZCB0eXBlcyBpbiBMVFRuZy1VU1QuCgo+IEknZCBsb3ZlIHRvIGhhdmUgY29uZmlybWF0
aW9uIHRoYXQgSSBkaWQgbm90IGp1c3QgbWlzcyBzb21ldGhpbmcgOikKPiBJZiBMVFRuZyBVU1Qg
aXMgb3V0IGZvciBtZSBJIHdpbGwgcHJvYmFibHkgdHJ5IHRvIHVzZSB0aGUgY3RmLXdyaXRlciAK
PiBtb2R1bGUgb2YgYmFiZWx0cmFjZSAyIGluc3RlYWQKCkZvciBub3cgdGhlIGN0Zi13cml0ZXIg
bW9kdWxlcyBvZiBidDIgd291bGQgYmUgYW4gYWx0ZXJuYXRpdmUgdG8gCmNvbnNpZGVyLCBidXQg
cmVtZW1iZXIgdGhhdCBpdCBpcyBub3QgZGVzaWduZWQgZm9yIGxvdy1pbXBhY3QgdHJhY2luZyAK
c3VjaCBhcyBsdHRuZy11c3QuIFNvIGl0IGRlcGVuZHMgb24gaG93IG11Y2ggdHJhY2VyIG92ZXJo
ZWFkL3J1bnRpbWUgCmltcGFjdCB5b3UgY2FuIGFmZm9yZCBpbiB5b3VyIHVzZS1jYXNlLgoKVGhh
bmtzLAoKTWF0aGlldQoKPiAKPiBCZXN0IHJlZ2FyZHMsCj4gCj4gQ2hhcmxlcwo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxp
bmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2CgotLSAKTWF0aGlldSBEZXNu
b3llcnMKRWZmaWNpT1MgSW5jLgpodHRwczovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
