Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEB8C77B73
	for <lttng-dev@archiver.kernel.org>; Fri, 26 May 2023 14:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1685110820;
	bh=Z/fFCUGUIqxudXTCZ+Aa2TDSfH3e7zjQOeA7x0XGS0s=;
	h=To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IAO5TQV1niOr6uVaaQX2vbCyxwwceBOUXRAUPQYISDwhPmvjRffF/+wXVQ4tQoqP5
	 IIQp6R2eF14vZ0O9kb+KC6YUPMHXHJqGmNOkDGiTq8cHQnPgv/+d33RTZInjlNjbnf
	 OKk/Dalr4An17PeU9MfmVNwsZc5388YxU/IVGmdUsOJPdho1BZpRXuGGdaS6w17dNy
	 2Pe3rxgOs1//wwa8YLjCYH4oimfuBeVIDsCVs/k8v0c91LLTjF3MwrZgk0HyTQ9YZx
	 tEOCHLoV66k1n8hP2eiGyLKNH0DddB18liTh4iQkr7B99CTE562x87WwMgNShlfO7M
	 GiAaifKXqctow==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QSRsH3YxLz1SjH;
	Fri, 26 May 2023 10:20:19 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QSRsG2VfTz1SjF
 for <lttng-dev@lists.lttng.org>; Fri, 26 May 2023 10:20:13 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QSRrx1Dlsz144d;
 Fri, 26 May 2023 10:20:01 -0400 (EDT)
To: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>, Dmitry Vyukov
 <dvyukov@google.com>
Cc: tsan-users <tsan-users@google.com>, lttng-dev
 <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@kernel.org>, Tony
 Finch <fanf@isc.org>
In-Reply-To: <2D55847D-F6DC-48F2-BF12-44736D0AC1EF@sury.org>
Organization: EfficiOS
References: <CACT4Y+a22N7gvcePvBazN_=AyeigVaeH-nFX-ZqZbq49mftMPg@mail.gmail.com>
 <EFA4F8F7-0767-4FEF-8EA5-DDEA05F3296C@sury.org>
 <CACT4Y+bwGm1h5A0qsjCQrLzwt+uAbNZ-D+6zSr6PiXDGq2LgYw@mail.gmail.com>
 <2D55847D-F6DC-48F2-BF12-44736D0AC1EF@sury.org>
Date: Fri, 26 May 2023 10:20:00 -0400
Message-ID: <87cz2n18fj.fsf@laura>
MIME-Version: 1.0
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gRnJpLCAyNiBNYXkgMjAyMywgT25kxZllaiBTdXLDvSA8b25kcmVqQHN1cnkub3JnPiB3cm90
ZToKCj4gTG9va3MgbGlrZSBpdCBnb3QgYWxsIHJlc29sdmVkIGJ5IHVzaW5nIHRoZSBsYXRlc3Qg
bGlidXJjdSBwYXRjaCBzZXQgd2l0aCBmdWxsCj4gVFNBTiBzdXBwb3J0LiBJIGhhdmVuJ3QgcmVh
bGl6ZWQgdGhhdCBvdXIgQ0kgc3RpbGwgcnVucyB3aXRoIHdoYXRldmVyCj4gbGlidXJjdQoKSnVz
dCBwb2ludGluZyBvdXQgdGhhdCB3ZSd2ZSBhZGQgc3VwcG9ydCBmb3Igd2ZjcXVldWUgd2hpY2gg
c2VlbXMgdG8gYmUKcXVpdGUgdXNlZCBpbiBCSU5ELiAgTmV3IHBhdGNoZXMgYXJlIG9uIHRoZSB3
YXkgZm9yIHN1cHBvcnRpbmcgb3RoZXIKZGF0YSBzdHJ1Y3R1cmVzIGFzIHdlbGwgaW4gdGhlIHNh
bWUgdmVpbiA6LSkKCi0tIApPbGl2aWVyIERpb24KRWZmaWNpT1MgSW5jLgpodHRwczovL3d3dy5l
ZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
