Return-Path: <SRS0=79Yp=DT=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E991C433DF
	for <lttng-dev@archiver.kernel.org>; Mon, 12 Oct 2020 13:18:00 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF4620714
	for <lttng-dev@archiver.kernel.org>; Mon, 12 Oct 2020 13:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="DvAqxsjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF4620714
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4C8zkX6hW5z10QY;
	Mon, 12 Oct 2020 09:17:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1602508677;
	bh=TmqIwIwbeJ4cZw1JS7R42yQs9Fw9Aou76txlGuwulzI=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DvAqxsjYImC2ho/lMh4+pewrf3VjNCedvS9d9U8QJLZjjoBOUTWbsHMTEaqniv2vv
	 e2XEhOT0a8BODfZBzjG4z6FMPsp+Apx8QO5qi2fabj8G55xa/dyLahlpjZnJ3d3sVy
	 tFjxhf5218Vz/DzmnsEp3akNCdZ3bYTYQXWv3iITzC4mCaDtpvphiCvA+iPmPtGexu
	 7/LjPml7qg/KnMmTUDBgFWiIq/BDeMAdouvnqWA9hlvM6l2heYEu1C1R8880g6upbi
	 EZJ7MxhnA6JK0yk0MKjNMzViJJyMzA+9b5KEVW/K9g6uj5kdEkPFrCnwUCoIzpErYp
	 8FhPU8EVeMt2w==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4C8zkV6cyJz10bv
 for <lttng-dev@lists.lttng.org>; Mon, 12 Oct 2020 09:17:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 86EF42E982D
 for <lttng-dev@lists.lttng.org>; Mon, 12 Oct 2020 09:17:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id mCp06oC04Yby; Mon, 12 Oct 2020 09:17:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4068E2E982B;
 Mon, 12 Oct 2020 09:17:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4068E2E982B
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 5o59UI_Tl33z; Mon, 12 Oct 2020 09:17:48 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 352C92E982A;
 Mon, 12 Oct 2020 09:17:48 -0400 (EDT)
Date: Mon, 12 Oct 2020 09:17:48 -0400 (EDT)
To: nils doering <nils.doering@fujitsu.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <67256246.16573.1602508668109.JavaMail.zimbra@efficios.com>
In-Reply-To: <DB8P191MB1016B09FD65AF6B091A78C729D070@DB8P191MB1016.EURP191.PROD.OUTLOOK.COM>
References: <DB8P191MB1016B09FD65AF6B091A78C729D070@DB8P191MB1016.EURP191.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: Deleted files held open by LTTng
Thread-Index: AdagdWz1nQMxavrbS9eYaI0jR/YKaBWGyxUK
Subject: Re: [lttng-dev] Deleted files held open by LTTng
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

