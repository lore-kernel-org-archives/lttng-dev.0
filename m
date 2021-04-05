Return-Path: <SRS0=Pen4=JC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0701CC433B4
	for <lttng-dev@archiver.kernel.org>; Mon,  5 Apr 2021 18:09:57 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0191A61359
	for <lttng-dev@archiver.kernel.org>; Mon,  5 Apr 2021 18:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0191A61359
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FDdwc6r0Vz12mh;
	Mon,  5 Apr 2021 14:09:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617646193;
	bh=NZpHuFD+lAOx/Pd+w/sObWOKOtJNw03KQ8WjaRfhm/0=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ESpuwMG/wFrTiJKO8E3HanWVBh6M1DjBdbbaNi4UDvZpwsl9S3Wm+jkPsOAFovPm7
	 qpRQmiQJK/3WHCFM6t5/g8/glpGoTkYbZ6HhDldQAcXwcvfzWbi/uTZrZjwdmGt5a3
	 sZG7A+8/fJ0XwDwhPYhsFicOCRA4vSdSAmszUz4VwkduwjqgPey1dY40so74PD46/2
	 Y64i2JHQeIu33Rb56mRopmB/Qit9iQiFQrd0biIpPEMsADChO1gfOqlhG/LwDz6h3A
	 Z6HkYoDrhnmWELCHu+N7myZadtb5VuOBXdXYV6EaHgFI5fPd+2UQ4VGTC4zC2Nq6ex
	 wy27iMDylejWA==
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by lists.lttng.org (Postfix) with ESMTPS id 4FDdwb1vwPz12KW
 for <lttng-dev@lists.lttng.org>; Mon,  5 Apr 2021 14:09:51 -0400 (EDT)
Received: by mail-oi1-x22b.google.com with SMTP id d12so12415231oiw.12
 for <lttng-dev@lists.lttng.org>; Mon, 05 Apr 2021 11:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=xpmMNutDXBuEGLRUouab62ePpALLxFQTnBlEk4YZolI=;
 b=XRlwrh3KNrlP4c0F5eoM/sliW2eGhfUTPfxE4tk8cceafHcmyIGzejnVvKEeMm4HdM
 UqskKfiZCwpWxeH6wxFF+YXHt4OiVxuZZEeEKpzui4j6gQS0yXKBSUlzkXYewWQMZ2hv
 IfxUxME0BOyaVuJxqBn3sjOoDfm5r6y2WGLmdkqY8Jw1tYEnO49b6aGf9n/fYLp4lmnB
 U05QfYusVv2+TRTCWqUYFSvu1pTSd0f0onT7Mc+kCrZZxAo8UlbVdtuiNVhCh9IJZpag
 3HfKG7Xm1yoPtkpYaYfxi35VZXNThF3SqXWyBh/0XbfxDacVqkmTXr0+fzZpJyWI7hKv
 qrUg==
X-Gm-Message-State: AOAM5325Xl6CqzOd5UWPYFWuzgMYuC1p8Sm3i/+IvvjLUfn5dkwL1fzh
 E3DbvNfm2qzAopW9XkR7Nv4BgXWe5qNGgDwVQLp+yt11gqA=
X-Google-Smtp-Source: ABdhPJxSPXkBzvi++k4fwN8lpEWqj6NK9718R4cPVkXro/lN6djp0ce26VmMlsyuAe9QWkjal3TNWJb+KQQVkghwYzI=
X-Received: by 2002:aca:1a19:: with SMTP id a25mr235328oia.167.1617646190104; 
 Mon, 05 Apr 2021 11:09:50 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 5 Apr 2021 11:09:39 -0700
Message-ID: <CAPj=WkgS6XxzCazt4gWOiebas+BJ3fxSz-KRyXUpDQRLovM-NA@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] Userspace tracing in docker containers
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
From: Eqbal via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Eqbal <eqbalzee@gmail.com>
Content-Type: multipart/mixed; boundary="===============2594605068720748575=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2594605068720748575==
Content-Type: multipart/alternative; boundary="00000000000088930f05bf3d9ad3"

--00000000000088930f05bf3d9ad3
Content-Type: text/plain; charset="UTF-8"

