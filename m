Return-Path: <SRS0=HzhM=J6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702A0C433ED
	for <lttng-dev@archiver.kernel.org>; Mon,  3 May 2021 23:45:23 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8893561183
	for <lttng-dev@archiver.kernel.org>; Mon,  3 May 2021 23:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8893561183
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FZ02m6YJBz1h83;
	Mon,  3 May 2021 19:45:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1620085521;
	bh=bUXHHSEsZWlLjU0PZwgs3Staq4Se75K0LcOA1+A/MUA=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CsLVnJ0xTrQEGuSdmo5qIk8eyGVLbjEl9MX+CYtuWiNfGz6P8ahwQj0n6WcQMh2Wo
	 Qj+FjDXV22pajaadKAq6RVwUGhgDwAcBEc0eTgtDC5G6yR0Qs6KxrEu3If7KHSD21b
	 RCGDhLm4mqC/i38RDepkH35S6PeaBCk62peCjZ6D8lB7iWMWZvJynAfYwFqH9CRd70
	 H+L79bQDQJ5MEhalWWPIreJ+LTEqMJd3VhvNGyFeMhXq2MZ5/+JAyrj7YZ/qBzGtwM
	 vkEv+Ka+tT6rTHMTlPhPN6QBh8cBOH4NiFahsQA8frUfF13VRMI1NVMK6NitVKqUww
	 0Sfk5Yd2Se3Vw==
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by lists.lttng.org (Postfix) with ESMTPS id 4FZ02l4zblz1grX
 for <lttng-dev@lists.lttng.org>; Mon,  3 May 2021 19:45:19 -0400 (EDT)
Received: by mail-oi1-x235.google.com with SMTP id k25so7099060oic.4
 for <lttng-dev@lists.lttng.org>; Mon, 03 May 2021 16:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tWVnFEudJHPRxpnEDSLirQMvwUgenca54wjY7B4uVSs=;
 b=WE7nnmDSi3LkTlaq3EVCgMjNLLfVky7OdFWD3SonMJDoHFcc7Pscjo5FoA3rKLrww/
 ca+4jKt7jXX5zmJYI+phJSg35a5SMf0yOmCpgy68JlAzQLrxgDKgfQbPj/qol3w7gsgY
 SttfiQZJcQMpuBq3w1mMbWqE435NBudDDMLmzMsLZe3JENoCG42ALKEDk1VBmDLKVZJw
 P/f7J7l7en33Okuw8vWUDza3xJfgHTT88El39wAYeTcaPX3LvoMcjZyI8pXCK6CxHFQx
 2h7PxjX//PNy1H0Dk8gHgfB7bH9l0PXXJt7RFRkqlq4LvsbHkOvWxLvasf5Ma1Ws3q9/
 9/EA==
X-Gm-Message-State: AOAM533izzLGwT5AnJXckPLZwMFQk2H5IYaa00SC9oYnueYa100ft/qS
 LgcoWg9MsmsnAQ7TcOZiH9BucbWoPr6xZetsA2A=
X-Google-Smtp-Source: ABdhPJykZxVomKpCzH5woEnZMBTzPQsR34GzLunnStfp5fpaKadnu3SaApPEmdVQVlklfr/kJU8KCXE+RuZODoFyDcQ=
X-Received: by 2002:a54:4812:: with SMTP id j18mr15792213oij.14.1620085518775; 
 Mon, 03 May 2021 16:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAPj=WkgS6XxzCazt4gWOiebas+BJ3fxSz-KRyXUpDQRLovM-NA@mail.gmail.com>
 <20210406140753.GE79283@joraj-alpa>
In-Reply-To: <20210406140753.GE79283@joraj-alpa>
Date: Mon, 3 May 2021 16:45:07 -0700
Message-ID: <CAPj=WkhE+DB3_mvtKeRPBPyZ2RHztoM5P2ZKYk8rhTzLQekwZg@mail.gmail.com>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
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
Content-Type: multipart/mixed; boundary="===============4715195462515793040=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4715195462515793040==
Content-Type: multipart/alternative; boundary="000000000000da3a9a05c1758d0c"

--000000000000da3a9a05c1758d0c
Content-Type: text/plain; charset="UTF-8"