LS0tLS0gT24gT2N0IDEyLCAyMDIwLCBhdCA1OjA0IEFNLCBsdHRuZy1kZXYgbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZyB3cm90ZToKCj4gSGkgYWxsLAo+IAo+IEkgaGF2ZSByZWNlbnRseSBzdGFy
dGVkIHVzaW5nIExUVG5nIGFuZCBzdHVtYmxlZCB1cG9uIHRoZSBmYWN0LCB0aGF0Cj4gTFRUbmcg
aXMga2VlcGluZyBhIGxvdCBvZiBvcGVuIGZpbGUgcG9pbnRlcnMgdG8gYSBzaW5nbGUgZGVsZXRl
ZCBmaWxlLgo+IAo+IFNwZWNpZmljYWxseSB0aGUgcHJvY2VzcyB0aGF0IGhvbGRzIHRoZXNlIG9w
ZW4gaXMgdGhlIGx0dG5nLWNvbnN1bWVyZCBhbmQgaXRzCj4gdGhyZWFkcy4gVGhlIGZpbGUgdGhh
dCBpcyBoZWxkIG9wZW4sIGJ1dCBpcyBkZWxldGVkIGlzCj4gL2Rldi9zaG0vdXN0LXNobS1jb25z
dW1lci0ke1BJRH0gd2l0aCB0aGUgUElEIG9mIHRoZSBsdHRuZy1jb21zdW1lcmQuIFRoZQo+IG51
bWJlciBvZiBvcGVuIGZpbGUgZGVzY3JpcHRvcnMgaXMgZGVwZW5kZW50IG9uIHRoZSBudW1iZXIg
b2YgQ1BVcyB0aGUKPiBzeXN0ZW0gaGFzIGFuZCByZXN1bHRzIHRvIDE2ICsgKCNDUFVzICogMTYp
LiBJcyB0aGlzIGJlaGF2aW9yIGV4cGVjdGVkPwo+IAo+ICMgbHNvZiB8IGdyZXAgbHR0bmcgfCBn
cmVwIERFTAo+IGx0dG5nLWNvbiAgMjI4MCAgICAgICAgICAgICByb290ICBERUwgICAgICAgUkVH
ICAgICAgICAgICAgICAgMCwxOAo+IDExMTI4Cj4gICAgICAgIC9kZXYvc2htL3VzdC1zaG0tY29u
c3VtZXItMjI4MAo+IGx0dG5nLWNvbiAgMjI4MCAgICAgICAgICAgICByb290ICBERUwgICAgICAg
UkVHICAgICAgICAgICAgICAgMCwxOAo+IDExMTI3Cj4gICAgICAgIC9kZXYvc2htL3VzdC1zaG0t
Y29uc3VtZXItMjI4MAo+IGx0dG5nLWNvbiAgMjI4MCAgICAgICAgICAgICByb290ICBERUwgICAg
ICAgUkVHICAgICAgICAgICAgICAgMCwxOAo+IDExMTI2Cj4gICAgICAgIC9kZXYvc2htL3VzdC1z
aG0tY29uc3VtZXItMjI4MAo+IFsuLi5dCj4gCj4gSSBoYXZlIHRlc3RlZCB0aGlzIG9uIGEgWGVu
LURvbTAgc3lzdGVtIHJ1bm5pbmcgU0xFUyAxMiBTUDUgYW5kIG9uIGEKPiBTTEVTMTIgU1A1IHdp
dGhvdXQgWGVuLgoKWWVzLCBpdCB3b3JrcyBleGFjdGx5IGFzIGRlc2lnbmVkLiBUaGUgaW5vZGVz
IHRvIGVhY2ggb2YgdGhvc2UgZmlsZXMgc3RheQphbGxvY2F0ZWQgYXMgYWxvbmcgYXMgdGhlcmUg
aXMgYXQgbGVhc3Qgb25lIGZpbGUgZGVzY3JpcHRvciByZWZlcmVuY2luZyB0aGVtLgpXZSB1c2Ug
dGhpcyBzY2hlbWUgdG8gZmFjaWxpdGF0ZSBjbGVhbmluZyB1cCB3aGVuIHRoZSBjb25zdW1lciBk
YWVtb24gaXMKa2lsbGVkIChpbmNsdWRpbmcgd2l0aCBTSUdLSUxMKSBzbyBpdCBkb2VzIG5vdCBs
ZWF2ZSBzdGFsZSBmaWxlcyBoYW5naW5nCmFyb3VuZC4KCk5vdGUgdGhhdCBvbiBMaW51eCwgYW5k
IHN0YXJ0aW5nIGZyb20gTGludXgga2VybmVsIDMuMTcsIHdlIGNvdWxkIGluc3RlYWQKdXNlIHRo
ZSBtZW1mZF9jcmVhdGUgc3lzdGVtIGNhbGwgdG8gY3JlYXRlIHRob3NlIHNoYXJlZCBtYXBwaW5n
cywgd2hpY2ggQUZBSVUKd291bGQgcmVtb3ZlIHRoZSBuZWVkIGZvciB1bmxpbmtpbmcgdGhlIHNo
bSBmaWxlcyBhZnRlciB0aGVpciBjcmVhdGlvbi4KSG93ZXZlciwgY29uc2lkZXJpbmcgdGhhdCBM
VFRuZy10b29scyBhbmQgTFRUbmctVVNUIGFsc28gd29ya3Mgb24gb2xkZXIgTGludXgKa2VybmVs
cywgYW5kIG9uIEJTRHMsIHVzaW5nIHRoZSBQT1NJWCBzaG0gc3RpbGwgYXBwZWFycyB0byBiZSBh
cHByb3ByaWF0ZS4KCk9uIHRoZSByZWFzb24gZm9yIGhhdmluZyBvbmUgc2htIGZpbGUgcGVyIGNw
dSAocGVyIGNoYW5uZWwvcGVyIHVpZC9wZXIgc2Vzc2lvbik6CmhhdmluZyBvbmUgZmlsZSBwZXIg
Y3B1IGlzIG1haW5seSBkb25lIHRvIGZhY2lsaXRhdGUgTlVNQS1sb2NhbCBtZW1vcnkgYWxsb2Nh
dGlvbi4KVGhhdCBiZWluZyBzYWlkLCBJIHdvbmRlciBpZiBhcyBhIGZ1dHVyZSBpbXByb3ZlbWVu
dCB3ZSBjb3VsZCBjb21iaW5lIGFsbCBwZXItY3B1CmJ1ZmZlcnMgaW50byBhIHNpbmdsZSBzaG0g
ZmlsZSwgYW5kIGlzc3VlIG51bWFfc2V0X3ByZWZlcnJlZCBwaWVjZXdpc2Ugd2hlbgptbWFwcGlu
ZyByZWdpb25zIG9mIHRoZSBmaWxlcy4gVGhpcyB3b3VsZCBsZXNzZW4gdGhlIG51bWJlciBvZiBm
aWxlIGRlc2NyaXB0b3JzCm5lZWRlZCBieSBhIHNpZ25pZmljYW50IGFtb3VudC4gSSBzdXNwZWN0
IGl0IHdvdWxkIHdvcmssIGJ1dCB3ZSdkIG5lZWQgdG8gZG8gc29tZQpwcm90b3R5cGluZyB0byB2
YWxpZGF0ZSB0aGlzIGFwcHJvYWNoIGZpcnN0LgoKVGhhbmtzLAoKTWF0aGlldQoKPiAKPiBCZXN0
IHJlZ2FyZHMsCj4gTmlscyBEw7ZyaW5nCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9s
aXN0aW5mby9sdHRuZy1kZXYKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0
dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
