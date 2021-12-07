Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6374FC433FE
	for <lttng-dev@archiver.kernel.org>; Tue,  7 Dec 2021 17:25:05 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4J7nHM14F2z1rQD;
	Tue,  7 Dec 2021 12:25:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1638897904;
	bh=FbnumnmJ256uyP0Mrk9MFJ0Bbu1HRjcZqyGIJWUHnYM=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=sp9Empwh4Uk3oOigJdIsWBsiX6TCfzrmzKD2/Wjuq7lKzcCj2kjvPNjleUHxv7ro5
	 3lQhcgJf+fKqFW/jifmskmQJj5NRWYYgVr/FWu3c0KuHJJUG0jPayV5T01XMNPkyhZ
	 ZjITT0XLpfN/j0C3ah/F0Afi6VCrkYZQ6LAD2JJhporg4jrdyAtmt5Utm9VxAEpe88
	 V1CtwG1vJv1SutN+MsaBKQEZgUSfDGq53AAtGiM93xCRuYJLXdqlEjnnjE41/a8RMm
	 EzJ1ctMrxTrXwrp9H8U7qEGL9li2hwxJv/Lh9o4JCuIrlAoU8Sd+kR6NljUR/WQnPH
	 6GuT4b9SYrVcA==
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by lists.lttng.org (Postfix) with ESMTPS id 4J7nHL1kQ6z1rYQ
 for <lttng-dev@lists.lttng.org>; Tue,  7 Dec 2021 12:25:02 -0500 (EST)
Received: by mail-lf1-x12d.google.com with SMTP id u3so35266505lfl.2
 for <lttng-dev@lists.lttng.org>; Tue, 07 Dec 2021 09:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vlylQyBl+cj3EWDTNL5Yz7Z3ymlinurLzVBOxL+Q/mM=;
 b=D6MDZnxdqgSb7plJWBeT+YxZ/ROzsudrMEiaT5mLvqrjnaVuhwrseG7zk6elMyYEM+
 cnUEznLTLGsjFblfy24pyk7cgBRRsof2Gt2DYpZIFY7UldwcgiWqSwIJUXnyKH8LTlxw
 opP4BMcQPzqFfjjpPpMXUsvY3YGhurvR/lvW9VgxBc3GJ8aCtDftSgRvSLhWo3NzybrW
 7Oy6ytxFqm5v0lrf8ohR83BIYusJeieY1H/0svTY9WTHpeXR1ArsDpkCdUp/xyOdX18t
 +leX0RtvpqSz7WzjMWh3bYM25NJKS1WEdrNnOp7Lr8T5BqxGUCkjnTfg6l09/xmT+Vmw
 fw3w==
X-Gm-Message-State: AOAM533GNSgINEhkQx9ZzQNLlvUtkkvj9inmHN3Eac50QLq8z1oKqXTB
 jLEH+yx9fy2gDsZNvanreRaea1OlIxZk3WvqhUlh7AdXwdatng==
X-Google-Smtp-Source: ABdhPJx+6wLnQt+O5+Id8O7d5opc88ptYYq+sYzIuofcT3YNPeP9yWbsUr6Rf13T+/DzVtPeLZDw8GO+Tggx8xM7YwA=
X-Received: by 2002:a05:6512:32c9:: with SMTP id
 f9mr42641107lfg.575.1638897900544; 
 Tue, 07 Dec 2021 09:25:00 -0800 (PST)
MIME-Version: 1.0
References: <PR3PR08MB5579AFB7793FED4AA03989BAA5639@PR3PR08MB5579.eurprd08.prod.outlook.com>
In-Reply-To: <PR3PR08MB5579AFB7793FED4AA03989BAA5639@PR3PR08MB5579.eurprd08.prod.outlook.com>
Date: Tue, 7 Dec 2021 12:24:34 -0500
Message-ID: <CAB4xu_0KK5cLiUycoxgfx+He6WO_=2JV6oEx_CuG3EMr2f9dqw@mail.gmail.com>
To: =?UTF-8?B?WW9hbm4gRmFycsOp?= <yoann.farre@cil4sys.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] [barectf] How to debug a malformed trace event?
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
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

