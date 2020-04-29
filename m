Return-Path: <SRS0=qetO=6N=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A10CC83003
	for <lttng-dev@archiver.kernel.org>; Wed, 29 Apr 2020 12:08:10 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9460E2087E
	for <lttng-dev@archiver.kernel.org>; Wed, 29 Apr 2020 12:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="jeo3SSJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9460E2087E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49By2b6DcRz1nQv;
	Wed, 29 Apr 2020 08:08:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1588162088;
	bh=pQ3EtGf9FIpl3j+pWztIf5CO5cu6XNDDenVBtghvb7o=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jeo3SSJFAA7+oxnIpH2ffd9M/pvC2enGzCff5BAwaeq8toaf8bsK8OHR/I6aVXVsk
	 bunliteFk70E5nWZddS8RtsxlmGhsmq7kPKMJ9Azd3eDtgC0/DroIjBavGN+9pBTBG
	 QaYB/gcsH3RFrUOoh7gT9/ZSl0aQsIrHHAOD5Yw6ajUpuOnANyylsVCxj+NQhX1DcU
	 C30ogmo2oGcZia6OT/DHl02bzGH8NWW4NcW79b8WoLf3KxHR6GWQDMlYRHtjTjDNZB
	 r6kfM0IENxI+pl9A8gvtD4ZoPDfhU6S5FTq+5OETD/AmS9WcDr6ClqQxBRRhuZwAYx
	 LBy3DT57lgRJQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49By2Y5PqXz1ntV
 for <lttng-dev@lists.lttng.org>; Wed, 29 Apr 2020 08:08:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0BD9F292F4A;
 Wed, 29 Apr 2020 08:08:05 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id kfDuQyQoD6uv; Wed, 29 Apr 2020 08:08:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A51D2292F49;
 Wed, 29 Apr 2020 08:08:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A51D2292F49
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id d9a9UQOJhKpV; Wed, 29 Apr 2020 08:08:04 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 9484D292BEF;
 Wed, 29 Apr 2020 08:08:04 -0400 (EDT)
Date: Wed, 29 Apr 2020 08:08:04 -0400 (EDT)
To: Philippe Proulx <pproulx@efficios.com>
Message-ID: <104691146.75724.1588162084473.JavaMail.zimbra@efficios.com>
In-Reply-To: <1859708486.72922.1588099890391.JavaMail.zimbra@efficios.com>
References: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
 <20200423205226.496-2-mathieu.desnoyers@efficios.com>
 <1031751564.72894.1588099218629.JavaMail.zimbra@efficios.com>
 <1859708486.72922.1588099890391.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: Clarify that unlisted enum values are implementation-defined
Thread-Index: 5rnZzbaQIIrW8uKoGz/PvuDKOpUtDZMKMmtGL8qxFNk=
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>,
 Genevieve Bastien <gbastien+lttng@versatic.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200429120804.0dTRM3OSPJkrujD6YwAfm3iPpph46mxPdT8VvBZHmLE@z>

