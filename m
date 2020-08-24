Return-Path: <SRS0=E16+=CC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29BEC433E1
	for <lttng-dev@archiver.kernel.org>; Mon, 24 Aug 2020 22:33:34 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7161D20656
	for <lttng-dev@archiver.kernel.org>; Mon, 24 Aug 2020 22:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="mwsmwDPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7161D20656
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Bb6NF0T2rz2vl;
	Mon, 24 Aug 2020 18:33:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1598308413;
	bh=aoIsRInnU06y8jDlsXrRWHmAk4IWUaKf7haxuvwjivA=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=mwsmwDPLJeJH7uPMmDDpoJMUBZQjU6vn25p2y74zfQEEbid3YrjbYAmkWOkNpW9pV
	 hyJVe9biUxKId5OLlNm5YNxbfrfz8lyP/RFhYuuYDTv96yRcwzGeIVcnnnCNsO0Ie4
	 SKrhNZDWf9reZLGefxkfAMjgh3h929JcJxTgGGYoOmlmFQKj6H/xSLYpLf+tWhIvmm
	 5rOrewHsC77cOYM4J1ux62bz3qBW/dLIwoN/9mL6BO9ON/Ciq7w7zZaoeXSyzZ25DO
	 lwpDFv+xyRGxisDvo92red4gc6fzEzNXU7alc+mRZ+u90l9yTC6Rg7c2aQhYGuFj2q
	 pLo7Vr+xvlp6A==
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 by lists.lttng.org (Postfix) with ESMTPS id 4Bb6NC2svsz367
 for <lttng-dev@lists.lttng.org>; Mon, 24 Aug 2020 18:33:31 -0400 (EDT)
Received: by mail-yb1-xb41.google.com with SMTP id s195so6052505ybc.8
 for <lttng-dev@lists.lttng.org>; Mon, 24 Aug 2020 15:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=P8OlGF9DN3texfoNL7ZSYSo5+zdtD9Pl1y4NSME0re4=;
 b=ofqR7fDnBBEsPLZa19B4cGwumqpSXQV96eDTmpK89bk+rUwowOcCPa7YWNHi8cB30b
 bHnnPOqPormUvLzSrATY4Wk7tmT2wp293LzrdyRjKYJetTlJOqqZb0ukwDXg/GjQnsXe
 YkCyXIx4baEjWJSZbODpYir+6RL1acndS7uzLaKCjtLkNEq4eVBS7YIw9vCPBYjulg3w
 pY5fsbHnAN6ZKISMUT1f654R4OQHjbv6ocR8lgDhIuRDvUdi2IPa1Zsxm7hpj6ObjXLM
 cDnjYKPysq7XAm8LCR/4ToXiJs7khgTdu9Tbor44hccSsF+av0wPv7x/BRxPrIZMLG3Z
 2L5g==
X-Gm-Message-State: AOAM530JyFVPsCQlw/AoOk2v52EderjxJcvL37ml44Aq9Yr34AX6Y3IP
 rSUqXYX3NjZ8M7EVEk6ZqJ29cRbnNrPORstSKWE=
X-Google-Smtp-Source: ABdhPJxa0Y3aGqapOKEFxzKTNY+BtvtDn/iesEJ8F+BeG9t/hdaVU0SGPoxaxf0aaSvDW3m9bhOUeL6aHcZT+QOEWkc=
X-Received: by 2002:a25:234a:: with SMTP id j71mr10640600ybj.504.1598308410574; 
 Mon, 24 Aug 2020 15:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <96422055-7592-4024-897D-35CD4D4211B9@ridgerun.com>
In-Reply-To: <96422055-7592-4024-897D-35CD4D4211B9@ridgerun.com>
Date: Mon, 24 Aug 2020 18:33:04 -0400
Message-ID: <CAB4xu_1s0CarVpxh-+jFEjX5vi2gcN-5dKaUMhLt49CBu58HMg@mail.gmail.com>
To: Michael Gruner <michael.gruner@ridgerun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] sink.ctf.fs vs bt_ctf_writer
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <eeppeliteloop@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

