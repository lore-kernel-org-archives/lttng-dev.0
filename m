From: Anand Neeli <anand.neeli@gmail.com>
Subject: lttng-relayd core at relay_close_stream
Date: Thu, 23 Apr 2015 00:26:28 +0530
Message-ID: <CAM5kDqw_sa93tu+tGimeWZPE4xoaVQF1PNhpD3F-1=WO2M23hg__39749.0259296775$1429729078$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0452107955=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1Ykzp4-0001Q3-53
 for lttng-dev@lists.lttng.org; Wed, 22 Apr 2015 14:56:39 -0400
Received: by wizk4 with SMTP id k4so189478932wiz.1
 for <lttng-dev@lists.lttng.org>; Wed, 22 Apr 2015 11:56:28 -0700 (PDT)
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

--===============0452107955==
Content-Type: multipart/alternative; boundary=f46d0435c0187b15c4051454b8d8

--f46d0435c0187b15c4051454b8d8
Content-Type: text/plain; charset=UTF-8

Hi,
I see following relayd core in 2.6
is there any fix or is this a known issue?

(gdb) bt
#0  0x00007fccd7d54ff9 in __GI_raise (sig=sig@entry=6) at
../nptl/sysdeps/unix/sysv/linux/raise.c:56
#1  0x00007fccd7d58068 in __GI_abort () at abort.c:89
#2  0x00007fccd7d4e146 in __assert_fail_base (
    fmt=0x7fccd7e86230 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n",
    assertion=assertion@entry=0x4209da "ctf_trace", file=file@entry=0x4209bf
"main.c", line=line@entry=737,
    function=function@entry=0x4237a0 <__PRETTY_FUNCTION__.9535>
"try_close_stream") at assert.c:92
#3  0x00007fccd7d4e1f2 in __GI___assert_fail
(assertion=assertion@entry=0x4209da
"ctf_trace",
    file=file@entry=0x4209bf "main.c", line=line@entry=737,
    function=function@entry=0x4237a0 <__PRETTY_FUNCTION__.9535>
"try_close_stream") at assert.c:101
#4  0x00000000004079f0 in try_close_stream (session=0x7fccc801c780,
stream=0x7fccc8024500) at main.c:737
#5  0x0000000000408e8b in relay_close_stream (recv_hdr=0x7fccd61e9b40,
conn=0x7fcccc000ec0) at main.c:1360
#6  relay_process_control (recv_hdr=recv_hdr@entry=0x7fccd61e9c60,
conn=0x7fcccc000ec0) at main.c:2106
#7  0x000000000040a9e3 in relay_thread_worker (data=<optimized out>) at
main.c:2564
#8  0x00007fccd80d1fe3 in start_thread (arg=0x7fccd61ea700) at
pthread_create.c:312
#9  0x00007fccd7e07afd in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111


Thanks,
Anand Neeli

--f46d0435c0187b15c4051454b8d8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>I see following relayd core in 2.6</div><div>is th=
ere any fix or is this a known issue?</div><div><br></div><div><div>(gdb) b=
t</div><div>#0 =C2=A00x00007fccd7d54ff9 in __GI_raise (sig=3Dsig@entry=3D6)=
 at ../nptl/sysdeps/unix/sysv/linux/raise.c:56</div><div>#1 =C2=A00x00007fc=
cd7d58068 in __GI_abort () at abort.c:89</div><div>#2 =C2=A00x00007fccd7d4e=
146 in __assert_fail_base (</div><div>=C2=A0 =C2=A0 fmt=3D0x7fccd7e86230 &q=
uot;%s%s%s:%u: %s%sAssertion `%s&#39; failed.\n%n&quot;,=C2=A0</div><div>=
=C2=A0 =C2=A0 assertion=3Dassertion@entry=3D0x4209da &quot;ctf_trace&quot;,=
 file=3Dfile@entry=3D0x4209bf &quot;main.c&quot;, line=3Dline@entry=3D737,=
=C2=A0</div><div>=C2=A0 =C2=A0 function=3Dfunction@entry=3D0x4237a0 &lt;__P=
RETTY_FUNCTION__.9535&gt; &quot;try_close_stream&quot;) at assert.c:92</div=
><div>#3 =C2=A00x00007fccd7d4e1f2 in __GI___assert_fail (assertion=3Dassert=
ion@entry=3D0x4209da &quot;ctf_trace&quot;,=C2=A0</div><div>=C2=A0 =C2=A0 f=
ile=3Dfile@entry=3D0x4209bf &quot;main.c&quot;, line=3Dline@entry=3D737,=C2=
=A0</div><div>=C2=A0 =C2=A0 function=3Dfunction@entry=3D0x4237a0 &lt;__PRET=
TY_FUNCTION__.9535&gt; &quot;try_close_stream&quot;) at assert.c:101</div><=
div>#4 =C2=A00x00000000004079f0 in try_close_stream (session=3D0x7fccc801c7=
80, stream=3D0x7fccc8024500) at main.c:737</div><div>#5 =C2=A00x00000000004=
08e8b in relay_close_stream (recv_hdr=3D0x7fccd61e9b40, conn=3D0x7fcccc000e=
c0) at main.c:1360</div><div>#6 =C2=A0relay_process_control (recv_hdr=3Drec=
v_hdr@entry=3D0x7fccd61e9c60, conn=3D0x7fcccc000ec0) at main.c:2106</div><d=
iv>#7 =C2=A00x000000000040a9e3 in relay_thread_worker (data=3D&lt;optimized=
 out&gt;) at main.c:2564</div><div>#8 =C2=A00x00007fccd80d1fe3 in start_thr=
ead (arg=3D0x7fccd61ea700) at pthread_create.c:312</div><div>#9 =C2=A00x000=
07fccd7e07afd in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111<=
/div></div><div><br></div><div><br></div><div>Thanks,</div><div>Anand Neeli=
</div><div><br></div></div>

--f46d0435c0187b15c4051454b8d8--


--===============0452107955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0452107955==--
