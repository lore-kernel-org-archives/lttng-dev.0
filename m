Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D29C71136
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Jun 2025 15:09:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM9J96Xk9z22bJ
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1750172954;
	b=EWLoGQN+9FLXzN8BkahkOT9n53As8VvDTyL66dIOwd8yIufBDb747L3yHEJchAAW/UT4
	 r5FAS1yvHMGBVcErrrTdZPU4mXohfvW3KkzesTbdKO8H/SM2/LLAZGoaJqRZXodIxaw1l
	 A3zmdJ7LIau0hzmHA5JcsY/LU0RUUiLbPh68m/NsKCV6KHak6O50tmInZuA4jF6YwOZIS
	 bHqaDBYG9oJvjIKZJsZMY8jf7gkYQKLNUzW9xsdOWntFqudUJcxyigPJeuVmFPn7c8HR+
	 YEjwffRVdkK9rJyrQK49R0G8uYK5aI1YeMwBg5vNzdAYzY8TwsJ/qAicNc5UTPvclXg==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750172954;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=jhxW//7FUqqARWRfZ/wMHEYqpvpMyt89zMkdHClv9Mo=;
	b=SrIiII/bMNIBs8W/0zNyQ/rO1TcA2VTl2YtuQiBuibts35csyhGFI4pqU+IG8/G0akjT
	 rbonhtBxcp2Po0pS1HlYCTKRzVCXGWZuT2NqDmuPJ7ijuLa4snqbwxT2WZhs4p0stIf7W
	 uDDsDvoMvZkKLiDvWjdvU8WMFNSrzmNh6y0yVImPlwz5y1iQKrSIs55Fh/lbbLlWHMXKI
	 ZUMNxWshqaaOa8M9A/Dw9UnjmHSOFHL4YwYaNEpZMwLSqMTdihH0AW+gKWR2S6ZRes2hz
	 JN0ne2fcVaUouTDNco6eb+tDs6vuTnB8rusAPiijjFO8oK6tW9lUjyUrpjKTkIyV6Cw==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM9J96Xk9z22bJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750172954;
	bh=jhxW//7FUqqARWRfZ/wMHEYqpvpMyt89zMkdHClv9Mo=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0ETuXRx/RHHcFBDyl2/pihk/5+nfOHA/9Cs3J+jUaBoU88/zLD3J/JcWdrklrr/2w
	 0XV6YfyGtdrvRro1Z5KT/CvR3ds90h3GQNDCmq34L0Y8zeeX9qSic9O78mNXeLQ3BT
	 1mpXMrzsM4+a9n4JrWqdAl4zv2OYWLNIVnd2qMWIRUxX2gj92d3PHAMFYWKn77uZzm
	 9rnkeJJTAZd8ZcUE6kVQREOjr9nX4jAYE3lqNlvWgmWdk+XKZgwmfZOkoucEulHu95
	 owNxSqU6cBstAdViUmRTTrwWXZ6riVh925+wZ9QpcopWuxYS1iZDDqLhKTnG14EOE5
	 Q7rLRlaMysrKw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bM9J96Xk9z22bJ;
	Tue, 17 Jun 2025 11:09:13 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM9J82j1Lz226J
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM9J82j1Lz226J
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by lists.lttng.org (Postfix) with ESMTPS id 4bM9J82j1Lz226J
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 11:09:11 -0400 (EDT)
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-32b4876dfecso34729701fa.1
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 08:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750172950; x=1750777750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QVohlwATJEbPy1WNEPNIATlUvYOVzyX3AaHePNa5bT0=;
 b=NARXE1X3MnjX7fuiiL7L2YXXK5FrRGn4jPH5J8XZZ3Ts1d0rpAcLh7DQfIMztRHmnT
 hZICxdb1J7I9zyDi1klRHHTjvh8YCcn6FPyZRmtK6GFPMvcdKV2+HCqjuZ8oUyl7FST3
 tRUTgcanl2RsAb/OkfhtjfDKq8AXT01btQTemdC/qEyaJ27p3HoDW+Uo+y0PMYOdfi60
 QRNpQmTJKKLkVuFJtM0t54s3VzqfCIsDd/vrAF8WgXhXUjcYCvD1Gxz3FYIYdczPAvP9
 q2lcMo9ZEPr80EsfC4BcrJiRplbLUZa+taLAnJA5YZVaBcKKeMNPfH8qsvW36y2PzNcQ
 sU9Q==
