Return-Path: <SRS0=w+6D=LB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D07C47094
	for <lttng-dev@archiver.kernel.org>; Mon,  7 Jun 2021 15:24:41 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE9461164
	for <lttng-dev@archiver.kernel.org>; Mon,  7 Jun 2021 15:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE9461164
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FzHGt5J4xz7xM;
	Mon,  7 Jun 2021 11:24:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1623079479;
	bh=U3y8rdmrS033bYHNAzgBpMEMeTo950GYTlH5H40tugo=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rhDmoDgiTB4MgWbSIFYQp7RHgRZKmmhRwL9CycGLT3Gd+FLYaK6SqMWPRCIVHHpwS
	 2l3qVuzu/UwJOqaRKX1/xzhOtmNz4otg6DqvITccX23w/BYGLps+lweL0QQz8uHhyk
	 TaVzfx1Oix5q/69hlBi1Ii0wi9jYhmPJz0Y8skcewLFZxwlD4mqSyyIP9rOJaZ68B6
	 P5840hcLHFGSiZRg32x/BU6POYrgeWw911iy5/yKCiQF7j5Aha+ksHs77Me+4CiXKi
	 UmlQTGbfRrDNOYkrY6zR8/lEctg9YKlUOa68bdVVy5DpdaY7OKlmy3C6MkwycWnbD7
	 I8v9Hz+GBcQXw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FzHGs01xfz84n
 for <lttng-dev@lists.lttng.org>; Mon,  7 Jun 2021 11:24:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id AFE1832FBC8
 for <lttng-dev@lists.lttng.org>; Mon,  7 Jun 2021 11:24:30 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id d0qlTCJE0WbY; Mon,  7 Jun 2021 11:24:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4D6E232FBC7;
 Mon,  7 Jun 2021 11:24:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4D6E232FBC7
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id OPFpb-hp0jqL; Mon,  7 Jun 2021 11:24:28 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 4058F32F6D6;
 Mon,  7 Jun 2021 11:24:28 -0400 (EDT)
Date: Mon, 7 Jun 2021 11:24:28 -0400 (EDT)
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <947236961.14801.1623079468191.JavaMail.zimbra@efficios.com>
In-Reply-To: <PR3PR02MB6202F326FC88DD8F3EF90596D13B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
References: <PR3PR02MB6202F326FC88DD8F3EF90596D13B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Linux)/8.8.15_GA_4026)
Thread-Topic: LTTng 32 bits on 64 bits systems - kernel events... but no
 user-event
Thread-Index: AQHXWTyXrFTi8gSpG0+XSeNSyXv/wIZFEyc2
Subject: Re: [lttng-dev] LTTng 32 bits on 64 bits systems - kernel events...
 but no user-event
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi, 

> I am currently trying to add lttng 32bits on a 64bits system with a custom
> kernel 4.19.177+ x86_64 (Debian 10.9)
> My former attempt only with only a 100% arm32 bits was successful (raspberry).
> I am facing now a strange issue : I can record kernel event but not userspace
> event... but I can see these user-event (see below)!

Ok. 

> (tuto : [ https://lttng.org/docs/#doc-instrumenting-32-bit-app-on-64-bit-system
> | https://lttng.org/docs/#doc-instrumenting-32-bit-app-on-64-bit-system ] )

> I followed two times the tutorial : on lttng 2.12 and lttng 2.10.
> I am on lttng (LTTng Trace Control) 2.10.11 - KeKriek now

Any particular reasons?

> All installation seemed to install without any error.
> The only thing I added is at the very end where I did a : ln -s
> /usr/local/bin/lttng /usr/bin/lttng (to directly call commands like "lttng
> start")

> Here some interesting outputs, I am using this projet as an example : [
> https://lttng.org/docs/#doc-tracing-your-own-user-application |
> https://lttng.org/docs/#doc-tracing-your-own-user-application ]
> lttng list -u : OK [ https://paste.ubuntu.com/p/hZptnNzySw/ | Ubuntu Pastebin ]
> LTTNG_UST_DEBUG=1 ./hello : seems OK : [ https://paste.ubuntu.com/p/w6xHrJsWJ9/
> | Ubuntu Pastebin ]
> kernel-event output : [ https://paste.ubuntu.com/p/5KfyS8wVdb/ | Ubuntu Pastebin
> ]
> user-event ouput : none - the output folder stated with lttng create
> my-user-session --output=/tmp/my-user-session doesn't even appear
> apt-file search lttng : [ https://paste.ubuntu.com/p/xMcCc7bqwk/ | Ubuntu
> Pastebin ]
> lsmod | grep lttng : [ https://paste.ubuntu.com/p/7YNkNsh9Fr/ | Ubuntu Pastebin
> ]

Can you provide the config.log from the configure steps 

We are missing the most important logs: lttng-sessiond. 

$ lttng-sessiond -vvv --verbose-consumer 

> Note : file /usr/local/bin/lttng (the exe I am using) gives :
> /usr/local/bin/lttng: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV),
> dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux
> 3.2.0, BuildID[sha1]=542a108c40e386c17027c2c8f8fcb30e278b7748, with debug_info,
> not stripped

This is normal. Concretely to support tracing of 32 bit applications only a 32 bits
lttng-consumerd executable is needed which is launched by the lttng-sessiond executable. 

> I am wondering if the installation didn't pick a 64bits RCU and analyses
> programms only on this.

Hmmm, what indicate this? I seriously doubt that this can happen. 

> However, I have currently absolutely no idea how to debug this.

I decided to do the process on a clean ubuntu 20.04 machine.
For 2.12 there is some problems when compiling only lttng-consumerd (fd-tracker lib and libcommon problem). I plan on providing a patch shortly.

But the major problem is that the path passed at configure time for the lttng-consumerd32 bit daemon are simply not used at runtime.
See this bug I just opened [1]. This is valid for 2.10 all the way to master AFAIK.

[1] https://bugs.lttng.org/issues/1318 

In the meantime you will have to pass the lttng-consumerd 32 bit path as argument or env variables to lttng-sessiond as such: 

$ lttng-sessiond -vvv --verbose-consumer --consumerd32-libdir=/usr/local/lib32 --consumerd32-path=/usr/local/lib32/lttng/libexec/lttng-consumerd

or 

$ LTTNG_CONSUMERD32_BIN=/usr/local/lib32/lttng/libexec/lttng-consumerd LTTNG_CONSUMERD32_LIBDIR=/usr/local/lib32 lttng-sessiond -vvv --verbose-consumer


From there the 32bits application is traced correctly and data is gathered without any problem (at least on 2.12).


```
[15:22:24.500655502] (+?.?????????) ubuntu2004.localdomain lttng_ust_statedump:start: { cpu_id = 3 }, { }
[15:22:24.500661538] (+0.000006036) ubuntu2004.localdomain lttng_ust_statedump:procname: { cpu_id = 3 }, { procname = "hello" }
[15:22:24.502611224] (+0.001949686) ubuntu2004.localdomain lttng_ust_statedump:bin_info: { cpu_id = 3 }, { baddr = 0xF7EC9000, memsz = 20596, path = "/usr/lib32/libdl-2.31.so", is_pic = 1, has_build_id = 1, has_debug_link = 1 }
[15:22:24.502614501] (+0.000003277) ubuntu2004.localdomain lttng_ust_statedump:build_id: { cpu_id = 3 }, { baddr = 0xF7EC9000, _build_id_length = 20, build_id = [ [0] = 0x75, [1] = 0x1E, [2] = 0xDD, [3] = 0x47, [4] = 0x72, [5] = 0x3, [6] 
```

Cheers
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