Hi,

I am trying to get user space tracing working for an application running in
a docker container. I am running lttng session daemon in another container.
I mounted the unix socket locations (either /var/run/lttng for root or
$HOME/.lttng for another user). By doing that I can run commands like lttng
create or lttng list <session-name>, but the tracepoint events from the
application don't get registered and there is no trace output.

I enabled LTTNG_UST_DEBUG an ran lttng-sessiond in verbose mode (-vvv and
--verbose-consumer) and got the following error message:

"*Unix socket credential pid=0. Refusing application in distinct,
non-nested pid namespace.*"

It appears that for some calls to the session daemon there is a getsockopt
syscall made with *SO_PEERCRED* which returns 0 for pid and the call is
failed with *LTTNG_UST_ERR_PEERCRED_PID* error (see get_cred call in
ustctl.c).

If I comment out the getsockopt call, my application tracing starts to work.

From what I found, docker cannot support getsockopt/SO_PEERCRED call to get
peer pid on the unix socket which would make sense as it's in a separate
namespace.

I have a few questions on this:
1. What is the reason for the get_cred/getsockopt call with SO_PEERCRED? I
would like to understand why it's required for some and not other calls.
2. Is there any workaround for this problem, so that I can get this to work
with the container topology I am working with (app in one container and
lttng daemons in another).
3. Related to 2, are there any gotchas to bypassing the getsockopt call in
get_cred?

Appreciate your help regarding this.

Thanks,
Eqbal

--00000000000088930f05bf3d9ad3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I am trying to get user =
space tracing working for an application running in a docker container. I a=
m running lttng session daemon in another container. I mounted the unix soc=
ket locations (either /var/run/lttng for root or $HOME/.lttng for another u=
ser). By doing that I can run commands like lttng create or lttng list &lt;=
session-name&gt;, but the tracepoint events from the application don&#39;t =
get registered and there is no trace output.</div><div><br></div><div>I ena=
bled LTTNG_UST_DEBUG an ran lttng-sessiond in verbose mode (-vvv and --verb=
ose-consumer) and got the following error message:</div><div><br></div><div=
>&quot;<span style=3D"color:rgb(206,145,120)"><i><span style=3D"color:rgb(0=
,0,0)">Unix socket credential pid=3D0. Refusing application in distinct, no=
n-nested pid namespace.</span></i>&quot;</span></div><div><span style=3D"co=
lor:rgb(206,145,120)"><br></span></div><div><span style=3D"color:rgb(0,0,0)=
">It appears that for some calls to the session daemon there is a getsockop=
t syscall made with <i>SO_PEERCRED</i> which returns 0 for pid and the call=
 is failed with</span><span style=3D"color:rgb(79,193,255)"> <b><span style=
=3D"color:rgb(0,0,0)">LTTNG_UST_ERR_PEERCRED_PID</span></b> <span style=3D"=
color:rgb(0,0,0)">error (see get_cred call in ustctl.c).</span></span></div=
><div><br></div><div>If I comment out the getsockopt call, my application t=
racing starts to work.</div><div><br></div><div>From what I found, docker c=
annot support getsockopt/SO_PEERCRED call to get peer pid on the unix socke=
t which would make sense as it&#39;s in a separate namespace.</div><div><br=
></div><div>I have a few questions on this:</div><div>1. What is the reason=
 for the get_cred/getsockopt call with SO_PEERCRED? I would like to underst=
and why it&#39;s required for some and not other calls.</div><div>2. Is the=
re any workaround for this problem, so that I can get this to work with the=
 container topology I am working with (app in one container and lttng daemo=
ns in another).</div><div>3. Related to 2, are there any gotchas to bypassi=
ng the getsockopt call in get_cred?</div><div><br></div><div>Appreciate you=
r help regarding this.</div><div><br></div><div>Thanks,</div><div>Eqbal<br>=
</div><div><span style=3D"color:rgb(79,193,255)"><span style=3D"color:rgb(0=
,0,0)"></span></span><span style=3D"color:rgb(206,145,120)"></span></div></=
div>

--00000000000088930f05bf3d9ad3--

--===============2594605068720748575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2594605068720748575==--
