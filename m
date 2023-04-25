Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7DFC77B61
	for <lttng-dev@archiver.kernel.org>; Tue, 25 Apr 2023 04:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1682398668;
	bh=sJArTUnhgnq5rySBwSOT/ObagByi+1q1QAWa8Gj+tDA=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=WtdpHW3o3rt59QRdX8EppMLiGNYhudzoFoSu9dCSDnqcBYC2dXEo5qrtYG7EKWE0O
	 Rc7g9xdBVztvKwyGySDK8Qhwyz3yK1jWzUZ+sLDt7wApNIisHNtvkLn+sXDjpcruw1
	 a6ruuWvTdgX/rsp7DROPAfFBS4nJG1PBTr+0TFtc4LcJdTTa/MCxqjR+AE4ic4XZI4
	 nnNBjmSbmDXWeQ18BgeLhoQIJz6MoYSlBfyYtbIVi5Q1FhiMQ2vPa3G9QzafuWwSPp
	 bmrZFosfS7QjqXG8NguGZgms0VtyIHBL3YP193DbacM1fmRLPAIdgI+4ePaOE/2b1e
	 vPD5W+PbNM6wg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Q58rW3y40zGgf;
	Tue, 25 Apr 2023 00:57:47 -0400 (EDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by lists.lttng.org (Postfix) with ESMTPS id 4Q58rV2Pk6zGgc
 for <lttng-dev@lists.lttng.org>; Tue, 25 Apr 2023 00:57:46 -0400 (EDT)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-507bdc5ca2aso9380368a12.3
 for <lttng-dev@lists.lttng.org>; Mon, 24 Apr 2023 21:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682398605; x=1684990605;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K6QX5UTIgg26ffkKQiW3eqPBrVHS7Poi5EkkX6m8pwg=;
 b=F/qpKaTyNTI7ybRmtErVqWPAl/Ph47qetqRsZ6mQMffwQvFKVV0+8k07W6m0KFN0+6
 8yrMBtkOaOcMTRT7U0KKGfgKl4pwSENkkGZAVk7oOyHwrAgX+s4vtiEYqOUZhpiwZkdY
 JLJl5rox+45TQ6NV2ICwNtmdQQn64k2Lb5YtIyhTjrXNmgDGr21EW6LE2hRFJ2pwqfKb
 w6xf84Vah8Rehpfd4lTe6t8VhbR4WxVgCl0aqGSyGyvtS+k2KepSTZHtMkCj9jY+tLP+
 QTGpUYczBC3kwgMGuX2+rcV9Tn0a+VCqEko3xAB//N9K7mYDCseNO3BBjo2IzKzc0SpA
 5ToQ==
X-Gm-Message-State: AAQBX9eFIWHEFyTr8zd+NkxT6n0m9FIsTD7Fq2EfQ76ukylPG9Oult0G
 3gtq/2+coyZSKyzkuCdgFc5Qi+mywzUwvhkPb1o=
X-Google-Smtp-Source: AKy350YQ3iP7YQbxrwsOGFbKVEbKOahZXf6qYybliWNcRb4VD5/F1hHDT2FFmvNPAGMx8vEWM0yE+bpewUvwpv45kXM=
X-Received: by 2002:aa7:cf8b:0:b0:506:7c86:1fd with SMTP id
 z11-20020aa7cf8b000000b005067c8601fdmr12455237edx.37.1682398604890; Mon, 24
 Apr 2023 21:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <9b162e6a547c41b284327034a9749027@amazon.com>
In-Reply-To: <9b162e6a547c41b284327034a9749027@amazon.com>
Date: Tue, 25 Apr 2023 00:56:33 -0400
Message-ID: <CAFZh4h_6zdF7uMF7EE6YgbEvvWWvc_4=uTderkwcUJVV8_mzvw@mail.gmail.com>
To: "Yitschak, Yehuda" <yehuday@amazon.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] Using lttng 2.11 and UST doesn't appear to work -
 getting empty trace files
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Brian Hutchinson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Brian Hutchinson <b.hutchman@gmail.com>
Content-Type: multipart/mixed; boundary="===============6595523373414597871=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6595523373414597871==
Content-Type: multipart/alternative; boundary="00000000000037170005fa21f3b3"

