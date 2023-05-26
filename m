Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8945C7EE23
	for <lttng-dev@archiver.kernel.org>; Fri, 26 May 2023 06:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1685081416;
	bh=wm39LGuSbJHME4g0Lt67imDD+NlsfVGo1PMP50wR90Y=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=I56SgqQxPH+uVNxrkYGYpunL9p1sLooPs9Yic9Qs3V+n4Jw/xAj8/2WNk0yguAfet
	 ScYa90OHYpFmT5Lnl+4MgHy+J0BaHM0SMYbIQi7BCO/2O+LRze0ybFJOVSowQo4fh6
	 eKq5wwoRy5q0e+L0voOVyW+BBE4M2ogc8Vuu8mMTdmu2t5KdzOj+5lL+B7lUn/hN9Y
	 QD2ikJW4MMEU8SBz0qw6oiZQiD4iv3+s3DdDhhdulGVvUpoEk4mcEys0GOqfAZadsb
	 SVc9z9lX21yt+9ekQH/Vp3g0qC9KhVHbmt6Zp/+ajLl2As30rS7Ie1CzZEA//3daEW
	 z8sa4kb/iI9sg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QSDzq75ZSz1T8J;
	Fri, 26 May 2023 02:10:15 -0400 (EDT)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by lists.lttng.org (Postfix) with ESMTPS id 4QSDzp3tPvz1T8G
 for <lttng-dev@lists.lttng.org>; Fri, 26 May 2023 02:10:14 -0400 (EDT)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f14865fcc0so2269e87.0
 for <lttng-dev@lists.lttng.org>; Thu, 25 May 2023 23:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685081413; x=1687673413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ehjLzFWa0XBx1aYs4eggbmE++xQ4OJ5hVwau4+q1EYQ=;
 b=IMUz5cA05vM6GQHdYONWsro4y6mGWdS5iCEK79hAM7CFTucxUVdhBs1pYXoXif5JC4
 w3mwwYPC49+NRSzw4sMfdtywTMvgehaCcrEGQ/QEMncMkiFiMil6rJxbHWJ1zhXP0gGm
 vfgZOd/vTJ2pOQiV0N9oK1al8kqnwFmNuCETr6S3WwsqoGXPlYoVyoWf9rs9VEWIBAhf
 xxGrSFBytY1+AX9FW58OLgvtlFUjkS6J+xH8t0ag3rP+eOKcTGBAwhhmTOocy9/77JYf
 y9RgD6CLwEadMYqH6KeY+4zuUkvcPUcAt/yPMdLR2qB0O22fW063T2xpvk3cwu4kisTt
 Qc7g==
X-Gm-Message-State: AC+VfDxRy7YUwMlkXJlWCNWFFQwrxQ8H81gb3obv1ybNthdM8Nqk1u1U
 h4TXpop+pmXXHgzEt/TtnF7nrTmx1FQy+k7xCKOpoQ==
X-Google-Smtp-Source: ACHHUZ6aAwsEArIUVuRa1uy8VH6JXmGDnJQudA8BzpX59tAcEEPI6zokYeQeYvZ1of7DA5jVPC13hxEa2g/wCH6oHVw=
X-Received: by 2002:ac2:5f19:0:b0:4f3:a7c6:590e with SMTP id
 25-20020ac25f19000000b004f3a7c6590emr4352lfq.7.1685081412821; Thu, 25 May
 2023 23:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+a22N7gvcePvBazN_=AyeigVaeH-nFX-ZqZbq49mftMPg@mail.gmail.com>
 <EFA4F8F7-0767-4FEF-8EA5-DDEA05F3296C@sury.org>
 <CACT4Y+bwGm1h5A0qsjCQrLzwt+uAbNZ-D+6zSr6PiXDGq2LgYw@mail.gmail.com>
In-Reply-To: <CACT4Y+bwGm1h5A0qsjCQrLzwt+uAbNZ-D+6zSr6PiXDGq2LgYw@mail.gmail.com>
Date: Fri, 26 May 2023 08:10:00 +0200
Message-ID: <CACT4Y+ZuC6oO3Ns=LKbL0NGK7RG9m+-gL6DYv5gzt_wgdAVGFQ@mail.gmail.com>
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

