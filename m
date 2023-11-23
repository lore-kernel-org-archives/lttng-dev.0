Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B07C61D85
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Nov 2023 19:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1700769414;
	bh=aqrtooJSTfEtyzSEdQzhrk46Sqe8ndSmL8SSKpFoCX8=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=tkb79vEAhh3upgi/wIv+8nrE+jrqf1bMNUuwCqxsnwDog7b1/NJUxehY++CpztK0E
	 WeORkqPciTewiA3xYLVO7FrcVaBLZmfK1fwqDt2u+7pilACwuM+U3fqlhW54V9eaT3
	 nvszlfUxIUlGgIpHQx8V2Ubru8Rlw19rRyB6qGDYlzY7ETE/v9g0ADessN2bgVwHJH
	 mWcBjmaH2KS2jAlw/N9dQgqHzytt22g5bQ922MfL+qI47VN5IQRIbdeiyUin/UskGw
	 jntVWNiR2VlEl7bdkclURQTgbYJ2rkVFq98sK/nfh4Fnm3G5CNtwH81y5IKuMsRpr8
	 g+cNw/trNmagg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Sbpm63Ls6zLHk;
	Thu, 23 Nov 2023 14:56:54 -0500 (EST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 by lists.lttng.org (Postfix) with ESMTPS id 4Sbpm43hcVzL4G
 for <lttng-dev@lists.lttng.org>; Thu, 23 Nov 2023 14:56:52 -0500 (EST)
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-35af2b4242eso3871215ab.2
 for <lttng-dev@lists.lttng.org>; Thu, 23 Nov 2023 11:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700769412; x=1701374212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLIP2BMiJqQBYxCxF7/xV3xIjpLUT7/4hRuWNdH5Ijw=;
 b=olSR1DVkME/BI6YCuTt8qlG6qx4cncOeQCD58tOCcLl/Bbe5aoGxYp7NtCbA/vjj3I
 UjaWDphc6QAQ905VEpMxi4TMFzzOK9vDLkKjJBAahADzbMV19K3kRW+IUf7+n6klMW0U
 ol1F6aS1MfxyNiTICaX0CMBEUXc4SwMzc03teIFV8VM21xlwbr3oRpR0bL/dqSRif3Vd
 PX4rVhW3qtYrEc9VB+Rt1TePxN3ZcAp6DLJun34s1wYcdI9bfgzP4ZPusMobEIvaUYCo
 lGccMT4HnIJo6KA9Fm3IlYWE/KdxBlk/XkEorDhCP2akjg9AqKdcZ8I0hWzOErEtAKcq
 ysKQ==
X-Gm-Message-State: AOJu0YzQ524SHToUU5B8nIYUiWsrmv9gAJkEdoQGWEZKMF4HUtRmU08+
 rRtxcRYSw9pDCcKBFk4E+q+4TggIHrqLe10XjdtuPfyfXI4=
X-Google-Smtp-Source: AGHT+IGDuVCCQeDppUDLh0DG3+Qbru9j9I9NhGwqwroYqou50fepgWmOC0FQLeuIJr16EVxGAlxD7pJoW7m01T+aijY=
X-Received: by 2002:a92:c547:0:b0:35b:36c5:5441 with SMTP id
 a7-20020a92c547000000b0035b36c55441mr699210ilj.19.1700769411736; Thu, 23 Nov
 2023 11:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20231123193249.3190764-1-bruce.ashfield@gmail.com>
 <20231123193249.3190764-3-bruce.ashfield@gmail.com>
 <2c0e2bb6-470d-45b7-af19-cbe0bd7eb280@efficios.com>
In-Reply-To: <2c0e2bb6-470d-45b7-af19-cbe0bd7eb280@efficios.com>
Date: Thu, 23 Nov 2023 14:56:40 -0500
Message-ID: <CADkTA4MJwtamzZxaV9tY56aCM5NdKvWj9tAiNW9nhuez6VLJDw@mail.gmail.com>
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] [PATCH 3/3] vmscan: drop isolate_mode (v6.7+)
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
From: Bruce Ashfield via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Bruce Ashfield <bruce.ashfield@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

