Return-Path: <SRS0=Pen4=JC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DDFC433B4
	for <lttng-dev@archiver.kernel.org>; Mon,  5 Apr 2021 18:36:30 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA6E610A7
	for <lttng-dev@archiver.kernel.org>; Mon,  5 Apr 2021 18:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA6E610A7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FDfWJ3sWmz12fs;
	Mon,  5 Apr 2021 14:36:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617647789;
	bh=b0PogeJe2seBt88XeZbfo10ilapRBmqBwX8wyF/5Vb8=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ajsGq7jRm73zdxj351rJsUsfo63UJiehiiLel7uMDpfr/ztE8rFz/R5H/ko1pG0jR
	 hWapB3fGzq5ihfYRHlrLcQUFXxbeEXKvH1DO5NoLKOJgysiuO6vlC7l7K47UbBuqqP
	 e8mbwgs5+aRkRMSodb1pUlEpS+L8G577pP4TBFLviFqrqJ09zVULCx9AyLmnROv0FP
	 8thWy3rhYhHkZeuZvjcS/q8lj5c5AJPN9dL6FmxoOF7BcZqFdg57uHYHPPznzt7Evb
	 xpCLN23hNrsU203xwkDi/Retn9LfYskLrK641opw8gCFvZil/tSlDWa5NF/Brs0dmr
	 T3gXbTSWHB+ng==
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by lists.lttng.org (Postfix) with ESMTPS id 4FDfWH5FWFz12Vs
 for <lttng-dev@lists.lttng.org>; Mon,  5 Apr 2021 14:36:27 -0400 (EDT)
Received: by mail-oi1-x234.google.com with SMTP id c16so12517121oib.3
 for <lttng-dev@lists.lttng.org>; Mon, 05 Apr 2021 11:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=mEJEhz5FevcKrmW58y2YzC0X3wwG8Fr4cRNKQUSdN8E=;
 b=b8NU47t8d3daOhNLk+LWCxRi+ZW8Gesh11vSbBkCgC99nk158oODhQj+IPZbxly5uK
 b+sdYQbkRL5C9nYZDGal9DxWYrXFb0zsbI/HeyQ803cn2AmpQXGxLKLhHqOBtTTqbH6p
 z6+orkuEsViFWnyU+jnK3s7f8uDLvY7tG++Q+AIIVxp+4+TkV9r8bsgY62u13wtqxW/0
 k728/LRgM+IHxlg/YpOm7jLsLD03m45W3RIkl61t3QDCJc44XKnqmk/+m50sMLBwjudJ
 Gqfj62iLsOjYbJs1X3QFogSK6kLYiGAJ666vQLqc4huRNRT0/dq8hnzpPA0tYwmVl63i
 9LJg==
X-Gm-Message-State: AOAM533kIws0uFJkqydZ8kZZ/6/fkyhWizb8RTQ44CNZoBLdjqGpORXI
 /4du77S4DZBPDN1TkMLw4kOBWeHOrRqVWAuUHvcGakSAjp4=
X-Google-Smtp-Source: ABdhPJwGrIAYsNX4fXxOmcyCw/3Lkp2rMbhgZVE6T/Q1vs7I299+ERsWbiZiBXsKeZb4cej7gL+tMj8JWq+lLHk7q+E=
X-Received: by 2002:aca:1a19:: with SMTP id a25mr308261oia.167.1617647786688; 
 Mon, 05 Apr 2021 11:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAPj=WkgS6XxzCazt4gWOiebas+BJ3fxSz-KRyXUpDQRLovM-NA@mail.gmail.com>
In-Reply-To: <CAPj=WkgS6XxzCazt4gWOiebas+BJ3fxSz-KRyXUpDQRLovM-NA@mail.gmail.com>
Date: Mon, 5 Apr 2021 11:36:15 -0700
Message-ID: <CAPj=Wkg4AbcxsAnzXFOH2EbNzw52SdhFcJN2zSHZoNgLDfmkrA@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Userspace tracing in docker containers
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
Content-Type: multipart/mixed; boundary="===============0236658100803549835=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0236658100803549835==
Content-Type: multipart/alternative; boundary="000000000000b284c105bf3df9f3"

