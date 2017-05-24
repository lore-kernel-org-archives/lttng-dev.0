From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: Re: tracing page_faults with lttng?
Date: Wed, 24 May 2017 12:26:38 -0400
Message-ID: <CADcCL0i-gZHviy_QZq_Krj_2zXiYvF-Z8BLu-3uQyA0anBfO-g__3328.16355298764$1495643681$gmane$org@mail.gmail.com>
References: <1807360.trHWC9KRqs@milian-kdab2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3632137124397965199=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-x230.google.com (mail-io0-x230.google.com
 [IPv6:2607:f8b0:4001:c06::230])
 by lists.lttng.org (Postfix) with ESMTPS id 3wXyVZ4yrrz117P
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 16:27:50 +0000 (UTC)
Received: by mail-io0-x230.google.com with SMTP id p24so121064154ioi.0
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 09:26:59 -0700 (PDT)
In-Reply-To: <1807360.trHWC9KRqs@milian-kdab2>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3632137124397965199==
Content-Type: multipart/alternative; boundary="94eb2c05d8cac1366d0550479278"

--94eb2c05d8cac1366d0550479278
Content-Type: text/plain; charset="UTF-8"

Hi Milian,
Are you running on an x86 processor?
The pagefault tracepoints are called : x86_exceptions_page_fault_user,
x86_exceptions_page_fault_kernel
Can you see those tracepoints when you run: lttng list --kernel

Thank you,
Francis

2017-05-24 12:00 GMT-04:00 Milian Wolff <milian.wolff@kdab.com>:

> Hey all,
>
> when I trace with perf, I can see page_faults occurring. But when I do
> something like the following with lttng:
>
> lttng create
> lttng enable-channel kernel -k
> lttng enable-event -c kernel -k -a
> lttng start
> # trigger page faults
> lttng stop
>
> then I do not see any page faults in tracecompass/babeltrace. What do I
> need
> to do to see those too? I'm aware that lttng comes with its own set of
> tracepoints - i.e. it's not using the same tracepoints that perf knows
> about.
> But googling shows me e.g. this:
>
> https://lists.lttng.org/pipermail/lttng-dev/2013-April/019954.html
> https://lists.lttng.org/pipermail/lttng-dev/2016-May/026033.html
>
> Which sounds like the feature should be available in lttng too?
>
> I'm using the ArchLinux packages in AUR, i.e. version 2.9.2 of LTTng and
> kernel 4.10.13-1.
>
> Thanks
> --
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


-- 
Francis Deslauriers
Software developer
EfficiOS inc.

--94eb2c05d8cac1366d0550479278
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Milian,<div>Are you running on an x86 processor?</div><=
div>The pagefault tracepoints are called :=C2=A0x86_exceptions_page_fault_<=
wbr>user, x86_exceptions_page_fault_<wbr>kernel</div><div>Can you see those=
 tracepoints when you run: lttng list --kernel=C2=A0</div><div><br></div><d=
iv>Thank you,</div><div>Francis</div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">2017-05-24 12:00 GMT-04:00 Milian Wolff <span dir=3D"lt=
r">&lt;<a href=3D"mailto:milian.wolff@kdab.com" target=3D"_blank">milian.wo=
lff@kdab.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hey all,<br>
<br>
when I trace with perf, I can see page_faults occurring. But when I do<br>
something like the following with lttng:<br>
<br>
lttng create<br>
lttng enable-channel kernel -k<br>
lttng enable-event -c kernel -k -a<br>
lttng start<br>
# trigger page faults<br>
lttng stop<br>
<br>
then I do not see any page faults in tracecompass/babeltrace. What do I nee=
d<br>
to do to see those too? I&#39;m aware that lttng comes with its own set of<=
br>
tracepoints - i.e. it&#39;s not using the same tracepoints that perf knows =
about.<br>
But googling shows me e.g. this:<br>
<br>
<a href=3D"https://lists.lttng.org/pipermail/lttng-dev/2013-April/019954.ht=
ml" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/piperm<wbr=
>ail/lttng-dev/2013-April/<wbr>019954.html</a><br>
<a href=3D"https://lists.lttng.org/pipermail/lttng-dev/2016-May/026033.html=
" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/piperm<wbr>a=
il/lttng-dev/2016-May/026033.<wbr>html</a><br>
<br>
Which sounds like the feature should be available in lttng too?<br>
<br>
I&#39;m using the ArchLinux packages in AUR, i.e. version 2.9.2 of LTTng an=
d<br>
kernel 4.10.13-1.<br>
<br>
Thanks<br>
<span class=3D"m_3331527344415455564HOEnZb"><font color=3D"#888888">--<br>
Milian Wolff | <a href=3D"mailto:milian.wolff@kdab.com" target=3D"_blank">m=
ilian.wolff@kdab.com</a> | Software Engineer<br>
KDAB (Deutschland) GmbH&amp;Co KG, a KDAB Group company<br>
Tel: +49-30-521325470<br>
KDAB - The Qt Experts</font></span><br>______________________________<wbr>_=
________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mail=
man/listinfo/lttng-dev</a><br>
<br></blockquote></div><br></div><br clear=3D"all"><div><br></div>-- <br><d=
iv class=3D"m_3331527344415455564gmail_signature" data-smartmail=3D"gmail_s=
ignature"><div dir=3D"ltr"><div><div>Francis Deslauriers</div><div dir=3D"l=
tr">Software developer<div>EfficiOS inc.</div></div></div></div></div></div=
>

--94eb2c05d8cac1366d0550479278--

--===============3632137124397965199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3632137124397965199==--
