Return-Path: <SRS0=0zlt=6M=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B062C83000
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Apr 2020 18:40:30 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96EFC2076A
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Apr 2020 18:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="qWbJa39a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EFC2076A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49BVnl752Dz1mwg;
	Tue, 28 Apr 2020 14:40:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1588099228;
	bh=MmJNHs+xI0dhv7sWSDZ9ptxXBnwwCwTa5MwIMoteYIc=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=qWbJa39aVtNqMJoi9Nx9Ro3+1HIgtVe3ebKK8g//GnqG0IFZYG8AmT/uZ7gcd+FOx
	 3G3rUUktSBcuRPjO6Cr9fk+CUw699Ks43rWXT2xb5MEoa5Ee7EVO4ghhO/kxS+xDvE
	 LZl28E3743P5kQmxXV09Whxe7HnQqD7QdqHfkIhQpNivmV+pKN0WBC+mtz7O7j4j0+
	 cSFvkliS5/q/K9LTRsdtLCWY4c7bg1kg7AW4NbyhvmSLenPuPkdjgH+we9uGy6Dn9G
	 02ADR/8RtZn2eWa31HJ7N4O+JWPJ/TCkwZ9NqYap1tTu0/+2L8HwW9YVVyMfEGR7rl
	 hmHYR7jzFaUlg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49BVnk6xfnz1mp6
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2020 14:40:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0118127F0CD;
 Tue, 28 Apr 2020 14:40:19 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id D6cRUdOwpOek; Tue, 28 Apr 2020 14:40:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id AF68D27F0CC;
 Tue, 28 Apr 2020 14:40:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AF68D27F0CC
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id tKaKwbzkgqDS; Tue, 28 Apr 2020 14:40:18 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id A184E27F0CA;
 Tue, 28 Apr 2020 14:40:18 -0400 (EDT)
Date: Tue, 28 Apr 2020 14:40:18 -0400 (EDT)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Message-ID: <1031751564.72894.1588099218629.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200423205226.496-2-mathieu.desnoyers@efficios.com>
References: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
 <20200423205226.496-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - GC79 (Linux)/8.8.15_GA_3895)
Thread-Topic: Clarify that unlisted enum values are implementation-defined
Thread-Index: 5rnZzbaQIIrW8uKoGz/PvuDKOpUtDQ==
Subject: Re: [lttng-dev] [RFC PATCH CTF 1/3] Clarify that unlisted enum
 values are implementation-defined
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.29
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
Reply-To: Philippe Proulx <pproulx@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>,
 Jeremie Galarneau <jgalar@efficios.com>,
 gbastien+lttng <gbastien+lttng@versatic.net>,
 diamon-discuss@linuxfoundation.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200428184018.tHOKo3SzA2vJarxqFmXlVFdForsJcSMxqCb4N7gZrtQ@z>

LS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+IEZyb206ICJNYXRoaWV1IERlc25veWVycyIg
PG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiBUbzogImdiYXN0aWVuK2x0dG5nIiA8
Z2Jhc3RpZW4rbHR0bmdAdmVyc2F0aWMubmV0PiwgIk1hdHRoZXcgS2hvdXphbSIgPG1hdHRoZXcu
a2hvdXphbUBlcmljc3Nvbi5jb20+LAo+IGRpYW1vbi1kaXNjdXNzQGxpbnV4Zm91bmRhdGlvbi5v
cmcsIHBwcm91bHhAZWZmaWNpb3MuY29tLCAiSmVyZW1pZSBHYWxhcm5lYXUiIDxqZ2FsYXJAZWZm
aWNpb3MuY29tPgo+IENjOiAibHR0bmctZGV2IiA8bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZz4s
ICJNYXRoaWV1IERlc25veWVycyIgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiBT
ZW50OiBUaHVyc2RheSwgMjMgQXByaWwsIDIwMjAgMTY6NTI6MjQKPiBTdWJqZWN0OiBbUkZDIFBB
VENIIENURiAxLzNdIENsYXJpZnkgdGhhdCB1bmxpc3RlZCBlbnVtIHZhbHVlcyBhcmUgaW1wbGVt
ZW50YXRpb24tZGVmaW5lZAoKPiBGcm9tOiBHZW5ldmnDqHZlIEJhc3RpZW4gPGdiYXN0aWVuK2x0
dG5nQHZlcnNhdGljLm5ldD4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBHZW5ldmnDqHZlIEJhc3RpZW4g
PGdiYXN0aWVuK2x0dG5nQHZlcnNhdGljLm5ldD4KPiBTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERl
c25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+IGNvbW1vbi10
cmFjZS1mb3JtYXQtc3BlY2lmaWNhdGlvbi5tZCB8IDMgKysrCj4gMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9jb21tb24tdHJhY2UtZm9ybWF0LXNwZWNp
ZmljYXRpb24ubWQKPiBiL2NvbW1vbi10cmFjZS1mb3JtYXQtc3BlY2lmaWNhdGlvbi5tZAo+IGlu
ZGV4IGZkNDllNTkuLmY1ZmVhNTEgMTAwNjQ0Cj4gLS0tIGEvY29tbW9uLXRyYWNlLWZvcm1hdC1z
cGVjaWZpY2F0aW9uLm1kCj4gKysrIGIvY29tbW9uLXRyYWNlLWZvcm1hdC1zcGVjaWZpY2F0aW9u
Lm1kCj4gQEAgLTQ2NCw2ICs0NjQsOSBAQCBlbnVtIHsKPiB9Cj4gfn5+Cj4gCj4gK1RoZSBtYXBw
aW5ncyBpbiB0aGUgZW51bWVyYXRpb24gdHlwZSBkbyBub3QgaGF2ZSB0byBiZSBleGhhdXN0aXZl
Lgo+ICtVbmxpc3RlZCB2YWx1ZXMgYXJlIGltcGxlbWVudGF0aW9uIGRlZmluZWQuCj4gKwoKV2h5
IG5vdCBqdXN0OgoKICAgIEFuIGVudW1lcmF0aW9uIGZpZWxkIGNhbiBoYXZlIGFuIGludGVncmFs
IHZhbHVlIHdoaWNoIGl0cyB0eXBlIGRvZXMgbm90CiAgICBtYXAgdG8gYSBzdHJpbmcuCgo/CgpQ
aGlsCgo+ICMjIyA0LjIgQ29tcG91bmQgdHlwZXMKPiAKPiBDb21wb3VuZCBhcmUgYWdncmVnYXRp
b24gb2YgdHlwZSBkZWNsYXJhdGlvbnMuIENvbXBvdW5kIHR5cGVzIGluY2x1ZGUKPiAtLQo+IDIu
MTEuMApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0
cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
