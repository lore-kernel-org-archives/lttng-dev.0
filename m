From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Notification event from lttng-relayd on trace
 rotation completion?
Date: Fri, 20 Apr 2018 14:58:27 -0400
Message-ID: <CA+jJMxvKQEJXMJCrQy-pARpVo8xA-Zof4DJV0CQemRniH_wFfQ__42154.3333832689$1524250614$gmane$org@mail.gmail.com>
References: <E2315562-B90A-4ABB-B6AC-74C9D896AA82@sinch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2089190273219798824=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x229.google.com (mail-lf0-x229.google.com
 [IPv6:2a00:1450:4010:c07::229])
 by lists.lttng.org (Postfix) with ESMTPS id 40SQB23MXqz14fZ
 for <lttng-dev@lists.lttng.org>; Fri, 20 Apr 2018 14:58:50 -0400 (EDT)
Received: by mail-lf0-x229.google.com with SMTP id p142-v6so6532095lfd.6
 for <lttng-dev@lists.lttng.org>; Fri, 20 Apr 2018 11:58:50 -0700 (PDT)
In-Reply-To: <E2315562-B90A-4ABB-B6AC-74C9D896AA82@sinch.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Christoffer Ahlbin <Christoffer.Ahlbin@sinch.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2089190273219798824==
Content-Type: multipart/alternative; boundary="000000000000360900056a4c47a2"

--000000000000360900056a4c47a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 10 April 2018 at 10:56, Christoffer Ahlbin <Christoffer.Ahlbin@sinch.com=
>
wrote:

> What is the recommended approach to have an external process notified
> that a trace session rotation has completed on the lttng-relayd end?
>
> I'm trying out the trace rotation functionality available in 2.11
> (pre-release) and will be running a trace session inside a Linux
> container (userspace tracepoints only), and running lttng-relayd on
> the container host. I would then like to have a third process, a
> "collector"-like process, that will also be running on the container
> host and will have the responsibility of collecting completeted trace
> chunks (i.e. rotated chunks) and push them further along into a trace
> analysis pipeline.
>
> So far I've looked at using inotify to watch the lttng-traces/
> directory, and the idea would be to infer a trace rotation based on
> that the destination directories post rotation are named on the format
> "%Y%m%dT%H%M%S%z-%Y%m%dT%H%M%S%z-<seqno>". But I'm not entirely
> satisifed with that approach. Ideally I would be able to be notified
> more explicitly that a rotation completed.
>

Hi Christopher,

There is a notification mechanism available on the target side (sessiond an=
d
consumerd) to which I'm adding notifications for ongoing and completed
notifications.

Unfortunately, those notifications are not forwarded over the network
to the relay daemon. It would be nice to extend the notification
system for that kind of use case.

In the short term, monitoring with inotify for new folders with the
format you mentioned is pretty much the only mechanism we have if
you can't monitor for notifications on the target.

In the current master branch, there is a bug that can cause the
relayd to rename the completed chunk too soon while it is
still being written. In this case, you could fail to read the trace.

We are working on a fix at the moment, so the inotify approach
should be safe by the time of the release. Did you observe other
problems using inotify?

Thanks!
J=C3=A9r=C3=A9mie


>
>
> Any thoughts and recommendations are most welcome.
>
> Thanks
>
> Christoffer Ahlbin
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--000000000000360900056a4c47a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 10 April 2018 at 10:56, Christoffer Ahlbin <span dir=3D"ltr">&lt;<a =
href=3D"mailto:Christoffer.Ahlbin@sinch.com" target=3D"_blank">Christoffer.=
Ahlbin@sinch.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Wh=
at is the recommended approach to have an external process notified<br>
that a trace session rotation has completed on the lttng-relayd end?<br>
<br>
I&#39;m trying out the trace rotation functionality available in 2.11<br>
(pre-release) and will be running a trace session inside a Linux<br>
container (userspace tracepoints only), and running lttng-relayd on<br>
the container host. I would then like to have a third process, a<br>
&quot;collector&quot;-like process, that will also be running on the contai=
ner<br>
host and will have the responsibility of collecting completeted trace<br>
chunks (i.e. rotated chunks) and push them further along into a trace<br>
analysis pipeline.<br>
<br>
So far I&#39;ve looked at using inotify to watch the lttng-traces/<br>
directory, and the idea would be to infer a trace rotation based on<br>
that the destination directories post rotation are named on the format<br>
&quot;%Y%m%dT%H%M%S%z-%Y%m%dT%H%M%<wbr>S%z-&lt;seqno&gt;&quot;. But I&#39;m=
 not entirely<br>
satisifed with that approach. Ideally I would be able to be notified<br>
more explicitly that a rotation completed.<br></blockquote><div><br></div><=
div>Hi Christopher,<br><br></div><div>There is a notification mechanism ava=
ilable on the target side (sessiond and<br>consumerd) to which I&#39;m addi=
ng notifications for ongoing and completed<br>notifications.<br><br></div><=
div>Unfortunately, those notifications are not forwarded over the network<b=
r></div><div>to the relay daemon. It would be nice to extend the notificati=
on<br></div><div>system for that kind of use case.<br><br></div><div>In the=
 short term, monitoring with inotify for new folders with the<br>format you=
 mentioned is pretty much the only mechanism we have if<br></div><div>you c=
an&#39;t monitor for notifications on the target.<br><br></div><div>In the =
current master branch, there is a bug that can cause the<br></div><div>rela=
yd to rename the completed chunk too soon while it is<br></div><div>still b=
eing written. In this case, you could fail to read the trace.<br><br></div>=
<div>We are working on a fix at the moment, so the inotify approach<br>shou=
ld be safe by the time of the release. Did you observe other<br></div><div>=
problems using inotify?<br></div><div><br></div><div>Thanks!<br></div><div>=
J=C3=A9r=C3=A9mie<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
Any thoughts and recommendations are most welcome.<br>
<br>
Thanks<br>
<br>
Christoffer Ahlbin<br>
<br>
______________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/mail=
man/listinfo/lttng-dev</a><br>
</blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_sig=
nature" data-smartmail=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>E=
fficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http:=
//www.efficios.com</a></div>
</div></div>

--000000000000360900056a4c47a2--

--===============2089190273219798824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2089190273219798824==--
