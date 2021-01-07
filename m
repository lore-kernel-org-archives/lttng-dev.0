Return-Path: <SRS0=Od8Q=GK=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126B1C433E0
	for <lttng-dev@archiver.kernel.org>; Thu,  7 Jan 2021 16:54:25 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A9D233FC
	for <lttng-dev@archiver.kernel.org>; Thu,  7 Jan 2021 16:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A9D233FC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DBXQ57011zP3B;
	Thu,  7 Jan 2021 11:54:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1610038462;
	bh=jCFFcRRyHonGoQHH0QPYB5/AFK7W24PDJzY9nMWzUZg=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=xUiedZUDTQQOdR4istEdpHG1iT2E+rE/kgrPCW9KfEF0NFc3lX5387My9vS0lmIDz
	 QZLAlSgMa7gd7x3Kv+83zmLhcCWpO8IRb6GzuuwKm0xHmFZuLRhqos8K21Eo/k+j0T
	 X2D+Ld4YuotDozBJmCYEjZvkbQLECiBnGvVlLJqSOmG0vNG4HB9Pv0GV9z/UC/vNZf
	 QU2WfIvirqyJrhi71SSp0iisfApZkvxQhPNtLLJa2vVOIEgV4mA0+ayNcNqO18of1c
	 f0CtiiG0surTJuF3uwX0qe0UcLmqIFWjr03+hVgu5FoDtCSqxa6WYkU8EA1FKNl2Ra
	 cWFpvAFTDHaGQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4DBXQ40FqDzNh7
 for <lttng-dev@lists.lttng.org>; Thu,  7 Jan 2021 11:54:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9732E2E10BA
 for <lttng-dev@lists.lttng.org>; Thu,  7 Jan 2021 11:54:13 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id u9s6xa38M6_p; Thu,  7 Jan 2021 11:54:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5DB472E10B9;
 Thu,  7 Jan 2021 11:54:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5DB472E10B9
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 4Gg3yOkLHgjz; Thu,  7 Jan 2021 11:54:13 -0500 (EST)
Received: from joraj-alpa (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id 788B62E10B2;
 Thu,  7 Jan 2021 11:54:12 -0500 (EST)
Date: Thu, 7 Jan 2021 11:54:08 -0500
To: "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20210107165408.GC227614@joraj-alpa>
References: <BYAPR11MB263254ABB57F458031AB33DBFFD50@BYAPR11MB2632.namprd11.prod.outlook.com>
 <BYAPR11MB2632B3DA9B535943CEE08A73FFD00@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210106150309.GA227614@joraj-alpa>
 <BYAPR11MB2632B5DE22E2561F0B018909FFAF0@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR11MB2632B5DE22E2561F0B018909FFAF0@BYAPR11MB2632.namprd11.prod.outlook.com>
Subject: Re: [lttng-dev] 
 =?utf-8?b?5Zue5aSNOiBoZWxwIG1vZHBvc3Q6ICJfX2JhZF9j?=
 =?utf-8?q?mpxchg=22?=
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGksCgpOb3RlCiAgVGhlIGluaXRpYWwgZW1haWwgd2FzIHNlbnQgdG8gdGhlICJvd25lciIgb2Yg
dGhlIG1haWxpbmcgbGlzdC4gUGxlYXNlCiAgKmFsd2F5cyogc2VuZCBlbWFpbCB0byB0aGUgbWFp
bGluZyBsaXN0IGRpcmVjdGx5OiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnIC4KICBPdGhlcndp
c2Ugd2Ugd2lsbCBub3QgYmUgaW50ZXJlc3RlZCBpbiBoZWxwaW5nIHlvdSBpbiB0aGUgZnV0dXJl
LgogIApTb3JyeSBmb3Jnb3QgdG8gYXNrIHlvdSB0aGUgZm9sbG93aW5nLgoKV2hhdCBpcyB0aGUg
YXJtIENQVSB5b3UgYXJlIGNvbXBpbGluZyBhZ2FpbnN0PyBUaGUgbW9yZSBkZXRhaWxzIHRoZSBt
b3JlIHdlIGNhbgpoZWxwIGhlcmUuCgpQbGVhc2UgcHJvdmlkZSB0aGUgLmNvbmZpZyBmaWxlIGZv
ciB0aGUga2VybmVsICh2aWEgcGFzdGViaW4gcGxlYXNlKSBhbmQgdGhlCmNvbXBpbGVyIHVzZWQu
IE1hdGhpZXUgRGVzbm95ZXJzIChDb21wdURKKSBtaWdodCBoYXZlIGEgbGVhZCByZWdhcmRpbmcg
Y21weGNoZwphbmQgX19iYWRfY21weGNoZyBsaW5rZXIgZXJyb3IgdHJpY2sgdXNlZCBieSB0aGUg
aW1wbGVtZW50YXRpb24gYW5kIHRoZQpvcHRpbWl6ZWQgaW5saW5pbmcgY29uZmlnIG9wdGlvbiAo
Q09ORklHX09QVElNSVpFX0lOTElOSU5HKS4KClRoZXNlIHNob3VsZCBoZWxwIHVzIHZhbGlkYXRl
IHRoaXMgbGVhZC4KCkNoZWVycwoKT24gVGh1LCBKYW4gMDcsIDIwMjEgYXQgMDE6MjA6NTRBTSAr
MDAwMCwgWmhhbmcsIFFpYW5nIHdyb3RlOgo+IAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiDlj5Hku7bkuro6IEpvbmF0aGFuIFJham90dGUtSnVsaWVuIDxq
b25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+Cj4g5Y+R6YCB5pe26Ze0OiAyMDIx
5bm0MeaciDbml6UgMjM6MDMKPiDmlLbku7bkuro6IFpoYW5nLCBRaWFuZwo+IOaKhOmAgTogbHR0
bmctZGV2LW93bmVyQGxpc3RzLmx0dG5nLm9yZwo+IOS4u+mimDogUmU6IGhlbHAgbW9kcG9zdDog
Il9fYmFkX2NtcHhjaGciCj4gCj4gW1BsZWFzZSBub3RlIHRoaXMgZS1tYWlsIGlzIGZyb20gYW4g
RVhURVJOQUwgZS1tYWlsIGFkZHJlc3NdCj4gCj4gPkhpLAo+ID4KPiA+V2hhdCB0aGUga2VybmVs
IHZlcnNpb24gYXJlIHlvdSBjb21waWxpbmcgYWdhaW5zdD8KPiAKPiAKPiAgICBrZXJuZWwgdmVy
c2lvbiA1LjEwLjIKPiAgICBsdHRuZy1tb2R1bGVzIG1hc3RlciBicmFuY2ggY29tbWl0IDoKPiAg
ICA2MWU2MzFlOTNlNTEyYjYzNmVhNmQ1Mjc5NmJjY2UxYzQ4NWE1NTFiCj4gCj4gICAgIENoZWVy
cwo+ICAgIAo+ID4KPiA+Q2hlZXJzCj4gPgo+ID5PbiBXZWQsIEphbiAwNiwgMjAyMSBhdCAwNToy
MDowNkFNICswMDAwLCBaaGFuZywgUWlhbmcgd3JvdGU6Cj4gPgo+ID4KPiA+IFRoZSBmb2xsb3dp
bmcgZXJyb3Igb2NjdXJyZWQgd2hlbiBJIGNvbXBpbGVkIGx0dG5nIG1vZHVsZXMgdW5kZXIgYXJt
djcgYXJjaGl0ZWN0dXJlCj4gPgo+ID4gRVJST1I6IG1vZHBvc3Q6ICJfX2JhZF9jbXB4Y2hnIiBb
L2J1aWxkYXJlYTEvT25EZW1hbmRfQ0lfQnVpbGRfV29ybGQvYnVpbGRfZGlyLzEyMjUxNzI3LWJ1
aWxkX3dvcmxkL3hpbGlueC16eW5xLXN0YW5kYXJkLXN0ZC1PRS9idWlsZC90bXAtZ2xpYmMvd29y
ay94aWxpbnhfenlucS13cnMtbGludXgtZ251ZWFiaS9sdHRuZy1tb2R1bGVzLzIuMTIuMytnaXRB
VVRPSU5DKzYxZTYzMWU5M2UtcjAvZ2l0L3NyYy9sdHRuZy1jb3VudGVyLWNsaWVudC1wZXJjcHUt
NjQtbW9kdWxhci5rb10gdW5kZWZpbmVkIQo+ID4KPiA+IEVSUk9SOiBtb2Rwb3N0OiAiX19iYWRf
Y21weGNoZyIgWy9idWlsZGFyZWExL09uRGVtYW5kX0NJX0J1aWxkX1dvcmxkL2J1aWxkX2Rpci8x
MjI1MTcyNy1idWlsZF93b3JsZC94aWxpbngtenlucS1zdGFuZGFyZC1zdGQtT0UvYnVpbGQvdG1w
LWdsaWJjL3dvcmsveGlsaW54X3p5bnEtd3JzLWxpbnV4LWdudWVhYmkvbHR0bmctbW9kdWxlcy8y
LjEyLjMrZ2l0QVVUT0lOQys2MWU2MzFlOTNlLXIwL2dpdC9zcmMvbHR0bmctY291bnRlci1jbGll
bnQtcGVyY3B1LTMyLW1vZHVsYXIua29dIHVuZGVmaW5lZCEKPiA+Cj4gPiBJIGZpbmQgIHVuZGVy
IHRoZSBjb25kaXRpb24gb2YKPiA+Cj4gPiBDT1VOVEVSX1NJWkVfMzJfQklULCAgY21weGNoZ19s
b2NhbCAgZnVuY3Rpb24gdHJpZ2dlciBlcnJvciBpbiBjb3VudGVyLWFwaS5oIGZpbGUuCj4gPgo+
ID4gaXMgY21weGNoZ19sb2NhbCBpcyBzdXBwb3J0IGluIGFtdjc/Cj4gCj4gLS0KPiBKb25hdGhh
biBSYWpvdHRlLUp1bGllbgo+IEVmZmljaU9TCgotLSAKSm9uYXRoYW4gUmFqb3R0ZS1KdWxpZW4K
RWZmaWNpT1MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8v
bGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
