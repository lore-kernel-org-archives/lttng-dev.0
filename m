Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3B2C00140
	for <lttng-dev@archiver.kernel.org>; Wed, 10 Aug 2022 14:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660140501;
	bh=6lysmZufu6daVr5xPRbPrp9YP5jlX9PCXjje5D6vDns=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cuXpcg+v45gG0Yr7+zc8bpg/Zf8bmxGuy2Ca1TMOqBobz/fknG3ve9SdzMPTboz2h
	 4Ma3sZgHOYswOpd2jrSa6j1GGBU/BdA3ZeAIyt1y2OzFD8nVWUjkg/FpVRkZHckC8z
	 Ec7vU21sbil9sDWysQGJ6v+tArXeE25WDz2VknmK+TpoUJ1ZjogsJC08sn3Vnsi786
	 gDJYIAAoJFPIpIaZHypU3NvcJiS/EKi25x701b9R/tnAJ07tzMzXvpTxmgXGBPUZ81
	 f1c5srLFFmYpjHMXsgzb6R2MhMjWgWo/Fdf4XKJn/8H8ZVzB/G1ISvcy6AeQ8wJoU/
	 WcWA5BrPq1pOQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M2sGs0JlKz16Zn;
	Wed, 10 Aug 2022 10:08:21 -0400 (EDT)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by lists.lttng.org (Postfix) with ESMTPS id 4M2sGp4xN2z1DGj
 for <lttng-dev@lists.lttng.org>; Wed, 10 Aug 2022 10:08:13 -0400 (EDT)
Received: by mail-lf1-x129.google.com with SMTP id t1so21406669lft.8
 for <lttng-dev@lists.lttng.org>; Wed, 10 Aug 2022 07:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=/WSg7gBgfJ7186+J1m3OhIhtH8F2T2x3SSVvLBn01Bo=;
 b=1AR5BNPHJZqA/OAz8NZ3fY5B5eNM0Cm7EeeAYuQVZ/eu6A+sgamwj/JGwqt0m6DfLS
 LZ2uT7z80ynKMZUaW+l3zU+km4DcOfoH7X8dlplwyoYCsacf4Nn4k31/CGZi0JlW7sB/
 bqg3I0t2gjVTzW9E6g8o6raZsk/iAuiTJ/4bYEflPp8Olvw/gWp3SBbPLu+3k4dueX9+
 nRPl8m4wXljn7cqGXQreeUgah7nMj8p4bK5W+MPbJL3gjH0PhPMrrcV/YDOAY7upFuZW
 Oone5M4OxdOZLYxYOEAjFcFOOlmtu+1LgP8IhIvoM9IzaR3ut60tv0jh/CYjmv/Ht0DV
 YucQ==
X-Gm-Message-State: ACgBeo1AQ2wq2+UpQ2eoUto+wN10JE4f2CGTmF3nlL97zo0Lf90p3FN8
 sDVz9ynxWJUAESABOI0M4Q2nBgvMHFAZSdS4XvU=
X-Google-Smtp-Source: AA6agR7lwPjqJIzDKx8AZp7EYH9i96hzwZ5YMVYDqX1bMkTrSVFmhw1eCXfYxrWQrm0UBFieZHe67VQeBWjwhUOsDz4=
X-Received: by 2002:ac2:499c:0:b0:48a:ee7d:fe6e with SMTP id
 f28-20020ac2499c000000b0048aee7dfe6emr9237609lfl.16.1660140491877; Wed, 10
 Aug 2022 07:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <62F357DF.2973D3.13514@m12-11.163.com>
In-Reply-To: <62F357DF.2973D3.13514@m12-11.163.com>
Date: Wed, 10 Aug 2022 10:07:45 -0400
Message-ID: <CAB4xu_0FsM2k+mxr+3SMrj1MySNO_O3atCjvipbFy9etxwObbA@mail.gmail.com>
To: zenan <dantefu9001@163.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] babeltrace2 python api related question
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <eeppeliteloop@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gV2VkLCBBdWcgMTAsIDIwMjIgYXQgOTo1NCBBTSB6ZW5hbiB2aWEgbHR0bmctZGV2CjxsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnPiB3cm90ZToKPgo+Cj4KPiBIaSB0aGVyZSwKPgo+IEnigJlt
IHRyeWluZyB0byB1c2UgYmFiZWx0cmFjZTIgcHl0aG9uIGJpbmRpbmdzIHRvIHRyYWNrIGxpdmUg
bHR0bmcgdHJhY2UsIGFzIHNob3duIGluIHNvbWUgZXhhbXBsZXMgaW4gdGhlIGRvY3VtZW50cywg
SSB0cmllZCB0byB1c2UgY3RmLmx0dG5nLWxpdmUoIGN0Zi5mcyBpbiB0aGUgZG9jdW1lbnRzKSBw
bHVnaW4gYXMgc291cmNlLCBhbmQgdXNlIHRleHQucHJldHR5IGFzIHNpbmssIGJ1dCBpdCBkaWRu
4oCZdCB3b3JrIG91dCBhcyBJIGV4cGVjdGVkLiAgU28gZG9lcyB0aGUgYXBpIHN1cHBvcnQgdHJh
Y2tpbmcgbGl2ZSBsdHRuZyB0cmFjZSBhbmQgcHJpbnQgdGhlbSBvdXQgeWV0Pwo+Cj4KCldoYXQg
ZGlkIHlvdSB0cnkgZXhhY3RseT8KCkkgbmVlZCBjb21tYW5kIGxpbmVzIGFuZC9vciBzb21lIGNv
ZGUgKGtlZXAgaXQgbWluaW1hbCkgdG8gaGVscCB5b3UuCgpQaGlsaXBwZQoKPgo+Cj4KPiBZb3Vy
cyBzaW5jZXJlbHkKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
