From: Francis Deslauriers <francis.deslauriers@mail.utoronto.ca>
Subject: Re: Beginner question: how to inspect scheduling of
 multi-threaded user application?
Date: Wed, 24 Aug 2016 12:17:40 -0400
Message-ID: <CADcCL0hqkvEPZEu85GzJnJKi9nOi0wntpOYoVz37QhcRVpb+=g__41052.5646679618$1472055499$gmane$org@mail.gmail.com>
References: <35de22c3d2034f3abb75596477b23e3a@EUX13SRV1.EU.NEC.COM>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2528005435743283489=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0088.outbound.protection.outlook.com [104.47.42.88])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 7FFE9A3BDB
 for <lttng-dev@lists.lttng.org>; Wed, 24 Aug 2016 16:18:23 +0000 (UTC)
Received: by mail-ua0-f172.google.com with SMTP id 74so37167004uau.0
 for <lttng-dev@lists.lttng.org>; Wed, 24 Aug 2016 09:18:05 -0700 (PDT)
In-Reply-To: <35de22c3d2034f3abb75596477b23e3a@EUX13SRV1.EU.NEC.COM>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: David Aldrich <David.Aldrich@emea.nec.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2528005435743283489==
Content-Type: multipart/alternative; boundary="001a114b7d320e9414053ad3a03d"

--001a114b7d320e9414053ad3a03d
Content-Type: text/plain; charset="UTF-8"

Hi David,
If you specifically want to trace the scheduling of the threads of your
app, you don't need custom tracepoints.
Enabling the sched_switch kernel event will give you both of cpu id and
thread id. Look at the cpu_id and next_tid fields.

You can enable the sched_switch event using : lttng enable-event -k
sched_switch

Cheers,
Francis

2016-08-24 3:17 GMT-04:00 David Aldrich <David.Aldrich@emea.nec.com>:

> Hi
>
>
>
> I am new to tracing in Linux and to lttng. I have a multi-threaded user
> application and I want to see:
>
>
>
> 1)      When the threads are scheduled to run
>
> 2)      Which cores the threads are running on.
>
>
>
> I have installed lttng on Ubuntu 14.04 LTS.  I am expecting to visualise
> the trace using TraceCompass.
>
>
>
> I have read the following doc section:
>
>
>
> http://lttng.org/docs/#doc-tracing-your-own-user-application
>
>
>
> In order to collect my trace, must I define custom tracepoint definitions ( in
> a tracepoint provider header file ), and insert tracepoints into my user
> application, or is there a simpler way of achieving my goal?
>
>
>
> Best regards
>
>
>
> David
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--001a114b7d320e9414053ad3a03d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p dir=3D"ltr">Hi David,=C2=A0<br>
If you specifically want to trace the scheduling of the threads of your app=
, you don&#39;t need custom tracepoints.<br>
Enabling the sched_switch kernel event will give you both of cpu id and thr=
ead id. Look at the cpu_id and next_tid fields.</p>
<p dir=3D"ltr">You can enable the sched_switch event using : lttng enable-e=
vent -k sched_switch</p>
<p dir=3D"ltr">Cheers,<br>
Francis</p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-08-24 3:17 G=
MT-04:00 David Aldrich <span dir=3D"ltr">&lt;<a href=3D"mailto:David.Aldric=
h@emea.nec.com" target=3D"_blank">David.Aldrich@emea.nec.com</a>&gt;</span>=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">





<div lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72">
<div>
<p class=3D"MsoNormal">Hi<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">I am new to tracing in Linux and to lttng. I have a =
multi-threaded user application and I want to see:<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p><u></u><span>1)<span style=3D"font:7.0pt &quot;Times New Roman&quot;">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span></span><u></u>When the threads are scheduled to run<u></u><u></u></p=
>
<p><u></u><span>2)<span style=3D"font:7.0pt &quot;Times New Roman&quot;">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span></span><u></u>Which cores the threads are running on.<u></u><u></u><=
/p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">I have installed lttng on Ubuntu 14.04 LTS.=C2=A0 I =
am expecting to visualise the trace using TraceCompass.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">I have read the following doc section:<u></u><u></u>=
</p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><a href=3D"http://lttng.org/docs/#doc-tracing-your-o=
wn-user-application" target=3D"_blank">http://lttng.org/docs/#doc-tra<wbr>c=
ing-your-own-user-application</a><u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">In order to collect my trace, must I define custom t=
racepoint definitions (<span><span style=3D"color:#1a1a1a;background:#fdfdf=
d">=C2=A0in a
</span></span><span style=3D"color:#1a1a1a;background:#fdfdfd">tracepoint p=
rovider<span>=C2=A0header file ), and insert tracepoints into my user appli=
cation, or is there a simpler way of achieving my goal?</span></span><u></u=
><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><span>Best regards<span><font color=3D"#888888"><u><=
/u><u></u></font></span></span></p><span><font color=3D"#888888">
<p class=3D"MsoNormal"><span><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span>David<u></u><u></u></span></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</font></span></div>
</div>

<br>______________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mail=
man/listinfo/lttng-dev</a><br>
<br></blockquote></div><br></div>
</div>

--001a114b7d320e9414053ad3a03d--

--===============2528005435743283489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2528005435743283489==--
