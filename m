Return-Path: <SRS0=wPN/=GB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEE0C433E0
	for <lttng-dev@archiver.kernel.org>; Tue, 29 Dec 2020 03:58:19 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016CD20798
	for <lttng-dev@archiver.kernel.org>; Tue, 29 Dec 2020 03:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016CD20798
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4D4gcl5tfLzKd2;
	Mon, 28 Dec 2020 22:58:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1609214296;
	bh=UszUQscOMmG0xzoM3S8RinhHvXa0tRhH5/gc7J3ERCs=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0xGG8YulmU2XX9MUsCM3mhGMCXoD3I4kBJncGipq5ixur/Janz3SL76KOROECIwz9
	 sAwR4BN/qsX4BcFNATZhlNUivunacyZWwABCZBzm93TRIYuLDrvbY4SGHfJd3jjhnm
	 yY8fh5fVqejk8rOAmjgVGnkAyTmVBWcL+lVr1y7cRKWRCeInzL3xr/Xv23+LM8HxCV
	 0sEZ1FOwK++i5e+AelWQ7M5GmenrMcFlnZJAs6pnnuB1f2OaaY7/pFRjU8WPVo2T4q
	 czPzEttzmCiTyHjXID3KFVJWQquBMIZzS5oKREsruRgPCMpbnGw8ytVZ/JW2vh2BiO
	 /wzhZ5A/P2sVg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4D4gcj4FbqzKd1
 for <lttng-dev@lists.lttng.org>; Mon, 28 Dec 2020 22:58:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3715A2E02F3
 for <lttng-dev@lists.lttng.org>; Mon, 28 Dec 2020 22:58:07 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 2zW8icRI-b8P; Mon, 28 Dec 2020 22:58:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 258EB2E05DC;
 Mon, 28 Dec 2020 22:58:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 258EB2E05DC
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id wSYLaSywmfu1; Mon, 28 Dec 2020 22:58:06 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 1863D2E072A;
 Mon, 28 Dec 2020 22:58:06 -0500 (EST)
Date: Mon, 28 Dec 2020 22:58:05 -0500 (EST)
To: Serica <serica_law@qq.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1510592650.3765.1609214285939.JavaMail.zimbra@efficios.com>
In-Reply-To: <tencent_13C276218B5808AF7848BFEF00E8B4AB3A05@qq.com>
References: <tencent_13C276218B5808AF7848BFEF00E8B4AB3A05@qq.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3991 (ZimbraWebClient - FF84 (Linux)/8.8.15_GA_3980)
Thread-Topic: Enamebling namespace contexts
Thread-Index: q91XTC3iMExwyM3NOkenFiF34qn11A==
Subject: Re: [lttng-dev] Enamebling namespace contexts
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
Content-Type: multipart/mixed; boundary="===============2284540646327306558=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2284540646327306558==
Content-Type: multipart/alternative; 
	boundary="=_05882436-b249-4b0f-aafd-2dfb2a2c83d0"

--=_05882436-b249-4b0f-aafd-2dfb2a2c83d0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Dec 23, 2020, at 9:55 PM, lttng-dev <lttng-dev@lists.lttng.org> wrote: 

> Hi,

> ThI found that lttng is working on container awareness in this slides:
> https://archive.fosdem.org/2019/schedule/event/containers_lttng/attachments/slides/3419/export/events/attachments/containers_lttng/slides/3419/lttng_containers_fosdem19.pdf

> On page #13, there is a command: lttng add-context -k -t procname -t pid -t vpid
> -t tid -t vtid -t pid_ns, where pid_ns and other namespace identifiers are very
> useful for tracing containers. However, it seems like that lttng of current
> version doesn't support adding context pid_ns(Error: Unknown context type
> pid_ns). Do you know how to enable these features?

What version of LTTng do you use (output of "lttng --version"), and what is the output of "lttng add-context --list" ? 

Thanks, 

Mathieu 

> Thanks a lot.
> Btw, have a nice holiday!

> Serica

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_05882436-b249-4b0f-aafd-2dfb2a2c83d0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Dec 23, 2020, at 9:55 PM, lttng-dev &lt;lttng-dev@lists.lttng.=
org&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div><div>Hi,</div><br>=
<div>ThI found that lttng is working on container awareness in this slides:=
 https://archive.fosdem.org/2019/schedule/event/containers_lttng/attachment=
s/slides/3419/export/events/attachments/containers_lttng/slides/3419/lttng_=
containers_fosdem19.pdf</div><br><div>On page #13, there is a command:&nbsp=
; lttng add-context -k -t procname -t pid -t vpid -t tid -t vtid -t pid_ns,=
 where pid_ns and other namespace identifiers are very useful for tracing c=
ontainers. However, it seems like that lttng of current version doesn't sup=
port adding context pid_ns(Error: Unknown context type pid_ns). Do you know=
 how to enable these features?</div></div></blockquote><div>What version of=
 LTTng do you use (output of "lttng --version"), and what is the output of =
"lttng add-context --list" ?<br></div><div><br data-mce-bogus=3D"1"></div><=
div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></d=
iv><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left=
:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:=
normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,s=
ans-serif;font-size:12pt;"><div><br><div>Thanks a lot.</div><div>Btw, have =
a nice holiday!</div><br><div>Serica</div></div><br>_______________________=
________________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng=
.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blo=
ckquote></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></div=
><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></=
div></body></html>
--=_05882436-b249-4b0f-aafd-2dfb2a2c83d0--

--===============2284540646327306558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2284540646327306558==--
