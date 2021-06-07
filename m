Return-Path: <SRS0=w+6D=LB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDE9C47082
	for <lttng-dev@archiver.kernel.org>; Mon,  7 Jun 2021 14:54:45 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013F161107
	for <lttng-dev@archiver.kernel.org>; Mon,  7 Jun 2021 14:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013F161107
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FzGcM0d6tz8B1;
	Mon,  7 Jun 2021 10:54:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1623077683;
	bh=xJu0Dm2JCEuyZMgRRzar8iD7LHqMF4NsEzH2jMwTef4=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QQK8AnVOr+HZvWh0n8PQqukX+TFxapad7m8x5o0LLqfvXZavI05uzdDoHV20T6ofZ
	 UtISfVdxEhNXVJbZpLu7bxxpGQ1p7QUnR1yhc+fkqhONVwj/GVFdVIWunXA5j2X92s
	 7mWl/doV4LyA49pkn7aRWrEjT0C2sqZ+lS2gKeKoeKGZhzUbVoRlS5lAFJ209MIxb8
	 lhCOe3fM7Y4Xz6xvm7cchVsDcD+Z5u7DzC2oWjFFl1xF7XKK6Hk9Hryb8WMYo2SmHB
	 HaJjWg4x+mr0hzZxRGhki683M5jr/Qdqqost6FbIK2GpbE6z62dDr6rYH/qcoRx6kL
	 4/rSwYlv1TcgA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FzGcJ6PGNz810
 for <lttng-dev@lists.lttng.org>; Mon,  7 Jun 2021 10:54:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6236C32F166
 for <lttng-dev@lists.lttng.org>; Mon,  7 Jun 2021 10:54:34 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id OQtc9Y-b6iGj; Mon,  7 Jun 2021 10:54:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D291832F40A;
 Mon,  7 Jun 2021 10:54:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D291832F40A
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id t50bA5xF5KRC; Mon,  7 Jun 2021 10:54:28 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id C79E232F409;
 Mon,  7 Jun 2021 10:54:28 -0400 (EDT)
Date: Mon, 7 Jun 2021 10:54:28 -0400 (EDT)
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <210674882.13694.1623077668695.JavaMail.zimbra@efficios.com>
In-Reply-To: <PR3PR02MB6202F326FC88DD8F3EF90596D13B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
References: <PR3PR02MB6202F326FC88DD8F3EF90596D13B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF89 (Linux)/8.8.15_GA_4026)
Thread-Topic: LTTng 32 bits on 64 bits systems - kernel events... but no
 user-event
Thread-Index: AQHXWTyXrFTi8gSpG0+XSeNSyXv/wDfgkaQ+
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>



----- On Jun 4, 2021, at 9:09 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Hi LTTng team,

> I am currently trying to add lttng 32bits on a 64bits system with a custom
> kernel 4.19.177+ x86_64 (Debian 10.9)
> My former attempt only with only a 100% arm32 bits was successful (raspberry).
> I am facing now a strange issue : I can record kernel event but not userspace
> event... but I can see these user-event (see below)!
> (tuto : [ https://lttng.org/docs/#doc-instrumenting-32-bit-app-on-64-bit-system
> | https://lttng.org/docs/#doc-instrumenting-32-bit-app-on-64-bit-system ] )

> I followed two times the tutorial : on lttng 2.12 and lttng 2.10.
> I am on lttng (LTTng Trace Control) 2.10.11 - KeKriek now
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

> Note : file /usr/local/bin/lttng (the exe I am using) gives :
> /usr/local/bin/lttng: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV),
> dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux
> 3.2.0, BuildID[sha1]=542a108c40e386c17027c2c8f8fcb30e278b7748, with debug_info,
> not stripped

> I am wondering if the installation didn't pick a 64bits RCU and analyses
> programms only on this.
> However, I have currently absolutely no idea how to debug this.

> Could you advise me some methods ?

Did you follow this section of the documentation ? 

https://lttng.org/docs/#doc-instrumenting-32-bit-app-on-64-bit-system 

Thanks, 

Mathieu 

> Regards,

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
