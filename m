From: Ruslan Uvashev <ruslan.uvashev@gmail.com>
Subject: Event redefinition/re-enablement
Date: Sun, 16 Mar 2014 00:41:28 -0700
Message-ID: <CACQ=--QjjvvEPpeFqWCKa4qtkdXr1LWnUOh81snNp6LnAupooQ__13129.0172612809$1394955736$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1441460344=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <ruslan.uvashev@gmail.com>) id 1WP5hN-0000sn-No
	for lttng-dev@lists.lttng.org; Sun, 16 Mar 2014 03:41:35 -0400
Received: by mail-ig0-f182.google.com with SMTP id uy17so2828911igb.3
	for <lttng-dev@lists.lttng.org>; Sun, 16 Mar 2014 00:41:28 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1441460344==
Content-Type: multipart/alternative; boundary=20cf303bf98644d30104f4b46e90

--20cf303bf98644d30104f4b46e90
Content-Type: text/plain; charset=ISO-8859-1

Hi,

It seems that event once enabled for a channel cannot be reassigned to
another channel.
If events are immutable will Feature #445 (https://bugs.lttng.org/issues/445)
 account such situation? Or do we need to update man saying that events
cannot be redefined?

Command output below.

Thank you!


Output:

$ sudo lttng create tst1
Session tst1 created.
Traces will be written in /home/rusty/lttng-traces/tst1-20140315-173020
$ sudo lttng enable-event writeback_nothread -k
Kernel event writeback_nothread created in channel channel0
$ sudo lttng enable-channel ch1 -k
Kernel channel ch1 enabled for session tst1
$ sudo lttng list tst1
Tracing session tst1: [inactive]
    Trace path: /home/rusty/lttng-traces/tst1-20140315-173020

=== Domain: Kernel ===

Channels:
-------------
- ch1: [enabled]

    Attributes:
      overwrite mode: 0
      subbufers size: 262144
      number of subbufers: 4
      switch timer interval: 0
      read timer interval: 200000
      output: splice()

    Events:
      None

- channel0: [enabled]

    Attributes:
      overwrite mode: 0
      subbufers size: 262144
      number of subbufers: 4
      switch timer interval: 0
      read timer interval: 200000
      output: splice()

    Events:
      writeback_nothread (loglevel: TRACE_EMERG (0)) (type: tracepoint)
[enabled]

$ sudo lttng disable-event writeback_nothread -k -c channel0
Kernel event writeback_nothread disabled in channel channel0 for session
tst1
$ sudo lttng enable-event writeback_nothread -k -c ch1
Error: Event writeback_nothread: Enable kernel event failed (channel ch1,
session tst1)
Warning: Some command(s) went wrong




-------------------------------------
Best regards,
Ruslan Uvashev

--20cf303bf98644d30104f4b46e90
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>It seems that event once=
 enabled for a channel cannot be reassigned to another channel.</div><div>I=
f events are immutable will Feature #445 (<a href=3D"https://bugs.lttng.org=
/issues/445">https://bugs.lttng.org/issues/445</a>) =A0account such situati=
on? Or do we need to update man saying that events cannot be redefined?</di=
v>
<div><br></div><div>Command output below.</div><div><br></div><div>Thank yo=
u!</div><div><br></div><div><br></div><div>Output:</div><blockquote style=
=3D"margin:0 0 0 40px;border:none;padding:0px"><div><div><font face=3D"cour=
ier new, monospace">$ sudo lttng create tst1</font></div>
</div><div><div><font face=3D"courier new, monospace">Session tst1 created.=
</font></div></div><div><div><font face=3D"courier new, monospace">Traces w=
ill be written in /home/rusty/lttng-traces/tst1-20140315-173020</font></div=
>
</div><div><div><font face=3D"courier new, monospace">$ sudo lttng enable-e=
vent writeback_nothread -k</font></div></div><div><div><font face=3D"courie=
r new, monospace">Kernel event writeback_nothread created in channel channe=
l0</font></div>
</div><div><div><font face=3D"courier new, monospace">$ sudo lttng enable-c=
hannel ch1 -k</font></div></div><div><div><font face=3D"courier new, monosp=
ace">Kernel channel ch1 enabled for session tst1</font></div></div><div><di=
v>
<font face=3D"courier new, monospace">$ sudo lttng list tst1</font></div></=
div><div><div><font face=3D"courier new, monospace">Tracing session tst1: [=
inactive]</font></div></div><div><div><font face=3D"courier new, monospace"=
>=A0 =A0 Trace path: /home/rusty/lttng-traces/tst1-20140315-173020</font></=
div>
</div><div><div><font face=3D"courier new, monospace"><br></font></div></di=
v><div><div><font face=3D"courier new, monospace">=3D=3D=3D Domain: Kernel =
=3D=3D=3D</font></div></div><div><div><font face=3D"courier new, monospace"=
><br></font></div>
</div><div><div><font face=3D"courier new, monospace">Channels:</font></div=
></div><div><div><font face=3D"courier new, monospace">-------------</font>=
</div></div><div><div><font face=3D"courier new, monospace">- ch1: [enabled=
]</font></div>
</div><div><div><font face=3D"courier new, monospace"><br></font></div></di=
v><div><div><font face=3D"courier new, monospace">=A0 =A0 Attributes:</font=
></div></div><div><div><font face=3D"courier new, monospace">=A0 =A0 =A0 ov=
erwrite mode: 0</font></div>
</div><div><div><font face=3D"courier new, monospace">=A0 =A0 =A0 subbufers=
 size: 262144</font></div></div><div><div><font face=3D"courier new, monosp=
