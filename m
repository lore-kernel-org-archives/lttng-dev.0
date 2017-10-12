From: avkumar <anilzoom@gmail.com>
Subject: Re: How to user perf probes and module tracepoints in
	lttng
Date: Thu, 12 Oct 2017 08:50:18 -0500
Message-ID: <CANaS5jpKSm4VzVDkizTtyfLwjodMH+2odY=-K1jAAgnpsB4v4w__42249.3273429156$1507818101$gmane$org@mail.gmail.com>
References: <CANaS5jp1rE6Vnb1zmBgb+Gd5N_XLjFsH+HR7zD-UAo8FfYL43g@mail.gmail.com>
 <CADcCL0j4oasXdjNcrdN15fJbOhoBtyTsKi73u2dhprGZKdnm+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3949630932222007642=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x22d.google.com (mail-qt0-x22d.google.com
 [IPv6:2607:f8b0:400d:c0d::22d])
 by lists.lttng.org (Postfix) with ESMTPS id 3yCXKm1vZ2z105J
 for <lttng-dev@lists.lttng.org>; Thu, 12 Oct 2017 13:50:19 +0000 (UTC)
Received: by mail-qt0-x22d.google.com with SMTP id 1so13714575qtn.3
 for <lttng-dev@lists.lttng.org>; Thu, 12 Oct 2017 06:50:19 -0700 (PDT)
In-Reply-To: <CADcCL0j4oasXdjNcrdN15fJbOhoBtyTsKi73u2dhprGZKdnm+A@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3949630932222007642==
Content-Type: multipart/alternative; boundary="001a113fce7620d986055b59d26b"

--001a113fce7620d986055b59d26b
Content-Type: text/plain; charset="UTF-8"

Francis,
The suggestion you gave works, but the issue I was trying to solve was to
be able to peer into the structures passed to the function and get some
information from that. That is the reason I pulled out the variables in
perf probe. When I use the way you have suggested I am not able to figure
out how to get it to print the skb length and skb address. Is there a way
to do it( skb is passed into those functions?)

Reg the trace point compile error:
I figured that one out.  I had to have the source files for the kernel to
get that to work. I could not do with only header file for the kernel.
Once I had the source files and  set the KERNELDIR to the root of the
source files ( compiled) it worked.

Thanks



On Wed, Oct 11, 2017 at 4:49 PM, Francis Deslauriers <
francis.deslauriers@efficios.com> wrote:

