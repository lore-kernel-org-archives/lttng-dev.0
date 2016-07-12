From: Aravind HT <aravind.ht@gmail.com>
Subject: Core seen with lttng_abi_map_channel()
Date: Tue, 12 Jul 2016 16:35:59 +0530
Message-ID: <CACd+_b7jEvRC6hAJh2yCeuPo5aEXuKsn5AWcEodUmdCeoy08vw__19226.7228536823$1468321579$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6226046772473849898=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-f65.google.com (mail-it0-f65.google.com
 [209.85.214.65])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 0825FA2B7B
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jul 2016 11:06:01 +0000 (UTC)
Received: by mail-it0-f65.google.com with SMTP id h190so778005ith.3
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jul 2016 04:06:01 -0700 (PDT)
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

--===============6226046772473849898==
Content-Type: multipart/alternative; boundary=001a1143de96fb9a1205376e4021

--001a1143de96fb9a1205376e4021
Content-Type: text/plain; charset=UTF-8

Hi,

Below is a recent core that I saw. Unfortunately the code is optimized, but
still it points to a call to free(lttng_chan);

(gdb) bt
#0  0x00007f3cbb0df367 in __GI_raise (sig=sig@entry=6) at
../sysdeps/unix/sysv/linux/raise.c:55
#1  0x00007f3cbb0e233a in __GI_abort () at abort.c:89
#2  0x00007f3cbb11928c in __libc_message (do_abort=do_abort@entry=2,
fmt=fmt@entry=0x7f3cbb2158c8 "*** Error in `%s': %s: 0x%s ***\n") at
../sysdeps/posix/libc_fatal.c:175
#3  0x00007f3cbb122cbe in malloc_printerr (action=3,
str=0x7f3cbb211a87 "free(): invalid pointer", ptr=<optimized out>) at
malloc.c:4960
#4  0x00007f3cbb12349b in _int_free (av=<optimized out>, p=<optimized
out>, have_lock=0) at malloc.c:3831
#5  0x00007f3cb79551c5 in lttng_abi_map_channel () from
/var/tmp/iso-path.24284/altroot/usr/lib64/liblttng-ust.so.0
#6  0x00007f3cb79554c8 in ?? () from
/var/tmp/iso-path.24284/altroot/usr/lib64/liblttng-ust.so.0
#7  0x00007f3cb7952846 in ?? () from
/var/tmp/iso-path.24284/altroot/usr/lib64/liblttng-ust.so.0
#8  0x00007f3cb8974294 in start_thread (arg=0x7f3cb1ad7700) at
pthread_create.c:336
#9  0x00007f3cbb19413d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109


Think we should not be freeing lttng_chan here.


https://github.com/dgoulet/lttng-ust-dev/blob/master/liblttng-ust/lttng-ust-abi.c#L516



Regards,
Aravind.

--001a1143de96fb9a1205376e4021
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Below is a recent core that I saw. =
Unfortunately the code is optimized, but still it points to a call to free(=
lttng_chan);</div><div><br></div><div><pre style=3D"margin-top:0px;margin-b=
ottom:0px;padding:0px;white-space:pre-wrap;word-wrap:break-word;font-size:1=
3px;color:black">(gdb) bt
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
v/blob/master/liblttng-ust/lttng-ust-abi.c#L516">https://github.com/dgoulet=
/lttng-ust-dev/blob/master/liblttng-ust/lttng-ust-abi.c#L516</a></span></pr=
e><pre style=3D"margin-top:0px;margin-bottom:0px;padding:0px;word-wrap:brea=
k-word"><font color=3D"#000000"><span style=3D"font-size:13px;white-space:p=
re-wrap"><br></span></font></pre><pre style=3D"margin-top:0px;margin-bottom=
:0px;padding:0px;white-space:pre-wrap;word-wrap:break-word;font-size:13px;c=
olor:black"><br></pre><pre style=3D"margin-top:0px;margin-bottom:0px;paddin=
g:0px;white-space:pre-wrap;word-wrap:break-word;font-size:13px;color:black"=
>Regards,
Aravind.</pre></div></div>

--001a1143de96fb9a1205376e4021--

--===============6226046772473849898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6226046772473849898==--
