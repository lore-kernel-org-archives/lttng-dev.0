Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A683FC77B7D
	for <lttng-dev@archiver.kernel.org>; Thu, 18 May 2023 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684415953;
	bh=sYRCRtdHJI/cSshPEMWXOfyBxC+pYzARnt5dK1tm0hQ=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=jR5EECIAdO1qiZ425GKVFvynlf9FL0rXG0hnvukty63woAL4L4wUNYbIP/k5m53H1
	 wyCUD2Rg2qUf9OXsudCXDYuupSr9luKGVQBe8sgnOyicMOCuMXs4cgKNg0HlEdPlzj
	 EHFgy/EAPexvjXlkDj+vswuoIBaY3hep2bFOz0TeWwueYxKh8FafYw9OKulfCeRB01
	 TYYLaKsaOY5YHwzcH/dEDm6FkOz3iAUvRCcx5juzLkrUhSkMA7bgwE6yFQvt4611C3
	 gpnx6736fOMYHhtxItvPkmJCn5KjaBNZfEFxLjnJNHYavdhlcmpLIyEl1K8+Tv+iT/
	 /0fimGEs2Pzkw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QMVtS5q8gz1G88;
	Thu, 18 May 2023 09:19:12 -0400 (EDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by lists.lttng.org (Postfix) with ESMTPS id 4QMVtR3FNcz1G0v
 for <lttng-dev@lists.lttng.org>; Thu, 18 May 2023 09:19:11 -0400 (EDT)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-510d9218506so2359732a12.1
 for <lttng-dev@lists.lttng.org>; Thu, 18 May 2023 06:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684415890; x=1687007890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sx9ltTKwyp5yP5P9AJB/XvacMIJmat3qYmVsfE1cf8Y=;
 b=WXsxex7QaOVJ0B2cJO1nqiC1HwkRL2qU/YsbAs0bB0rRo7ILD3DfTRc6LLoDinFax5
 1HZt9uxwP7XIKvTVE29gr9awXiJmASVPnJD6igsyubyMNlRbKlr+PCnjKwjaQ+331xCa
 1Wp5cFJLrkY1S6mbaWIWzGjkzgyUkzXq2mBVxHVhLJksdxsIL92RR+3QsIFf3yOSRk5l
 5nUiVfSWtIRvOVtGM7k7i+L08RKfQNCD4cY4IMxakdpXT6lg4816ir96NpOXG3t2XRKu
 Vzrq12weI4+7wIkMnxHUGw0fRnEcOiH4HKbNU4ezzAmosUByD/T5oUnhWVi7+fTed4LN
 YSww==
X-Gm-Message-State: AC+VfDy4mLCC9EXTkwAdG/zLZuZ/j/eb+MeCWYKpRdE1NjRnWe31fGqz
 YUQMo/9VMTKCf0FbtEWcUPCD7vLVwq6VtiBqCvM=
X-Google-Smtp-Source: ACHHUZ6hKnjCejWzG7LJQ1/tfd7Lpo1VoXawZ2DAQz9jIu8ywiQKDOhoK0pUMJAXkMoFUGh/EooISaK+cMMc+fHhKgM=
X-Received: by 2002:aa7:d7cf:0:b0:4ad:738b:6706 with SMTP id
 e15-20020aa7d7cf000000b004ad738b6706mr5742548eds.2.1684415889778; Thu, 18 May
 2023 06:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAFZh4h8C5ZVHGWsBW2iaVYi56t=SsmuiSGZPLf0KpQO9LwfeMQ@mail.gmail.com>
 <2d953bd2-6544-3357-1424-fa44731e2bf5@efficios.com>
In-Reply-To: <2d953bd2-6544-3357-1424-fa44731e2bf5@efficios.com>
Date: Thu, 18 May 2023 09:17:58 -0400
Message-ID: <CAFZh4h95d=U6wj6RxR-z3kDMwJD58cC+DLC5O6UNSsKcschr3w@mail.gmail.com>
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
LWRpc2FibGluZy1ldmVudHMKCkkgYWRkZWQgYSBmdW5jdGlvbiB0aGF0J3MgY2FsbGVkIHdoZW4g
dGhlIGV2ZW50IEkgd2FudCB0byBwcm9iZSBvY2N1cnMuCgpJIHRyaWVkIHRvIGVuYWJsZSB0aGUg
ZXZlbnQgd2l0aDoKcm9vdEBsb2NhbGhvc3Q6L3Vzci9sb2NhbC9iaW4jIGx0dG5nIGVuYWJsZS1l
dmVudCAtLWtlcm5lbAotLXVzZXJzcGFjZS1wcm9iZT0vdXNyL2xvY2FsL2Jpbi9teV9hcHA6bXlf
cHJvYmVfZXZlbnQKRXJyb3I6IE1pc3NpbmcgZXZlbnQgbmFtZShzKS4KCi4uLiBhbmQ6Cgpyb290
QGxvY2FsaG9zdDovdXNyL2xvY2FsL2JpbiMgbHR0bmcgZW5hYmxlLWV2ZW50IC0ta2VybmVsCi0t
dXNlcnNwYWNlLXByb2JlPWVsZjovdXNyL2xvY2FsL2Jpbi9teV9hcHA6bXlfcHJvYmVfZXZlbnQK
RXJyb3I6IE1pc3NpbmcgZXZlbnQgbmFtZShzKS4KCkkgY2FuIGRvICR7Q1JPU1NfQ09NUElMRX1v
YmpkdW1wIC1kIGFuZCB2ZXJpZnkgdGhhdCB0aGUgc3ltYm9sIGFib3ZlCmZvciB0aGUgZnVuY3Rp
b24gSSBhZGRlZCBpcyBpbmRlZWQgdGhlcmUuCgpXaGF0IGFtIEkgZG9pbmcgd3Jvbmc/Cgo+Cj4g
SW5kZWVkIGluc2VydGluZyBhIGx0dG5nLW1vZHVsZXMgdXByb2JlIHdpdGhpbiBmdW5jdGlvbnMg
aXMgbm90Cj4gc3VwcG9ydGVkIGF0IHRoZSBtb21lbnQsIG1haW5seSBiZWNhdXNlIHdlIHByZWZl
ciB0byBlcnIgdG93YXJkcyBzYWZldHkKPiBhbmQgZG9uJ3QgaGF2ZSB0aGUgdmFsaWRhdGlvbiBp
biBwbGFjZSB0byBwcmV2ZW50IGNvcnJ1cHRpbmcgdGhlCj4gcHJvZ3JhbSdzIGluc3RydWN0aW9u
cyBpZiBhbiBlbmQgdXNlciB3b3VsZCB0cnkgdG8gaW5zZXJ0IGEgdXByb2JlIGF0IGFuCj4gYWRk
cmVzcyB3aGljaCBpcyBub3QgYW4gaW5zdHJ1Y3Rpb24gYm91bmRhcnkuCj4KPiBTbyB3ZSBvbmx5
IHN1cHBvcnQgaW5zZXJ0aW5nIHVwcm9iZSBvbiBmdW5jdGlvbnMgYW5kIFNEVCBwcm9iZXMgYXQK
PiB0aGUgbW9tZW50Lgo+Cj4gVGhhbmtzLAo+Cj4gTWF0aGlldQo+Cj4KPiA+IFRoYW5rcywKPiA+
Cj4gPiBCcmlhbgo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPiA+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiA+IGx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKPiA+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYKPgo+IC0tCj4gTWF0aGlldSBEZXNub3llcnMKPiBFZmZpY2lPUyBJbmMuCj4g
aHR0cHM6Ly93d3cuZWZmaWNpb3MuY29tCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