--000000000000b284c105bf3df9f3
Content-Type: text/plain; charset="UTF-8"

>If I comment out the getsockopt call, my application tracing starts to
work.

Correction on the above, I meant I comment out the check for pid being
non-zero in the get_cred call, not the whole getsockopt call.

diff --git a/liblttng-ust-ctl/ustctl.c b/liblttng-ust-ctl/ustctl.c
index 39860ebf..96aeef3c 100644
--- a/liblttng-ust-ctl/ustctl.c
+++ b/liblttng-ust-ctl/ustctl.c
@@ -1825,10 +1825,10 @@ int get_cred(int sock,
                "application registered claiming [ pid: %u, ppid: %u, uid:
%u, gid: %u ]",
                ucred.pid, ucred.uid, ucred.gid,
                reg_msg->pid, reg_msg->ppid, reg_msg->uid, reg_msg->gid);
-       if (!ucred.pid) {
-               ERR("Unix socket credential pid=0. Refusing application in
distinct, non-nested pid namespace.");
-               return -LTTNG_UST_ERR_PEERCRED_PID;
-       }
+       // if (!ucred.pid) {
+       //      ERR("Unix socket credential pid=0. Refusing application in
distinct, non-nested pid namespace.");
+       //      return -LTTNG_UST_ERR_PEERCRED_PID;
+       // }
        *pid = ucred.pid;
        *uid = ucred.uid;
        *gid = ucred.gid;

On Mon, Apr 5, 2021 at 11:09 AM Eqbal <eqbalzee@gmail.com> wrote:

> Hi,
>
> I am trying to get user space tracing working for an application running
> in a docker container. I am running lttng session daemon in another
> container. I mounted the unix socket locations (either /var/run/lttng for
> root or $HOME/.lttng for another user). By doing that I can run commands
> like lttng create or lttng list <session-name>, but the tracepoint events
> from the application don't get registered and there is no trace output.
>
> I enabled LTTNG_UST_DEBUG an ran lttng-sessiond in verbose mode (-vvv and
> --verbose-consumer) and got the following error message:
>
> "*Unix socket credential pid=0. Refusing application in distinct,
> non-nested pid namespace.*"
>
> It appears that for some calls to the session daemon there is a getsockopt
> syscall made with *SO_PEERCRED* which returns 0 for pid and the call is
> failed with *LTTNG_UST_ERR_PEERCRED_PID* error (see get_cred call in
> ustctl.c).
>
> If I comment out the getsockopt call, my application tracing starts to
> work.
>
> From what I found, docker cannot support getsockopt/SO_PEERCRED call to
> get peer pid on the unix socket which would make sense as it's in a
> separate namespace.
>
> I have a few questions on this:
> 1. What is the reason for the get_cred/getsockopt call with SO_PEERCRED? I
> would like to understand why it's required for some and not other calls.
> 2. Is there any workaround for this problem, so that I can get this to
> work with the container topology I am working with (app in one container
> and lttng daemons in another).
> 3. Related to 2, are there any gotchas to bypassing the getsockopt call in
> get_cred?
>
> Appreciate your help regarding this.
>
> Thanks,
> Eqbal
>

--000000000000b284c105bf3df9f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;If I comment out the getsockopt call, my application t=
racing starts to work.<div><br></div><div>Correction on the above, I meant =
I comment out the check for pid being non-zero in the get_cred call, not th=
e whole getsockopt call.</div><div><br></div><div>diff --git a/liblttng-ust=
-ctl/ustctl.c b/liblttng-ust-ctl/ustctl.c<br>index 39860ebf..96aeef3c 10064=
4<br>--- a/liblttng-ust-ctl/ustctl.c<br>+++ b/liblttng-ust-ctl/ustctl.c<br>=
@@ -1825,10 +1825,10 @@ int get_cred(int sock,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;application registered claiming [ pid=
: %u, ppid: %u, uid: %u, gid: %u ]&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ucred.pid, ucred.uid, ucred.gid,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_msg-&gt;pid, reg_msg-&gt;=
ppid, reg_msg-&gt;uid, reg_msg-&gt;gid);<br>- =C2=A0 =C2=A0 =C2=A0 if (!ucr=
ed.pid) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;U=
nix socket credential pid=3D0. Refusing application in distinct, non-nested=
 pid namespace.&quot;);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -LTTNG_UST_ERR_PEERCRED_PID;<br>- =C2=A0 =C2=A0 =C2=A0 }<br>+ =
