Return-Path: <SRS0=0ltL=GJ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D471C433E6
	for <lttng-dev@archiver.kernel.org>; Wed,  6 Jan 2021 17:02:06 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5179923120
	for <lttng-dev@archiver.kernel.org>; Wed,  6 Jan 2021 17:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5179923120
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4D9wdR360xzNYP;
	Wed,  6 Jan 2021 12:02:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1609952524;
	bh=BFV+2dpXIgtIlC5W/uOlpuYsrcrTFeOc5zxDPYytasg=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Cukj6TgmC6ooRBKq4GQM7t4RzSserseZA+q37clXIioPuq2bCYQEYovzw7RaYhXXr
	 IeLRMK9xSby+Bg6TpblWkEqqZ27Yvgz69Fq9xDUw4+wCWrHbly2oZW6NuCaXSRscND
	 JYwcf4XoWzxMmRhSIU6H/hhjetSFh/mIxPK32NUP8zgo4NG2ZFk5f4hmlKjva+gq83
	 e1jMzcCuXM3+/qiVk16ylw43+Jx/J8drkddYRLY3bomYUp8Wu0tTCEZGWUyoIqQH3b
	 SIf//fLoRsCEbwVwtaQeJOj+2fI98IzKz6nN11bZ5WnhLwefXZ0Oj7QXiiqJHvY9I4
	 m0SWNUBagxqQA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4D9wdQ0WzhzNWh
 for <lttng-dev@lists.lttng.org>; Wed,  6 Jan 2021 12:02:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A7F27307D93
 for <lttng-dev@lists.lttng.org>; Wed,  6 Jan 2021 12:02:01 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id z5Tgpnm5ErX0; Wed,  6 Jan 2021 12:02:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 690B0307D92;
 Wed,  6 Jan 2021 12:02:01 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 690B0307D92
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id K8NXn5CNVAP1; Wed,  6 Jan 2021 12:02:01 -0500 (EST)
Received: from [10.10.0.241] (96-127-212-112.qc.cable.ebox.net
 [96.127.212.112])
 by mail.efficios.com (Postfix) with ESMTPSA id 3EC70307D91;
 Wed,  6 Jan 2021 12:02:01 -0500 (EST)
To: Mohammad Kavousi <kavousi@u.northwestern.edu>, lttng-dev@lists.lttng.org
Cc: Yan Chen <ychen@northwestern.edu>,
 Xutong Chen <XutongChen2021@u.northwestern.edu>
