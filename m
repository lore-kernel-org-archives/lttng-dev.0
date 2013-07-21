From: yin sun <sunyin51@gmail.com>
Subject: Re: LTTng snapshot howto
Date: Sun, 21 Jul 2013 14:42:18 -0700
Message-ID: <CAKPZSeAHfHAYSAyJx5_kHUHSj0BPg1BX6jD=q=hELbdDcHnSHQ__28924.6707376607$1374443017$gmane$org@mail.gmail.com>
References: <20130719225436.GA2488@Krystal> <20130721182752.GA10255@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1277190452=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sunyin51@gmail.com>) id 1V11Ou-0002QX-9x
	for lttng-dev@lists.lttng.org; Sun, 21 Jul 2013 17:42:48 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so6334700pbc.32
	for <lttng-dev@lists.lttng.org>; Sun, 21 Jul 2013 14:42:38 -0700 (PDT)
In-Reply-To: <20130721182752.GA10255@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1277190452==
Content-Type: multipart/alternative; boundary=047d7b86f1184d6a1404e20c7045

--047d7b86f1184d6a1404e20c7045
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

Can you explain how the snapshot record works. Is it going to dump the
whole buffer even if the same buffer is dumped before.
How to do something like "tail -f" to the buffer.

Thanks,
/Yin


On Sun, Jul 21, 2013 at 11:27 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Hi,
>
> I just pushed a LTTng snapshot howto (new feature of lttng 2.3-rc). I'm
> posting it to lttng-dev, since it provides a quick insight on how to use
> the snapshot feature. Comments are welcome!
>
> Thanks,
>
> Mathieu
>
>
> LTTng Flight Recorder Snapshot HOWTO
>
> Mathieu Desnoyers
> July 21st, 2013
>
> This document presents how to use the snapshot feature of LTTng.
>
> Snapshots allow to grab the content of flight recorder tracing buffers
> at the time the snapshot record command is invoked. Flight recorder
> tracing gather trace data in memory, overwriting the oldest information,
> without requiring any disk I/O. The snapshot record command exports the
> snapshot to the destination specified by the user.
>
> Basic usage:
>
> Session daemon started as root for kernel tracing:
>
> # lttng-sessiond -d
>
> From a user part of the tracing group (for kernel tracing):
>
> $ lttng create --snapshot
> $ lttng enable-event -k -a      # enable kernel tracing
> $ lttng enable-event -u -a      # enable user-space tracing
> $ lttng start
>
>     [ do something, generate activity on the system ]
>
> $ lttng snapshot record
>
>     [ do more stuff... ]
>
> $ lttng snapshot record
>
> $ lttng stop
> $ lttng destroy
>
> Each "lttng snapshot" command records a snapshot of the current buffer
> state. "lttng enable --snapshot" automatically setups the buffers in
> overwrite mode for flight recording, and does not attach any output file
> to the trace. The "lttng snapshot record" command can be performed
> either while tracing is started or stopped.
>
> As an example, this generates the following hierarchy under the
> directory reported by the "create" command above:
>
> .
> =E2=94=9C=E2=94=80=E2=94=80 snapshot-1-20130721-141838-0
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 kernel
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_0
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_1
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_2
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_3
> =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 metadata
> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 ust
> =E2=94=82       =E2=94=94=E2=94=80=E2=94=80 uid
> =E2=94=82           =E2=94=94=E2=94=80=E2=94=80 1000
> =E2=94=82               =E2=94=94=E2=94=80=E2=94=80 64-bit
> =E2=94=82                   =E2=94=9C=E2=94=80=E2=94=80 channel0_0
> =E2=94=82                   =E2=94=9C=E2=94=80=E2=94=80 channel0_1
> =E2=94=82                   =E2=94=9C=E2=94=80=E2=94=80 channel0_2
> =E2=94=82                   =E2=94=9C=E2=94=80=E2=94=80 channel0_3
> =E2=94=82                   =E2=94=94=E2=94=80=E2=94=80 metadata
> =E2=94=94=E2=94=80=E2=94=80 snapshot-1-20130721-141842-1
>     =E2=94=9C=E2=94=80=E2=94=80 kernel
>     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_0
>     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_1
>     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_2
>     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_3
>     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 metadata
>     =E2=94=94=E2=94=80=E2=94=80 ust
>         =E2=94=94=E2=94=80=E2=94=80 uid
>             =E2=94=94=E2=94=80=E2=94=80 1000
>                 =E2=94=94=E2=94=80=E2=94=80 64-bit
>                     =E2=94=9C=E2=94=80=E2=94=80 channel0_0
>                     =E2=94=9C=E2=94=80=E2=94=80 channel0_1
>                     =E2=94=9C=E2=94=80=E2=94=80 channel0_2
>                     =E2=94=9C=E2=94=80=E2=94=80 channel0_3
>                     =E2=94=94=E2=94=80=E2=94=80 metadata
>
>
> Then, running babeltrace on, e.g.
>
> babeltrace snapshot-1-20130721-141838-0
>
> shows the content of the first snapshot.
>
> Please refer to the lttng(1) manpage for details on the snapshot mode.
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--047d7b86f1184d6a1404e20c7045
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mathieu,=C2=A0<div><br></div><div>Can you explain how t=
he snapshot record works. Is it going to dump the whole buffer even if the =
same buffer is dumped before.</div><div>How to do something like &quot;tail=
 -f&quot; to the buffer.=C2=A0</div>

