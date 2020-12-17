Return-Path: <SRS0=Ppkc=FV=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD80DC4361B
	for <lttng-dev@archiver.kernel.org>; Thu, 17 Dec 2020 15:27:32 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2334423975
	for <lttng-dev@archiver.kernel.org>; Thu, 17 Dec 2020 15:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2334423975
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CxbTZ1RsKzFdT;
	Thu, 17 Dec 2020 10:27:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1608218850;
	bh=NC42Jh0CVYA+0MvT++Pwq4r5A/mE/GMX323TsnHU/yk=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=b2uFnC3QW0FfuKqjt2GjRXtvtjaTkak3q5GMLjmo50wbbnWdQcexiAcCuSfuTUSgb
	 VHhfP8qZGFPJphHeYRZUWzieMYl/KgW8TlFtqjyS+6UkSXFuVsi+q3YWe3oT10Gq6f
	 b+t2OkvzL0gf+R6kP7RiKBe7oq1z2d517nsdY1lMvT3H4dQbvbLOeJEm6YPz0VSXMO
	 TYc+PvhLxybx0hcGZGzoUarieTaiAI1eWkxaIpjF6nsWvYqagtRwCoZgAgKMDmr/Pj
	 a1cwNroi+G8iIhrG3N+YtfHxQQY/4fLi7mJ0Dulj5nFeB1KGf3JWPuEsuIGjkD7ORi
	 6aRHtfA9Q/hSA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CxbTX1gjkzFCy
 for <lttng-dev@lists.lttng.org>; Thu, 17 Dec 2020 10:27:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B0C3B2A40A1
 for <lttng-dev@lists.lttng.org>; Thu, 17 Dec 2020 10:27:27 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id a1RgWFKMvWir; Thu, 17 Dec 2020 10:27:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5F9412A40A0;
 Thu, 17 Dec 2020 10:27:27 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5F9412A40A0
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id VMM__6YUuidG; Thu, 17 Dec 2020 10:27:27 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 51D382A3CCD;
 Thu, 17 Dec 2020 10:27:27 -0500 (EST)
Date: Thu, 17 Dec 2020 10:27:27 -0500 (EST)
To: Serica <serica_law@qq.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <829410434.7017.1608218847209.JavaMail.zimbra@efficios.com>
In-Reply-To: <tencent_8F00E9F4A97AC396358B4008BF78437FE105@qq.com>
References: <tencent_8F00E9F4A97AC396358B4008BF78437FE105@qq.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3980)
Thread-Topic: Possibilities to customize lttng tracepoints in kernel space
Thread-Index: du8MC3RhZd5l0VHnHIvWFzHIm+M5XA==
Subject: Re: [lttng-dev] Possibilities to customize lttng tracepoints in
 kernel space
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: multipart/mixed; boundary="===============8769167294035375815=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8769167294035375815==
Content-Type: multipart/alternative; 
	boundary="=_97c702d8-131f-4bc1-9128-4d2981d4e6b1"

--=_97c702d8-131f-4bc1-9128-4d2981d4e6b1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Dec 16, 2020, at 4:19 AM, lttng-dev <lttng-dev@lists.lttng.org> wrote: 

> Hi,

> I send this email to consult that whether it is possible to customize lttng
> tracepoints in kernel space. I have learnt that lttng leverages linux
> tracepoint to collect audit logs like system calls. Also, I have found that
> user can define their customized tracepoints in user space by using lttng-ust
> so that they can trace their user applications.

> Is it possible for lttng users to customize the existing tracepoints in kernel
> space? For example, after the system call sys_clone, or read, called and then
> collected by lttng, I want to process some data ( e.g., the return value of the
> syscall ), and place the result in a new field in the audit log ( or using
> another approach, by emitting a new type of event in the audit log ), and later
> when parsed by babeltrace, we can see the newly-added field or event in the
> parsed result.

> Looking forward to your reply.

Hi, 

You will want to start by having a look at this section of the LTTng documentation: https://lttng.org/docs/v2.12/#doc-instrumenting-linux-kernel 

You can indeed modify lttng-modules to change the fields gathered by the system call tracing facility (see include/instrumentation/syscalls/README section (3)). 
Those changes will be reflected in the resulting trace data. 

Thanks, 

Mathieu 

> Best wishes,

> Serica

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_97c702d8-131f-4bc1-9128-4d2981d4e6b1
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><div><span id=3D"z=
wchr" data-marker=3D"__DIVIDER__">----- On Dec 16, 2020, at 4:19 AM, lttng-=
dev &lt;lttng-dev@lists.lttng.org&gt; wrote:<br></span></div><div data-mark=
er=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;m=
argin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:no=
rmal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:=
12pt;"><div>Hi,</div><br><div>I send this email to consult that whether it =
is possible to customize lttng tracepoints in kernel space. I have learnt t=
hat lttng leverages linux tracepoint to collect audit logs like system call=
s. Also, I have found that user can define their customized tracepoints in =
user space by using lttng-ust so that they can trace their user application=
s.</div><br><div>Is it possible for lttng users to customize the existing t=
racepoints in kernel space? For example, after the system call sys_clone, o=
r read, called and then collected by lttng, I want to process some data ( e=
.g., the return value of the syscall ), and place the result in a new field=
 in the audit log ( or using another approach, by emitting a new type of ev=
ent in the audit log ), and later when parsed by babeltrace, we can see the=
 newly-added field or event in the parsed result.</div><br><div>Looking for=
ward to your reply.</div></blockquote><div><br></div><div>Hi,<br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>You will want to =
start by having a look at this section of the LTTng documentation: https://=
lttng.org/docs/v2.12/#doc-instrumenting-linux-kernel<br data-mce-bogus=3D"1=
"></div><div><br data-mce-bogus=3D"1"></div><div>You can indeed modify lttn=
g-modules to change the fields gathered by the system call tracing facility=
 (see include/instrumentation/syscalls/README section (3)).</div><div>Those=
 changes will be reflected in the resulting trace data.<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-m=
ce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><br data-mce-=
bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;=
"><br><div>Best wishes,</div><br><div>Serica</div><br>_____________________=
__________________________<br>lttng-dev mailing list<br>lttng-dev@lists.ltt=
ng.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></b=
lockquote></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></d=
iv><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div>=
</div></body></html>
--=_97c702d8-131f-4bc1-9128-4d2981d4e6b1--

--===============8769167294035375815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8769167294035375815==--
