Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD9EC77B7A
	for <lttng-dev@archiver.kernel.org>; Wed, 17 May 2023 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684341500;
	bh=y0b2Ggbvl/NUM/nJA1pHsdsUG1Z5YLggfOmu+Ct1ukw=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=vsJlxvhdBn7l5MULzGTOq6TUCY35R4qORC5JyFu/AvT5Xl7xdqjq9qEOfuX4Hx3XF
	 CDzebEpoZm+MmeSDALapDbU8laUqbNyV9UqzpoDuGRmuikhy2W2Vk5nW+EiIJeDxh8
	 2Z4GuuRmCiQyj/ftbQz00MOGRM0+A243hqdnkQXGQborUBq16zgTzibQU/STBV+6/e
	 zcTJJy2YJqQKX9bZwhcuVJbni5ldC05r0uG1vTfemCrk88u87oyHEgEK5EpXfU346v
	 /mNEKoLzsOXwEjcf6E3oO9+suAG4CMKbDV98Psy+Opv0BDjI/XtvtimZBBEsmg4ayE
	 ISswSaj/FRdQQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QLzLh0bPfz1FZW;
	Wed, 17 May 2023 12:38:20 -0400 (EDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by lists.lttng.org (Postfix) with ESMTPS id 4QLzLf5Z50z1FrQ
 for <lttng-dev@lists.lttng.org>; Wed, 17 May 2023 12:38:18 -0400 (EDT)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-965f7bdab6bso184103866b.3
 for <lttng-dev@lists.lttng.org>; Wed, 17 May 2023 09:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684341437; x=1686933437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHRsBeIg2o3umMkFhbcPvlVXx5zR1o27kFw0xbaXNm8=;
 b=A0KfvZmo+L8+DMSd3ZVP+IBpZXnsYVS7+2zEjZdhFZGMO33iTFTcT8l1LYCUuVGdcy
 BWde/7X78SsenskAJCFtXmlmyXrQoY0+FcgtMdlfw6i4fmQU6S7DkNmkSJRWcLHJ4+lf
 RxW/K1TXURkWUQryhHvetMpkPvUvafHFhkx3PIKPEveJI9sFEj2n7EEAYvBuZQ+7OCqN
 8lhUZj5JQ/yUyT8B4khjYX00NbC58CUWKpjk6naQ6RrKARk4DL4KrxO7vvDU0B7NT0E6
 HKE6Ygwea7kdrVetriAVs9bhlIhTk+9PnbqiHALiIkMubGTA1F0+HXncW0o9wvTcNfnc
 BP3g==
X-Gm-Message-State: AC+VfDxJfP+zrjQeAbISQBcy4AbS+yoJVdfUv9SdqPMGuTipF0xuVieO
 9H0Iej+g7LBe2HuQ6kTcit2i3LREDE8yFzoGXaVUFwRc
X-Google-Smtp-Source: ACHHUZ4T0svnFSgpLDZtV8SVdcregJoG9BgDzKr3grxoXQsemA5DHYdPCtsLV2X7HDNAQZMtRz6husz4PGEqOb7J740=
X-Received: by 2002:a17:907:3e9e:b0:96a:29c0:8515 with SMTP id
 hs30-20020a1709073e9e00b0096a29c08515mr22735868ejc.58.1684341437336; Wed, 17
 May 2023 09:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAFZh4h8C5ZVHGWsBW2iaVYi56t=SsmuiSGZPLf0KpQO9LwfeMQ@mail.gmail.com>
 <2d953bd2-6544-3357-1424-fa44731e2bf5@efficios.com>
In-Reply-To: <2d953bd2-6544-3357-1424-fa44731e2bf5@efficios.com>
Date: Wed, 17 May 2023 12:37:06 -0400
Message-ID: <CAFZh4h-Jf4eTNpPEh9=kBRXBN3JxBa_2BCBtRx0EfV_MaHZm1g@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Trying to understand use of lttng enable-event
 --kernel --userspace-probe=
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
From: Brian Hutchinson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Brian Hutchinson <b.hutchman@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgMTI6MDjigK9QTSBNYXRoaWV1IERlc25veWVycwo8bWF0
aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPgo+IE9uIDIwMjMtMDUtMTYgMjI6
MTEsIEJyaWFuIEh1dGNoaW5zb24gdmlhIGx0dG5nLWRldiB3cm90ZToKPiA+IEhpLAo+ID4KPiA+
IEknbSB0cnlpbmcgdG8gZmlndXJlIG91dCBob3cgdG8gdXNlIHVwcm9iZXMgd2l0aCBsdHRuZy4K
PiA+Cj4gPiBJIGNhbid0IHVzZSBhIG5vcm1hbCB1cHJvYmUgZm9yIGEgbGluZSBudW1iZXIganVz
dCB1c2luZyB0aGUgYWRkcmVzcyBJCj4gPiB3YW50IHRvIHByb2JlIG9idGFpbmVkIGZyb20gb2Jq
ZHVtcD8gIEFzIGluOgo+ID4KPiA+IGVjaG8gJ3AgL3Vzci9sb2NhbC9iaW4vbXlfYXBwOjB4MmMz
YTgnID4+Cj4gPiAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFjaW5nL3Vwcm9iZV9ldmVudHMKPiA+Cj4g
PiAuLi4gd2hpY2ggaXNuJ3QgYSBmdW5jdGlvbiBlbnRyeSwgaXQncyBqdXN0IGEgbGluZSBvZiBj
b2RlIEkgd2FudCB0byBwcm9iZSBvbi4KPiA+Cj4gPiBUaGlzIGxpbmsgc2F5cyBpdCBoYXMgdG8g
YmUgZWxmIG9yIHNkdDoKPiA+IGh0dHBzOi8vbHR0bmcub3JnL21hbi8xL2x0dG5nLWVuYWJsZS1l
dmVudC92Mi4xMS8jZG9jLW9wdC0tdXNlcnNwYWNlLXByb2JlCj4gPgo+ID4gU28gY2FuIEkgbm90
IHByb2JlIG9uIGp1c3QgYSBsaW5lIG9mIGNvZGUgYnkgc3BlY2lmeWluZyBhbiBhZGRyZXNzPz8/
Cj4gPgo+ID4gSXQgZG9lc24ndCBsb29rIGxpa2UgdGhlc2UgbWV0aG9kcyBhYm92ZSB3aWxsIGRv
IHdoYXQgSSdtIHdhbnRpbmcgdG8KPiA+IGRvLiAgSSd2ZSB0cmllZCB0byBmaW5kIGV4YW1wbGVz
IG9mIHVzaW5nIGVuYWJsZS1ldmVudCAtLWtlcm5lbAo+ID4gLS11c2Vyc3BhY2UtcHJvYmU9IGJ1
dCB0aGVyZSBkb2Vzbid0IGFwcGVhciB0byBiZSBtYW55Lgo+ID4KPgo+IFRoZXJlIGFyZSBleGFt
cGxlcyBoZXJlOgo+Cj4gaHR0cHM6Ly9sdHRuZy5vcmcvZG9jcy92Mi4xMy8jZG9jLWVuYWJsaW5n
LWRpc2FibGluZy1ldmVudHMKPgo+IEluZGVlZCBpbnNlcnRpbmcgYSBsdHRuZy1tb2R1bGVzIHVw
cm9iZSB3aXRoaW4gZnVuY3Rpb25zIGlzIG5vdAo+IHN1cHBvcnRlZCBhdCB0aGUgbW9tZW50LCBt
YWlubHkgYmVjYXVzZSB3ZSBwcmVmZXIgdG8gZXJyIHRvd2FyZHMgc2FmZXR5Cj4gYW5kIGRvbid0
IGhhdmUgdGhlIHZhbGlkYXRpb24gaW4gcGxhY2UgdG8gcHJldmVudCBjb3JydXB0aW5nIHRoZQo+
IHByb2dyYW0ncyBpbnN0cnVjdGlvbnMgaWYgYW4gZW5kIHVzZXIgd291bGQgdHJ5IHRvIGluc2Vy
dCBhIHVwcm9iZSBhdCBhbgo+IGFkZHJlc3Mgd2hpY2ggaXMgbm90IGFuIGluc3RydWN0aW9uIGJv
dW5kYXJ5LgoKSG1tLCB3YXMgcmVhbGx5IGhvcGluZyB0byBiZSBhYmxlIHRvIGRvIGR5bmFtaWMg
dHJhY2luZyB3aXRob3V0IGhhdmluZwp0byBtb2RpZnkgY29kZS4KCkkgZ3Vlc3MgaWYgSSBhZGQg
YSBmdW5jdGlvbiBjYWxsIHRvIGEgZGVidWcgc3RhdGVtZW50IG9yIHNvbWV0aGluZyBhdAp0aGUg
cG9pbnQgSSB3YW50IHRvIHByb2JlIHRoZW4gSSBjb3VsZCB1c2UgdGhlIGVsZiBleGFtcGxlLgoK
Pgo+IFNvIHdlIG9ubHkgc3VwcG9ydCBpbnNlcnRpbmcgdXByb2JlIG9uIGZ1bmN0aW9ucyBhbmQg
U0RUIHByb2JlcyBhdAo+IHRoZSBtb21lbnQuCgpJJ3ZlIGhlYXJkIG9mIHN5c3RlbSB0YXAgYnV0
IG5ldmVyIHVzZWQgaXQuICBXaWxsIGhhdmUgdG8gbG9vayBpbnRvIHRoYXQuCgpJIHJlYWxseSB3
YW50IHRvIGdldCBsdHRuZy11c3Qgd29ya2luZyBidXQgSSdtIGdldHRpbmcgcHVzaGJhY2sgb24g
dGhlCnRpbWUgSSdtIHNwZW5kaW5nIHRyeWluZyB0byBnZXQgaXQgdG8gd29yayAuLi4gYW5kIHdv
dWxkIHJlYWxseSBsaWtlCnRvIGRlbW9uc3RyYXRlIHNvbWV0aGluZyAod2FzIGhvcGluZyBrZXJu
ZWwgZXZlbnRzIGFuZCB1cHJvYmVzKQpxdWlja2x5IHRvIGFuIGF1ZGllbmNlIHRoYXQga25vd3Mg
bm90aGluZyBhYm91dCBsdHRuZyBvciBmdWxsIHN0YWNrCnRyYWNpbmcgdG8gZ2FpbiAiYnV5IGlu
IiBmb3IgdGhlIGVmZm9ydC4KCllvdSBrbm93LCB0aG9zZSBwZXNreSB0aGluZ3MgY2FsbGVkIHNj
aGVkdWxlcy4KClRoYW5rcywKCkJyaWFuCgo+Cj4gVGhhbmtzLAo+Cj4gTWF0aGlldQo+Cj4KPiA+
IFRoYW5rcywKPiA+Cj4gPiBCcmlhbgo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiA+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiA+IGx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKPiA+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYKPgo+IC0tCj4gTWF0aGlldSBEZXNub3llcnMKPiBFZmZp
Y2lPUyBJbmMuCj4gaHR0cHM6Ly93d3cuZWZmaWNpb3MuY29tCj4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
