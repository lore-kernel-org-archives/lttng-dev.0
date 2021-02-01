Return-Path: <SRS0=7ik+=HD=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469A7C433E0
	for <lttng-dev@archiver.kernel.org>; Mon,  1 Feb 2021 13:02:57 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27A160C41
	for <lttng-dev@archiver.kernel.org>; Mon,  1 Feb 2021 13:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27A160C41
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DTp5T5bW3z16Hj;
	Mon,  1 Feb 2021 08:02:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1612184574;
	bh=Zrdipw3I6zoSw9L8NK1D+HeReWY/LZPoRFjLUQG5xr8=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Vl1uHwrSDiPZtj6QhtDsgCBftGfS0AbEulDYFAAD92de3YOShBRqs4aVEIWvZTGkt
	 Eaq8ScTLdQS7aTxjhN0DnevVNOWvsOmFZKAIRJ7nQbbjU/2Kny9e4c15PA7O+zEpUb
	 g/WqRlIqxNHyKT9ALwx7Hx9mR6PxH7BGygLioSNllMndqZoJi/ZRHS+8KMTxdbyEsj
	 oo2peVZ53yN777/CMbEvhReuemDNTy1nHl/MEhcElt8mfPPCB6o0pfi6ClxvKmHt0K
	 37RUXho4Iy5czz/JpOmSj3MLQ8cuKIkX+6LesY5uk7Pr/Y9Pzr762M00IveKNbHpo1
	 HROYWMok2i5EA==
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 by lists.lttng.org (Postfix) with ESMTPS id 4DTp5R5Vk2z16Hg
 for <lttng-dev@lists.lttng.org>; Mon,  1 Feb 2021 08:02:51 -0500 (EST)
Received: by mail-yb1-xb34.google.com with SMTP id b187so2667288ybg.9
 for <lttng-dev@lists.lttng.org>; Mon, 01 Feb 2021 05:02:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9HRg0vi/RMnB1ZEMhTFRjMvNpWRoRC4DSnoYtQzsLuk=;
 b=GwFNFX2kC3aFvklTl3jFBodukNylD6AxFPEAJ42w7N0AlvQwglndMhIxF44nTP8qNf
 TmVUzXGm46AmfBIbb2Pe7c2n/F2qrWFdShXKuhJXPfI/4YxsEvUWMTDYO3ONw6zQKn8T
 4bEH9A4vqUVe+66vFcbMLs7bV7OZDQib0brkZ0Qs9ksQ/QxpB4sLJl7sOqHi3rKcekTX
 jgKUgqtBgArEnCbo9tLHY/cNTV1F98XODcCCnsL+3o2s+g+0RZ2rg1m5HO/5uMUSrE2D
 B62QAygdy03XxMU3kEAjE1K/c0cv0XSJVXVcSe7D+a6HWYzf9wcqkCwGzx2hucXKpVv3
 0Q6g==
X-Gm-Message-State: AOAM530N91kxCp7B/nJiI2Q6hz0/hN69g0/AbVtCUUZYHVO+HLq/Dfq+
 f3RnGsCzpm2hhLUuknLXhsxss5IBssWe7AdGwss=
X-Google-Smtp-Source: ABdhPJwLc6LdAheXQM+c1iJm/8RYyKtt92BowyPvFzqfw1Vcd4SXMHkSzoSD0E+pWm7m6wZX0dxGMD1javTCko0BtsE=
X-Received: by 2002:a5b:108:: with SMTP id 8mr12023640ybx.398.1612184570766;
 Mon, 01 Feb 2021 05:02:50 -0800 (PST)
