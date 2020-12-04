Return-Path: <SRS0=IxRW=FI=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEDCC4361A
	for <lttng-dev@archiver.kernel.org>; Fri,  4 Dec 2020 21:38:26 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32DA422BE8
	for <lttng-dev@archiver.kernel.org>; Fri,  4 Dec 2020 21:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DA422BE8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CnmKW02bVz1TS5;
	Fri,  4 Dec 2020 16:38:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1607117903;
	bh=DlACidph1TLwkR45fhQ6j9J79b3tLIruDgHL0cnDHPI=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RHXTnbNXCnUnsoCIhVh3Ll+sTDrNKJDb4QT2CgTa19bm9GER5taB6D+dAj4lTcBod
	 o8GHx+qF1Z3pyB38k1iovm5XXRjVyPV122Tctnea18K6Pr3xMVW/E9FvVdtIrciv94
	 BhC8ANArL/X8iIKtNlWJMLpZywI2GYvcRI+9XZN/b8l4BQAd5oJqsd0Q1nqmgNYU2d
	 x/TTaHtz/ndnbHIbCF1lSu+peAOw427s7174S/ztCYUnJJUT+t2OF9MVjkanesgMhO
	 7R3WYCG3qZ/Sy22VEBDVTnpFTalLoQW64Z+iGlvV1mZZXDlYUz8M5pUdFvRqD2MIc0
	 /ytYvJ7S5JAzQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CnmKS4sV9z1TS4
 for <lttng-dev@lists.lttng.org>; Fri,  4 Dec 2020 16:38:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5E9CA2CF4C0
 for <lttng-dev@lists.lttng.org>; Fri,  4 Dec 2020 16:38:13 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id l4eV2Nj-h1yF for <lttng-dev@lists.lttng.org>;
 Fri,  4 Dec 2020 16:38:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DB8262CF4BF
 for <lttng-dev@lists.lttng.org>; Fri,  4 Dec 2020 16:38:12 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DB8262CF4BF
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id O0u_OVx3Xh8X for <lttng-dev@lists.lttng.org>;
 Fri,  4 Dec 2020 16:38:12 -0500 (EST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mail.efficios.com (Postfix) with ESMTPSA id A9FD62CF5A8
 for <lttng-dev@lists.lttng.org>; Fri,  4 Dec 2020 16:38:12 -0500 (EST)
Received: by mail-wr1-f50.google.com with SMTP id k14so6685976wrn.1
 for <lttng-dev@lists.lttng.org>; Fri, 04 Dec 2020 13:38:12 -0800 (PST)
X-Gm-Message-State: AOAM532nM8ZVOlMJnVyXCl+h8ki2QokGrxGK4IJn3s1sBTdvO1pQQjc9
 5C7OZLrrX3BHAFIyk3dyxieQsgbF5LPQY/Re0Ro=
X-Google-Smtp-Source: ABdhPJyR1DJcHHYnizoWnWkn2ZLamWIKWQR1Uh4j9Yf+s/3vWB7rFQAhILdI0XDWUnvSYuWNZ7/zUg2KpvTh7E7RpVo=
X-Received: by 2002:a5d:668d:: with SMTP id l13mr6909089wru.279.1607117891572; 
 Fri, 04 Dec 2020 13:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20201125083140.25923-1-wallinux@gmail.com>
In-Reply-To: <20201125083140.25923-1-wallinux@gmail.com>
Date: Fri, 4 Dec 2020 16:37:35 -0500
X-Gmail-Original-Message-ID: <CA+jJMxuVXpebURuJuV7TixXsAq798-TPGWfXBDYUwtW5D7NJyg@mail.gmail.com>
Message-ID: <CA+jJMxuVXpebURuJuV7TixXsAq798-TPGWfXBDYUwtW5D7NJyg@mail.gmail.com>
To: Anders Wallin <wallinux@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] [PATCH lttng-tools] Extras: Perl 5.26 requires { to
 be escaped by \
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?=
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

TWVyZ2VkIGluIG1hc3Rlci4KClRoYW5rcyEKSsOpcsOpbWllCgpPbiBXZWQsIDI1IE5vdiAyMDIw
IGF0IDAzOjMxLCBBbmRlcnMgV2FsbGluIHZpYSBsdHRuZy1kZXYKPGx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmc+IHdyb3RlOgo+Cj4gVW5lc2NhcGVkIGxpdGVyYWwgInsiIGNoYXJhY3RlcnMgaW4g
cmVndWxhciBleHByZXNzaW9uIHBhdHRlcm5zIGFyZSBubwo+IGxvbmdlciBwZXJtaXNzaWJsZQo+
Cj4gU2lnbmVkLW9mZi1ieTogQW5kZXJzIFdhbGxpbiA8d2FsbGludXhAZ21haWwuY29tPgo+IC0t
LQo+ICBleHRyYXMvY2hlY2twYXRjaC5wbCB8IDEwICsrKysrLS0tLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9leHRy
YXMvY2hlY2twYXRjaC5wbCBiL2V4dHJhcy9jaGVja3BhdGNoLnBsCj4gaW5kZXggMjg2Yzk0ZGUu
LjE0ZTE2ZmFlIDEwMDc1NQo+IC0tLSBhL2V4dHJhcy9jaGVja3BhdGNoLnBsCj4gKysrIGIvZXh0
cmFzL2NoZWNrcGF0Y2gucGwKPiBAQCAtMjQzMyw4ICsyNDMzLDggQEAgc3ViIHByb2Nlc3Mgewo+
Cj4gICMgZnVuY3Rpb24gYnJhY2UgY2FuJ3QgYmUgb24gc2FtZSBsaW5lLCBleGNlcHQgZm9yICNk
ZWZpbmVzIG9mIGRvIHdoaWxlLAo+ICAjIG9yIGlmIGNsb3NlZCBvbiBzYW1lIGxpbmUKPiAtICAg
ICAgICAgICAgICAgaWYgKCgkbGluZT1+LyRUeXBlXHMqJElkZW50XCguKlwpLipcc3svKSBhbmQK
PiAtICAgICAgICAgICAgICAgICAgICEoJGxpbmU9fi9cI1xzKmRlZmluZS4qZG9cc3svKSBhbmQg
ISgkbGluZT1+L30vKSkgewo+ICsgICAgICAgICAgICAgICBpZiAoKCRsaW5lPX4vJFR5cGVccyok
SWRlbnRcKC4qXCkuKlxzXHsvKSBhbmQKPiArICAgICAgICAgICAgICAgICAgICEoJGxpbmU9fi9c
I1xzKmRlZmluZS4qZG9cc1x7LykgYW5kICEoJGxpbmU9fi9cfS8pKSB7Cj4gICAgICAgICAgICAg
ICAgICAgICAgICAgRVJST1IoIk9QRU5fQlJBQ0UiLAo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJvcGVuIGJyYWNlICd7JyBmb2xsb3dpbmcgZnVuY3Rpb24gZGVjbGFyYXRpb25zIGdv
IG9uIHRoZSBuZXh0IGxpbmVcbiIgLiAkaGVyZWN1cnIpOwo+ICAgICAgICAgICAgICAgICB9Cj4g
QEAgLTI3MDksOCArMjcwOSw4IEBAIHN1YiBwcm9jZXNzIHsKPiAgIyMgICAgICAgICAgICAgfQo+
Cj4gICNuZWVkIHNwYWNlIGJlZm9yZSBicmFjZSBmb2xsb3dpbmcgaWYsIHdoaWxlLCBldGMKPiAt
ICAgICAgICAgICAgICAgaWYgKCgkbGluZSA9fiAvXCguKlwpey8gJiYgJGxpbmUgIX4gL1woJFR5
cGVcKXsvKSB8fAo+IC0gICAgICAgICAgICAgICAgICAgJGxpbmUgPX4gL2Rvey8pIHsKPiArICAg
ICAgICAgICAgICAgaWYgKCgkbGluZSA9fiAvXCguKlwpXHsvICYmICRsaW5lICF+IC9cKCRUeXBl
XClcey8pIHx8Cj4gKyAgICAgICAgICAgICAgICAgICAkbGluZSA9fiAvZG9cey8pIHsKPiAgICAg
ICAgICAgICAgICAgICAgICAgICBFUlJPUigiU1BBQ0lORyIsCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgInNwYWNlIHJlcXVpcmVkIGJlZm9yZSB0aGUgb3BlbiBicmFjZSAneydcbiIg
LiAkaGVyZWN1cnIpOwo+ICAgICAgICAgICAgICAgICB9Cj4gQEAgLTMwMDUsNyArMzAwNSw3IEBA
IHN1YiBwcm9jZXNzIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJGRzdGF0ICF+IC9e
Zm9yXHMqJENvbnN0YW50JC8gJiYgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyBmb3IgKC4u
LikKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJGRzdGF0ICF+IC9eZm9yXHMqJENvbnN0
YW50XHMrKD86JElkZW50fC0/JENvbnN0YW50KSQvICYmICAgIyBmb3IgKC4uLikgYmFyKCkKPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJGRzdGF0ICF+IC9eZG9ccyp7LyAmJiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyBkbyB7Li4uCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICRkc3RhdCAhfiAvXlwoey8pICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICMgKHsuLi4KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgJGRz
dGF0ICF+IC9eXChcey8pICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IyAoey4uLgo+ICAgICAgICAgICAgICAgICAgICAgICAgIHsKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICRjdHggPX4gcy9cbiokLy87Cj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBteSAkaGVyZWN0eCA9ICRoZXJlIC4gIlxuIjsKPiAtLQo+IDIuMjkuMgo+Cj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYg
bWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKCgoKLS0gCkrDqXLD
qW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
