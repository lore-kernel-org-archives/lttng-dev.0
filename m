From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: Core seen with lttng_abi_map_channel()
Date: Tue, 12 Jul 2016 23:09:00 +0530
Message-ID: <CACd+_b5SERDoEjDx=N3Pm6YznLgjO-fW5_GNL_ydR2CwOoNDXA__43875.2910042696$1468345159$gmane$org@mail.gmail.com>
References: <CACd+_b7jEvRC6hAJh2yCeuPo5aEXuKsn5AWcEodUmdCeoy08vw@mail.gmail.com>
 <1062783302.67453.1468331755083.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1153057480752225338=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-f67.google.com (mail-it0-f67.google.com
 [209.85.214.67])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 14FD6A2B83
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jul 2016 17:39:02 +0000 (UTC)
Received: by mail-it0-f67.google.com with SMTP id f6so1445913ith.2
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jul 2016 10:39:02 -0700 (PDT)
In-Reply-To: <1062783302.67453.1468331755083.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1153057480752225338==
Content-Type: multipart/alternative; boundary=001a1143de9688a602053773be21

--001a1143de9688a602053773be21
Content-Type: text/plain; charset=UTF-8

Thanks Mathieu.

On Tue, Jul 12, 2016 at 7:25 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ----- On Jul 12, 2016, at 7:05 AM, Aravind HT <aravind.ht@gmail.com>
> wrote:
>
> Hi,
> Below is a recent core that I saw. Unfortunately the code is optimized,
> but still it points to a call to free(lttng_chan);
>
> (gdb) bt
> #0  0x00007f3cbb0df367 in __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:55
> #1  0x00007f3cbb0e233a in __GI_abort () at abort.c:89
> #2  0x00007f3cbb11928c in __libc_message (do_abort=do_abort@entry=2, fmt=fmt@entry=0x7f3cbb2158c8 "*** Error in `%s': %s: 0x%s ***\n") at ../sysdeps/posix/libc_fatal.c:175
> #3  0x00007f3cbb122cbe in malloc_printerr (action=3, str=0x7f3cbb211a87 "free(): invalid pointer", ptr=<optimized out>) at malloc.c:4960
> #4  0x00007f3cbb12349b in _int_free (av=<optimized out>, p=<optimized out>, have_lock=0) at malloc.c:3831
> #5  0x00007f3cb79551c5 in lttng_abi_map_channel () from /var/tmp/iso-path.24284/altroot/usr/lib64/liblttng-ust.so.0
> #6  0x00007f3cb79554c8 in ?? () from /var/tmp/iso-path.24284/altroot/usr/lib64/liblttng-ust.so.0
> #7  0x00007f3cb7952846 in ?? () from /var/tmp/iso-path.24284/altroot/usr/lib64/liblttng-ust.so.0
> #8  0x00007f3cb8974294 in start_thread (arg=0x7f3cb1ad7700) at pthread_create.c:336
> #9  0x00007f3cbb19413d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:109
>
>
> Think we should not be freeing lttng_chan here.
>
>
> https://github.com/dgoulet/lttng-ust-dev/blob/master/liblttng-ust/lttng-ust-abi.c#L516
>
> By the way, this is an old repository. You should refer to
> https://github.com/lttng/lttng-ust/
> instead.
>
> There is indeed an issue there. I pushed the following fix into master,
> cherry-picked into stable 2.7 and 2.8:
>
> commit 3eae1fb99c6821530888b470528299ff187021a8
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date: Tue Jul 12 09:51:40 2016 -0400
>
> Fix: remove invalid free
>
> On this error path, we should not free lttng_chan, because it is located
> within an allocated shm memory area associated with the channel now. It
> is invalid to free this pointer.
>
> This is invoked on a channel creation error path.
>
> Reported-by: Aravind HT <aravind.ht@gmail.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
> Thanks,
>
> Mathieu
>
>
>
> Regards,
> Aravind.
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a1143de9688a602053773be21
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Mathieu.</div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">On Tue, Jul 12, 2016 at 7:25 PM, Mathieu Desnoyers <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=
=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans=
-serif;font-size:12pt;color:#000000"><span class=3D""><div><span>----- On J=
ul 12, 2016, at 7:05 AM, Aravind HT &lt;<a href=3D"mailto:aravind.ht@gmail.=
com" target=3D"_blank">aravind.ht@gmail.com</a>&gt; wrote:<br></span></div>=
</span><div><span class=3D""><blockquote style=3D"border-left:2px solid #10=
10ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font=
-size:12pt"><div dir=3D"ltr">Hi,<br><div>Below is a recent core that I saw.=
 Unfortunately the code is optimized, but still it points to a call to free=