LS0tLS0gT24gQXByIDI4LCAyMDIwLCBhdCAyOjUxIFBNLCBNYXRoaWV1IERlc25veWVycyBtYXRo
aWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20gd3JvdGU6Cgo+IC0tLS0tIE9uIEFwciAyOCwgMjAy
MCwgYXQgMjo0MCBQTSwgUGhpbGlwcGUgUHJvdWx4IHBwcm91bHhAZWZmaWNpb3MuY29tIHdyb3Rl
Ogo+IAo+PiAtLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4+PiBGcm9tOiAiTWF0aGlldSBE
ZXNub3llcnMiIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4+PiBUbzogImdiYXN0
aWVuK2x0dG5nIiA8Z2Jhc3RpZW4rbHR0bmdAdmVyc2F0aWMubmV0PiwgIk1hdHRoZXcgS2hvdXph
bSIKPj4+IDxtYXR0aGV3Lmtob3V6YW1AZXJpY3Nzb24uY29tPiwKPj4+IGRpYW1vbi1kaXNjdXNz
QGxpbnV4Zm91bmRhdGlvbi5vcmcsIHBwcm91bHhAZWZmaWNpb3MuY29tLCAiSmVyZW1pZSBHYWxh
cm5lYXUiCj4+PiA8amdhbGFyQGVmZmljaW9zLmNvbT4KPj4+IENjOiAibHR0bmctZGV2IiA8bHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZz4sICJNYXRoaWV1IERlc25veWVycyIKPj4+IDxtYXRoaWV1
LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4+PiBTZW50OiBUaHVyc2RheSwgMjMgQXByaWwsIDIw
MjAgMTY6NTI6MjQKPj4+IFN1YmplY3Q6IFtSRkMgUEFUQ0ggQ1RGIDEvM10gQ2xhcmlmeSB0aGF0
IHVubGlzdGVkIGVudW0gdmFsdWVzIGFyZQo+Pj4gaW1wbGVtZW50YXRpb24tZGVmaW5lZAo+PiAK
Pj4+IEZyb206IEdlbmV2acOodmUgQmFzdGllbiA8Z2Jhc3RpZW4rbHR0bmdAdmVyc2F0aWMubmV0
Pgo+Pj4gCj4+PiBTaWduZWQtb2ZmLWJ5OiBHZW5ldmnDqHZlIEJhc3RpZW4gPGdiYXN0aWVuK2x0
dG5nQHZlcnNhdGljLm5ldD4KPj4+IFNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxt
YXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4+PiAtLS0KPj4+IGNvbW1vbi10cmFjZS1m
b3JtYXQtc3BlY2lmaWNhdGlvbi5tZCB8IDMgKysrCj4+PiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspCj4+PiAKPj4+IGRpZmYgLS1naXQgYS9jb21tb24tdHJhY2UtZm9ybWF0LXNwZWNp
ZmljYXRpb24ubWQKPj4+IGIvY29tbW9uLXRyYWNlLWZvcm1hdC1zcGVjaWZpY2F0aW9uLm1kCj4+
PiBpbmRleCBmZDQ5ZTU5Li5mNWZlYTUxIDEwMDY0NAo+Pj4gLS0tIGEvY29tbW9uLXRyYWNlLWZv
cm1hdC1zcGVjaWZpY2F0aW9uLm1kCj4+PiArKysgYi9jb21tb24tdHJhY2UtZm9ybWF0LXNwZWNp
ZmljYXRpb24ubWQKPj4+IEBAIC00NjQsNiArNDY0LDkgQEAgZW51bSB7Cj4+PiB9Cj4+PiB+fn4K
Pj4+IAo+Pj4gK1RoZSBtYXBwaW5ncyBpbiB0aGUgZW51bWVyYXRpb24gdHlwZSBkbyBub3QgaGF2
ZSB0byBiZSBleGhhdXN0aXZlLgo+Pj4gK1VubGlzdGVkIHZhbHVlcyBhcmUgaW1wbGVtZW50YXRp
b24gZGVmaW5lZC4KPj4+ICsKPj4gCj4+IFdoeSBub3QganVzdDoKPj4gCj4+ICAgIEFuIGVudW1l
cmF0aW9uIGZpZWxkIGNhbiBoYXZlIGFuIGludGVncmFsIHZhbHVlIHdoaWNoIGl0cyB0eXBlIGRv
ZXMgbm90Cj4+ICAgIG1hcCB0byBhIHN0cmluZy4KPj4gCj4+ID8KPiAKPiBHb29kIHBvaW50LCBJ
IHdpbGwgdXNlIHRoYXQgd29yZGluZy4KCkdlbmV2acOodmUgcG9pbnRlZCBvdXQgb24gSVJDIHRo
YXQgdGhlIHNlbnRlbmNlIGFib3ZlIGlzIHdlaXJkLiBXb3VsZCB0aGUKZm9sbG93aW5nIGNvbnZl
eSB0aGUgcmlnaHQgbWVhbmluZyA/CgoiQW4gZW51bWVyYXRpb24gZmllbGQgY2FuIGhhdmUgYW4g
aW50ZWdyYWwgdmFsdWUgZm9yIHdoaWNoIHRoZSBhc3NvY2lhdGVkIGVudW1lcmF0aW9uCnR5cGUg
ZG9lcyBub3QgbWFwIHRvIGEgc3RyaW5nLiIKClRoYW5rcywKCk1hdGhpZXUKCj4gCj4gVGhhbmtz
LAo+IAo+IE1hdGhpZXUKPiAKPj4gCj4+IFBoaWwKPj4gCj4+PiAjIyMgNC4yIENvbXBvdW5kIHR5
cGVzCj4+PiAKPj4+IENvbXBvdW5kIGFyZSBhZ2dyZWdhdGlvbiBvZiB0eXBlIGRlY2xhcmF0aW9u
cy4gQ29tcG91bmQgdHlwZXMgaW5jbHVkZQo+Pj4gLS0KPj4gPiAyLjExLjAKPiAKPiAtLQo+IE1h
dGhpZXUgRGVzbm95ZXJzCj4gRWZmaWNpT1MgSW5jLgo+IGh0dHA6Ly93d3cuZWZmaWNpb3MuY29t
CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9z
LmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0
cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