UGhpbGlwcGUgUHJvdWx4CgpPbiBNb24sIEF1ZyAyNCwgMjAyMCBhdCA1OjQxIFBNIE1pY2hhZWwg
R3J1bmVyIHZpYSBsdHRuZy1kZXYKPGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc+IHdyb3RlOgo+
Cj4gSGkgYWxsCj4KPiBJ4oCZbSBpbnRlZ3JhdGluZyBDVEYgc3VwcG9ydCB0byBhIHRoaXJkIHBh
cnR5IGZyYW1ld29yay4gVG8gZG8gc28sIEkgZGVjaWRlZCB0byBnbyB3aXRoIHRoZSBCYWJlbHRy
YWNlIDIgQVBJIChJIGxvdmUgdGhlIHJld3JpdGUgQlRXKS4KClRoYW5rIHlvdS4KCj4gU28gYmFz
aWNhbGx5IEkgbWFkZSBteSBjdXN0b20gcGx1Zy1pbiBhbmQgdGhlIGZyYW1ld29yayBzcGF3bnMg
dGhlIGZvbGxvd2luZyBwcm9jZXNzaW5nIGdyYXBoOgo+Cj4gTXkgRnJhbWV3b3JrIC0+ICBTT1VS
Q0UuTVlQTFVHSU4uTVlDT01QT05FTlQgLT4gU0lOSy5DVEYuRlMKPgo+IFRoaXMgZWZmZWN0aXZl
bHkgZ2VuZXJhdGVzIGEgdmFsaWQgc2V0IG9mIENURiB0cmFjZXMuIEhvd2V2ZXIsIHdoZW4gZXhw
bG9yaW5nIHRoZSBCYWJlbHRyYWNlMiBzb3VyY2UgSSBmb3VuZCB0aGUgZXhpc3RlbmNlIG9mIGEg
YnRfY3RmX3dyaXRlciwgd2hpY2ggc2VlbXMgbGlrZSBhIGNvbnZlbmllbmNlIG9iamVjdCB0byB3
cml0ZSBDVEYgZGlyZWN0bHkgKHdpdGhvdXQgdGhlIG5lZWQgb2YgdGhlIGdyYXBoKS4gVGhpcyB3
b3VsZOKAmXZlIGJlZW4gYSBtdWNoIHNpbXBsZXIgYXBwcm9hY2ggZm9yIG15IHVzZSBjYXNlLCBz
byBJ4oCZbSBldmFsdWF0aW5nIHRvIHJld3JpdGUgdXNpbmcgYnRfY3RmX3dyaXRlciBpbiBmYXZv
ciBvZiBzaW1wbGljaXR5IGFuZCBtYWludGFpbmFiaWxpdHkuIE15IHF1ZXN0aW9ucyBhcmU6Cj4K
PiBTaG91bGQgYnRfY3RmX3dyaXRlciBiZSB1c2VkPwoKWW91IGNhbiB1c2UgaXQuCgpTaG91bGQg
eW91IHVzZSBpdD8gVGhlIHByb2plY3QgZG9lc24ndCByZWNvbW1lbmQgaXQuCgpTZWUKPGh0dHBz
Oi8vYmFiZWx0cmFjZS5vcmcvZG9jcy9yZWxlYXNlLW5vdGVzL2JhYmVsdHJhY2UtMi4wLjAtcmVs
ZWFzZS1ub3Rlcy5odG1sI19iYWNrZ3JvdW5kPgp3aGljaCBtZW50aW9ucyBDVEYgd3JpdGVyLgoK
VGhlIEJhYmVsdHJhY2UgMiBDVEYgd3JpdGVyIEFQSSBleGlzdHMgZm9yIGJhY2t3YXJkIGNvbXBh
dGliaWxpdHkKcmVhc29ucywgdG8gbWFrZSB1c2VycyBvZiBCVCAxJ3MgQ1RGIHdyaXRlciBtaWdy
YXRlIHRvIEJUIDIgbW9yZSBlYXNpbHkuCgpIb3dldmVyLCBpdCdzIG5vdCBhIHBhcnQgb2YgdGhl
IHByb2plY3Qgb24gd2hpY2ggd2UgcGxhbiB0byBwdXQgZWZmb3J0cwppbiB0aGUgZnV0dXJlLiBG
b3IgZXhhbXBsZSwgd2hlbiBDVEYgMiBpcyByZWxlYXNlZCwgYHNpbmsuY3RmLmZzYCB3aWxsCnN1
cHBvcnQgcHJvZHVjaW5nIGl0LCBidXQgYGJ0X2N0Zl93cml0ZXJgIHByb2JhYmx5IHdvbid0LgoK
VGhpcyBpcyBhbHNvIHdoeSB3ZSBkaWRuJ3QgY3JhZnQgUHl0aG9uIDMgYmluZGluZ3MgZm9yIHRo
ZSBCVCAyIENURgp3cml0ZXIgQVBJLgoKPiBidF9jdGZfd3JpdGVyIGlzIG5vdCBkb2N1bWVudGVk
LCBpcyBpdCBiZWNhdXNlIGlzIGJlaW5nIGRlcHJlY2F0ZWQ/CgouLi4gYW5kIHRoaXMgaXMgYWxz
byB3aHkgd2UgZGlkbid0IGRvY3VtZW50IGl0LgoKVGhlIHByb2plY3QncyBwb3NpdGlvbiBpcyB0
byBlbmNvdXJhZ2UgdGhlIGNyZWF0aW9uIG9mIHJldXNhYmxlCmNvbXBvbmVudCBjbGFzc2VzICh3
aGF0IHlvdSBkaWQgc28gZmFyKS4KCj4gU2VlbXMgbGlrZSBzaW5rLmN0Zi5mcyBwZXJmb3JtcyB0
aGUgdHJhY2UgYW5kIG1ldGFkYXRhIHdyaXRlIGJhY2sgdG8gZGlzayB3aGVuIGl0IHJlY2VpdmVz
IHRoZSBlbmQgbWVzc2FnZSwgd2hlcmVhcyB3aXRoIGJ0X2N0Zl93cml0ZXIgSSBjYW4gbWFudWFs
bHkgZmx1c2ggdGhlbSAod2hpY2ggaXMgdmVyeSBjb252ZW5pZW50IHRvIG1lKS4gSXMgdGhlcmUg
YSB3YXkgdG8gYWNoaWV2ZSB0aGlzIHVzaW5nIHRoZSBncmFwaD8KCldoaWNoICJlbmQgbWVzc2Fn
ZSI/CgpDdXJyZW50bHksIGJvdGggYHNpbmsuY3RmLmZzYCBhbmQgQ1RGIHdyaXRlciB1c2UgdGhl
IHNhbWUgaW50ZXJuYWwgQ1RGCnNlcmlhbGl6YXRpb24gQVBJIHdoaWNoIHVzZXMgYW4gYXV0b21h
dGljYWxseSBncm93aW5nIG1lbW9yeSBtYXAgdG8Kd3JpdGUgZGF0YSB0byB0aGUgZmlsZSBzeXN0
ZW0uCgpXaGF0J3MgeW91ciB1c2UgY2FzZSBoZXJlIGV4YWN0bHk/CgpCUiwKClBoaWwKCj4KPgo+
IFRoYW5rcyEKPiBNaWNoYWVsCj4gd3d3LnJpZGdlcnVuLmNvbQo+Cj4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