> Hi,
> 2017-10-11 17:10 GMT-04:00 avkumar <anilzoom@gmail.com>:
> >
> > Perf probes:
> > How can we add the dynamic trace points created by perf probe into
> lttng? When I add the perf probe as kprobe type I get missing tracepoint
> error, If I add the perf probe as tracepoint , Lttng does not complain but
> it does not collect any data when the tracepoint is hit.
> >
> > perf probe -l
> >   probe:tcp_gro        (on tcp_gro_receive@net/ipv4/tcp_offload.c with
> addr len)
> >
> > lttng enable-event -k --probe=tcp_gro
>
> First, you have to give your probe event a name.
> Second, tcp_gro has to be a kernel symbol. According to the Perf
> output above, the symbol name is `tcp_gro_receive` so the command you
> want to run is:
> lttng enable-event -k --probe=tcp_gro_receive EVENT_NAME
>
> > Error: Missing event name(s).
> >
> > When I add it as a trace point
> >
> > lttng enable-event -k probe:tcp_gro
> > Kernel event probe:tcp_gro created in channel channel0]
> >
> > it does not give any error but no data is collected
>
> It's expected if you don't have a kernel tracepoint named
> "probe:tcp_gro"(you probably don't) currently loaded in your kernel.
> There is no error because there is no way for the kernel tracer if the
> tracepoint is part of an not-yet-loaded kernel module or not.
> "probe:tcp_gro" is a Perf specific description of the kprobe you
> enabled. You can not directly reuse this description in the
> lttng-enable-event command. To use the `lttng enable-event -k
> TRACEPOINT`, try the `lttng list -k` command (with a lttng-sessiond
> running as root) to list the currently available tracepoints.
>
> >
> >
> >
> > Module tracepoints:
> > I created module tracepoints in the kernel and compiled the trace
> points. The header file is in the driver module directory. When I write the
> adaptation layer for lttng, it does not compile as it is not able to fien
> the header file. I have given fill path name to the header file and still
> it does not work.
>
> Can you give us a bit more details. Could you send us a pastebin of
> the error you get?
>
> Thank you,
> Francis
>
> >
> >
> > Thanks
> >
> >
> >
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>
>
>
> --
> Francis Deslauriers
> Software developer
> EfficiOS inc.
>

--001a113fce7620d986055b59d26b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Francis,=C2=A0<div>The suggestion you gave works, but the =
issue I was trying to solve was to be able to peer into the structures pass=
ed to the function and get some information from that. That is the reason I=
 pulled out the variables in perf probe. When I use the way you have sugges=
ted I am not able to figure out how to get it to print the skb length and s=
kb address. Is there a way to do it( skb is passed into those functions?)</=
div><div><br></div><div>Reg the trace point compile error:</div><div>I figu=
red that one out.=C2=A0 I had to have the source files for the kernel to ge=
t that to work. I could not do with only header file for the kernel.=C2=A0<=
/div><div>Once I had the source files and =C2=A0set the KERNELDIR to the ro=
ot of the source files ( compiled) it worked.=C2=A0</div><div><br></div><di=
v>Thanks</div><div><br></div><div><br></div></div><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">On Wed, Oct 11, 2017 at 4:49 PM, Francis D=
eslauriers <span dir=3D"ltr">&lt;<a href=3D"mailto:francis.deslauriers@effi=
cios.com" target=3D"_blank">francis.deslauriers@efficios.com</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Hi,<br>
2017-10-11 17:10 GMT-04:00 avkumar &lt;<a href=3D"mailto:anilzoom@gmail.com=
">anilzoom@gmail.com</a>&gt;:<br>
&gt;<br>
&gt; Perf probes:<br>
&gt; How can we add the dynamic trace points created by perf probe into ltt=
ng? When I add the perf probe as kprobe type I get missing tracepoint error=
, If I add the perf probe as tracepoint , Lttng does not complain but it do=
es not collect any data when the tracepoint is hit.<br>
&gt;<br>
&gt; perf probe -l<br>
&gt;=C2=A0 =C2=A0probe:tcp_gro=C2=A0 =C2=A0 =C2=A0 =C2=A0 (on tcp_gro_recei=
ve@net/ipv4/tcp_<wbr>offload.c with addr len)<br>
&gt;<br>
&gt; lttng enable-event -k --probe=3Dtcp_gro<br>
<br>
First, you have to give your probe event a name.<br>
Second, tcp_gro has to be a kernel symbol. According to the Perf<br>
output above, the symbol name is `tcp_gro_receive` so the command you<br>
want to run is:<br>
lttng enable-event -k --probe=3Dtcp_gro_receive EVENT_NAME<br>
<br>
&gt; Error: Missing event name(s).<br>
&gt;<br>
&gt; When I add it as a trace point<br>
&gt;<br>
&gt; lttng enable-event -k probe:tcp_gro<br>
&gt; Kernel event probe:tcp_gro created in channel channel0]<br>
&gt;<br>
&gt; it does not give any error but no data is collected<br>
<br>
It&#39;s expected if you don&#39;t have a kernel tracepoint named<br>
&quot;probe:tcp_gro&quot;(you probably don&#39;t) currently loaded in your =
kernel.<br>
There is no error because there is no way for the kernel tracer if the<br>
tracepoint is part of an not-yet-loaded kernel module or not.<br>
&quot;probe:tcp_gro&quot; is a Perf specific description of the kprobe you<=
br>
enabled. You can not directly reuse this description in the<br>
lttng-enable-event command. To use the `lttng enable-event -k<br>
TRACEPOINT`, try the `lttng list -k` command (with a lttng-sessiond<br>
running as root) to list the currently available tracepoints.<br>
<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Module tracepoints:<br>
&gt; I created module tracepoints in the kernel and compiled the trace poin=
ts. The header file is in the driver module directory. When I write the ada=
ptation layer for lttng, it does not compile as it is not able to fien the =
header file. I have given fill path name to the header file and still it do=
es not work.<br>
<br>
Can you give us a bit more details. Could you send us a pastebin of<br>
the error you get?<br>
<br>
Thank you,<br>
Francis<br>
<br>
&gt;<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/=
mailman/listinfo/lttng-dev</a><br>
&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
--<br>
Francis Deslauriers<br>
Software developer<br>
EfficiOS inc.<br>
</font></span></blockquote></div><br></div>

--001a113fce7620d986055b59d26b--

--===============3949630932222007642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3949630932222007642==--