MIME-Version: 1.0
References: <386C5D4D5C53C24CBC2C60CAAFD2136A5B4A40A0@EXDAG0-B1.intra.cea.fr>
In-Reply-To: <386C5D4D5C53C24CBC2C60CAAFD2136A5B4A40A0@EXDAG0-B1.intra.cea.fr>
Date: Mon, 1 Feb 2021 08:02:24 -0500
Message-ID: <CAB4xu_0dP0Hu9pcu7v12c6mjaaTVSrocDZ3f4gJHDge+xzD0jQ@mail.gmail.com>
To: RADERMACHER Ansgar <Ansgar.RADERMACHER@cea.fr>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <eeppeliteloop@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gTW9uLCBGZWIgMSwgMjAyMSBhdCA0OjM5IEFNIFJBREVSTUFDSEVSIEFuc2dhciB2aWEgbHR0
bmctZGV2CjxsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnPiB3cm90ZToKPgo+IEhlbGxvLAo+Cj4g
d2UncmUgY3VycmVudGx5IHdvcmtpbmcgb24gQ1RGIGNvZGUgaW5zdHJ1bWVudGF0aW9uIGluIHRo
ZSBDKysgY29kZSBnZW5lcmF0aW9uIGZyb20gUGFweXJ1cy4gVW5saWtlIGluIGEgcHJldmlvdXMg
dmVyc2lvbiwgd2UgdXNlIEJhcmVDVEYuCj4KPiBJbiB0aGlzIGNvbnRleHQsIHRoZSBtZXRhZGF0
YSB0YWcgIm1vZGVsLmVtZi51cmkiIGNhbiBjb250YWluIHRoZSBVUkkgb2YgdGhlIGVsZW1lbnQg
dG8gdHJhY2UuIFRoaXMgd29ya3MgZmluZSBpbiBUcmFjZUNvbXBhc3MsIGlmIHdlIG1hbnVhbGx5
IGFkZCB0aGUgVVJJIHRvIHRoZSBtZXRhZGF0YSwgYXMgc2hvd24gYmVsb3cuIEJ1dCBJIGhhdmUg
bm90IGJlZW4gYWJsZSB0byBhZGQgYW4gZW50cnkgdG8gQmFyZUNURidzIGNvbmZpZy55YW1sIHRo
YXQgcHJvZHVjZXMgdGhlIG1vZGVsLmVtZi51cmkgaW4gdGhlIGdlbmVyYXRlZCBtZXRhZGF0YSBm
aWxlLiBJcyBpdCBwb3NzaWJsZT8KPgo+IEkgY291bGQgbm90IGZpbmQgYW4gc3VpdGFibGUgZXhh
bXBsZSBpbiB0aGUgZG9jdW1lbnRhdGlvbiAtIEkgZXhwZXJpbWVudGVkIHdpdGggdGhlICJzcGVj
aWZpYy1jb250ZXh0LWZpZWxkLXR5cGUiLCBidXQgaXQgYWxzbyBhZGRzIGEgcGFyYW1ldGVyIHRv
IHRoZSBnZW5lcmF0ZWQgQyBjb2RlIGZ1bmN0aW9ucyB3aGljaCBpcyBub3Qgd2hhdCBJIHdhbnQu
Cj4KClRoYW5rIHlvdSBmb3Igd3JpdGluZyBBbnNnYXIuCgpBbHRob3VnaCBiYXJlY3RmIDMgZ2Vu
ZXJhdGVzIHRyYWNlcnMgd2hpY2ggcHJvZHVjZSBDVEYgMS44IHRyYWNlcywgdGhlCnVsdGltYXRl
IGdvYWwgb2YgdGhlIHByb2plY3QgaXMgdG8gYWRvcHQgQ1RGIDIuIFRoaXMgaXMgd2h5IHRoZSBt
b2RlbAphbmQgdm9jYWJ1bGFyeSBvZiBpdHMgY29uZmlndXJhdGlvbiBmb3JtYXQgYXJlIHZlcnkg
Y2xvc2UgdG8gd2hhdCdzCnByb3Bvc2VkIGluIENURjItUFJPUC0yLjAgWzFdLgoKQ1RGIDIgaXMg
bm90IHJlbGVhc2VkIHlldCBhcyB3ZSBzdGlsbCBuZWVkIHRvIGltcGxlbWVudCBhbmQgZXhwZXJp
bWVudAp3aXRoIENURjItUFJPUC0yLjAgaW4gb3VyIG9wZW4tc291cmNlIHRvb2xzIChMVFRuZywg
QmFiZWx0cmFjZSwgYW5kCmJhcmVjdGYpIGJlZm9yZSBwdWJsaXNoaW5nIENURjItU1BFQy0yLjAu
CgpJbiBDVEYgMiwgd2UgZGVjaWRlZCB0byByZW1vdmUgdGhlIEVNRiBVUkkgY29uY2VwdCBbMl06
Cgo+IFRoZSBFTUYgVVJJIHByb3BlcnR5IGlzIHJlbW92ZWQgZnJvbSB0aGUgZXZlbnQgcmVjb3Jk
IGNsYXNzLgo+Cj4gVGhpcyBFY2xpcHNlIE1vZGVsaW5nIEZyYW1ld29yayBwcm9wZXJ0eSBpcyBu
b3QgY29tbW9uIGVub3VnaCBmb3IgdGhlCj4gQ29tbW9uIFRyYWNlIEZvcm1hdC4KPgo+IEEgcHJv
ZHVjZXIgY2FuIHN0aWxsIHdyaXRlIHN1Y2ggYW4gVVJJIGFzIGFuIGV2ZW50IHJlY29yZCBjbGFz
c+KAmXMgdXNlcgo+IGF0dHJpYnV0ZS4KCkluZGVlZCwgd2UgYmVsaWV2ZSB0aGlzIHByb3BlcnR5
IGluIENURiAxLjggaXMgdG9vIHNwZWNpZmljIHRvIHJlbWFpbiBhCnBhcnQgb2YgdGhlIGNvcmUg
c3BlY2lmaWNhdGlvbiBvZiBDVEYgMi4KCkFzIHRoZSBxdW90YXRpb24gYWJvdmUgaW5kaWNhdGVz
LCB0aGUgYWx0ZXJuYXRpdmUgd2lsbCBiZSB0byBzcGVjaWZ5IHRoZQpFTUYgVVJJIGFzIGEgY3Vz
dG9tIGV2ZW50IHJlY29yZCBjbGFzcyB1c2VyIGF0dHJpYnV0ZSBbM10sIHVuZGVyIGEKc3BlY2lm
aWMgbmFtZXNwYWNlLiBNeSBndWVzcyBpcyB0aGF0IGFub3RoZXIgc3BlY2lmaWNhdGlvbiBkb2N1
bWVudCB3aWxsCmVtZXJnZSBmcm9tIHNvbWUgb3JnYW5pemF0aW9uIHRvIHNob3cgdGhlIGV4YWN0
IG5hbWVzcGFjZSBhbmQgdXNlcgphdHRyaWJ1dGUgbmFtZS4gSW4gYmFyZWN0ZiAzLCBpdCBjb3Vs
ZCBsb29rIGxpa2UgdGhpcyAoZXZlbnQgcmVjb3JkIHR5cGUKb2JqZWN0KToKCiAgICBteS1ldmVu
dDoKICAgICAgdXNlci1hdHRyaWJ1dGVzOgogICAgICAgIGVjbGlwc2Uub3JnOgogICAgICAgICAg
ZW1mLXVyaToKcGxhdGZvcm06L3Jlc291cmNlL0RlbW9UcmFjZS9EZW1vVHJhY2UudW1sI19BVnJl
Sm05ZkVlcUplSThtYkxMUmNnCiAgICAgIHBheWxvYWQtZmllbGQtdHlwZToKICAgICAgICBjbGFz
czogc3RydWN0dXJlCiAgICAgICAgbWVtYmVyczoKICAgICAgICAgIC0gbXNnOiBzdHJpbmcKICAg
ICAgICAgIC0gaWQ6IHVpbnQzMgoKVW5mb3J0dW5hdGVseSwgd2UncmUgY3VycmVudGx5IGluIGEg
c3RhZ2Ugb2YgdHJhbnNpdGlvbiBmcm9tIENURiAxLjggdG8KQ1RGIDIuIFdlIGNhbid0IGFkZCB0
aGUgdXNlciBhdHRyaWJ1dGUgZmVhdHVyZSB1bnRpbCBDVEYyLVNQRUMtMi4wIGlzCnJhdGlmaWVk
LgoKVGhhdCBiZWluZyBzYWlkLCBJIGNhbiBhY2NlcHQgdGhhdCBiYXJlY3RmIDMgaGFzIHRoZSBF
TUYgVVJJIGZlYXR1cmUsCmJ1dCBvbmx5IHdoZW4gaXQgZ2VuZXJhdGVzIENURiAxLjgtcHJvZHVj
aW5nIHRyYWNlcnMuIEkgZG9uJ3QgaGF2ZSB0aW1lCnRvIGltcGxlbWVudCB0aGlzIGN1cnJlbnRs
eSwgYnV0IEkgd2lsbCBhY2NlcHQgYSBwYXRjaC4gVGVsbCBtZSBpZiB5b3UKd2FudCB0byBkbyB0
aGlzOyBJJ2xsIGdpdmUgeW91IG1vcmUgZGV0YWlscy4KCkJSLAoKUGhpbAoKWzFdOiBodHRwczov
L2RpYW1vbi5vcmcvY3RmL2ZpbGVzL0NURjItUFJPUC0yLjByQS5odG1sClsyXTogaHR0cHM6Ly9k
aWFtb24ub3JnL2N0Zi9maWxlcy9DVEYyLVBST1AtMi4wckEuaHRtbCNfY2hhbmdlc19zaW5jZV9j
dGYxClszXTogaHR0cHM6Ly9kaWFtb24ub3JnL2N0Zi9maWxlcy9DVEYyLVBST1AtMi4wckEuaHRt
bCN1c2VyLWF0dHJzCgo+IEJlc3QgcmVnYXJkcwo+Cj4gQW5zZ2FyCj4KPgo+IC4uLgo+IGV2ZW50
IHsKPiAgICAgc3RyZWFtX2lkID0gMDsKPiAgICAgaWQgPSAxOwo+ICAgICBuYW1lID0gInN0YXRl
X0MxX0ZpcnN0U3RhdGVfc3RhdGUiOwo+ICAgICBtb2RlbC5lbWYudXJpID0gInBsYXRmb3JtOi9y
ZXNvdXJjZS9EZW1vVHJhY2UvRGVtb1RyYWNlLnVtbCNfQVZyZUptOWZFZXFKZUk4bWJMTFJjZyI7
Cj4gICAgIGZpZWxkcyA6PSBzdHJ1Y3Qgewo+ICAgICAgICAgc3RyaW5nIHsKPiAgICAgICAgICAg
ICBlbmNvZGluZyA9IFVURjg7Cj4gICAgICAgICB9IGluc3RhbmNlSWQ7Cj4gICAgIH0gYWxpZ24o
MSk7Cj4gfTsKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4g
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