Thanks for the responses. The reasoning makes sense. We have decided to run
lttng-sessiond on the host. Our trace generating application will run in a
container and so will our libbabeltrace based trace consumer app (using
live sessions).

On Tue, Apr 6, 2021 at 7:07 AM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
> On Mon, Apr 05, 2021 at 11:09:39AM -0700, Eqbal via lttng-dev wrote:
> > Hi,
> >
> > I am trying to get user space tracing working for an application running
> in
> > a docker container. I am running lttng session daemon in another
> container.
> > I mounted the unix socket locations (either /var/run/lttng for root or
> > $HOME/.lttng for another user). By doing that I can run commands like
> lttng
> > create or lttng list <session-name>, but the tracepoint events from the
> > application don't get registered and there is no trace output.
> >
> > I enabled LTTNG_UST_DEBUG an ran lttng-sessiond in verbose mode (-vvv and
> > --verbose-consumer) and got the following error message:
> >
> > "*Unix socket credential pid=0. Refusing application in distinct,
> > non-nested pid namespace.*"
> >
> > It appears that for some calls to the session daemon there is a
> getsockopt
> > syscall made with *SO_PEERCRED* which returns 0 for pid and the call is
> > failed with *LTTNG_UST_ERR_PEERCRED_PID* error (see get_cred call in
> > ustctl.c).
> >
> > If I comment out the getsockopt call, my application tracing starts to
> work.
> >
> > From what I found, docker cannot support getsockopt/SO_PEERCRED call to
> get
> > peer pid on the unix socket which would make sense as it's in a separate
> > namespace.
> >
> > I have a few questions on this:
> > 1. What is the reason for the get_cred/getsockopt call with SO_PEERCRED?
> I
> > would like to understand why it's required for some and not other calls.
>
>
> More information is found in the introducing commit:
>
>   commit a834901f2890deadb815d7f9e3ab79c3ba673994
>   Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   Date:   Mon Oct 12 16:52:03 2020 -0400
>
>     Fix: Use unix socket peercred for pid, uid, gid credentials
>
>     Currently, the session daemon trust the pid, ppid, uid, and gid values
>     passed by the application, but should really validate the uid using
> unix
>     socket peercred. This fix uses the peercred values rather than the
>     values provided by the application on registration for:
>
>     - pid, uid and gid on Linux,
>     - uid and gid on FreeBSD.
>
>     This should improve how the session daemon deals with containerized
>     applications on Linux as well. Applications are required to be either
> in
>     the same pid namespace, or in a pid namespace nested within the pid
>     namespace of the lttng-sessiond, so the session daemon can map the
>     application pid to something meaningful within its own pid namespace.
>     Applications in a unrelated (disjoint) pid namespace will be refused by
>     the session daemon.
>
>     About the uid and gid with user namespaces on Linux, those will provide
>     meaningful IDs if the application user namespace is either the same as
>     the user namespace of the session daemon, or a nested user namespace.
>     Otherwise, the IDs will be that of /proc/sys/kernel/overflowuid and
>     /proc/sys/kernel/overflowgid, which typically maps to nobody.nogroup on
>     current distributions.
>
>     Given that fetching the parent pid (ppid) of the application would
>     require to use /proc/<pid>/status (which is racy wrt pid reuse), expose
>     the ppid provided by the application on registration instead, but only
>     in situations where the application sits in the same pid namespace as
>     the session daemon (on Linux), which is detected by checking if the pid
>     provided by the application matches the pid obtained using unix socket
>     credentials. The ppid is only used for logging/debugging purposes in
> the
>     session daemon anyway, so it is OK to use the value provided by the
>     application for that purpose.
>
>     Fixes: #1286
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>     Change-Id: I94742e57dad642106908d09e2c7e395993c2c48f
>
> As for "why it's required for some and not other calls.", there is a
> difference
> between communicating with a lttng-sessiond daemon (using the lttng CLI)
> and
> userspace application registering. They are essentially two distinct
> communication interface. Now, to be honest, I'm not certain of the complete
> "security" policy for the lttng-sessiond <-> CLI interface and if we
> should be
> more strict or not.
>
> > 2. Is there any workaround for this problem, so that I can get this to
> work
> > with the container topology I am working with (app in one container and
> > lttng daemons in another).
>
> Based on the commit message, lttng-ust explicitly cannot be used across
> non-nested pid namespace.
>
> Could you give us more information on the goal for the topology you plan
> to use?
> This could lead to further discussion and/or alternative solution based on
> the
> goal and constraints of your deployment.
>
> > 3. Related to 2, are there any gotchas to bypassing the getsockopt call
> in
> > get_cred?
>
> Based on the content of the mentioned bug (1286) [1],  the principal
> concern is:
>
> "
> This means a non-root application could theoretically impersonate a root
> application from a tracing perspective, and thus access root tracing
> buffers in
> a per-uid configuration, which is unwanted.
> "
>
> [1] https://bugs.lttng.org/issues/1286
>
> Cheers
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--000000000000da3a9a05c1758d0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the responses. The reasoning makes sense. We ha=
ve decided to run lttng-sessiond on the host. Our trace generating applicat=
ion will run in a container and so will our libbabeltrace based trace consu=
mer app (using live sessions).<br></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 6, 2021 at 7:07 AM Jonathan R=
ajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">j=
onathan.rajotte-julien@efficios.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Mon, Apr 05, 2021 at 11:09:39AM -0700, Eqbal via lttng-dev wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I am trying to get user space tracing working for an application runni=
ng in<br>
&gt; a docker container. I am running lttng session daemon in another conta=
iner.<br>
&gt; I mounted the unix socket locations (either /var/run/lttng for root or=
<br>
&gt; $HOME/.lttng for another user). By doing that I can run commands like =
lttng<br>
&gt; create or lttng list &lt;session-name&gt;, but the tracepoint events f=
rom the<br>
&gt; application don&#39;t get registered and there is no trace output.<br>
&gt; <br>
&gt; I enabled LTTNG_UST_DEBUG an ran lttng-sessiond in verbose mode (-vvv =
and<br>
&gt; --verbose-consumer) and got the following error message:<br>
&gt; <br>
&gt; &quot;*Unix socket credential pid=3D0. Refusing application in distinc=
t,<br>
&gt; non-nested pid namespace.*&quot;<br>
&gt; <br>
&gt; It appears that for some calls to the session daemon there is a getsoc=
kopt<br>
&gt; syscall made with *SO_PEERCRED* which returns 0 for pid and the call i=
s<br>
&gt; failed with *LTTNG_UST_ERR_PEERCRED_PID* error (see get_cred call in<b=
r>
&gt; ustctl.c).<br>
&gt; <br>
&gt; If I comment out the getsockopt call, my application tracing starts to=
 work.<br>
