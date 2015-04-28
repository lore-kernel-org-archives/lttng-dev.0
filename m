From: Anand Neeli <anand.neeli@gmail.com>
Subject: lttng-relayd core
Date: Tue, 28 Apr 2015 20:22:07 +0530
Message-ID: <CAM5kDqxgbBpA29j3J66BkMoFJidEhPiHeJ+Vdtp8-3PacrD5ww__33385.3590688252$1430232815$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1238555068=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1Yn6rt-00027Q-AX
 for lttng-dev@lists.lttng.org; Tue, 28 Apr 2015 10:52:18 -0400
Received: by wgso17 with SMTP id o17so154651549wgs.1
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2015 07:52:07 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1238555068==
Content-Type: multipart/alternative; boundary=047d7b3a8906add2450514ca015c

--047d7b3a8906add2450514ca015c
Content-Type: text/plain; charset=UTF-8

Hi All,

Found this crash in 2.6.0
Is there any open issue or workaround. Please help me with more info on
this crash.


(gdb) bt
#0  0x00007fc62fe5bff9 in __GI_raise (sig=sig@entry=6)
    at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
#1  0x00007fc62fe5f068 in __GI_abort () at abort.c:89
#2  0x00007fc62fe55146 in __assert_fail_base (
    fmt=0x7fc62ff8d230 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n",
    assertion=assertion@entry=0x425ba2 "!obj->refcount",
    file=file@entry=0x425b92 "ctf-trace.c", line=line@entry=55,
    function=function@entry=0x425d80 <__PRETTY_FUNCTION__.5729>
"ctf_trace_destroy") at assert.c:92
#3  0x00007fc62fe551f2 in __GI___assert_fail (
    assertion=assertion@entry=0x425ba2 "!obj->refcount",
    file=file@entry=0x425b92 "ctf-trace.c", line=line@entry=55,
    function=function@entry=0x425d80 <__PRETTY_FUNCTION__.5729>
"ctf_trace_destroy") at assert.c:101
#4  0x00000000004110e0 in ctf_trace_destroy (obj=0x7fc61001e320)
    at ctf-trace.c:55
#5  0x00000000004131f7 in session_destroy (
    session=session@entry=0x7fc61001a3c0) at session.c:177
#6  0x0000000000413311 in session_try_destroy (ht=ht@entry=0x6330e0,
    session=session@entry=0x7fc61001a3c0) at session.c:149
#7  0x00000000004078a7 in destroy_session (session=0x7fc61001a3c0,
    sessions_ht=0x6330e0) at main.c:1058
#8  0x0000000000407a7d in destroy_connection (
---Type <return> to continue, or q <return> to quit---
    relay_connections_ht=<optimized out>, conn=0x7fc624000d00) at
main.c:2418
#9  0x000000000040aa11 in relay_thread_worker (data=<optimized out>)
    at main.c:2568
#10 0x00007fc6301d8fe3 in start_thread (arg=0x7fc62e2f1700)
    at pthread_create.c:312
#11 0x00007fc62ff0eafd in clone ()
    at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
(gdb)
(gdb)


Thanks,
Anand Neeli

--047d7b3a8906add2450514ca015c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>Found this crash in 2.6.0</div>=
<div>Is there any open issue or workaround. Please help me with more info o=
n this crash.</div><div><br></div><div><br></div><div>







<p class=3D""></p></div><div><div>(gdb) bt</div><div>#0 =C2=A00x00007fc62fe=
5bff9 in __GI_raise (sig=3Dsig@entry=3D6)</div><div>=C2=A0 =C2=A0 at ../npt=
l/sysdeps/unix/sysv/linux/raise.c:56</div><div>#1 =C2=A00x00007fc62fe5f068 =
in __GI_abort () at abort.c:89</div><div>#2 =C2=A00x00007fc62fe55146 in __a=
ssert_fail_base (</div><div>=C2=A0 =C2=A0 fmt=3D0x7fc62ff8d230 &quot;%s%s%s=
:%u: %s%sAssertion `%s&#39; failed.\n%n&quot;,=C2=A0</div><div>=C2=A0 =C2=
=A0 assertion=3Dassertion@entry=3D0x425ba2 &quot;!obj-&gt;refcount&quot;,=
=C2=A0</div><div>=C2=A0 =C2=A0 file=3Dfile@entry=3D0x425b92 &quot;ctf-trace=
.c&quot;, line=3Dline@entry=3D55,=C2=A0</div><div>=C2=A0 =C2=A0 function=3D=
function@entry=3D0x425d80 &lt;__PRETTY_FUNCTION__.5729&gt; &quot;ctf_trace_=
destroy&quot;) at assert.c:92</div><div>#3 =C2=A00x00007fc62fe551f2 in __GI=
___assert_fail (</div><div>=C2=A0 =C2=A0 assertion=3Dassertion@entry=3D0x42=
5ba2 &quot;!obj-&gt;refcount&quot;,=C2=A0</div><div>=C2=A0 =C2=A0 file=3Dfi=
le@entry=3D0x425b92 &quot;ctf-trace.c&quot;, line=3Dline@entry=3D55,=C2=A0<=
/div><div>=C2=A0 =C2=A0 function=3Dfunction@entry=3D0x425d80 &lt;__PRETTY_F=
UNCTION__.5729&gt; &quot;ctf_trace_destroy&quot;) at assert.c:101</div><div=
>#4 =C2=A00x00000000004110e0 in ctf_trace_destroy (obj=3D0x7fc61001e320)</d=
iv><div>=C2=A0 =C2=A0 at ctf-trace.c:55</div><div>#5 =C2=A00x00000000004131=
f7 in session_destroy (</div><div>=C2=A0 =C2=A0 session=3Dsession@entry=3D0=
x7fc61001a3c0) at session.c:177</div><div>#6 =C2=A00x0000000000413311 in se=
ssion_try_destroy (ht=3Dht@entry=3D0x6330e0,=C2=A0</div><div>=C2=A0 =C2=A0 =
session=3Dsession@entry=3D0x7fc61001a3c0) at session.c:149</div><div>#7 =C2=
=A00x00000000004078a7 in destroy_session (session=3D0x7fc61001a3c0,=C2=A0</=
div><div>=C2=A0 =C2=A0 sessions_ht=3D0x6330e0) at main.c:1058</div><div>#8 =
=C2=A00x0000000000407a7d in destroy_connection (</div><div>---Type &lt;retu=
rn&gt; to continue, or q &lt;return&gt; to quit---</div><div>=C2=A0 =C2=A0 =
relay_connections_ht=3D&lt;optimized out&gt;, conn=3D0x7fc624000d00) at mai=
n.c:2418</div><div>#9 =C2=A00x000000000040aa11 in relay_thread_worker (data=
=3D&lt;optimized out&gt;)</div><div>=C2=A0 =C2=A0 at main.c:2568</div><div>=
#10 0x00007fc6301d8fe3 in start_thread (arg=3D0x7fc62e2f1700)</div><div>=C2=
=A0 =C2=A0 at pthread_create.c:312</div><div>#11 0x00007fc62ff0eafd in clon=
e ()</div><div>=C2=A0 =C2=A0 at ../sysdeps/unix/sysv/linux/x86_64/clone.S:1=
11</div><div>(gdb)=C2=A0</div><div>(gdb)=C2=A0</div></div><div><br></div><d=
iv><br></div><div>Thanks,</div><div>Anand Neeli</div><div><br></div></div>

--047d7b3a8906add2450514ca015c--


--===============1238555068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1238555068==--