<div><br></div><div>Thanks,</div><div>/Yin</div></div><div class=3D"gmail_e=
xtra"><br><br><div class=3D"gmail_quote">On Sun, Jul 21, 2013 at 11:27 AM, =
Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers=
@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</sp=
an> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<br>
I just pushed a LTTng snapshot howto (new feature of lttng 2.3-rc). I&#39;m=
<br>
posting it to lttng-dev, since it provides a quick insight on how to use<br=
>
the snapshot feature. Comments are welcome!<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
<br>
LTTng Flight Recorder Snapshot HOWTO<br>
<br>
Mathieu Desnoyers<br>
July 21st, 2013<br>
<br>
This document presents how to use the snapshot feature of LTTng.<br>
<br>
Snapshots allow to grab the content of flight recorder tracing buffers<br>
at the time the snapshot record command is invoked. Flight recorder<br>
tracing gather trace data in memory, overwriting the oldest information,<br=
>
without requiring any disk I/O. The snapshot record command exports the<br>
snapshot to the destination specified by the user.<br>
<br>
Basic usage:<br>
<br>
Session daemon started as root for kernel tracing:<br>
<br>
# lttng-sessiond -d<br>
<br>
From a user part of the tracing group (for kernel tracing):<br>
<br>
$ lttng create --snapshot<br>
$ lttng enable-event -k -a =C2=A0 =C2=A0 =C2=A0# enable kernel tracing<br>
$ lttng enable-event -u -a =C2=A0 =C2=A0 =C2=A0# enable user-space tracing<=
br>
$ lttng start<br>
<br>
=C2=A0 =C2=A0 [ do something, generate activity on the system ]<br>
<br>
$ lttng snapshot record<br>
<br>
=C2=A0 =C2=A0 [ do more stuff... ]<br>
<br>
$ lttng snapshot record<br>
<br>
$ lttng stop<br>
$ lttng destroy<br>
<br>
Each &quot;lttng snapshot&quot; command records a snapshot of the current b=
uffer<br>
state. &quot;lttng enable --snapshot&quot; automatically setups the buffers=
 in<br>
overwrite mode for flight recording, and does not attach any output file<br=
>
to the trace. The &quot;lttng snapshot record&quot; command can be performe=
d<br>
either while tracing is started or stopped.<br>
<br>
As an example, this generates the following hierarchy under the<br>
directory reported by the &quot;create&quot; command above:<br>
<br>
.<br>
=E2=94=9C=E2=94=80=E2=94=80 snapshot-1-20130721-141838-0<br>
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 kernel<br>
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel0_0<br>
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel0_1<br>
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel0_2<br>
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel0_3<br>
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 met=
adata<br>
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 ust<br>
=E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =E2=94=94=E2=94=80=E2=94=80 uid<br>
=E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=94=94=E2=94=80=E2=94=
=80 1000<br>
=E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=94=94=
=E2=94=80=E2=94=80 64-bit<br>
=E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_0<br>
=E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_1<br>
=E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_2<br>
=E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_3<br>
=E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =E2=94=94=E2=94=80=E2=94=80 metadata<br>
=E2=94=94=E2=94=80=E2=94=80 snapshot-1-20130721-141842-1<br>
=C2=A0 =C2=A0 =E2=94=9C=E2=94=80=E2=94=80 kernel<br>
=C2=A0 =C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_0<=
br>
=C2=A0 =C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_1<=
br>
=C2=A0 =C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_2<=
br>
=C2=A0 =C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_3<=
br>
=C2=A0 =C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 metadata<br=
>
=C2=A0 =C2=A0 =E2=94=94=E2=94=80=E2=94=80 ust<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=94=94=E2=94=80=E2=94=80 uid<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=94=94=E2=94=80=E2=94=80 1000<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=94=94=E2=94=80=
=E2=94=80 64-bit<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=
=94=9C=E2=94=80=E2=94=80 channel0_0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=
=94=9C=E2=94=80=E2=94=80 channel0_1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=
=94=9C=E2=94=80=E2=94=80 channel0_2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=
=94=9C=E2=94=80=E2=94=80 channel0_3<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=
=94=94=E2=94=80=E2=94=80 metadata<br>
<br>
<br>
Then, running babeltrace on, e.g.<br>
<br>
babeltrace snapshot-1-20130721-141838-0<br>
<br>
shows the content of the first snapshot.<br>
<br>
Please refer to the lttng(1) manpage for details on the snapshot mode.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</font></span></blockquote></div><br></div>

--047d7b86f1184d6a1404e20c7045--


--===============1277190452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1277190452==--
