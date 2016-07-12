From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Core seen with lttng_abi_map_channel()
Date: Tue, 12 Jul 2016 13:55:55 +0000 (UTC)
Message-ID: <1062783302.67453.1468331755083.JavaMail.zimbra__46147.3871874206$1468331784$gmane$org@efficios.com>
References: <CACd+_b7jEvRC6hAJh2yCeuPo5aEXuKsn5AWcEodUmdCeoy08vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5085739069546474052=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 0EC85A3B28
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jul 2016 13:56:02 +0000 (UTC)
In-Reply-To: <CACd+_b7jEvRC6hAJh2yCeuPo5aEXuKsn5AWcEodUmdCeoy08vw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Aravind HT <aravind.ht@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5085739069546474052==
Content-Type: multipart/alternative;
	boundary="----=_Part_67452_719856138.1468331755082"

------=_Part_67452_719856138.1468331755082
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jul 12, 2016, at 7:05 AM, Aravind HT <aravind.ht@gmail.com> wrote: 

> Hi,
> Below is a recent core that I saw. Unfortunately the code is optimized, but
> still it points to a call to free(lttng_chan);

> (gdb) bt
> #0  0x00007f3cbb0df367 in __GI_raise (sig=sig@entry=6) at
> ../sysdeps/unix/sysv/linux/raise.c:55
> #1  0x00007f3cbb0e233a in __GI_abort () at abort.c:89
> #2  0x00007f3cbb11928c in __libc_message (do_abort=do_abort@entry=2,
> fmt=fmt@entry=0x7f3cbb2158c8 "*** Error in `%s': %s: 0x%s ***\n") at
> ../sysdeps/posix/libc_fatal.c:175
> #3  0x00007f3cbb122cbe in malloc_printerr (action=3, str=0x7f3cbb211a87 "free():
> invalid pointer", ptr=<optimized out>) at malloc.c:4960
> #4  0x00007f3cbb12349b in _int_free (av=<optimized out>, p=<optimized out>,
> have_lock=0) at malloc.c:3831
> #5  0x00007f3cb79551c5 in lttng_abi_map_channel () from
> /var/tmp/iso-path.24284/altroot/usr/lib64/liblttng-ust.so.0
> #6  0x00007f3cb79554c8 in ?? () from
> /var/tmp/iso-path.24284/altroot/usr/lib64/liblttng-ust.so.0
> #7  0x00007f3cb7952846 in ?? () from
> /var/tmp/iso-path.24284/altroot/usr/lib64/liblttng-ust.so.0
> #8  0x00007f3cb8974294 in start_thread (arg=0x7f3cb1ad7700) at
> pthread_create.c:336
> #9  0x00007f3cbb19413d in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:109

> Think we should not be freeing lttng_chan here.

> https://github.com/dgoulet/lttng-ust-dev/blob/master/liblttng-ust/lttng-ust-abi.c#L516

By the way, this is an old repository. You should refer to https://github.com/lttng/lttng-ust/ 
instead. 

There is indeed an issue there. I pushed the following fix into master, 
cherry-picked into stable 2.7 and 2.8: 

commit 3eae1fb99c6821530888b470528299ff187021a8 
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 
Date: Tue Jul 12 09:51:40 2016 -0400 

Fix: remove invalid free 

On this error path, we should not free lttng_chan, because it is located 
within an allocated shm memory area associated with the channel now. It 
is invalid to free this pointer. 

This is invoked on a channel creation error path. 

Reported-by: Aravind HT <aravind.ht@gmail.com> 
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 

Thanks, 

Mathieu 

> Regards,
> Aravind.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_67452_719856138.1468331755082
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Jul 12, 2016, at 7:05 AM, Aravind HT &lt;aravind.ht@gmail.com&=
gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote=
 style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;co=
lor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fam=
ily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Hi,<br><di=
v>Below is a recent core that I saw. Unfortunately the code is optimized, b=
ut still it points to a call to free(lttng_chan);</div><br><div><pre style=
=3D"margin-top:0px;margin-bottom:0px;padding:0px;white-space:pre-wrap;word-=
wrap:break-word;font-size:13px;color:black">(gdb) bt
#0  0x00007f3cbb0df367 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/un=
ix/sysv/linux/raise.c:55
#1  0x00007f3cbb0e233a in __GI_abort () at abort.c:89
#2  0x00007f3cbb11928c in __libc_message (do_abort=3Ddo_abort@entry=3D2, fm=
t=3Dfmt@entry=3D0x7f3cbb2158c8 "*** Error in `%s': %s: 0x%s ***\n") at ../s=
ysdeps/posix/libc_fatal.c:175
#3  0x00007f3cbb122cbe in malloc_printerr (action=3D3, str=3D0x7f3cbb211a87=
 "free(): invalid pointer", ptr=3D&lt;optimized out&gt;) at malloc.c:4960
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
516</a></span><br data-mce-bogus=3D"1"></pre></div></div></blockquote><div>=
By the way, this is an old repository. You should refer to https://github.c=
om/lttng/lttng-ust/<br></div><div>instead.<br data-mce-bogus=3D"1"></div><d=
iv><br data-mce-bogus=3D"1"></div><div>There is indeed an issue there. I pu=
shed the following fix into master,<br data-mce-bogus=3D"1"></div><div>cher=
ry-picked into stable 2.7 and 2.8:<br data-mce-bogus=3D"1"></div><div><br d=
ata-mce-bogus=3D"1"></div><div>commit 3eae1fb99c6821530888b470528299ff18702=
1a8<br>Author: Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>=
Date: Tue Jul 12 09:51:40 2016 -0400<br><br> Fix: remove invalid free<br> <=
br> On this error path, we should not free lttng_chan, because it is locate=
d<br> within an allocated shm memory area associated with the channel now. =
It<br> is invalid to free this pointer.<br> <br> This is invoked on a chann=
el creation error path.<br> <br> Reported-by: Aravind HT &lt;aravind.ht@gma=
il.com&gt;<br> Signed-off-by: Mathieu Desnoyers &lt;mathieu.desnoyers@effic=
ios.com&gt;</div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-m=
ce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br da=
ta-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><br data-=
mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;ma=
rgin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:nor=
mal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:1=
2pt;"><div dir=3D"ltr"><div><pre style=3D"margin-top:0px;margin-bottom:0px;=
padding:0px;white-space:pre-wrap;word-wrap:break-word;font-size:13px;color:=
black"><br></pre><pre style=3D"margin-top:0px;margin-bottom:0px;padding:0px=
;white-space:pre-wrap;word-wrap:break-word;font-size:13px;color:black">Rega=
rds,
Aravind.</pre></div></div><br>_____________________________________________=
__<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>https://lists.=
lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><div><br=
></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyer=
s<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_67452_719856138.1468331755082--

--===============5085739069546474052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5085739069546474052==--