T24gRnJpLCAyNiBNYXkgMjAyMyBhdCAwODowOCwgRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29n
bGUuY29tPiB3cm90ZToKPiA+IEEgbGl0dGxlIGJpdCByZWxhdGVkIHF1ZXN0aW9uL3Byb2JsZW0g
LSBzb21lIG9mIG91ciBzeXN0ZW0gdGVzdCBqb2JzIGdvdCBzaWduaWZpY2FudGx5IHNsb3dlciAo
M3gtNXgpIHdpdGggKipjbGFuZy0xNioqIFRTQU4gYWZ0ZXIgd2UgaW50ZWdyYXRlZCBsaWJ1cmN1
IHRvIEJJTkQgOS4gVGhlIEdDQyAoMTMuMS4xKSBUU0FOIGRvZXNu4oCZdCBleGhpYml0IHRoaXMg
YmVoYXZpb3IuCj4gPgo+ID4gVGhlIGxpYnVyY3UgaW50ZWdyYXRpb24gaW4gQklORCA5IGlzIHZl
cnkgbGlnaHQgYXQgdGhlIG1vbWVudCAtIHdlIHVzZSBsaWJ1cmN1IGZvciBxcHRyaWUgYW5kIHRo
ZXJl4oCZcyBzb21lIHVzYWdlIG9mIHdmY3F1ZXVlIGZvciBxdWV1aW5nIGpvYnMoY2FsbGJhY2tz
KSBiZXR3ZWVuIHRocmVhZHMuCj4gPgo+ID4gV2Ugd2VyZSBub3QgYWJsZSB0byBwdXQgYSBmaW5n
ZXIgb24gaXQgeWV0LCBidXQgc2F5aW5nIHRoaXMgYWxvdWQgbWlnaHQgaGVscCBkaWFnbm9zZSB0
aGlzLgo+Cj4gSW50ZXJlc3RpbmcuIENsYW5nIDE2IGdvdCBhIGNvbXBsZXRlbHkgbmV3IHRzYW4g
cnVudGltZQo+IGltcGxlbWVudGF0aW9uLCB3aGljaCBpcyBnZW5lcmFsbHkgfjJ4IGZhc3RlciBh
bmQgY29uc3VtZXMgbGVzcwo+IG1lbW9yeS4KPiBIb3dldmVyLCBvZiBjb3Vyc2UsIGl0J3Mgbm90
IHBvc3NpYmxlIHRvIG9wdGltaXplIGZvciBhbGwgZ2F6aWxsaW9uIG9mCj4gcHJvZ3JhbXMgaW4g
dGhlIHdvcmxkLiBJIHN1c3BlY3QgbGlicmN1IHRlc3RzIGFyZSBxdWl0ZSBleHRyZW1lIGluCj4g
dGVybXMgb2Ygc3luY2hyb25pemF0aW9uLgo+Cj4gSWYgeW91IGNvbGxlY3QgcGVyZiBwcm9maWxl
cyBmb3IgYm90aCwgSSBjYW4gbG9vayBmb3Igc29tZSBsb3cgaGFuZ2luZyBmcnVpdC4KPiBPciBp
cyB0aGVyZSBhIHJlYXNvbmFibGUgd2F5IGZvciBtZSB0byByZXByb2R1Y2U/CgpIb3cgbWFueSBD
UFVzIGRvIHRoZXNlIG1hY2hpbmVzIGhhdmU/Cgo+ID4gT25kcmVqCj4gPiAtLQo+ID4gT25kxZll
aiBTdXLDvSA8b25kcmVqQHN1cnkub3JnPiAoSGUvSGltKQo+ID4KPiA+ID4gT24gMjQuIDUuIDIw
MjMsIGF0IDEwOjE1LCBEbWl0cnkgVnl1a292IHZpYSBsdHRuZy1kZXYgPGx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmc+IHdyb3RlOgo+ID4gPgo+ID4gPiDvu79PbiBUdWUsIDIzIE1heSAyMDIzIGF0
IDE4OjA1LCBPbGl2aWVyIERpb24gPG9kaW9uQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gPiA+Pgo+
ID4gPj4gSGkgRG1pdHJ5LAo+ID4gPj4KPiA+ID4+IFdlIGRvIGhhdmUgYSBuZXcgaXNzdWUgYW5k
IHdlIHRoaW5rIGl0IG1pZ2h0IGJlIGEgbGltaXRhdGlvbiBmcm9tIFRTQU4uCj4gPiA+Pgo+ID4g
Pj4gRmluZCBhdHRhY2hlZCBhIHRlc3QgcHJvZ3JhbSB0aGF0IHdlIGJlbGlldmUgaXMgY29ycmVj
dC4gIFlvdSBjYW4KPiA+ID4+IGNvbXBpbGUgaXQgd2l0aCBgZ2NjIC1mc2FuaXRpemU9dGhyZWFk
IHRlc3QuYyAtcHRocmVhZCcuCj4gPiA+Pgo+ID4gPj4KPiA+ID4+IFRTQU4gZmxhZ3MgYSByYWNl
IGNvbmRpdGlvbiBiZXR3ZWVuIHRoZSBhdG9taWMgc3RvcmUgcmVsYXhlZCBhdCBsaW5lIDM2Cj4g
PiA+PiBhbmQgdGhlIGZyZWUgYXQgbGluZSA4MS4KPiA+ID4+Cj4gPiA+PiBXZSBjYW4gc29sdmUg
dGhlIGlzc3VlIGJ5IHJlcGxhY2luZyB0aGUgYXRvbWljIHN0b3JlIHJlbGF4ZWQgd2l0aCBhCj4g
PiA+PiBhdG9taWMgc3RvcmUgcmVsZWFzZS4gIEhvd2V2ZXIsIHRoZSBwcmVjZWRpbmcgYXRvbWlj
IGV4Y2hhbmdlIHdpdGgKPiA+ID4+IHNlcXVlbnRpYWwgY29uc2lzdGVuY3kgYWxyZWFkeSBhY3Rz
IGFzIGFuIGltcGxpY2l0IHJlbGVhc2UgKGluIHRlcm0gb2YKPiA+ID4+IG1lbW9yeSBiYXJyaWVy
KSBmb3IgdGhlIGZvbGxvd2luZyBzdG9yZSwgbWFraW5nIHRoZSByZWxlYXNlIHNlbWFudGljCj4g
PiA+PiByZWR1bmRhbnQuCj4gPiA+Pgo+ID4gPj4gV2UndmUgZm91bmQgYW4gYWx0ZXJuYXRpdmUg
dG8gZml4IHRoaXMgYnkgaWdub3JpbmcgdGhlIHRocmVhZCBkdXJpbmcgdGhlCj4gPiA+PiByZWxh
eGVkIHN0b3JlIChsaW5lIDM5KS4gIEhvd2V2ZXIsIHdoYXQgd2Ugd291bGQgbGlrZSBpcyB0byBh
bm5vdGF0ZSB0aGUKPiA+ID4+IG1lbW9yeSBzdG9yZWQgKGxpbmUgNDUpLgo+ID4gPj4KPiA+ID4+
IE15IHRoZW9yeSAoSSBkb24ndCBrbm93IHRoZSBpbnRlcm5hbCBvZiBUU0FOIG11Y2gpIGlzIHRo
YXQgVFNBTiB0aGlua3MKPiA+ID4+IGZvciBzb21lIHJlYXNvbiB0aGF0IHRoZSBhdG9taWMgc3Rv
cmUgcmVsYXhlZCBoYXBwZW4gYXQgdGhlIHNhbWUgZXBvY2gKPiA+ID4+IGFzIHRoZSBmcmVlLCBy
ZXN1bHRpbmcgaW4gYSBmYWxzZSBwb3NpdGl2ZS4gIElmIHNvLCBtCj4gPiA+Cj4gPiA+Cj4gPiA+
IEkgZG9uJ3QgdGhpcyB0aGlzIGlzIHRydWUgaW4gdGhlIEMvQysrIG1lbW9yeSBtb2RlbDoKPiA+
ID4gInRoZSBwcmVjZWRpbmcgYXRvbWljIGV4Y2hhbmdlIHdpdGggc2VxdWVudGlhbCBjb25zaXN0
ZW5jeSBhbHJlYWR5Cj4gPiA+IGFjdHMgYXMgYW4gaW1wbGljaXQgcmVsZWFzZSAoaW4gdGVybSBv
ZiBtZW1vcnkgYmFycmllcikgZm9yIHRoZQo+ID4gPiBmb2xsb3dpbmcgc3RvcmUiLgo+ID4gPgo+
ID4gPiBzdGQ6OmF0b21pY190aHJlYWRfZmVuY2UgZG9lcyBhZmZlY3QgYWxsIHByZWNlZGluZy9z
dWJzZXF1ZW50Cj4gPiA+IG9wZXJhdGlvbnMsIGJ1dCBhbiBhdG9taWMgbWVtb3J5IG9wZXJhdGlv
biBvbmx5IGFmZmVjdHMgb3JkZXJpbmcgb24KPiA+ID4gdGhhdCB2YXJpYWJsZSwgaXQgZG9lc24n
dCBhbHNvIHNlcnZlIGFzIGEgc3RhbmRhbG9uZSBtZW1vcnkgZmVuY2UuCj4gPiA+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiA+IGx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKPiA+ID4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+ID4gPiBodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cj4gPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYg
bWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