--00000000000037170005fa21f3b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So instructions for tracef just say to link in lttng-ust, not dl, I didn't
use liblttng-ust.a so maybe I misspoke.

https://lttng.org/docs/v2.11/#doc-tracef

... so that's what I did.

When I compile in a tracepoint with trace provider, I link in lttng-ust and
dl.  I'm assuming you can mix both tracef and tracepoint calls?

I included a lttng-sessiond -vvv log in original post.  Are attachments
allowed or should I have posted the context as a plain text post?  It's
quite big.

When I do lttng start, my app is already running via systemd at startup.
Do I need to disable that and start the executable manually after enabling
the lttng ust events?

Like I said, kernel trace is working fine, it's UST that appears to not be
working for some reason.  I have less experience with UST but I've been
researching and searching archives and I see others complaining about what
looks to be my problem but either don't see a solution or maybe I just
don't understand it.

Thanks,

Brian

On Tue, Apr 25, 2023 at 12:13=E2=80=AFAM Yitschak, Yehuda <yehuday@amazon.c=
om>
wrote:

> It might be related to the static linking of lttng-ust
> https://lists.lttng.org/pipermail/lttng-dev/2018-January/027705.html
>
> I also went down that path just to figure it=E2=80=99s not supported.
>
> Perhaps lttng documentation should be updated to make a clear note static
> linking is not supported (or maybe I missed it)
>
> Yehuda
>
> Hi,
>
>
>
> I'm on an embedded platform, i.MX8 using Lttng 2.11 with 5.6.69 kernel.
>
>
>
> Tracing kernel events with lttng works fine but userspace (tracef and
> trace provider type tracing) appears to have an issue I can't figure out.
>
>
>
> systemd is starting up my application ( a bunch of processes and threads
> on multiple cpu's) on boot.
>
>
>
> I'm statically compiling and linking in lttng-ust.  If I use just tracef
> type tracing, when I do lttng list --userspace I get nothing.  If I add i=
n
> a trace provider and a tracepoint, then I see my trace provider tracepoin=
t
> and:
>
>
>
>      lttng_ust_tracelog:TRACE_DEBUG (loglevel: TRACE_DEBUG (14)) (type:
> tracepoint)
>      lttng_ust_tracelog:TRACE_DEBUG_LINE (loglevel: TRACE_DEBUG_LINE (13)=
)
> (type: tracepoint)
>      lttng_ust_tracelog:TRACE_DEBUG_FUNCTION (loglevel:
> TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)
>      lttng_ust_tracelog:TRACE_DEBUG_UNIT (loglevel: TRACE_DEBUG_UNIT (11)=
)
> (type: tracepoint)
>      lttng_ust_tracelog:TRACE_DEBUG_MODULE (loglevel: TRACE_DEBUG_MODULE
> (10)) (type: tracepoint)
>      lttng_ust_tracelog:TRACE_DEBUG_PROCESS (loglevel: TRACE_DEBUG_PROCES=
S
> (9)) (type: tracepoint)
>      lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (loglevel: TRACE_DEBUG_PROGRA=
M
> (8)) (type: tracepoint)
>      lttng_ust_tracelog:TRACE_DEBUG_SYSTEM (loglevel: TRACE_DEBUG_SYSTEM
> (7)) (type: tracepoint)
>      lttng_ust_tracelog:TRACE_INFO (loglevel: TRACE_INFO (6)) (type:
> tracepoint)
>      lttng_ust_tracelog:TRACE_NOTICE (loglevel: TRACE_NOTICE (5)) (type:
> tracepoint)
>      lttng_ust_tracelog:TRACE_WARNING (loglevel: TRACE_WARNING (4)) (type=
:
> tracepoint)
>      lttng_ust_tracelog:TRACE_ERR (loglevel: TRACE_ERR (3)) (type:
> tracepoint)
>      lttng_ust_tracelog:TRACE_CRIT (loglevel: TRACE_CRIT (2)) (type:
> tracepoint)
>      lttng_ust_tracelog:TRACE_ALERT (loglevel: TRACE_ALERT (1)) (type:
> tracepoint)
>      lttng_ust_tracelog:TRACE_EMERG (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>      lttng_ust_tracef:event (loglevel: TRACE_DEBUG (14)) (type:
> tracepoint)
>      lttng_ust_lib:unload (loglevel: TRACE_DEBUG_LINE (13)) (type:
> tracepoint)
>      lttng_ust_lib:debug_link (loglevel: TRACE_DEBUG_LINE (13)) (type:
> tracepoint)
>      lttng_ust_lib:build_id (loglevel: TRACE_DEBUG_LINE (13)) (type:
> tracepoint)
>      lttng_ust_lib:load (loglevel: TRACE_DEBUG_LINE (13)) (type:
> tracepoint)
>      lttng_ust_statedump:end (loglevel: TRACE_DEBUG_LINE (13)) (type:
> tracepoint)
>      lttng_ust_statedump:debug_link (loglevel: TRACE_DEBUG_LINE (13))
> (type: tracepoint)
>      lttng_ust_statedump:build_id (loglevel: TRACE_DEBUG_LINE (13)) (type=
:
> tracepoint)
>      lttng_ust_statedump:bin_info (loglevel: TRACE_DEBUG_LINE (13)) (type=
:
> tracepoint)
>      lttng_ust_statedump:start (loglevel: TRACE_DEBUG_LINE (13)) (type:
> tracepoint)
>
>
>
> When I do lttng start, I get a directory structure in the trace directory
> but the file sizes do not ever increase.  It's just a directory structure
> with files created and then that's it, no events being written to the
> files.  At first I thought things just weren't linked in right and not
> working but then discovered how to run lttng-sessiond in -vvv mode and th=
en
> could see lots of things are going on, tracing appears to be trying to wo=
rk
> as there is tons of activity being output by lttng-sessiond, but like I
> said the trace files aren't being added to.
>
>
>
> I looked at the lttng-sessiond log I captured and can't quite make out th=
e
> problem so attaching it.
>
>
>
> I'm probably not doing something right but can't figure out what that is
> so any pointers appreciated.
>
>
>
> Regards,
>
>
>
> Brian
>
>
>

--00000000000037170005fa21f3b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>So instructions for tracef just say =
to link in lttng-ust, not dl, I didn&#39;t use liblttng-ust.a so maybe I mi=
sspoke.</div><div><br></div><div><a href=3D"https://lttng.org/docs/v2.11/#d=
oc-tracef">https://lttng.org/docs/v2.11/#doc-tracef</a></div><div><br></div=
><div>... so that&#39;s what I did.</div><div><br></div><div>When I compile=
 in a tracepoint with trace provider, I link in lttng-ust and dl.=C2=A0 I&#=
39;m assuming you can mix both tracef and tracepoint calls?</div><div><br><=
/div><div>I included a lttng-sessiond -vvv log in original post.=C2=A0 Are =
attachments allowed or should I have posted the context as a plain text pos=
t?=C2=A0 It&#39;s quite big.</div><div><br></div><div>When I do lttng start=
, my app is already running via systemd at startup.=C2=A0 Do I need to disa=
ble that and start the executable manually after enabling the lttng ust eve=
nts?</div><div><br></div><div>Like I said, kernel trace is working fine, it=
&#39;s UST that appears to not be working for some reason.=C2=A0 I have les=
s experience with UST but I&#39;ve been researching and searching archives =
and I see others complaining about what looks to be my problem but either d=
on&#39;t see a solution or maybe I just don&#39;t understand it.<br></div><=
div><br></div><div>Thanks,</div><div><br></div><div>Brian<br></div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Apr 25, 2023 at 12:13=E2=80=AFAM Yitschak, Yehuda &lt;<a href=3D"mailto:yeh=
uday@amazon.com">yehuday@amazon.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div class=3D"msg-6153908626702280795">





<div lang=3D"EN-US">
<div class=3D"m_-6153908626702280795WordSection1">
<p class=3D"MsoNormal">It might be related to the static linking of lttng-u=
st<br>
<a href=3D"https://lists.lttng.org/pipermail/lttng-dev/2018-January/027705.=
html" target=3D"_blank">https://lists.lttng.org/pipermail/lttng-dev/2018-Ja=
nuary/027705.html</a><br>
<br>
<u></u><u></u></p>
<p class=3D"MsoNormal">I also went down that path just to figure it=E2=80=
=99s not supported.<u></u><u></u></p>
<p class=3D"MsoNormal">Perhaps lttng documentation should be updated to mak=
e a clear note static linking is not supported (or maybe I missed it)<br>
<br>
<u></u><u></u></p>
<p class=3D"MsoNormal">Yehuda <br>
<br>
<u></u><u></u></p>
<div style=3D"border-color:currentcolor currentcolor currentcolor blue;bord=
er-style:none none none solid;border-width:medium medium medium 1.5pt;paddi=
ng:0cm 0cm 0cm 4pt">
<div>
<div>
<div>
<p class=3D"MsoNormal">Hi,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I&#39;m on an embedded platform, i.MX8 using Lttng 2=
.11 with 5.6.69 kernel.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Tracing kernel events with lttng works fine but user=
space (tracef and trace provider type tracing) appears to have an issue I c=
an&#39;t figure out.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">systemd is starting up my application ( a bunch of p=
rocesses and threads on multiple cpu&#39;s) on boot.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I&#39;m statically compiling and linking in lttng-us=
t.=C2=A0 If I use just tracef type tracing, when I do lttng list --userspac=
e I get nothing.=C2=A0 If I add in a trace provider and a tracepoint, then =
I see my trace provider tracepoint and:<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:black;background:white">=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TR=
ACE_DEBUG (loglevel: TRACE_DEBUG (14)) (type: tracepoint)
</span><span style=3D"font-family:&quot;Courier New&quot;"><br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_DEBUG_LINE (loglevel=
: TRACE_DEBUG_LINE (13)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_DEBUG_FUNCTION (logl=
evel: TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_DEBUG_UNIT (loglevel=
: TRACE_DEBUG_UNIT (11)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_DEBUG_MODULE (loglev=
el: TRACE_DEBUG_MODULE (10)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_DEBUG_PROCESS (logle=
vel: TRACE_DEBUG_PROCESS (9)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (logle=
vel: TRACE_DEBUG_PROGRAM (8)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_DEBUG_SYSTEM (loglev=
el: TRACE_DEBUG_SYSTEM (7)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_INFO (loglevel: TRAC=
E_INFO (6)) (type: tracepoint) <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_NOTICE (loglevel: TR=
ACE_NOTICE (5)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_WARNING (loglevel: T=
RACE_WARNING (4)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_ERR (loglevel: TRACE=
_ERR (3)) (type: tracepoint) <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_CRIT (loglevel: TRAC=
E_CRIT (2)) (type: tracepoint) <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_ALERT (loglevel: TRA=
CE_ALERT (1)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_EMERG (loglevel: TRA=
CE_EMERG (0)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracef:event (loglevel: TRACE_DEBUG=
 (14)) (type: tracepoint) <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_lib:unload (loglevel: TRACE_DEBUG_L=
INE (13)) (type: tracepoint) <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_lib:debug_link (loglevel: TRACE_DEB=
UG_LINE (13)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_lib:build_id (loglevel: TRACE_DEBUG=
_LINE (13)) (type: tracepoint) <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_lib:load (loglevel: TRACE_DEBUG_LIN=
E (13)) (type: tracepoint) <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_statedump:end (loglevel: TRACE_DEBU=
G_LINE (13)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_statedump:debug_link (loglevel: TRA=
CE_DEBUG_LINE (13)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_statedump:build_id (loglevel: TRACE=
_DEBUG_LINE (13)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_statedump:bin_info (loglevel: TRACE=
_DEBUG_LINE (13)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_statedump:start (loglevel: TRACE_DE=
BUG_LINE (13)) (type: tracepoint)</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
When I do lttng start, I get a directory structure in the trace directory b=
ut the file sizes do not ever increase.=C2=A0 It&#39;s just a directory str=
ucture with files created and then that&#39;s it, no events
 being written to the files.=C2=A0 At first I thought things just weren&#39=
;t linked in right and not working but then discovered how to run lttng-ses=
siond in -vvv mode and then could see lots of things are going on, tracing =
appears to be trying to work as there is
 tons of activity being output by lttng-sessiond, but like I said the trace=
 files aren&#39;t being added to.</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
I looked at the lttng-sessiond log I captured and can&#39;t quite make out =
the problem so attaching it.</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
I&#39;m probably not doing something right but can&#39;t figure out what th=
at is so any pointers appreciated.</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Regards,</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Brian</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
</div>
</div>
</div>
</div>
</div>

</div></blockquote></div></div>

--00000000000037170005fa21f3b3--

--===============6595523373414597871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6595523373414597871==--