&gt; <br>
&gt; From what I found, docker cannot support getsockopt/SO_PEERCRED call t=
o get<br>
&gt; peer pid on the unix socket which would make sense as it&#39;s in a se=
parate<br>
&gt; namespace.<br>
&gt; <br>
&gt; I have a few questions on this:<br>
&gt; 1. What is the reason for the get_cred/getsockopt call with SO_PEERCRE=
D? I<br>
&gt; would like to understand why it&#39;s required for some and not other =
calls.<br>
<br>
<br>
More information is found in the introducing commit:<br>
<br>
=C2=A0 commit a834901f2890deadb815d7f9e3ab79c3ba673994<br>
=C2=A0 Author: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>
=C2=A0 Date:=C2=A0 =C2=A0Mon Oct 12 16:52:03 2020 -0400<br>
<br>
=C2=A0 =C2=A0 Fix: Use unix socket peercred for pid, uid, gid credentials<b=
r>
<br>
=C2=A0 =C2=A0 Currently, the session daemon trust the pid, ppid, uid, and g=
id values<br>
=C2=A0 =C2=A0 passed by the application, but should really validate the uid=
 using unix<br>
=C2=A0 =C2=A0 socket peercred. This fix uses the peercred values rather tha=
n the<br>
=C2=A0 =C2=A0 values provided by the application on registration for:<br>
<br>
=C2=A0 =C2=A0 - pid, uid and gid on Linux,<br>
=C2=A0 =C2=A0 - uid and gid on FreeBSD.<br>
<br>
=C2=A0 =C2=A0 This should improve how the session daemon deals with contain=
erized<br>
=C2=A0 =C2=A0 applications on Linux as well. Applications are required to b=
e either in<br>
=C2=A0 =C2=A0 the same pid namespace, or in a pid namespace nested within t=
he pid<br>
=C2=A0 =C2=A0 namespace of the lttng-sessiond, so the session daemon can ma=
p the<br>
=C2=A0 =C2=A0 application pid to something meaningful within its own pid na=
mespace.<br>
=C2=A0 =C2=A0 Applications in a unrelated (disjoint) pid namespace will be =
refused by<br>
=C2=A0 =C2=A0 the session daemon.<br>
<br>
=C2=A0 =C2=A0 About the uid and gid with user namespaces on Linux, those wi=
ll provide<br>
=C2=A0 =C2=A0 meaningful IDs if the application user namespace is either th=
e same as<br>
=C2=A0 =C2=A0 the user namespace of the session daemon, or a nested user na=
mespace.<br>
=C2=A0 =C2=A0 Otherwise, the IDs will be that of /proc/sys/kernel/overflowu=
id and<br>
=C2=A0 =C2=A0 /proc/sys/kernel/overflowgid, which typically maps to nobody.=
nogroup on<br>
=C2=A0 =C2=A0 current distributions.<br>
<br>
=C2=A0 =C2=A0 Given that fetching the parent pid (ppid) of the application =
would<br>
=C2=A0 =C2=A0 require to use /proc/&lt;pid&gt;/status (which is racy wrt pi=
d reuse), expose<br>
=C2=A0 =C2=A0 the ppid provided by the application on registration instead,=
 but only<br>
