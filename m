Return-Path: <SRS0=qlDs=L7=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A19C07E95
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Jul 2021 13:46:29 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13D561C89
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Jul 2021 13:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13D561C89
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4GKggX72crzSwC;
	Wed,  7 Jul 2021 09:46:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1625665577;
	bh=yPUP0o8HBbUJnZAVTaMEQT0LTg+tS8J0TgQQnJa8L8s=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SDKeS1wAZVCy6KU7VjC2NOr6CCFcU8P0/6V4XRy02dlEwaY1XFuOhniPFbYGVc+Tp
	 vb+dAr7MfnjbJhqBBKD10FRJtFE6UmopBVsz2JVKoT6HRlVeMP+Dj+bSS0ALwMr8oA
	 EtOPYFLws1M5IgQWS/ircx49fheWTKfDzRdY1hLKexYGo+5lgEPUiDzFz5htnxCPIr
	 3RAhx/RYEvpv1ct3IyWjaEs52/rk0sosXbGPrvn1qkfvGMvbpNGvF31OwL1XgOt2Ih
	 WLyxmWOWxKucEc7ZxU8CgveqrCW0SYXVjQpbaOjmL/HIRDj4Fm/Po3YNh7ulDfw3Tl
	 DkZAOt3GUzvrw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4GKggW3ZpSzSw9
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jul 2021 09:46:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C12B234B921
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jul 2021 09:46:09 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id rVMSW_kqVosq; Wed,  7 Jul 2021 09:46:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C984634B919;
 Wed,  7 Jul 2021 09:46:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C984634B919
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id F8K6QoVRgrj4; Wed,  7 Jul 2021 09:46:05 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id B868F34B37C;
 Wed,  7 Jul 2021 09:46:05 -0400 (EDT)
Date: Wed, 7 Jul 2021 09:46:05 -0400 (EDT)
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1613735014.8733.1625665565618.JavaMail.zimbra@efficios.com>
In-Reply-To: <a286a436-454c-4aa1-b184-cccd0825370e.zhenyu.ren@aliyun.com>
References: <a286a436-454c-4aa1-b184-cccd0825370e.zhenyu.ren@aliyun.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4059 (ZimbraWebClient - FF89 (Linux)/8.8.15_GA_4059)
Thread-Topic: what will happen during tracing if getcpu() doesn't return
 correct cpu number occasionally?
Thread-Index: mHanKvsgQlE1eBDaRSpDFE0iDxnlXw==
Subject: Re: [lttng-dev] what will happen during tracing if getcpu() doesn't
 return correct cpu number occasionally?
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
Content-Type: multipart/mixed; boundary="===============2187317392108577367=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2187317392108577367==
Content-Type: multipart/alternative; 
	boundary="=_88cef2e3-38e0-4c6a-ab13-a3b4d08e9f3c"

--=_88cef2e3-38e0-4c6a-ab13-a3b4d08e9f3c
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jul 6, 2021, at 10:37 PM, lttng-dev <lttng-dev@lists.lttng.org> wrote: 

> Hi,
> I know lttng-ust tracepoint process uses per cpu lockless ringbuffer algorithm
> for high performance so that it relies on getcpu() to return the cpu number on
> which the app is running.
> Unfortunately, I am working on arm that linux kernel does not support vdso
> getcpu() implemention and one getcpu() will take 200ns!!!
> My question is :
> 1. do you have any advice for that?

You might want to try wiring up the "rseq" system call in user-space to provide an accurate cpu_id 
field in a __rseq_abi TLS variable. It is always kept up to date by the kernel. The rseq system call 
is implemented on ARM. However the __rseq_abi TLS is a shared resource across libraries, and 
we have not agreed with glibc people on how exactly it must be shared within a process. 

> 2. If I implement a cache-version for getcpu()(just like getcpu() implemention
> before kernel 2.6.23 ), what will happen during tracing process?

You'd have to give more details on how this "cache-version" works. 

> Since use of the cache could speed getcpu() calls, at the cost that there was a
> very small chance that the returned cpu number would be out of date, I am not
> sure whether the "wrong" cpu number will result in the tracing app crashing?

LTTng-UST always has to expect that it can be migrated at any point between getcpu and writes to 
per-cpu data. Therefore, it always relies on atomic operations when interacting with the ring buffer, 
and there is no expectation that it runs on the "right" CPU compared to the ring buffer data structure 
for consistency. Therefore, you won't experience crashes nor corruption even if the CPU number is 
wrong once in a while, as long as it belongs to the "possible CPUs". 

This behavior is selected by lttng's libringbuffer "RING_BUFFER_SYNC_GLOBAL" configuration 
option internally, as selected by lttng-ust. 

Note that the kernel tracer instead selects "RING_BUFFER_SYNC_PER_CPU", which is faster, but 
requires that preemption (or migration) be disabled between the "smp_processor_id()" and writes to 
the ring buffer per-cpu data structures. 

Thanks, 

Mathieu 

