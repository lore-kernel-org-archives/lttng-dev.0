Return-Path: <SRS0=pdKY=65=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EEEC433E0
	for <lttng-dev@archiver.kernel.org>; Fri, 15 May 2020 19:21:56 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CB320728
	for <lttng-dev@archiver.kernel.org>; Fri, 15 May 2020 19:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="V9ea+/Ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CB320728
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49Nyvj6RPmz23dH;
	Fri, 15 May 2020 15:21:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1589570514;
	bh=Ei/WbnGMnJxjuNnrDGrul0vBA9n0HfASvY/DLTNYaFw=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=V9ea+/AiAZ4A/HX+aFlKGR+UmiC8T3Scd3Fi3P/SXNlCEKhv+OWJoxaedj6ZWP4hW
	 p4RShpYqi6NZiVVTNRUAX1vBvi7Tx2fxHxr45fOJTQJvNiEuYrMGJBnB+9CvLgdDMD
	 7I68ldTM1zTDmPDPJHlhK5Avmipf3wXtXfKGmr5Ix8LWRyad6+U1Tvwo4bVTW77YZU
	 IOjQK94YevFwxqSFuO1agWpyfXB2bd9YyfCxTbH+A4z3u2L8SIFBsmObEqWIWvNhJA
	 ypYDAHXHHgR77ru0jdoD0k8dN/pjExKY8nTaGlqmuoFnwBZpdn8vvfPmqlwM23crDc
	 ABnvbpRKsAX4Q==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49Nyvh269Mz23xj
 for <lttng-dev@lists.lttng.org>; Fri, 15 May 2020 15:21:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A080F2B2256
 for <lttng-dev@lists.lttng.org>; Fri, 15 May 2020 15:15:16 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 5990skdLQhz6; Fri, 15 May 2020 15:15:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3D36E2B1E96;
 Fri, 15 May 2020 15:15:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3D36E2B1E96
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id iOnzQZNLlFh6; Fri, 15 May 2020 15:15:16 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 3173C2B1E95;
 Fri, 15 May 2020 15:15:16 -0400 (EDT)
Date: Fri, 15 May 2020 15:15:16 -0400 (EDT)
To: Yonghong Yan <yanyh15@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <996953575.22598.1589570116107.JavaMail.zimbra@efficios.com>
In-Reply-To: <CACJEY85H4OMTz9ggfZZP3QCXoWgLiJgsMVNTP8LNBAF67mQTEQ@mail.gmail.com>
References: <CACJEY85H4OMTz9ggfZZP3QCXoWgLiJgsMVNTP8LNBAF67mQTEQ@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: process/thread-specific UST tracing
Thread-Index: KhaJmlG96GtM2Vum0ygn/d/trmRP6A==
Subject: Re: [lttng-dev] process/thread-specific UST tracing
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
Content-Type: multipart/mixed; boundary="===============2140998864923875700=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200515191516.selS2gtKR3oYafoA9oHxcoqe8nz1Uk1Gs4nngSU1GGc@z>

--===============2140998864923875700==
Content-Type: multipart/alternative; 
	boundary="=_805e3d30-41da-4d66-bb38-41b754ace32c"

--=_805e3d30-41da-4d66-bb38-41b754ace32c
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On May 15, 2020, at 1:16 PM, lttng-dev <lttng-dev@lists.lttng.org> wrote: 

> I am tracing a multiprocess/multithreaded code (MPI/OpenMP) using lttng-ust.
> Right now, I need to include process id and thread id for each event in order
> to generate process/thread indexed view of the traces. Is there a way that I
> can store per-process events into a specific buffer without mixing the events
> with other events that are generated on the same CPU? The same thing for
> per-thread events, I would like lttng or CTF to allow to store per-thread
> events in a specific buffer without mixing the events with other events on the
> same CPU channel. With that feature, I do not need to store process id and
> thread id in each event and then need to query all the events in order to
> collect per-process or per-thread event.

No, but you can use kernel tracing (lttng-modules) of the scheduler events (sched:*) to map 
the CPU number to the currently running thread and process at trace post-processing. 

By doing so, both current thread and process become implicit with the CPU number. 

Thanks, 

Mathieu 

> Thank you
> Yonghong

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_805e3d30-41da-4d66-bb38-41b754ace32c
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><div><span id=3D"z=
wchr" data-marker=3D"__DIVIDER__">----- On May 15, 2020, at 1:16 PM, lttng-=
dev &lt;lttng-dev@lists.lttng.org&gt; wrote:<br></span></div><div data-mark=
er=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;m=
argin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:no=
rmal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:=
12pt;"><div dir=3D"ltr">I am tracing a multiprocess/multithreaded code (MPI=
/OpenMP) using lttng-ust. Right now, I need to include process id and threa=
d id for each event in order to&nbsp;generate process/thread indexed view o=
f the traces. Is there a way that I can store per-process events into a spe=
cific buffer without mixing the events with other events that are generated=
 on the same CPU? The same thing for per-thread events, I would like lttng =
or CTF to allow to store per-thread events in a specific buffer without mix=
ing the events with other events on the same CPU channel. With that feature=
, I do not need to store process id and thread id in each event and then ne=
ed to query all the events in order to collect per-process or per-thread ev=
ent.&nbsp;</div></blockquote><div>No, but you can use kernel tracing (lttng=
-modules) of the scheduler events (sched:*) to map</div><div>the CPU number=
 to the currently running thread and process at trace post-processing.<br d=
ata-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>By doing=
 so, both current thread and process become implicit with the CPU number.<b=
r data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thank=
s,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>M=
athieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><d=
iv><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><bloc=
kquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:=
5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fo=
nt-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><br>=
<div>Thank you</div><div>Yonghong</div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_805e3d30-41da-4d66-bb38-41b754ace32c--

--===============2140998864923875700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2140998864923875700==--
