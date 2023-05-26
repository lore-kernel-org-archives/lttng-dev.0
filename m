Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C46BC7EE23
	for <lttng-dev@archiver.kernel.org>; Fri, 26 May 2023 06:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1685081335;
	bh=kXifwFrn/YdAk6fYchJbhu54UlEoKgjsFP3stBCwEXc=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qa2UO7aVsnQnHdx51XuoW0/JW+x6XhdYH3DyVJFXq2ebUFbu2+sQcDgojezJyfgv0
	 j/Ll4QvUKDJI055C9MhIS5YOgpBxFRFW/Il0AheS4dG3e7OICvOTjDeYgaZ8lufSMb
	 Obnuomz0oSVFnS264cX5IhzoUILyDCaxi5fXwhCbgpuqXLoOm135AdbT3p4Ip9puSh
	 BaflbXfYwUnH0i5zdKs9uVTLdu/XGF5dv8Q47RRFmA8KLNsC1NhVuy1k9Re50u6sjC
	 gD4pLhn5DU4C/J9kwpNmhsz5p+V/HVhkiKwkixQO9GgPuyFO5f8mcBtEC3kYyJn+eO
	 iFrj1HGijTMaQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QSDyH0Sqcz1SfJ;
	Fri, 26 May 2023 02:08:55 -0400 (EDT)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by lists.lttng.org (Postfix) with ESMTPS id 4QSDyG0KVrz1SrY
 for <lttng-dev@lists.lttng.org>; Fri, 26 May 2023 02:08:53 -0400 (EDT)
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f3b900195dso1396e87.1
 for <lttng-dev@lists.lttng.org>; Thu, 25 May 2023 23:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685081332; x=1687673332;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DB/USL4K9IQdYmqrlQK7SW/V3ur9XJcFHOSKtDCLkhw=;
 b=IRvWZnIEhd0jGZd+wrZgE8CTnY6Eiz7D31pOTQaEdnQ1RGvLFQiT5+rtqI0nBdTA72
 HzvaAOCKS1KtjeLy+zoheSZ13ncvJletFzwDFQ1a0wEiZ2wJo/cbLvEuR/kI/riYcUGx
 np9M9W/N8/MhKUqHsP2ppbNVk7Rk/bznynN8P7UhCJrbCB5i1Wic29OCZ3T2UPwqpCnO
 IiDGUPFslWuQeCQHROVpoQpRLLbWYnGLO5umSHbQj4vQudHMb2kTjcfHxK3qcIY48jYe
 UbOkm5fuXBPrRU37H/Km047bIzV2O5gGuk2SACJUTZ5E6HK3odx+gAgdWxYs/InxA7Us
 4j/A==
X-Gm-Message-State: AC+VfDy9yth178myOqDRaepJApLV1pmnb41QQ2/dqcX3WK7cLcZ+Zivz
 GXQVsNaIW57wVpc803I3So9//mi+ucVW7i/8LpG17Q==
X-Google-Smtp-Source: ACHHUZ55DyZfVsiC6UYuB9LQozd+DICPZRxgkyjCFoWb6IZGnZbP959X9i1dkMmdPx9KbsjeY+8TRaeGJlSuKHMhxr8=
X-Received: by 2002:a05:6512:3258:b0:4ec:5157:bb37 with SMTP id
 c24-20020a056512325800b004ec5157bb37mr15723lfr.2.1685081332133; Thu, 25 May
 2023 23:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+a22N7gvcePvBazN_=AyeigVaeH-nFX-ZqZbq49mftMPg@mail.gmail.com>
 <EFA4F8F7-0767-4FEF-8EA5-DDEA05F3296C@sury.org>
In-Reply-To: <EFA4F8F7-0767-4FEF-8EA5-DDEA05F3296C@sury.org>
Date: Fri, 26 May 2023 08:08:40 +0200
Message-ID: <CACT4Y+bwGm1h5A0qsjCQrLzwt+uAbNZ-D+6zSr6PiXDGq2LgYw@mail.gmail.com>
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Cc: Olivier Dion <odion@efficios.com>, tsan-users <tsan-users@google.com>,
 lttng-dev@lists.lttng.org, 
 "Paul E. McKenney" <paulmck@kernel.org>, Tony Finch <fanf@isc.org>
