From: Aravind HT <aravind.ht@gmail.com>
Subject: Mem leak in lttng_ust lttng_probes_get_event_list()
Date: Mon, 28 Mar 2016 11:39:51 +0530
Message-ID: <CACd+_b7QyU_npdoa-NzffgA2cJpLGu0c0Yajk+bQ+hhOP=6dkQ__38082.8852569268$1459145416$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8496276003336521329=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com
 [209.85.213.176])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C5807A2EDD
 for <lttng-dev@lists.lttng.org>; Mon, 28 Mar 2016 06:09:52 +0000 (UTC)
Received: by mail-ig0-f176.google.com with SMTP id cl4so46318880igb.0
 for <lttng-dev@lists.lttng.org>; Sun, 27 Mar 2016 23:09:52 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8496276003336521329==
Content-Type: multipart/alternative; boundary=089e0122e720bc0613052f15c201

--089e0122e720bc0613052f15c201
Content-Type: text/plain; charset=UTF-8

Hi,

I have seen that the RES mem from TOP increases over time for an
application that
is being traced. When analyzed with valgrind, I see the following

==12429== 175,824 bytes in 594 blocks are possibly lost in loss record 30
of 30
==12429==    at 0x4C29810: calloc (in
/usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==12429==    by 0x54AF21E: calloc (in
/usr/lib64/liblttng-ust-libc-wrapper.so.0.0.0)
==12429==    by 0x526C27B: lttng_probes_get_event_list (in
/usr/lib64/liblttng-ust.so.0.0.0)
==12429==    by 0x526AD9E: ??? (in /usr/lib64/liblttng-ust.so.0.0.0)
==12429==    by 0x5267FAF: ??? (in /usr/lib64/liblttng-ust.so.0.0.0)
==12429==    by 0x503CFE2: start_thread (pthread_create.c:312)
==12429==    by 0x579BAFC: clone (clone.S:111)


There is a memleak seen when lttng_probes_get_event_list() gets called
during listing of
trace points, example "lttng list -u". Each time
lttng_probes_get_event_list() gets called,
objd_alloc() is called and a new list of trace points generated in
lttng_probes_get_event_list()
and stored.
This entry in the objd_table is not reused when "lttng list -u" gets called
again in the future
and is also not removed until the application exits resulting in memory
consumption.

I can see that the objd_table is meant to be used as a cache but somehow
the full implementation is not present..is this a work still in progress ?
If not, to solve this, whenever lttng_probes_get_event_list() is called, we
could check if we have results available in the objd_table from an earlier
call for a particular owner and name and re-use it.

Regards,
Aravind.

--089e0122e720bc0613052f15c201
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div><div>I have seen that the RES mem f=
rom TOP increases over time for an application that</div><div>is being trac=
ed. When analyzed with valgrind, I see the following</div><div><br></div><d=
iv>=3D=3D12429=3D=3D 175,824 bytes in 594 blocks are possibly lost in loss =
record 30 of 30</div><div>=3D=3D12429=3D=3D =C2=A0 =C2=A0at 0x4C29810: call=
oc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)</div><div>=3D=
=3D12429=3D=3D =C2=A0 =C2=A0by 0x54AF21E: calloc (in /usr/lib64/liblttng-us=
t-libc-wrapper.so.0.0.0)</div><div>=3D=3D12429=3D=3D =C2=A0 =C2=A0by 0x526C=
27B: lttng_probes_get_event_list (in /usr/lib64/liblttng-ust.so.0.0.0)</div=
><div>=3D=3D12429=3D=3D =C2=A0 =C2=A0by 0x526AD9E: ??? (in /usr/lib64/liblt=
tng-ust.so.0.0.0)</div><div>=3D=3D12429=3D=3D =C2=A0 =C2=A0by 0x5267FAF: ??=
? (in /usr/lib64/liblttng-ust.so.0.0.0)</div><div>=3D=3D12429=3D=3D =C2=A0 =
=C2=A0by 0x503CFE2: start_thread (pthread_create.c:312)</div><div>=3D=3D124=
29=3D=3D =C2=A0 =C2=A0by 0x579BAFC: clone (clone.S:111)</div><div><br></div=
><div><br></div><div>There is a memleak seen when lttng_probes_get_event_li=
st() gets called during listing of =C2=A0</div><div>trace points, example &=
quot;lttng list -u&quot;. Each time lttng_probes_get_event_list() gets call=
ed,</div><div>objd_alloc() is called and a new list of trace points generat=
ed in lttng_probes_get_event_list()</div><div>and stored.</div><div>This en=
try in the objd_table is not reused when &quot;lttng list -u&quot; gets cal=
led again in the future=C2=A0</div><div>and is also not removed until the a=
pplication exits resulting in memory consumption.=C2=A0</div><div><br></div=
><div>I can see that the objd_table is meant to be used as a cache but some=
how the full implementation is not present..is this a work still in progres=
s ? If not, to solve this, whenever lttng_probes_get_event_list() is called=
, we could check if we have results available in the objd_table from an ear=
lier call for a particular owner and name and re-use it.=C2=A0</div></div><=
div><br></div><div>Regards,</div><div>Aravind.</div></div>

--089e0122e720bc0613052f15c201--

--===============8496276003336521329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8496276003336521329==--