WW9hbm4sCgpTb3JyeSBmb3IgdGhlIHdhaXQuCgpJIGNyZWF0ZWQgYSBjb3JyZXNwb25kaW5nIGJh
cmVjdGYgcHJvamVjdCBpc3N1ZSBoZXJlOgo8aHR0cHM6Ly9naXRodWIuY29tL2VmZmljaW9zL2Jh
cmVjdGYvaXNzdWVzLzE5Pi4KCkNhbiB5b3UgYW5zd2VyIHRoZSBsYXRlc3QgcXVlc3Rpb24gdGhl
cmU/CgpUaGFuayB5b3UgZm9yIHJlcG9ydGluZyB0aGlzLgoKUGhpbGlwcGUgUHJvdWx4CgpQaGls
aXBwZSBQcm91bHgKCgpPbiBGcmksIE5vdiAyNiwgMjAyMSBhdCAxMjo0MSBQTSBZb2FubiBGYXJy
w6kgdmlhIGx0dG5nLWRldgo8bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZz4gd3JvdGU6Cj4KPiBI
ZWxsbywKPgo+Cj4KPiBJ4oCZbSBuZXcgaW4gdGhlIHdvcmxkIG9mIHRyYWNpbmcuIEFuZCBJIGhh
dmUgYSBxdWVzdGlvbiBhYm91dCBiYXJlY3RmIGFuZCBtYWxmb3JtZWQgdHJhY2UgZXZlbnQuCj4K
Pgo+Cj4gRm9yIHRoZSBjb250ZXh0LCBJIHVzZSB0aGUgdG9vbCBQYXB5cnVzIHRvIGJ1aWxkIFVN
TCBtb2RlbHMgYW5kIHRoZW4gZ2VuZXJhdGUgQysrIGNvZGUuIFRoZSBjb2RlIGNhbiBiZSBpbnN0
cnVtZW50ZWQgdG8gZ2VuZXJhdGUgQ1RGIHRyYWNlcyAod2l0aCBiYXJlY3RmKSBhbmQgZm9sbG93
IHNvbWUgcmVsZXZhbnQgbW9kZWwgZWxlbWVudHMuCj4KPgo+Cj4gTW9yZSBwcmVjaXNlbHksIEkg
Z2VuZXJhdGVkIGEgdHJhY2UgYW5kIHRyaWVkIHRvIHJlYWQgaXQgd2l0aCBUcmFjZUNvbXBhc3Mu
IFRoZSB0cmFjZXMgc2VlbXMgdG8gY29udGFpbnMgYSBtYWxmb3JtZWQgZXZlbnQuIFVuZm9ydHVu
YXRlbHkgaXQgYXZvaWRzIHRvIHJlYWQgdGhlIGZvbGxvdy11cCAoaWYgYW55KS4KPgo+Cj4KPgo+
Cj4gSSBhbHNvIHRyaWVkIHRvIHJlYWQgdGhlIHRyYWNlIHdpdGggYmFiZWx0cmFjZSB3aGljaCBj
bGVhcmx5IHNob3dzIHRoYXQgdGhlcmUgaXMgYSBtYWxmb3JtZWQgZXZlbnQgWzFdLgo+Cj4KPgo+
IENhbiBhbnlvbmUgZ2l2ZSBtZSBzb21lIGhlbHAgdG8gYXZvaWQgZ2VuZXJhdGUgbWFsZm9ybWVk
IGV2ZW50IC8gb3IgdG8gZW5hYmxlIHRvIHJlYWQgdGhlIGZvbGxvdy11cCBvZiB0aGUgdHJhY2Ug
Pwo+Cj4KPgo+IFRvIGJlIGNvbXBsZXRlLCBJIGpvaW4gdGhlIHJhdyB0cmFjZSBbMl0uIEkgY2Fu
IGFsc28gcHJvdmlkZSB0aGUgY29kZSB3aGljaCBwcm9kdWNlcyB0aGlzIHRyYWNlIGlmIGl0IGhh
cyBhbnkga2luZCBvZiBpbnRlcmVzdC4KPgo+Cj4KPiBbMV0gZXJyb3JfYmFiZWx0cmFjZS50eHQK
Pgo+IFsyXSBjdGZ0cmFjZTA0LnppcAo+Cj4KPgo+IFRoYW5rcyBmb3IgcmVhZGluZyBhbmQgeW91
ciBoZWxwLgo+Cj4gUmVnYXJkcy4KPgo+Cj4KPiBZb2FubiBGYXJyw6kuCj4KPgo+Cj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