ace">=A0 =A0 =A0 number of subbufers: 4</font></div></div><div><div><font f=
ace=3D"courier new, monospace">=A0 =A0 =A0 switch timer interval: 0</font><=
/div>
</div><div><div><font face=3D"courier new, monospace">=A0 =A0 =A0 read time=
r interval: 200000</font></div></div><div><div><font face=3D"courier new, m=
onospace">=A0 =A0 =A0 output: splice()</font></div></div><div><div><font fa=
ce=3D"courier new, monospace"><br>
</font></div></div><div><div><font face=3D"courier new, monospace">=A0 =A0 =
Events:</font></div></div><div><div><font face=3D"courier new, monospace">=
=A0 =A0 =A0 None</font></div></div><div><div><font face=3D"courier new, mon=
ospace"><br></font></div>
</div><div><div><font face=3D"courier new, monospace">- channel0: [enabled]=
</font></div></div><div><div><font face=3D"courier new, monospace"><br></fo=
nt></div></div><div><div><font face=3D"courier new, monospace">=A0 =A0 Attr=
ibutes:</font></div>
</div><div><div><font face=3D"courier new, monospace">=A0 =A0 =A0 overwrite=
 mode: 0</font></div></div><div><div><font face=3D"courier new, monospace">=
=A0 =A0 =A0 subbufers size: 262144</font></div></div><div><div><font face=
=3D"courier new, monospace">=A0 =A0 =A0 number of subbufers: 4</font></div>
</div><div><div><font face=3D"courier new, monospace">=A0 =A0 =A0 switch ti=
mer interval: 0</font></div></div><div><div><font face=3D"courier new, mono=
space">=A0 =A0 =A0 read timer interval: 200000</font></div></div><div><div>=
<font face=3D"courier new, monospace">=A0 =A0 =A0 output: splice()</font></=
div>
</div><div><div><font face=3D"courier new, monospace"><br></font></div></di=
v><div><div><font face=3D"courier new, monospace">=A0 =A0 Events:</font></d=
iv></div><div><div><font face=3D"courier new, monospace">=A0 =A0 =A0 writeb=
ack_nothread (loglevel: TRACE_EMERG (0)) (type: tracepoint) [enabled]</font=
></div>
</div><div><div><font face=3D"courier new, monospace"><br></font></div></di=
v><div><div><font face=3D"courier new, monospace">$ sudo lttng disable-even=
t writeback_nothread -k -c channel0</font></div></div><div><div><font face=
=3D"courier new, monospace">Kernel event writeback_nothread disabled in cha=
nnel channel0 for session tst1</font></div>
</div><div><div><font face=3D"courier new, monospace">$ sudo lttng enable-e=
vent writeback_nothread -k -c ch1</font></div></div><div><div><font face=3D=
"courier new, monospace">Error: Event writeback_nothread: Enable kernel eve=
nt failed (channel ch1, session tst1)</font></div>
</div><div><div><font face=3D"courier new, monospace">Warning: Some command=
(s) went wrong</font></div></div></blockquote><div><br></div><div><br></div=
><br clear=3D"all"><div><div dir=3D"ltr">----------------------------------=
---<br>
Best regards,<br>Ruslan Uvashev<div><br></div><div><br></div></div></div>
</div>

--20cf303bf98644d30104f4b46e90--


--===============1441460344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1441460344==--