=C2=A0 =C2=A0 =C2=A0 // if (!ucred.pid) {<br>+ =C2=A0 =C2=A0 =C2=A0 // =C2=
=A0 =C2=A0 =C2=A0ERR(&quot;Unix socket credential pid=3D0. Refusing applica=
tion in distinct, non-nested pid namespace.&quot;);<br>+ =C2=A0 =C2=A0 =C2=
=A0 // =C2=A0 =C2=A0 =C2=A0return -LTTNG_UST_ERR_PEERCRED_PID;<br>+ =C2=A0 =
=C2=A0 =C2=A0 // }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 *pid =3D ucred.pid;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *uid =3D ucred.uid;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 *gid =3D ucred.gid;</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Apr 5, 2021 at 11:09 AM Eqbal &lt;<a =
href=3D"mailto:eqbalzee@gmail.com">eqbalzee@gmail.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>=
Hi,</div><div><br></div><div>I am trying to get user space tracing working =
for an application running in a docker container. I am running lttng sessio=
n daemon in another container. I mounted the unix socket locations (either =
/var/run/lttng for root or $HOME/.lttng for another user). By doing that I =
can run commands like lttng create or lttng list &lt;session-name&gt;, but =
the tracepoint events from the application don&#39;t get registered and the=
re is no trace output.</div><div><br></div><div>I enabled LTTNG_UST_DEBUG a=
n ran lttng-sessiond in verbose mode (-vvv and --verbose-consumer) and got =
the following error message:</div><div><br></div><div>&quot;<span style=3D"=
color:rgb(206,145,120)"><i><span style=3D"color:rgb(0,0,0)">Unix socket cre=
dential pid=3D0. Refusing application in distinct, non-nested pid namespace=
.</span></i>&quot;</span></div><div><span style=3D"color:rgb(206,145,120)">=
<br></span></div><div><span style=3D"color:rgb(0,0,0)">It appears that for =
some calls to the session daemon there is a getsockopt syscall made with <i=
>SO_PEERCRED</i> which returns 0 for pid and the call is failed with</span>=
<span style=3D"color:rgb(79,193,255)"> <b><span style=3D"color:rgb(0,0,0)">=
LTTNG_UST_ERR_PEERCRED_PID</span></b> <span style=3D"color:rgb(0,0,0)">erro=
r (see get_cred call in ustctl.c).</span></span></div><div><br></div><div>I=
f I comment out the getsockopt call, my application tracing starts to work.=
</div><div><br></div><div>From what I found, docker cannot support getsocko=
pt/SO_PEERCRED call to get peer pid on the unix socket which would make sen=
se as it&#39;s in a separate namespace.</div><div><br></div><div>I have a f=
ew questions on this:</div><div>1. What is the reason for the get_cred/gets=
ockopt call with SO_PEERCRED? I would like to understand why it&#39;s requi=
red for some and not other calls.</div><div>2. Is there any workaround for =
this problem, so that I can get this to work with the container topology I =
am working with (app in one container and lttng daemons in another).</div><=
div>3. Related to 2, are there any gotchas to bypassing the getsockopt call=
 in get_cred?</div><div><br></div><div>Appreciate your help regarding this.=
</div><div><br></div><div>Thanks,</div><div>Eqbal<br></div><div><span style=
=3D"color:rgb(79,193,255)"><span style=3D"color:rgb(0,0,0)"></span></span><=
span style=3D"color:rgb(206,145,120)"></span></div></div>
</blockquote></div>

--000000000000b284c105bf3df9f3--

--===============0236658100803549835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0236658100803549835==--