X-Gm-Message-State: AOJu0YwcMVEAz7GshGkVBKaKiJ5O63vQf3DWRHVhqA+8SmPdrrkEl8wP
 aKmIE7ouKxXNTEZPbLkA3mOQcLxth+FPr7TphM3RQh80frDatLO2XoGwy3Sw8MQEwGLwCY4AWNt
 naZWO5ifrZr3HGwe6fw8WeWmH9RVm1fFOPyyQ
X-Gm-Gg: ASbGncs3wnjckmvLtOQ6jIjgq5oTgiEmxM3RMsUPevu5PZEoTw+6zxk4/RaCYUxKefO
 AunNy2VVEA/8rnCbFvcPTB7aah/2Xv9bj7V0sIXLjGHhAMvoAgoyIkfZ56PqGnYIt5JUsE6LgWm
 VVz6IGjuS+ZVjF7hhtVtufjRcgbAdr+6af6Er2C29fSr0=
X-Google-Smtp-Source: AGHT+IGv2+5/6RZuBviQ1mKG2VGe+iebhouANeqgwbUQawbPrqL/XUkWNDcpd+EmZloVojo0w5scstfR277A/BBEA1Q=
X-Received: by 2002:a2e:b8c4:0:b0:308:e956:66e with SMTP id
 38308e7fff4ca-32b49396cbcmr38196671fa.0.1750172950065; Tue, 17 Jun 2025
 08:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <CADYdroM27zgM1RWHoCocru7VY6kHi1=g3PK4QJ0D67Wra1tc8A@mail.gmail.com>
 <30d81f2c-a2ce-47b6-b999-fb6f09f1c026@efficios.com>
In-Reply-To: <30d81f2c-a2ce-47b6-b999-fb6f09f1c026@efficios.com>
Date: Tue, 17 Jun 2025 17:08:58 +0200
X-Gm-Features: AX0GCFvkGw9l-UNT5zUtWUTjLPxCxwMNYPWa7Pr2xlEI0JHB6lt6PgZ7s6rHIrI
Message-ID: <CADYdroNushrX7E3ZR8LoKLpj0rrcebPo6iJTcKBTowUWAniQYQ@mail.gmail.com>
Subject: Re: lttng-tools-2.14.0-rc1: fails to compile with libxml2-2.14.4
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="UTF-8"
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
From: Norbert Lange via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Norbert Lange <nolange79@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Am Di., 17. Juni 2025 um 16:50 Uhr schrieb Kienan Stewart
<kstewart@efficios.com>:
>
> Hi Norbert,
>
> On 6/17/25 10:15 AM, Norbert Lange via lttng-dev wrote:
> > /tmp/dev_develop_libxml2/usr/include/libxml2/libxml/encoding.h:173:7:
> > note: declared here
> >    173 |     } input XML_DEPRECATED_MEMBER;
> >        |       ^~~~~
> > ../../../src/common/config/session-config.cpp:297:75: error: no match
> > for call to '(_xmlCharEncodingHandler::<unnamed union>) (xmlChar*&,
> > int*, const xmlChar*, int*)'
> >    297 |  ret = handler->input(out_str, &out_len, (const xmlChar *)
> > in_str, &in_len);
> >        |
> >             ^
> >
> > Changing the call to handler->input.legacyFunc seems to fix it.
> >
> > Also lttng seems to need libxml2, but doesnt add the necessary flags.
> >
>
> Regarding the "necessary flags" for libxml2 when building the lttng
> binary, could you indicate clearly the error you have?
>
> All uses of libxml2 are via libconfig, and the libxml2 LD flags are
> added to lttng via libconfig.la.
>
> When performing the final link of lttng, I see `-lxml2` in the command line.
>
> thanks,
> kienan
> > Regards, Norbert
>

The error is, that I don't see -lxml2 in the commandline (unless I use
the global LDFLAGS), libconfig.la does not contain the flags either.
However, the Makefiles all contain them:

src/common/Makefile:libxml2_CFLAGS =
-I/tmp/dev_develop_libxml2/usr/include/libxml2
src/common/Makefile:libxml2_LIBS =
/tmp/dev_develop_libxml2/usr/local/lib/libxml2.so

I dont use pkgconf, I set the variables directly (libxml2 is not a
part of our production filesystem + compiler and right now I just
barely managed to compile lttng somehow).

Regards, Norbert
