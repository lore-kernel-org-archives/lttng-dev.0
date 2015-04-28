From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng-relayd core
Date: Tue, 28 Apr 2015 15:21:44 +0000 (UTC)
Message-ID: <1598887302.39240.1430234504111.JavaMail.zimbra__15836.4702867859$1430234582$gmane$org@efficios.com>
References: <CAM5kDqxgbBpA29j3J66BkMoFJidEhPiHeJ+Vdtp8-3PacrD5ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0796254838=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Yn7KV-0002J9-ET
 for lttng-dev@lists.lttng.org; Tue, 28 Apr 2015 11:21:52 -0400
In-Reply-To: <CAM5kDqxgbBpA29j3J66BkMoFJidEhPiHeJ+Vdtp8-3PacrD5ww@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: lttng-dev@lists.lttng.org, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0796254838==
Content-Type: multipart/alternative;
	boundary="----=_Part_39239_1034291160.1430234504111"

------=_Part_39239_1034291160.1430234504111
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Anand, 

This bug report lacks a lot of information we need to reproduce the 
issue. We'll soon come up with a "bug report guideline" on the lttng.org 
website. 

Also, we can't help but noticing that the amount of support you have been 
requiring those past months seems better suited to the commercial LTTng 
support offered by EfficiOS. In addition to give you the amount of support 
you need, this is one of the main mechanisms for funding LTTng project 
maintenance work. 

Best Regards, 

Mathieu 

----- Original Message -----

> Hi All,

> Found this crash in 2.6.0
> Is there any open issue or workaround. Please help me with more info on this
> crash.

> (gdb) bt
> #0 0x00007fc62fe5bff9 in __GI_raise (sig=sig@entry=6)
> at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
> #1 0x00007fc62fe5f068 in __GI_abort () at abort.c:89
> #2 0x00007fc62fe55146 in __assert_fail_base (
> fmt=0x7fc62ff8d230 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n",
> assertion=assertion@entry=0x425ba2 "!obj->refcount",
> file=file@entry=0x425b92 "ctf-trace.c", line=line@entry=55,
> function=function@entry=0x425d80 <__PRETTY_FUNCTION__.5729>
> "ctf_trace_destroy") at assert.c:92
> #3 0x00007fc62fe551f2 in __GI___assert_fail (
> assertion=assertion@entry=0x425ba2 "!obj->refcount",
> file=file@entry=0x425b92 "ctf-trace.c", line=line@entry=55,
> function=function@entry=0x425d80 <__PRETTY_FUNCTION__.5729>
> "ctf_trace_destroy") at assert.c:101
> #4 0x00000000004110e0 in ctf_trace_destroy (obj=0x7fc61001e320)
> at ctf-trace.c:55
> #5 0x00000000004131f7 in session_destroy (
> session=session@entry=0x7fc61001a3c0) at session.c:177
> #6 0x0000000000413311 in session_try_destroy (ht=ht@entry=0x6330e0,
> session=session@entry=0x7fc61001a3c0) at session.c:149
> #7 0x00000000004078a7 in destroy_session (session=0x7fc61001a3c0,
> sessions_ht=0x6330e0) at main.c:1058
> #8 0x0000000000407a7d in destroy_connection (
> ---Type <return> to continue, or q <return> to quit---
> relay_connections_ht=<optimized out>, conn=0x7fc624000d00) at main.c:2418
> #9 0x000000000040aa11 in relay_thread_worker (data=<optimized out>)
> at main.c:2568
> #10 0x00007fc6301d8fe3 in start_thread (arg=0x7fc62e2f1700)
> at pthread_create.c:312
> #11 0x00007fc62ff0eafd in clone ()
> at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
> (gdb)
> (gdb)

> Thanks,
> Anand Neeli

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_39239_1034291160.1430234504111
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Hi Anand,<br></div><div><br></di=
v><div>This bug report lacks a lot of information we need to reproduce the<=
br></div><div>issue. We'll soon come up with a "bug report guideline" on th=
e lttng.org<br></div><div>website.<br></div><div><br></div><div>Also, we ca=
n't help but noticing that the amount of support you have been</div><div>re=
quiring those past months seems better suited to the commercial LTTng</div>=
<div>support offered by EfficiOS. In addition to give you the amount of sup=
port</div><div>you need, this is one of the main mechanisms for funding LTT=
ng project</div><div>maintenance work.</div><div><br></div><div>Best Regard=
s,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><div><br></=
div><hr id=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;mar=
gin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:norm=
al;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12=
pt;"><div dir=3D"ltr">Hi All,<div><br></div><div>Found this crash in 2.6.0<=
/div><div>Is there any open issue or workaround. Please help me with more i=
nfo on this crash.</div><div><br></div><div><br></div><div>