References: <CAK7B4KePHyJFCwAczqcqz+05Ts8AVm0Xh9f4hwSBKaVhQLz8cw@mail.gmail.com>
Message-ID: <977d5fa1-ff33-f99e-5be9-7c53ff6adfc4@efficios.com>
Date: Wed, 6 Jan 2021 12:02:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK7B4KePHyJFCwAczqcqz+05Ts8AVm0Xh9f4hwSBKaVhQLz8cw@mail.gmail.com>
Content-Language: en-US
Subject: Re: [lttng-dev] LTTng Support for Mount Namespace
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gMjAyMS0wMS0wNiAxMCBoIDUwLCBNb2hhbW1hZCBLYXZvdXNpIHZpYSBsdHRuZy1kZXYgd3Jv
dGU6Cj4gRGVhciBMVFRuZyBkZXZlbG9wZXJzLAo+IAo+IE91ciBncm91cCBhdCBOb3J0aHdlc3Rl
cm4gaGFzIGJlZW4gdXNpbmcgeW91ciBhbWF6aW5nIHRvb2wgZm9yIHRoZSAKPiBwdXJwb3NlIG9m
IHByb3ZlbmFuY2UgdHJhY2tpbmcgb24gTGludXgtYmFzZWQgc3lzdGVtcyBhbmQgd2UgYXJlIHZl
cnkgCj4gZm9uZCBvZiB0aGUgcGVyZm9ybWFuY2UgYW5kIGFjY3VyYWN5IGl0IHByb3ZpZGVzLgo+
IAo+IE91ciBhbmFseXNpcyBzaG93cyB0aGF0IG1udF9ucyBjb250ZXh0IGlzIHN1cHBvcnRlZCBp
biB0aGUgMi4xMiB2ZXJzaW9uIAo+IG9mIExUVG5nLiBIb3dldmVyLCB0aG91Z2gsIGFkZGluZyB0
aGUgbW50X25zIGNvbnRleHQgdXNpbmcgCj4gdGhlwqBhZGQtY29udGV4dCBjb21tYW5kIHByb2R1
Y2VzIHRoaXMgZXJyb3I6Cj4gCj4gRXJyb3I6IG1udF9uczogQ29udGV4dCB1bmF2YWlsYWJsZSBv
biB0aGlzIGtlcm5lbAo+IAo+IFdlIGhhdmUgdHJpZWQgYWRkaW5nIHRoZSBjb250ZXh0IHRvIHRo
ZSBtb3JlIHJlY2VudCB2ZXJzaW9uIG9mIHRoZSAKPiBrZXJuZWwgKDUuOCkgb24gVWJ1bnR1IDIw
LjA0LCBhcyB3ZWxsIGFzIG9sZGVyIGtlcm5lbCB2ZXJzaW9ucyBzdWNoIGFzIAo+IHRoZSA0LjQg
dmVyc2lvbiBvbiBVYnVudHUgMTYuMDQuIEhvd2V2ZXIsIHdlIGFsd2F5cyByZWNlaXZlIHRoZSBh
Ym92ZSAKPiBlcnJvciB0cnlpbmcgdG8gYWRkIHRoZSBtbnRfbnMgY29udGV4dC4KPiAKPiBXZSBj
b3VsZCBub3QgZmluZCB3aGljaCBrZXJuZWwgdmVyc2lvbnMgYXJlIHN1cHBvcnRlZCBmb3IgYWRk
aW5nIHRoaXMgCj4gY29udGV4dCwgb3Igd2hldGhlciB0aGV5IG5lZWQgdG8gYmUgYnVpbHQgd2l0
aCBzcGVjaWFsIGZsYWdzLiBJIHdvdWxkIAo+IGFwcHJlY2lhdGUgeW91ciBndWlkYW5jZSBvbiBy
ZXNvbHZpbmcgdGhpcyBpc3N1ZS4KPiAKPiAKPiBUaGFuayB5b3UsCj4gTW9oYW1tYWQKCkhpLAoK
VW5mb3J0dW5hdGVseSB0aGUgZGVmaW5pdGlvbiBvZiAnc3RydWN0IG1udF9uYW1lc3BhY2UnIGlz
IGluIGEgcHJpdmF0ZSAKa2VybmVsIGhlYWRlciAoZnMvbW91bnQuaCkgdW5saWtlIG90aGVyIG5h
bWVzcGFjZXMuICBQcml2YXRlIGhlYWRlcnMgYXJlIApub3QgaW5jbHVkZWQgaW4gdGhlIGtlcm5l
bCBoZWFkZXJzIHBhY2thZ2Ugb2YgZGlzdHJpYnV0aW9ucyBsaWtlIFVidW50dSwgCnRvIGJ1aWxk
IHN1cHBvcnQgZm9yIHRoaXMgbmFtZXNwYWNlIGNvbnRleHQgaW4gbHR0bmctbW9kdWxlcyB5b3Ug
bmVlZCB0byAKdXNlIHRoZSBmdWxsIGtlcm5lbCBzb3VyY2UgdHJlZS4KCk9yIGFzIGEgcXVpY2sg
aGFjaywgeW91IGNvdWxkIGNvcHkgJ2ZzL21vdW50LmgnIGZyb20gdGhlIG9yaWdpbmFsIHNvdXJj
ZSAKdHJlZSB0byB5b3VyIGtlcm5lbCBoZWFkZXJzIHBhY2thZ2UgYnVpbGQgZGlyZWN0b3J5LCB3
aGljaCBvbiBVYnVudHUgaXMgCnVzdWFsbHkgJy9saWIvbW9kdWxlcy8kKHVuYW1lIC1yKS9idWls
ZCcuCgpIb2UgdGhpcyBoZWxwcywKCk1pY2hhZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
