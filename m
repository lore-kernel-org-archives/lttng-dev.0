Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52AEC7EE23
	for <lttng-dev@archiver.kernel.org>; Fri, 26 May 2023 10:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1685095717;
	bh=A5JRRCUgt3t0Q4POvHcaeZR2npgNF1FykiNrNgIf5kc=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=v4/Qw3LuE2NnoQrG29CHFa5oj99R+Ao1LRC9YgtDOJr04pt/5csybQYqoia94Optd
	 s2B+mji/u8IshuKMiXow6EHtxK2z/t+oOK2IA1j2+HgfaV6WudQNxl66UBse/YF5EV
	 4BgO/sWT1YPNdUT9tEpWiGA/weJaPRl+1obWaf+kRVCHyFmCdPhq0C/NPzLVLlaR15
	 l6v7mFrTU+pNnLY4EDRY0gby7GrV01GxBttCxSa0TsaXnmZmtyNPENkFCs2bl6hQr9
	 yAAkOaOzxbOfQl7i1oCf2kM7rPyYKwSVq1Fa8vsXJDxPObbaixE8TjBrVC5M101gb9
	 caL5XOL7oCqqw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QSLGr6QFdz1Sj6;
	Fri, 26 May 2023 06:08:36 -0400 (EDT)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by lists.lttng.org (Postfix) with ESMTPS id 4QSLGq4xT5z1SpC
 for <lttng-dev@lists.lttng.org>; Fri, 26 May 2023 06:08:35 -0400 (EDT)
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f3b900195dso2069e87.1
 for <lttng-dev@lists.lttng.org>; Fri, 26 May 2023 03:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685095714; x=1687687714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPOpVaXAH7I++TErw/3J+0eViZ4gEDGFBkBGxW5ZudA=;
 b=R6sIg5j7fOcaEkbYgOI820+Q3IM7rqTlgXWI4PQawX85G4EzbJuggwn/O9X+2zMUtO
 L7kVluW2SInnkc/OMly7IrgAIRJDpgWFI3NuvgQCnJ2sT4cM+LwdrneMQ164fZ6wBFA8
 C4h8Nk0acoLcEyC72M+Xx9PKUolxiqTSeS6KvF45Z6Qn0OpcGHQxGvM7ajR8cnDZG1Dj
 gpYyL4KUr0wY+BCKiskANq6drraI/Z8nfjT+cMw8nrntcTl13Tc+vQrbYz8C8WSUonaF
 RMdvLYCRTHrg7RXpqr4gHljIoLLQZucyjir9Th4dyER34WtC/mPALJDfkrQGPtl4Q9Zc
 a5KA==
X-Gm-Message-State: AC+VfDzOsomKtFYq6fKJ9gVCfeB0T0sNRCXyR6FJiRmo07RYlnEcHAht
 1LKpSxWTaomcn8wNh6/92oakJJggbga0n+hDReTArA==
X-Google-Smtp-Source: ACHHUZ4KUOZx+zfo/MY1q76N3EDnAcMgmHpr6NRzZybSdDPYlbgkxKlSPpeiwne9/VoFLnq4ZNW4qNeKdwYd6ClCUDc=
X-Received: by 2002:ac2:5f19:0:b0:4f3:a7c6:590e with SMTP id
 25-20020ac25f19000000b004f3a7c6590emr30444lfq.7.1685095713655; Fri, 26 May
 2023 03:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+a22N7gvcePvBazN_=AyeigVaeH-nFX-ZqZbq49mftMPg@mail.gmail.com>
 <EFA4F8F7-0767-4FEF-8EA5-DDEA05F3296C@sury.org>
 <CACT4Y+bwGm1h5A0qsjCQrLzwt+uAbNZ-D+6zSr6PiXDGq2LgYw@mail.gmail.com>
 <2D55847D-F6DC-48F2-BF12-44736D0AC1EF@sury.org>