<p class=3D""></p></div><div><div>(gdb) bt</div><div>#0 &nbsp;0x00007fc62fe=
5bff9 in __GI_raise (sig=3Dsig@entry=3D6)</div><div>&nbsp; &nbsp; at ../npt=
l/sysdeps/unix/sysv/linux/raise.c:56</div><div>#1 &nbsp;0x00007fc62fe5f068 =
in __GI_abort () at abort.c:89</div><div>#2 &nbsp;0x00007fc62fe55146 in __a=
ssert_fail_base (</div><div>&nbsp; &nbsp; fmt=3D0x7fc62ff8d230 "%s%s%s:%u: =
%s%sAssertion `%s' failed.\n%n",&nbsp;</div><div>&nbsp; &nbsp; assertion=3D=
assertion@entry=3D0x425ba2 "!obj-&gt;refcount",&nbsp;</div><div>&nbsp; &nbs=
p; file=3Dfile@entry=3D0x425b92 "ctf-trace.c", line=3Dline@entry=3D55,&nbsp=
;</div><div>&nbsp; &nbsp; function=3Dfunction@entry=3D0x425d80 &lt;__PRETTY=
_FUNCTION__.5729&gt; "ctf_trace_destroy") at assert.c:92</div><div>#3 &nbsp=
;0x00007fc62fe551f2 in __GI___assert_fail (</div><div>&nbsp; &nbsp; asserti=
on=3Dassertion@entry=3D0x425ba2 "!obj-&gt;refcount",&nbsp;</div><div>&nbsp;=
 &nbsp; file=3Dfile@entry=3D0x425b92 "ctf-trace.c", line=3Dline@entry=3D55,=
&nbsp;</div><div>&nbsp; &nbsp; function=3Dfunction@entry=3D0x425d80 &lt;__P=
RETTY_FUNCTION__.5729&gt; "ctf_trace_destroy") at assert.c:101</div><div>#4=
 &nbsp;0x00000000004110e0 in ctf_trace_destroy (obj=3D0x7fc61001e320)</div>=
<div>&nbsp; &nbsp; at ctf-trace.c:55</div><div>#5 &nbsp;0x00000000004131f7 =
in session_destroy (</div><div>&nbsp; &nbsp; session=3Dsession@entry=3D0x7f=
c61001a3c0) at session.c:177</div><div>#6 &nbsp;0x0000000000413311 in sessi=
on_try_destroy (ht=3Dht@entry=3D0x6330e0,&nbsp;</div><div>&nbsp; &nbsp; ses=
sion=3Dsession@entry=3D0x7fc61001a3c0) at session.c:149</div><div>#7 &nbsp;=
0x00000000004078a7 in destroy_session (session=3D0x7fc61001a3c0,&nbsp;</div=
><div>&nbsp; &nbsp; sessions_ht=3D0x6330e0) at main.c:1058</div><div>#8 &nb=
sp;0x0000000000407a7d in destroy_connection (</div><div>---Type &lt;return&=
gt; to continue, or q &lt;return&gt; to quit---</div><div>&nbsp; &nbsp; rel=
ay_connections_ht=3D&lt;optimized out&gt;, conn=3D0x7fc624000d00) at main.c=
:2418</div><div>#9 &nbsp;0x000000000040aa11 in relay_thread_worker (data=3D=
&lt;optimized out&gt;)</div><div>&nbsp; &nbsp; at main.c:2568</div><div>#10=
 0x00007fc6301d8fe3 in start_thread (arg=3D0x7fc62e2f1700)</div><div>&nbsp;=
 &nbsp; at pthread_create.c:312</div><div>#11 0x00007fc62ff0eafd in clone (=
)</div><div>&nbsp; &nbsp; at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111<=
/div><div>(gdb)&nbsp;</div><div>(gdb)&nbsp;</div></div><div><br></div><div>=
<br></div><div>Thanks,</div><div>Anand Neeli</div><div><br></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev<br></blockquote><div><br><br></div><div><br></div><div>--=
 <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<=
br>http://www.efficios.com<span name=3D"x"></span><br></div></div></body></=
html>
------=_Part_39239_1034291160.1430234504111--


--===============0796254838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0796254838==--