=C2=A0 =C2=A0 in situations where the application sits in the same pid name=
space as<br>
=C2=A0 =C2=A0 the session daemon (on Linux), which is detected by checking =
if the pid<br>
=C2=A0 =C2=A0 provided by the application matches the pid obtained using un=
ix socket<br>
=C2=A0 =C2=A0 credentials. The ppid is only used for logging/debugging purp=
oses in the<br>
=C2=A0 =C2=A0 session daemon anyway, so it is OK to use the value provided =
by the<br>
=C2=A0 =C2=A0 application for that purpose.<br>
<br>
=C2=A0 =C2=A0 Fixes: #1286<br>
=C2=A0 =C2=A0 Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"mailto:mathie=
u.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com<=
/a>&gt;<br>
=C2=A0 =C2=A0 Change-Id: I94742e57dad642106908d09e2c7e395993c2c48f<br>
<br>
As for &quot;why it&#39;s required for some and not other calls.&quot;, the=
re is a difference<br>
between communicating with a lttng-sessiond daemon (using the lttng CLI) an=
d<br>
userspace application registering. They are essentially two distinct<br>
communication interface. Now, to be honest, I&#39;m not certain of the comp=
lete<br>
&quot;security&quot; policy for the lttng-sessiond &lt;-&gt; CLI interface =
and if we should be<br>
more strict or not.<br>
<br>
&gt; 2. Is there any workaround for this problem, so that I can get this to=
 work<br>
&gt; with the container topology I am working with (app in one container an=
d<br>
&gt; lttng daemons in another).<br>
<br>
Based on the commit message, lttng-ust explicitly cannot be used across<br>
non-nested pid namespace.<br>
<br>
Could you give us more information on the goal for the topology you plan to=
 use?<br>
This could lead to further discussion and/or alternative solution based on =
the<br>
goal and constraints of your deployment.<br>
<br>
&gt; 3. Related to 2, are there any gotchas to bypassing the getsockopt cal=
l in<br>
&gt; get_cred?<br>
<br>
Based on the content of the mentioned bug (1286) [1],=C2=A0 the principal c=
oncern is:<br>
<br>
&quot;<br>
This means a non-root application could theoretically impersonate a root<br=
>
application from a tracing perspective, and thus access root tracing buffer=
s in<br>
a per-uid configuration, which is unwanted.<br>
&quot;<br>
<br>
[1] <a href=3D"https://bugs.lttng.org/issues/1286" rel=3D"noreferrer" targe=
t=3D"_blank">https://bugs.lttng.org/issues/1286</a><br>
<br>
Cheers<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>

--000000000000da3a9a05c1758d0c--

--===============4715195462515793040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4715195462515793040==--
