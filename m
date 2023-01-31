Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4401C38142
	for <lttng-dev@archiver.kernel.org>; Tue, 31 Jan 2023 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1675180176;
	bh=AGai+1gLpE0iXqRxURibv7Bq4uZYAz4yZSrKuqgt2S0=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=U27kaugBzLSUzt4alPMzGvhcPIJk7lgpkOm/r5E1xu1+IMWuEg0JsbC2hywxa4ISc
	 JQtNOImJfZdRl9KIAjB9zrS/ND2ZZkoQxgv29yu+4ugwnYKi59I6iUFA/ykZw65mdX
	 JcvrbNM1d2CDZMym/5m5MMpKxNe9XglRiVrAJ3Al+DO+rgllWISQHVuYAL2W+QqCrL
	 zD1G+yDCF0WbKPS69ijw3fSTCNpW9+Q+n22Bfc/PKnYQSgtvbTuiAPQM1Bw9ripxhk
	 s6nkm+KEdVMhwcNwk9jhyWAHeul7w04IET2HHq7ezwdfPS+jO9L9JLF/LdaX6ziiUl
	 M4bZP9ukHF3jg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4P5qHM6ZdPz1X7W;
	Tue, 31 Jan 2023 10:49:35 -0500 (EST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by lists.lttng.org (Postfix) with ESMTPS id 4P5f8j436bz1X9q
 for <lttng-dev@lists.lttng.org>; Tue, 31 Jan 2023 03:58:13 -0500 (EST)
Received: by mail-ej1-f53.google.com with SMTP id m2so39055057ejb.8
 for <lttng-dev@lists.lttng.org>; Tue, 31 Jan 2023 00:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aLsxow0OjyA9fa0aG9FtFv0xEau0cX9pGbD//86KnvM=;
 b=EHHBYT4RbSN6jFBNnhU1cs3ki6ZSJPGRbU8RDHJJ6gAanPsg0Maq6Me/PNum18pssB
 ty3gPg79zYK8tLk1fKGtWLpB9j21sejdcbj4D6mYQ86ovpeQkISlacdbfYDKMf8p6lUZ
 +nJuk6pdMSmAhIKNhnD+jDxpQR13q8KWIOij5tE2n3vF4GxDo5IGIs7/OGLTfuvNb8c2
 xY8zp4ZLUEqzE7LjG+H7d++/6in2F0hUi7HUc3U5m1W7fsy6RF/V2y8RdVodWYuQ6btR
 YG4YIvL6S7s4CeGKEC54Zu8+VLedqwooXIqcCowAtDBmIkuvLBOqvxJXpXvwM6SdDeM7
 bxtA==
X-Gm-Message-State: AO0yUKU/rZhdqozSKHAs5+7W954iqt9bx2vIi6fn8BjWDnGxBGawX/wF
 G+ro+MG3H2hD2aE1Ym0V4P6y3GUlDGoeejxpK2+E4aeMFQ52ArP3
X-Google-Smtp-Source: AK7set8bbnZ0eEEKlv81szHSWdy0/ZpUuc7DDSmzhLAuhC5K17kIGlJh2CFmUyInXO2G/in+smTnomZqdcyxt/JtElI=
X-Received: by 2002:a17:906:1653:b0:877:ec3a:ead0 with SMTP id
 n19-20020a170906165300b00877ec3aead0mr6091534ejd.74.1675155432136; Tue, 31
 Jan 2023 00:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20221027055428.406908-1-alistair.francis@opensource.wdc.com>
 <CAKmqyKO2Kv72-c98_nC-Aprf8gFUJYrW1=kUkhf7B=cHMwmdtQ@mail.gmail.com>
 <YT2PR01MB598408FB1F15EAE0FDF96E3FBCE09@YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YT2PR01MB598408FB1F15EAE0FDF96E3FBCE09@YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM>
Date: Tue, 31 Jan 2023 18:56:44 +1000
Message-ID: <CAKmqyKOEfX0tDXSuZGzd5v4HK7yoaJ5ggYUQXCei4dWANOkUOQ@mail.gmail.com>
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jgalar@efficios.com>
Cc: Alistair Francis <alistair.francis@opensource.wdc.com>, 
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
X-Mailman-Approved-At: Tue, 31 Jan 2023 10:49:35 -0500
Subject: Re: [lttng-dev] [PATCH v2] Tests: select_poll_epoll: Add support
 for _time64
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
From: Alistair Francis via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gVGh1LCBEZWMgMTUsIDIwMjIgYXQgNjoyMCBBTSBKw6lyw6ltaWUgR2FsYXJuZWF1IDxqZ2Fs
YXJAZWZmaWNpb3MuY29tPiB3cm90ZToKPgo+IEhpIEFsaXN0YWlyLAo+Cj4gVGhlIHBhdGNoIHlv
dSBzdWJtaXR0ZWQgZG9lc24ndCBwYXNzIG9uIHg4NiBhbmQgeDg2LTY0LgoKQXJlIHlvdSBhYmxl
IHRvIHByb3ZpZGUgdGhlIGZhaWx1cmVzPyBJdCBzaG91bGQganVzdCBiZSBhIHNpbXBsZSBmaXgK
Cj4KPiBJIGhhdmUgd3JpdHRlbiBhbiBhbHRlcm5hdGl2ZSBwYXRjaCB0aGF0IHdvcmtzIG9uIHRo
ZSAzMi82NCB2YXJpYW50cyBvZiBBUk0gYW5kIHg4Ni4gSSBjb3VsZCBvbmx5IHZlcmlmeSB0aGF0
IGl0IGJ1aWxkcyBvbiBSSVNDLVYgNjQuCj4KPiBBcmUgeW91IGFibGUgdG8gY29tcGlsZS10ZXN0
IGl0IG9uIFJJU0MtViAzMj8KPgo+IGh0dHBzOi8vcmV2aWV3Lmx0dG5nLm9yZy9jL2x0dG5nLXRv
b2xzLysvODkwNwoKVGhhbmtzIQoKSSBhbSBjdXJyZW50bHkgaGF2aW5nIHNvbWUgdHJvdWJsZSBi
dWlsZGluZyBpdC4gVGhlIHJlcXVpcmVtZW50IG9uCmxpYnVyY3UgPj0gMC4xNCBpcyBwcm92aW5n
IGRpZmZpY3VsdCB0byBtZWV0IGFuZCB0aGUgcGF0Y2ggY29uZmxpY3RzCndpdGggZWFybGllciB2
ZXJzaW9ucyBvZiBsdHRuZy4KCkkgaGFkIGEgbG9vayBhdCB0aGUgcGF0Y2ggdGhvdWdoLgoKSXQg
c2VlbXMgbGlrZSB5b3Ugc3RpbGwgY2FsbCBTWVNfcHBvbGwsIHdoaWNoIHdvbid0IHdvcmsgb24g
NjQtYml0CnRpbWVfdCAzMi1iaXQgc3lzdGVtcy4KCkNoYW5nZXMgbGlrZSB0aGlzOgoKKyAgICAg
ICAjaWZkZWYgc3lzX3BzZWxlY3Q2X3RpbWU2NAorICAgICAgIHRlc3RfcHNlbGVjdF90aW1lNjQo
KTsKKyAgICAgICAjZWxzZQogICAgICAgdGVzdF9wc2VsZWN0KCk7CisgICAgICAgI2VuZGlmIC8q
IHN5c19wc2VsZWN0Nl90aW1lNjQgKi8KCndpbGwgbWVhbiB0aGF0IHRlc3RfcHNlbGVjdCgpIGlz
bid0IGNhbGxlZCBvbiAzMi1iaXQgcGxhdGZvcm1zIHdpdGggYQo1LjQrIGtlcm5lbC4gV2hpY2gg
SSB0aG91Z2h0IGlzIHdoYXQgeW91IHdhbnRlZCB0byBhdm9pZC4KCkFsaXN0YWlyCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