QWhhLAoKU28gdGhlIG1haWxpbmcgbGlzdCBpc24ndCB1c2VkIGZvciBwYXRjaCBzdWJtaXNzaW9u
IGFueW1vcmUgPyBJIGRpZG4ndApub3RpY2UgYW55IHVwZGF0ZXMgaW4gdGhlIFJFQURNRXMsIGV0
Yywgc28gSSBqdXN0IGZlbGwgYmFjayB0byBteQpleGlzdGluZyB3b3JrZmxvdy4KCkkganVzdCB3
YW50IHRvIGtub3csIHNvIEkgd29uJ3Qgd2FzdGUgdGltZSBpbiB0aGUgZnV0dXJlLgoKQnJ1Y2UK
Ck9uIFRodSwgTm92IDIzLCAyMDIzIGF0IDI6NDnigK9QTSBLaWVuYW4gU3Rld2FydCA8a3N0ZXdh
cnRAZWZmaWNpb3MuY29tPiB3cm90ZToKPgo+IEhpIEJydWNlLAo+Cj4gdGhhbmtzIGZvciB0aGUg
cGF0Y2hlcyEgVGhlcmUncyBhIHNpbWlsYXIgc2VyaWVzIHdhaXRpbmcgZm9yIHJldmlldzoKPiBo
dHRwczovL3Jldmlldy5sdHRuZy5vcmcvcS90b3BpYzolMjJmaXgtbGludXgtNi43LjAtcmMxJTIy
Cj4KPiB0aGFua3MsCj4ga2llbmFuCj4KPiBPbiAyMDIzLTExLTIzIDE0OjMyLCBCcnVjZSBBc2hm
aWVsZCB2aWEgbHR0bmctZGV2IHdyb3RlOgo+ID4gRnJvbTogQnJ1Y2UgQXNoZmllbGQgPGJydWNl
LmFzaGZpZWxkQGdtYWlsLmNvbT4KPiA+Cj4gPiBjb21taXQgM2RmYmI1NTVjOThhYzU1YjkgW21t
LCB2bXNjYW46IHJlbW92ZSBJU09MQVRFX1VOTUFQUEVEXQo+ID4gbWFrZXMgdGhlIGlzb2xhdGVf
bW9kZSBwYXJhbWV0ZXIgdW51c2VkLCBzbyBpdCBpcyByZW1vdmVkLgo+ID4KPiA+IFRoaXMgdXBk
YXRlcyB0aGUgZXZlbnQgdG8gbWF0Y2guCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogQnJ1Y2UgQXNo
ZmllbGQgPGJydWNlLmFzaGZpZWxkQGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4KPiA+IFJlcGVhdGlu
ZyB0aGUgY29tbWVudCBmcm9tIHBhdGNoIDEgJiAyIG9mIHRoaXMgc2VyaWVzOgo+ID4KPiA+IFNv
bWVvbmUgZWxzZSBtYXkgb3IgbWF5IG5vdCBhbHJlYWR5IGhhdmUgdGhpcyBpbiBmbGlnaHQsCj4g
PiBidXQgSSBkaWRuJ3Qgc2VlIGFueXRoaW5nIG9uIHRoZSBsaXN0IG9yIGluIHRoZSBnaXQKPiA+
IHJlcG8uCj4gPgo+ID4gSSByYW4gaW50byB0aGlzIGZhaWx1cmUgd2hlbiB3b3JraW5nIG9uIHRo
ZSB2Ni43LXJjCj4gPiBrZXJuZWwgYXMgcGFydCBvZiB5b2N0byBwcm9qZWN0IGtlcm5lbCB1cGRh
dGVzLgo+ID4KPiA+IFR3ZWFrIGFzIG5lY2Vzc2FyeSwgYXMgSSdtIG5vIGV4cGVydCBpbiB0aGUg
cmlnaHQgd2F5Cj4gPiB0byB2ZXJzaW9uIHRoZXNlIHNvcnQgb2YgY2hhbmdlcy4KPiA+Cj4gPiBC
cnVjZQo+ID4KPiA+ICAgaW5jbHVkZS9pbnN0cnVtZW50YXRpb24vZXZlbnRzL21tX3Ztc2Nhbi5o
IHwgMTAgKysrKysrKysrLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaW5zdHJ1bWVudGF0aW9u
L2V2ZW50cy9tbV92bXNjYW4uaCBiL2luY2x1ZGUvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9tbV92
bXNjYW4uaAo+ID4gaW5kZXggZTdlOWI2MTMuLmEzZTlkZGYyIDEwMDY0NAo+ID4gLS0tIGEvaW5j
bHVkZS9pbnN0cnVtZW50YXRpb24vZXZlbnRzL21tX3Ztc2Nhbi5oCj4gPiArKysgYi9pbmNsdWRl
L2luc3RydW1lbnRhdGlvbi9ldmVudHMvbW1fdm1zY2FuLmgKPiA+IEBAIC0zNDMsMTIgKzM0Mywx
OCBAQCBMVFROR19UUkFDRVBPSU5UX0VWRU5UKG1tX3Ztc2Nhbl9scnVfaXNvbGF0ZSwKPiA+ICAg
ICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBucl9zY2FubmVkLAo+ID4gICAgICAgICAgICAgICB1
bnNpZ25lZCBsb25nIG5yX3NraXBwZWQsCj4gPiAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcg
bnJfdGFrZW4sCj4gPiArI2lmIChMVFROR19MSU5VWF9WRVJTSU9OX0NPREUgPCBMVFROR19LRVJO
RUxfVkVSU0lPTig2LDcsMCkpCj4gPiAgICAgICAgICAgICAgIGlzb2xhdGVfbW9kZV90IGlzb2xh
dGVfbW9kZSwKPiA+ICsjZW5kaWYKPiA+ICAgICAgICAgICAgICAgaW50IGxydQo+ID4gICAgICAg
KSwKPiA+Cj4gPiAgICAgICBUUF9BUkdTKGNsYXNzem9uZV9pZHgsIG9yZGVyLCBucl9yZXF1ZXN0
ZWQsIG5yX3NjYW5uZWQsIG5yX3NraXBwZWQsCj4gPiAtICAgICAgICAgICAgIG5yX3Rha2VuLCBp
c29sYXRlX21vZGUsIGxydQo+ID4gKyAgICAgICAgICAgICBucl90YWtlbiwKPiA+ICsjaWYgKExU
VE5HX0xJTlVYX1ZFUlNJT05fQ09ERSA8IExUVE5HX0tFUk5FTF9WRVJTSU9OKDYsNywwKSkKPiA+
ICsgICAgICAgICAgICAgaXNvbGF0ZV9tb2RlLAo+ID4gKyNlbmRpZgo+ID4gKyAgICAgICAgICAg
ICBscnUKPiA+ICAgICAgICksCj4gPgo+ID4gICAgICAgVFBfRklFTERTKAo+ID4gQEAgLTM1OCw3
ICszNjQsOSBAQCBMVFROR19UUkFDRVBPSU5UX0VWRU5UKG1tX3Ztc2Nhbl9scnVfaXNvbGF0ZSwK
PiA+ICAgICAgICAgICAgICAgY3RmX2ludGVnZXIodW5zaWduZWQgbG9uZywgbnJfc2Nhbm5lZCwg
bnJfc2Nhbm5lZCkKPiA+ICAgICAgICAgICAgICAgY3RmX2ludGVnZXIodW5zaWduZWQgbG9uZywg
bnJfc2tpcHBlZCwgbnJfc2tpcHBlZCkKPiA+ICAgICAgICAgICAgICAgY3RmX2ludGVnZXIodW5z
aWduZWQgbG9uZywgbnJfdGFrZW4sIG5yX3Rha2VuKQo+ID4gKyNpZiAoTFRUTkdfTElOVVhfVkVS
U0lPTl9DT0RFIDwgTFRUTkdfS0VSTkVMX1ZFUlNJT04oNiw3LDApKQo+ID4gICAgICAgICAgICAg
ICBjdGZfaW50ZWdlcihpc29sYXRlX21vZGVfdCwgaXNvbGF0ZV9tb2RlLCBpc29sYXRlX21vZGUp
Cj4gPiArI2VuZGlmCj4gPiAgICAgICAgICAgICAgIGN0Zl9pbnRlZ2VyKGludCwgbHJ1LCBscnUp
Cj4gPiAgICAgICApCj4gPiAgICkKCgoKLS0gCi0gVGhvdSBzaGFsdCBub3QgZm9sbG93IHRoZSBO
VUxMIHBvaW50ZXIsIGZvciBjaGFvcyBhbmQgbWFkbmVzcyBhd2FpdAp0aGVlIGF0IGl0cyBlbmQK
LSAiVXNlIHRoZSBmb3JjZSBIYXJyeSIgLSBHYW5kYWxmLCBTdGFyIFRyZWsgSUkKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcg
bGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2Nn
aS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