In-Reply-To: <2D55847D-F6DC-48F2-BF12-44736D0AC1EF@sury.org>
Date: Fri, 26 May 2023 12:08:21 +0200
Message-ID: <CACT4Y+ZvDAQZRjjW8f_iLeVNfT6ZxOjrSb1yQdbkf8CuTiH3pA@mail.gmail.com>
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Cc: Olivier Dion <odion@efficios.com>, tsan-users <tsan-users@google.com>, 
 lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Tony Finch <fanf@isc.org>
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

T24gRnJpLCAyNiBNYXkgMjAyMyBhdCAxMjowNiwgT25kxZllaiBTdXLDvSA8b25kcmVqQHN1cnku
b3JnPiB3cm90ZToKPgo+Cj4gPiBPbiAyNi4gNS4gMjAyMywgYXQgODowOCwgRG1pdHJ5IFZ5dWtv
diA8ZHZ5dWtvdkBnb29nbGUuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBGcmksIDI2IE1heSAyMDIz
IGF0IDA3OjMzLCBPbmTFmWVqIFN1csO9IDxvbmRyZWpAc3VyeS5vcmc+IHdyb3RlOgo+ID4+Cj4g
Pj4gQSBsaXR0bGUgYml0IHJlbGF0ZWQgcXVlc3Rpb24vcHJvYmxlbSAtIHNvbWUgb2Ygb3VyIHN5
c3RlbSB0ZXN0IGpvYnMgZ290IHNpZ25pZmljYW50bHkgc2xvd2VyICgzeC01eCkgd2l0aCAqKmNs
YW5nLTE2KiogVFNBTiBhZnRlciB3ZSBpbnRlZ3JhdGVkIGxpYnVyY3UgdG8gQklORCA5LiBUaGUg
R0NDICgxMy4xLjEpIFRTQU4gZG9lc27igJl0IGV4aGliaXQgdGhpcyBiZWhhdmlvci4KPiA+Pgo+
ID4+IFRoZSBsaWJ1cmN1IGludGVncmF0aW9uIGluIEJJTkQgOSBpcyB2ZXJ5IGxpZ2h0IGF0IHRo
ZSBtb21lbnQgLSB3ZSB1c2UgbGlidXJjdSBmb3IgcXB0cmllIGFuZCB0aGVyZeKAmXMgc29tZSB1
c2FnZSBvZiB3ZmNxdWV1ZSBmb3IgcXVldWluZyBqb2JzKGNhbGxiYWNrcykgYmV0d2VlbiB0aHJl
YWRzLgo+ID4+Cj4gPj4gV2Ugd2VyZSBub3QgYWJsZSB0byBwdXQgYSBmaW5nZXIgb24gaXQgeWV0
LCBidXQgc2F5aW5nIHRoaXMgYWxvdWQgbWlnaHQgaGVscCBkaWFnbm9zZSB0aGlzLgo+ID4KPiA+
IEludGVyZXN0aW5nLiBDbGFuZyAxNiBnb3QgYSBjb21wbGV0ZWx5IG5ldyB0c2FuIHJ1bnRpbWUK
PiA+IGltcGxlbWVudGF0aW9uLCB3aGljaCBpcyBnZW5lcmFsbHkgfjJ4IGZhc3RlciBhbmQgY29u
c3VtZXMgbGVzcwo+ID4gbWVtb3J5Lgo+ID4gSG93ZXZlciwgb2YgY291cnNlLCBpdCdzIG5vdCBw
b3NzaWJsZSB0byBvcHRpbWl6ZSBmb3IgYWxsIGdhemlsbGlvbiBvZgo+ID4gcHJvZ3JhbXMgaW4g
dGhlIHdvcmxkLiBJIHN1c3BlY3QgbGlicmN1IHRlc3RzIGFyZSBxdWl0ZSBleHRyZW1lIGluCj4g
PiB0ZXJtcyBvZiBzeW5jaHJvbml6YXRpb24uCj4gPgo+ID4gSWYgeW91IGNvbGxlY3QgcGVyZiBw
cm9maWxlcyBmb3IgYm90aCwgSSBjYW4gbG9vayBmb3Igc29tZSBsb3cgaGFuZ2luZyBmcnVpdC4K
PiA+IE9yIGlzIHRoZXJlIGEgcmVhc29uYWJsZSB3YXkgZm9yIG1lIHRvIHJlcHJvZHVjZT8KPgo+
IExvb2tzIGxpa2UgaXQgZ290IGFsbCByZXNvbHZlZCBieSB1c2luZyB0aGUgbGF0ZXN0IGxpYnVy
Y3UgcGF0Y2ggc2V0IHdpdGggZnVsbAo+IFRTQU4gc3VwcG9ydC4gSSBoYXZlbid0IHJlYWxpemVk
IHRoYXQgb3VyIENJIHN0aWxsIHJ1bnMgd2l0aCB3aGF0ZXZlciBsaWJ1cmN1Cj4gRGViaWFuIGJ1
bGxzZXllIGhhdmUuIFNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLgo+Cj4gQW5kIEkgY2FuIG5vIGxv
bmdlciByZXByb2R1Y2UgdGhpcyBsb2NhbGx5Lgo+Cj4gRlRSIGhlcmUgYXJlIHNvbWUgbnVtYmVy
cyBmcm9tIG15IGxvY2FsIHN5c3RlbSAoMTN0aCBHZW4gSW50ZWwoUikgQ29yZShUTSkgaTktMTM5
MDBLKQo+IHJ1bm5pbmcgVFNBTi1lbmFibGVkIHBhdGNoZWQgdXNlcnNwYWNlLXJjdVsxXSwgbGli
dXYgMS40NS4wIGFuZCBPcGVuU1NMIDMuMC44Ogo+Cj4gZ2NjLTEzIGJhc2VsaW5lCj4KPiBycHo6
ICAgICAgICAgICAgcGFzc2VkIGluIDE5OC43MXMgKDA6MDM6MTgpCj4gcnB6cmVjdXJzZTogICAg
IHBhc3NlZCBpbiAzMTAuNjJzICgwOjA1OjEwKQo+IHJyc2V0b3JkZXI6ICAgICBwYXNzZWQgaW4g
MjAwLjQwcyAoMDowMzoyMCkKPgo+IGdjYy0xMyBUU0FOCj4KPiBycHo6ICAgICAgICAgICAgcGFz
c2VkIGluIDMwNS42NHMgKDA6MDU6MDUpCj4gcnB6cmVjdXJzZTogICAgIHBhc3NlZCBpbiA0Mjcu
NzNzICgwOjA3OjA3KQo+IHJyc2V0b3JkZXI6ICAgICBwYXNzZWQgaW4gMjYwLjY1cyAoMDowNDoy
MCkKPgo+IGNsYW5nLTE2IFRTQU4KPgo+IHJwejogICAgICAgICAgICBwYXNzZWQgaW4gMjkwLjA1
cyAoMDowNDo1MCkKPiBycHpyZWN1cnNlOiAgICAgcGFzc2VkIGluIDQ2OC41M3MgKDA6MDc6NDgp
Cj4gcnJzZXRvcmRlcjogICAgIHBhc3NlZCBpbiAyNTguOTdzICgwOjA0OjE4KQo+Cj4gVGhpcyBs
b29rcyBxdWl0ZSByZWFzb25hYmxlIHRvIG1lLgo+Cj4gMS4gZ2l0IGZldGNoIGh0dHBzOi8vcmV2
aWV3Lmx0dG5nLm9yZy91c2Vyc3BhY2UtcmN1IHJlZnMvY2hhbmdlcy81OC8xMDA1OC8xICYmIGdp
dCBjaGVja291dCBGRVRDSF9IRUFECgpZZXMsIGxvb2tzIHJlYXNvbmFibGUuCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