> Thanks
> zhenyu.ren

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_88cef2e3-38e0-4c6a-ab13-a3b4d08e9f3c
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br data-mce-bogus=3D"1"></div><span id=3D"=
zwchr" data-marker=3D"__DIVIDER__">----- On Jul 6, 2021, at 10:37 PM, lttng=
-dev &lt;lttng-dev@lists.lttng.org&gt; wrote:<br></span><div data-marker=3D=
"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;=
"><div class=3D"__aliyun_email_body_block"><div><span style=3D"font-family:=
'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">Hi,=
&nbsp;</span></div><div><span style=3D"font-family:'tahoma' , 'arial' , 'st=
heiti' , 'simsun';font-size:14px;color:#000000">&nbsp; &nbsp;I know lttng-u=
st tracepoint process uses per cpu lockless ringbuffer algorithm&nbsp;for h=
igh performance so that it relies on getcpu() to return the cpu number on w=
hich the app is running.</span></div><div><span style=3D"font-family:'tahom=
a' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">&nbsp; &n=
bsp;Unfortunately,&nbsp;I&nbsp;am&nbsp;working&nbsp;on arm that linux kerne=
l does&nbsp;not&nbsp;support&nbsp;vdso getcpu() implemention and one getcpu=
() will take 200ns!!!</span></div><div><span style=3D"font-family:'tahoma' =
, 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">&nbsp; &nbsp=
;My question is :</span></div><div><span style=3D"font-family:'tahoma' , 'a=
rial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">&nbsp; &nbsp;1. =
do you have any advice for that?</span></div></div></blockquote><div><br></=
div><div>You might want to try wiring up the "rseq" system call in user-spa=
ce to provide an accurate cpu_id<br data-mce-bogus=3D"1"></div><div>field i=
n a __rseq_abi TLS variable. It is always kept up to date by the kernel. Th=
e rseq system call<br data-mce-bogus=3D"1"></div><div>is implemented on ARM=
. However the __rseq_abi TLS is a shared resource across libraries, and<br =
data-mce-bogus=3D"1"></div><div>we have not agreed with glibc people on how=
 exactly it must be shared within a process.<br data-mce-bogus=3D"1"></div>=
<div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px so=
lid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;=
font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-ser=
if;font-size:12pt;"><div class=3D"__aliyun_email_body_block"><div><span sty=
le=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;=
color:#000000">&nbsp; &nbsp;2. If I implement a cache-version for getcpu()(=
just like getcpu() implemention before kernel 2.6.23 ), what will happen du=
ring tracing process?&nbsp; </span></div></div></blockquote><div>You'd have=
 to give more details on how this "cache-version" works.</div><div><br data=
-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;m=
argin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:no=
rmal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:=
12pt;"><div class=3D"__aliyun_email_body_block"><div><span style=3D"font-fa=
mily:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000=
">&nbsp; &nbsp; &nbsp; Since use&nbsp;of&nbsp;the&nbsp;cache&nbsp;could&nbs=
p;speed&nbsp;getcpu()&nbsp;calls,&nbsp;at&nbsp;the&nbsp;cost&nbsp;that&nbsp=
;there&nbsp;was&nbsp;a&nbsp;very&nbsp;small&nbsp;chance&nbsp;that&nbsp;the&=
nbsp;returned cpu number would&nbsp;be&nbsp;out&nbsp;of&nbsp;date, I am not=
 sure whether the "wrong" cpu number will result in the tracing app crashin=
g?</span></div></div></blockquote><div><br></div><div>LTTng-UST always has =
to expect that it can be migrated at any point between getcpu and writes to=
<br data-mce-bogus=3D"1"></div><div>per-cpu data. Therefore, it always reli=
es on atomic operations when interacting with the ring buffer,<br data-mce-=
bogus=3D"1"></div><div>and there is no expectation that it runs on the "rig=
ht" CPU compared to the ring buffer data structure<br data-mce-bogus=3D"1">=
</div><div>for consistency. Therefore, you won't experience crashes nor cor=
ruption even if the CPU number is</div><div>wrong once in a while, as long =
as it belongs to the "possible CPUs".<br data-mce-bogus=3D"1"></div><div><b=
r data-mce-bogus=3D"1"></div><div>This behavior is selected by lttng's libr=
ingbuffer "RING_BUFFER_SYNC_GLOBAL" configuration<br data-mce-bogus=3D"1"><=
/div><div>option internally, as selected by lttng-ust.<br data-mce-bogus=3D=
"1"></div><div><br data-mce-bogus=3D"1"></div><div>Note that the kernel tra=
cer instead selects "RING_BUFFER_SYNC_PER_CPU", which is faster, but<br dat=
a-mce-bogus=3D"1"></div><div>requires that preemption (or migration) be dis=
abled between the "smp_processor_id()" and writes to</div><div>the ring buf=
fer per-cpu data structures.<br data-mce-bogus=3D"1"></div><div><br data-mc=
e-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br dat=
a-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br=
 data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote=
 style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;co=
lor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fam=
ily:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=3D"__aliyun_emai=
l_body_block"><div><span style=3D"font-family:'tahoma' , 'arial' , 'stheiti=
' , 'simsun';font-size:14px;color:#000000"><br></span></div><div><span styl=
e=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;c=
olor:#000000">Thanks</span></div><div><span style=3D"font-family:'tahoma' ,=
 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">zhenyu.ren</s=
pan></div></div><br>_______________________________________________<br>lttn=
g-dev mailing list<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/=
cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><br><div data-mark=
er=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br=
>http://www.efficios.com</div></div></body></html>
--=_88cef2e3-38e0-4c6a-ab13-a3b4d08e9f3c--

--===============2187317392108577367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2187317392108577367==--