(lttng_chan);</div><br><div><pre style=3D"margin-top:0px;margin-bottom:0px;=
padding:0px;white-space:pre-wrap;word-wrap:break-word;font-size:13px;color:=
black">(gdb) bt
#0  0x00007f3cbb0df367 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/un=
ix/sysv/linux/raise.c:55
#1  0x00007f3cbb0e233a in __GI_abort () at abort.c:89
#2  0x00007f3cbb11928c in __libc_message (do_abort=3Ddo_abort@entry=3D2, fm=
t=3Dfmt@entry=3D0x7f3cbb2158c8 &quot;*** Error in `%s&#39;: %s: 0x%s ***\n&=
quot;) at ../sysdeps/posix/libc_fatal.c:175
#3  0x00007f3cbb122cbe in malloc_printerr (action=3D3, str=3D0x7f3cbb211a87=
 &quot;free(): invalid pointer&quot;, ptr=3D&lt;optimized out&gt;) at mallo=
c.c:4960
#4  0x00007f3cbb12349b in _int_free (av=3D&lt;optimized out&gt;, p=3D&lt;op=
timized out&gt;, have_lock=3D0) at malloc.c:3831
#5  0x00007f3cb79551c5 in lttng_abi_map_channel () from /var/tmp/iso-path.2=
4284/altroot/usr/lib64/liblttng-ust.so.0
#6  0x00007f3cb79554c8 in ?? () from /var/tmp/iso-path.24284/altroot/usr/li=
b64/liblttng-ust.so.0
#7  0x00007f3cb7952846 in ?? () from /var/tmp/iso-path.24284/altroot/usr/li=
b64/liblttng-ust.so.0
#8  0x00007f3cb8974294 in start_thread (arg=3D0x7f3cb1ad7700) at pthread_cr=
eate.c:336
#9  0x00007f3cbb19413d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109</pre><pre style=3D"margin-top:0px;margin-bottom:0px;padding:0px;wh=
ite-space:pre-wrap;word-wrap:break-word;font-size:13px;color:black"><br></p=
re><pre style=3D"margin-top:0px;margin-bottom:0px;padding:0px;white-space:p=
re-wrap;word-wrap:break-word;font-size:13px;color:black">Think we should no=
t be freeing lttng_chan here.</pre><pre style=3D"margin-top:0px;margin-bott=
om:0px;padding:0px;white-space:pre-wrap;word-wrap:break-word;font-size:13px=
;color:black"><span style=3D"font-family:arial,sans-serif"><br></span></pre=
><pre style=3D"margin-top:0px;margin-bottom:0px;padding:0px;white-space:pre=
-wrap;word-wrap:break-word;font-size:13px;color:black"><span style=3D"font-=
family:arial,sans-serif"><a href=3D"https://github.com/dgoulet/lttng-ust-de=
v/blob/master/liblttng-ust/lttng-ust-abi.c#L516" target=3D"_blank">https://=
github.com/dgoulet/lttng-ust-dev/blob/master/liblttng-ust/lttng-ust-abi.c#L=
516</a></span><br></pre></div></div></blockquote></span><div>By the way, th=
is is an old repository. You should refer to <a href=3D"https://github.com/=
lttng/lttng-ust/" target=3D"_blank">https://github.com/lttng/lttng-ust/</a>=
<br></div><div>instead.<br></div><div><br></div><div>There is indeed an iss=
ue there. I pushed the following fix into master,<br></div><div>cherry-pick=
ed into stable 2.7 and 2.8:<br></div><div><br></div><div>commit 3eae1fb99c6=
821530888b470528299ff187021a8<br>Author: Mathieu Desnoyers &lt;<a href=3D"m=
ailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@e=
fficios.com</a>&gt;<br>Date: Tue Jul 12 09:51:40 2016 -0400<br><br> Fix: re=
move invalid free<br> <br> On this error path, we should not free lttng_cha=
n, because it is located<br> within an allocated shm memory area associated=
 with the channel now. It<br> is invalid to free this pointer.<br> <br> Thi=
s is invoked on a channel creation error path.<br> <br> Reported-by: Aravin=
d HT &lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">aravind.=
ht@gmail.com</a>&gt;<br> Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"ma=
ilto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@ef=
ficios.com</a>&gt;</div><div><br></div><div>Thanks,<br></div><div><br></div=
><div>Mathieu<br></div><div><br></div><div><br></div><blockquote style=3D"b=
order-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;fo=
nt-weight:normal;font-style:normal;text-decoration:none;font-family:Helveti=
ca,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div><pre style=3D"mar=
gin-top:0px;margin-bottom:0px;padding:0px;white-space:pre-wrap;word-wrap:br=
eak-word;font-size:13px;color:black"><br></pre><pre style=3D"margin-top:0px=
;margin-bottom:0px;padding:0px;white-space:pre-wrap;word-wrap:break-word;fo=
nt-size:13px;color:black">Regards,
Aravind.</pre></div></div><br>_____________________________________________=
__<br>lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org=
" target=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"https://lis=
ts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">https://=
lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><span class=3D"HOEnZb=
"><font color=3D"#888888"><br></font></span></blockquote></div><span class=
=3D"HOEnZb"><font color=3D"#888888"><div><br></div><div>-- <br></div><div>M=
athieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" ta=
rget=3D"_blank">http://www.efficios.com</a></div></font></span></div></div>=
</blockquote></div><br></div>

--001a1143de9688a602053773be21--

--===============1153057480752225338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1153057480752225338==--
