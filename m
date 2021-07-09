Return-Path: <SRS0=UBvy=MB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84765C07E99
	for <lttng-dev@archiver.kernel.org>; Fri,  9 Jul 2021 13:54:58 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DE761208
	for <lttng-dev@archiver.kernel.org>; Fri,  9 Jul 2021 13:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DE761208
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4GLvmS24Dnz109K;
	Fri,  9 Jul 2021 09:54:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1625838888;
	bh=0BT5jG+1tdspB6TMK/A+U+vZg5+xUPSQkc8xEHamcMA=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=BVrWMZ5w1XEnXx0wwkfidDEtAEVC0CYdpdRd7RwsOoGzKhZkBgQt5qPOWcXTaDpxG
	 eAxOhNzt/H8G2sjqf+gvVSGhh7Xh7Z8/yVTomM6D3mNKIOK5AWIA2Cm70Mn4VRZ23j
	 IMOKTrbJidnW8lroSDZjw/dqWgBJDoDmZqQzWpGuVqhqfD9hK20Yx/pyjp6W8C6yvF
	 bJnjvPVLzYrGU/8mV4ipDGfGFZg1X370GXB7K3zw/85hDEsZeVvC+DmRPL+3KTGQVq
	 Z8oO6Xet213yHSY5Wf07SOiPBqF20rjh3PlWj/t89+3KPXM3g0JAkbrODzTDJHV1pz
	 dC1g3CUqlPEnA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4GLvmQ18dqzynh
 for <lttng-dev@lists.lttng.org>; Fri,  9 Jul 2021 09:54:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9E767356217
 for <lttng-dev@lists.lttng.org>; Fri,  9 Jul 2021 09:54:39 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id igwON3Q_8l9s; Fri,  9 Jul 2021 09:54:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 83ED0356120;
 Fri,  9 Jul 2021 09:54:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 83ED0356120
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id wG6BSgoCbVDK; Fri,  9 Jul 2021 09:54:35 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 752A835611F;
 Fri,  9 Jul 2021 09:54:35 -0400 (EDT)
Date: Fri, 9 Jul 2021 09:54:35 -0400 (EDT)
To: Evan Galea <evanjamesgalea@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <482770069.11167.1625838875359.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAA+-46q3vLWvu6WNueSybHZ-7hE=S=eZo1WWXDDq7YOa7hyjWg@mail.gmail.com>
References: <CAA+-46q3vLWvu6WNueSybHZ-7hE=S=eZo1WWXDDq7YOa7hyjWg@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4059 (ZimbraWebClient - FF89 (Linux)/8.8.15_GA_4059)
Thread-Topic: unable to add callstack-user context
Thread-Index: bXYt4q9lOk763sg3WhWl7pl6z9aQ4A==
Subject: Re: [lttng-dev] unable to add callstack-user context
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
Content-Type: multipart/mixed; boundary="===============3351437464262535608=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3351437464262535608==
Content-Type: multipart/alternative; 
	boundary="=_89a983c4-4b9e-4d49-9361-0d8a51d67f4b"

--=_89a983c4-4b9e-4d49-9361-0d8a51d67f4b
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jul 9, 2021, at 4:30 AM, lttng-dev <lttng-dev@lists.lttng.org> wrote: 

> Hi there, I'm a little new to lttng and tracing in general. I am using a Java
> Userspace agent, which is working well, but I am having trouble adding
> callstack context to my tracing channels. I'm not sure if it's relevant but
> running 'lttng add-context --list" shows callstack-user in the list.

It's not surprising, because the callstack-user context is specific to the kernel tracer. 

> the commands I input are:

> lttng create
> lttng enable-channel --userspace mychannel
> lttng enable-event --userspace --all --channel mychannel
> lttng add-context --userspace --channel mychannel --type callstack-user
> >Error: callstack-user: UST invalid context

This is expected. 

> When I run the following command instead:
> lttng add-context --userspace --channel mychannel --type vpid

> I am able to get it to work and I see vpid appear in my traces. Are there any
> other things I need to set up first to be able to use it?

> also, are there any commands that can list the per-domain contexts available?

Not currently, though I think it would make sense to make "lttng add-context --list" allow a tracing domain 
(e.g. --kernel/--userspace) to be specified as a future improvement. 

Some information about this is available in the lttng-add-context(1) man page, but the fact that the 
kernel and user callstack contexts are only supported by the kernel tracer don't seem to be mentioned. 

Thanks, 

Mathieu 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_89a983c4-4b9e-4d49-9361-0d8a51d67f4b
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Jul 9, 2021, at 4:30 AM, lttng-dev &lt;lttng-dev@lists.lttng.o=
rg&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockqu=
ote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px=
;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-=
family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div di=
r=3D"ltr"><div>Hi there, I'm a little new to lttng and tracing in general. =
I am using a Java Userspace agent, which is working well, but I am having t=
rouble adding callstack context to my tracing channels. I'm not sure if it'=
s relevant but running 'lttng add-context --list" shows callstack-user in t=
he list.</div></div></div></blockquote><div><br></div><div>It's not surpris=
ing, because the callstack-user context is specific to the kernel tracer.<b=
r data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquot=
e style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;c=
olor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fa=
mily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div dir=
=3D"ltr"><br><div>the commands I input are:<br></div><br><div>lttng create =
<br></div><div>lttng enable-channel --userspace mychannel</div><div>lttng e=
nable-event --userspace --all --channel mychannel<br></div><div>lttng add-c=
ontext --userspace --channel mychannel --type callstack-user</div><div>&gt;=
Error: callstack-user: UST invalid context</div></div></div></blockquote><d=
iv><br></div><div>This is expected.<br data-mce-bogus=3D"1"></div><div><br =
data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010=
FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-styl=
e:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-s=
ize:12pt;"><div dir=3D"ltr"><div dir=3D"ltr"><br><div>When I run the follow=
ing command instead:<br></div><div>lttng add-context --userspace --channel =
mychannel --type vpid</div><br><div>I am able to get it to work and I see v=
pid appear in my traces. Are there any other things I need to set up first =
to be able to use it?</div><br><div>also, are there any commands that can l=
ist the per-domain contexts available?</div></div></div></blockquote><div><=
br></div><div>Not currently, though I think it would make sense to make "lt=
tng add-context --list" allow a tracing domain<br data-mce-bogus=3D"1"></di=
v><div>(e.g. --kernel/--userspace) to be specified as a future improvement.=
<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Som=
e information about this is available in the lttng-add-context(1) man page,=
 but the fact that the<br data-mce-bogus=3D"1"></div><div>kernel and user c=
allstack contexts are only supported by the kernel tracer don't seem to be =
mentioned.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></di=
v><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1">=
</div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D=
"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5p=
x;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-dec=
oration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div d=
ir=3D"ltr"><div dir=3D"ltr"><div><br></div></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_89a983c4-4b9e-4d49-9361-0d8a51d67f4b--

--===============3351437464262535608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3351437464262535608==--