Subject: Re: [lttng-dev] [PATCH 00/11] Add support for TSAN to liburcu
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
From: Dmitry Vyukov via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gRnJpLCAyNiBNYXkgMjAyMyBhdCAwNzozMywgT25kxZllaiBTdXLDvSA8b25kcmVqQHN1cnku
b3JnPiB3cm90ZToKPgo+IEEgbGl0dGxlIGJpdCByZWxhdGVkIHF1ZXN0aW9uL3Byb2JsZW0gLSBz
b21lIG9mIG91ciBzeXN0ZW0gdGVzdCBqb2JzIGdvdCBzaWduaWZpY2FudGx5IHNsb3dlciAoM3gt
NXgpIHdpdGggKipjbGFuZy0xNioqIFRTQU4gYWZ0ZXIgd2UgaW50ZWdyYXRlZCBsaWJ1cmN1IHRv
IEJJTkQgOS4gVGhlIEdDQyAoMTMuMS4xKSBUU0FOIGRvZXNu4oCZdCBleGhpYml0IHRoaXMgYmVo
YXZpb3IuCj4KPiBUaGUgbGlidXJjdSBpbnRlZ3JhdGlvbiBpbiBCSU5EIDkgaXMgdmVyeSBsaWdo
dCBhdCB0aGUgbW9tZW50IC0gd2UgdXNlIGxpYnVyY3UgZm9yIHFwdHJpZSBhbmQgdGhlcmXigJlz
IHNvbWUgdXNhZ2Ugb2Ygd2ZjcXVldWUgZm9yIHF1ZXVpbmcgam9icyhjYWxsYmFja3MpIGJldHdl
ZW4gdGhyZWFkcy4KPgo+IFdlIHdlcmUgbm90IGFibGUgdG8gcHV0IGEgZmluZ2VyIG9uIGl0IHll
dCwgYnV0IHNheWluZyB0aGlzIGFsb3VkIG1pZ2h0IGhlbHAgZGlhZ25vc2UgdGhpcy4KCkludGVy
ZXN0aW5nLiBDbGFuZyAxNiBnb3QgYSBjb21wbGV0ZWx5IG5ldyB0c2FuIHJ1bnRpbWUKaW1wbGVt
ZW50YXRpb24sIHdoaWNoIGlzIGdlbmVyYWxseSB+MnggZmFzdGVyIGFuZCBjb25zdW1lcyBsZXNz
Cm1lbW9yeS4KSG93ZXZlciwgb2YgY291cnNlLCBpdCdzIG5vdCBwb3NzaWJsZSB0byBvcHRpbWl6
ZSBmb3IgYWxsIGdhemlsbGlvbiBvZgpwcm9ncmFtcyBpbiB0aGUgd29ybGQuIEkgc3VzcGVjdCBs
aWJyY3UgdGVzdHMgYXJlIHF1aXRlIGV4dHJlbWUgaW4KdGVybXMgb2Ygc3luY2hyb25pemF0aW9u
LgoKSWYgeW91IGNvbGxlY3QgcGVyZiBwcm9maWxlcyBmb3IgYm90aCwgSSBjYW4gbG9vayBmb3Ig
c29tZSBsb3cgaGFuZ2luZyBmcnVpdC4KT3IgaXMgdGhlcmUgYSByZWFzb25hYmxlIHdheSBmb3Ig
bWUgdG8gcmVwcm9kdWNlPwoKCj4gT25kcmVqCj4gLS0KPiBPbmTFmWVqIFN1csO9IDxvbmRyZWpA
c3VyeS5vcmc+IChIZS9IaW0pCj4KPiA+IE9uIDI0LiA1LiAyMDIzLCBhdCAxMDoxNSwgRG1pdHJ5
IFZ5dWtvdiB2aWEgbHR0bmctZGV2IDxsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnPiB3cm90ZToK
PiA+Cj4gPiDvu79PbiBUdWUsIDIzIE1heSAyMDIzIGF0IDE4OjA1LCBPbGl2aWVyIERpb24gPG9k
aW9uQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiBIaSBEbWl0cnksCj4gPj4KPiA+PiBX
ZSBkbyBoYXZlIGEgbmV3IGlzc3VlIGFuZCB3ZSB0aGluayBpdCBtaWdodCBiZSBhIGxpbWl0YXRp
b24gZnJvbSBUU0FOLgo+ID4+Cj4gPj4gRmluZCBhdHRhY2hlZCBhIHRlc3QgcHJvZ3JhbSB0aGF0
IHdlIGJlbGlldmUgaXMgY29ycmVjdC4gIFlvdSBjYW4KPiA+PiBjb21waWxlIGl0IHdpdGggYGdj
YyAtZnNhbml0aXplPXRocmVhZCB0ZXN0LmMgLXB0aHJlYWQnLgo+ID4+Cj4gPj4KPiA+PiBUU0FO
IGZsYWdzIGEgcmFjZSBjb25kaXRpb24gYmV0d2VlbiB0aGUgYXRvbWljIHN0b3JlIHJlbGF4ZWQg
YXQgbGluZSAzNgo+ID4+IGFuZCB0aGUgZnJlZSBhdCBsaW5lIDgxLgo+ID4+Cj4gPj4gV2UgY2Fu
IHNvbHZlIHRoZSBpc3N1ZSBieSByZXBsYWNpbmcgdGhlIGF0b21pYyBzdG9yZSByZWxheGVkIHdp
dGggYQo+ID4+IGF0b21pYyBzdG9yZSByZWxlYXNlLiAgSG93ZXZlciwgdGhlIHByZWNlZGluZyBh
dG9taWMgZXhjaGFuZ2Ugd2l0aAo+ID4+IHNlcXVlbnRpYWwgY29uc2lzdGVuY3kgYWxyZWFkeSBh
Y3RzIGFzIGFuIGltcGxpY2l0IHJlbGVhc2UgKGluIHRlcm0gb2YKPiA+PiBtZW1vcnkgYmFycmll
cikgZm9yIHRoZSBmb2xsb3dpbmcgc3RvcmUsIG1ha2luZyB0aGUgcmVsZWFzZSBzZW1hbnRpYwo+
ID4+IHJlZHVuZGFudC4KPiA+Pgo+ID4+IFdlJ3ZlIGZvdW5kIGFuIGFsdGVybmF0aXZlIHRvIGZp
eCB0aGlzIGJ5IGlnbm9yaW5nIHRoZSB0aHJlYWQgZHVyaW5nIHRoZQo+ID4+IHJlbGF4ZWQgc3Rv
cmUgKGxpbmUgMzkpLiAgSG93ZXZlciwgd2hhdCB3ZSB3b3VsZCBsaWtlIGlzIHRvIGFubm90YXRl
IHRoZQo+ID4+IG1lbW9yeSBzdG9yZWQgKGxpbmUgNDUpLgo+ID4+Cj4gPj4gTXkgdGhlb3J5IChJ
IGRvbid0IGtub3cgdGhlIGludGVybmFsIG9mIFRTQU4gbXVjaCkgaXMgdGhhdCBUU0FOIHRoaW5r
cwo+ID4+IGZvciBzb21lIHJlYXNvbiB0aGF0IHRoZSBhdG9taWMgc3RvcmUgcmVsYXhlZCBoYXBw
ZW4gYXQgdGhlIHNhbWUgZXBvY2gKPiA+PiBhcyB0aGUgZnJlZSwgcmVzdWx0aW5nIGluIGEgZmFs
c2UgcG9zaXRpdmUuICBJZiBzbywgbQo+ID4KPiA+Cj4gPiBJIGRvbid0IHRoaXMgdGhpcyBpcyB0
cnVlIGluIHRoZSBDL0MrKyBtZW1vcnkgbW9kZWw6Cj4gPiAidGhlIHByZWNlZGluZyBhdG9taWMg
ZXhjaGFuZ2Ugd2l0aCBzZXF1ZW50aWFsIGNvbnNpc3RlbmN5IGFscmVhZHkKPiA+IGFjdHMgYXMg
YW4gaW1wbGljaXQgcmVsZWFzZSAoaW4gdGVybSBvZiBtZW1vcnkgYmFycmllcikgZm9yIHRoZQo+
ID4gZm9sbG93aW5nIHN0b3JlIi4KPiA+Cj4gPiBzdGQ6OmF0b21pY190aHJlYWRfZmVuY2UgZG9l
cyBhZmZlY3QgYWxsIHByZWNlZGluZy9zdWJzZXF1ZW50Cj4gPiBvcGVyYXRpb25zLCBidXQgYW4g
YXRvbWljIG1lbW9yeSBvcGVyYXRpb24gb25seSBhZmZlY3RzIG9yZGVyaW5nIG9uCj4gPiB0aGF0
IHZhcmlhYmxlLCBpdCBkb2Vzbid0IGFsc28gc2VydmUgYXMgYSBzdGFuZGFsb25lIG1lbW9yeSBm
ZW5jZS4KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cj4gPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8v
bGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
