From: Anders Wallin <wallinux@gmail.com>
Subject: Re: lttng-consumerd crash on aarch64 due to x86 arch
 specific optimization
Date: Thu, 28 Dec 2017 14:13:22 +0000
Message-ID: <CAF2baFecVMCenooHSMcNChMEkevz1taF0VWUxWAyxbUq8kVXSg__16129.7973282219$1514470314$gmane$org@mail.gmail.com>
References: <CAF2baFfZ+sxAGfxGY_or7=JJMxDngZTtfrzruUC5=RnZFD4tvA@mail.gmail.com>
 <954909194.21985.1511551181212.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6143442311900292999=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 by lists.lttng.org (Postfix) with ESMTPS id 3z6sC25253znnL
 for <lttng-dev@lists.lttng.org>; Thu, 28 Dec 2017 14:13:34 +0000 (UTC)
Received: by mail-oi0-x241.google.com with SMTP id s9so27123118oie.5
 for <lttng-dev@lists.lttng.org>; Thu, 28 Dec 2017 06:13:34 -0800 (PST)
In-Reply-To: <954909194.21985.1511551181212.JavaMail.zimbra@efficios.com>
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

--===============6143442311900292999==
Content-Type: multipart/alternative; boundary="001a113cd88c01e2640561671f19"

--001a113cd88c01e2640561671f19
Content-Type: text/plain; charset="UTF-8"

Hi Mathieu,

I finally got some time to dig into this issue. The crash only happens when
metadata is written AND the size of the metadata will end up in a write
that is 8,4,2 or 1 bytes long AND
that the source or destination is not aligned correctly according to HW
limitation. I have not found any simple way to keep the performance
enhancement code that is run most of the time.
Maybe the metadata writes should have it's own write function instead.

Here is an example of a crash (code is from lttng-ust 2.9.1 and lttng-tools
2.9.6) where the size is 8 bytes and the src address is unaligned at
0xf3b7eeb2;

#0  lttng_inline_memcpy (len=8, src=0xf3b7eeb2, dest=<optimized out>) at
/usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/backend_internal.h:610
No locals.
#1  lib_ring_buffer_write (len=8, src=0xf3b7eeb2, ctx=0xf57c47d0,
config=0xf737c560 <client_config>) at
/usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/backend.h:100
        __len = 8
        handle = 0xf3b2e0c0
        backend_pages = <optimized out>
        chanb = 0xf3b2e2e0
        offset = <optimized out>

#2  lttng_event_write (ctx=0xf57c47d0, src=0xf3b7eeb2, len=8) at
/usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust/lttng-ring-buffer-metadata-client.h:267
No locals.

#3  0xf7337ef8 in ustctl_write_one_packet_to_channel (channel=<optimized
out>, metadata_str=0xf3b7eeb2 "", len=<optimized out>) at
/usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust-ctl/ustctl.c:1183
        ctx = {chan = 0xf3b2e290, priv = 0x0, handle = 0xf3b2e0c0,
data_size = 8, largest_align = 1, cpu = -1, buf = 0xf6909000, slot_size =
8, buf_offset = 163877, pre_offset = 163877, tsc = 0, rflags = 0, ctx_len =
80, ip = 0x0, priv2 = 0x0, padding2 = '\000' <repeats 11 times>,
backend_pages = 0xf690c000}
        chan = 0xf3b2e4d8
        str = 0xf3b7eeb2 ""
        reserve_len = 8
        ret = <optimized out>
        __func__ = '\000' <repeats 34 times>
        __PRETTY_FUNCTION__ = '\000' <repeats 34 times>
---Type <return> to continue, or q <return> to quit---

#4  0x000344cc in commit_one_metadata_packet (stream=stream@entry=0xf3b2e560)
at ust-consumer.c:2206
        write_len = <optimized out>
        ret = <optimized out>
        __PRETTY_FUNCTION__ = "commit_one_metadata_packet"

#5  0x00036538 in lttng_ustconsumer_read_subbuffer
(stream=stream@entry=0xf3b2e560,
ctx=ctx@entry=0x25e6e8) at ust-consumer.c:2452
        len = 4096
        subbuf_size = 4093
        padding = <optimized out>
        err = -11
        write_index = 1
        ret = <optimized out>
        ustream = <optimized out>
        index = {offset = 0, packet_size = 575697416355872, content_size =
17564043391468256584, timestamp_begin = 17564043425827782792, timestamp_end
= 34359738496,

Regards
Anders

fre 24 nov. 2017 kl 20:18 skrev Mathieu Desnoyers <
mathieu.desnoyers@efficios.com>:

> ----- On Nov 24, 2017, at 3:23 AM, Anders Wallin <wallinux@gmail.com>
> wrote:
>
> Hi,
> architectures that has memory alignment restrictions may/will fail with
> the
> optimization done in 51b8f2fa2b972e62117caa946dd3e3565b6ca4a3.
> Please revert the patch or make it X86 specific.
>
>
> Hi Anders,
>
> This was added in the development cycle of lttng-ust 2.9. We could perhaps
> add a test on the pointer alignment for architectures that care about it,
> and
> fallback to memcpy in those cases.
>
> The revert approach would have been justified if this commit had been
> backported
> as a "fix" to a stable branch, which is not the case here. We should work
> on
> finding an acceptable solution that takes care of dealing with unaligned
> pointers
> on architectures that care about the difference.
>
> Thanks,
>
> Mathieu
>
>
>
> Regards
>
> Anders Wallin
>
> ------------------------------------------------------------------------------------------------------------
> commit 51b8f2fa2b972e62117caa946dd3e3565b6ca4a3
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Sun Sep 25 12:31:11 2016 -0400
>
>     Performance: implement lttng_inline_memcpy
>     Because all length parameters received for serializing data coming from
>     applications go through a callback, they are never constant, and it
>     hurts performance to perform a call to memcpy each time.
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
> diff --git a/libringbuffer/backend_internal.h
> b/libringbuffer/backend_internal.h
> index 90088b89..e597cf4d 100644
> --- a/libringbuffer/backend_internal.h
> +++ b/libringbuffer/backend_internal.h
> @@ -592,6 +592,28 @@ int update_read_sb_index(const struct
> lttng_ust_lib_ring_buffer_config *config,
>  #define inline_memcpy(dest, src, n)    memcpy(dest, src, n)
>  #endif
> +static inline __attribute__((always_inline))
> +void lttng_inline_memcpy(void *dest, const void *src,
> +               unsigned long len)
> +{
> +       switch (len) {
> +       case 1:
> +               *(uint8_t *) dest = *(const uint8_t *) src;
> +               break;
> +       case 2:
> +               *(uint16_t *) dest = *(const uint16_t *) src;
> +               break;
> +       case 4:
> +               *(uint32_t *) dest = *(const uint32_t *) src;
> +               break;
> +       case 8:
> +               *(uint64_t *) dest = *(const uint64_t *) src;
> +               break;
> +       default:
> +               inline_memcpy(dest, src, len);
> +       }
> +}
> +
>  /*
>   * Use the architecture-specific memcpy implementation for constant-sized
>   * inputs, but rely on an inline memcpy for length statically unknown.
> @@ -603,7 +625,7 @@ do {
>               \
>         if (__builtin_constant_p(len))                          \
>                 memcpy(dest, src, __len);                       \
>         else                                                    \
> -               inline_memcpy(dest, src, __len);                \
> +               lttng_inline_memcpy(dest, src, __len);          \
>  } while (0)
>  /*
>
>
> ----------------------------------------------------------------------------------------------------
> Here is one example of a crash, where 0xf3b7eeb2 is not 8 byte aligned;
>
>   (gdb) bt full
> #0  lttng_inline_memcpy (len=8, src=0xf3b7eeb2, dest=<optimized out>) at
> /usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/backend_internal.h:610
> No locals.
> #1  lib_ring_buffer_write (len=8, src=0xf3b7eeb2, ctx=0xf57c47d0,
> config=0xf737c560 <client_config>) at
> /usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/backend.h:100
>         __len = 8
>         handle = 0xf3b2e0c0
>         backend_pages = <optimized out>
>         chanb = 0xf3b2e2e0
>         offset = <optimized out>
> #2  lttng_event_write (ctx=0xf57c47d0, src=0xf3b7eeb2, len=8) at
> /usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust/lttng-ring-buffer-metadata-client.h:267
> No locals.
> #3  0xf7337ef8 in ustctl_write_one_packet_to_channel (channel=<optimized
> out>, metadata_str=0xf3b7eeb2 "", len=<optimized out>) at
> /usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust-ctl/ustctl.c:1183
>         ctx = {chan = 0xf3b2e290, priv = 0x0, handle = 0xf3b2e0c0,
> data_size = 8, largest_align = 1, cpu = -1, buf = 0xf6909000, slot_size =
> 8, buf_offset = 163877, pre_offset = 163877, tsc = 0, rflags = 0, ctx_len =
> 80, ip = 0x0, priv2 = 0x0, padding2 = '\000' <repeats 11 times>,
> backend_pages = 0xf690c000}
>         chan = 0xf3b2e4d8
>         str = 0xf3b7eeb2 ""
>         reserve_len = 8
>         ret = <optimized out>
>         __func__ = '\000' <repeats 34 times>
>         __PRETTY_FUNCTION__ = '\000' <repeats 34 times>
> ---Type <return> to continue, or q <return> to quit---
> #4  0x000344cc in commit_one_metadata_packet (stream=stream@entry=0xf3b2e560)
> at ust-consumer.c:2206
>         write_len = <optimized out>
>         ret = <optimized out>
>         __PRETTY_FUNCTION__ = "commit_one_metadata_packet"
> #5  0x00036538 in lttng_ustconsumer_read_subbuffer (stream=stream@entry=0xf3b2e560,
> ctx=ctx@entry=0x25e6e8) at ust-consumer.c:2452
>         len = 4096
>         subbuf_size = 4093
>         padding = <optimized out>
>         err = -11
>         write_index = 1
>         ret = <optimized out>
>         ustream = <optimized out>
>         index = {offset = 0, packet_size = 575697416355872, content_size =
> 17564043391468256584, timestamp_begin = 17564043425827782792, timestamp_end
> = 34359738496, events_discarded = 313327092840, stream_id = 4089446416,
> stream_instance_id = 17689097291346376608, packet_seq_num = 8589934593}
>         __PRETTY_FUNCTION__ = "lttng_ustconsumer_read_subbuffer"
>         __func__ = "lttng_ustconsumer_read_subbuffer"
> .....
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

--001a113cd88c01e2640561671f19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Mathieu,</div><div><br></div><div>I finally got so=
me time to dig into this issue. The crash only happens when metadata is wri=
tten AND the size of the metadata will end up in a write that is 8,4,2 or 1=
 bytes long AND</div><div>that the source or destination is not aligned cor=
rectly according to HW limitation. I have not found any simple way to keep =
the performance enhancement code that is run most of the time.</div><div>Ma=
ybe the metadata writes should have it&#39;s own write function instead.</d=
iv><div><br></div><div>Here is an example of a crash (code is from lttng-us=
t 2.9.1 and lttng-tools 2.9.6) where the size is 8 bytes and the src addres=
s is unaligned at 0xf3b7eeb2;</div><div><br></div><div>#0=C2=A0 lttng_inlin=
e_memcpy (len=3D8, src=3D0xf3b7eeb2, dest=3D&lt;optimized out&gt;) at /usr/=
src/debug/lttng-ust/2.9.1/git/libringbuffer/backend_internal.h:610</div><di=
v>No locals.</div><div>#1=C2=A0 lib_ring_buffer_write (len=3D8, src=3D0xf3b=
7eeb2, ctx=3D0xf57c47d0, config=3D0xf737c560 &lt;client_config&gt;) at /usr=
/src/debug/lttng-ust/2.9.1/git/libringbuffer/backend.h:100</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 __len =3D 8</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 han=
dle =3D 0xf3b2e0c0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 backend_pages =3D =
&lt;optimized out&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 chanb =3D 0xf3b=
2e2e0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 offset =3D &lt;optimized out&gt=
;</div><div><br></div><div>#2=C2=A0 lttng_event_write (ctx=3D0xf57c47d0, sr=
c=3D0xf3b7eeb2, len=3D8) at /usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust=
/lttng-ring-buffer-metadata-client.h:267</div><div>No locals.</div><div><br=
></div><div>#3=C2=A0 0xf7337ef8 in ustctl_write_one_packet_to_channel (chan=
nel=3D&lt;optimized out&gt;, metadata_str=3D0xf3b7eeb2 &quot;&quot;, len=3D=
&lt;optimized out&gt;) at /usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust-c=
tl/ustctl.c:1183</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D {chan =3D 0x=
f3b2e290, priv =3D 0x0, handle =3D 0xf3b2e0c0, data_size =3D 8, largest_ali=
gn =3D 1, cpu =3D -1, buf =3D 0xf6909000, slot_size =3D 8, buf_offset =3D 1=
63877, pre_offset =3D 163877, tsc =3D 0, rflags =3D 0, ctx_len =3D 80, ip =
=3D 0x0, priv2 =3D 0x0, padding2 =3D &#39;\000&#39; &lt;repeats 11 times&gt=
;, backend_pages =3D 0xf690c000}</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 chan=
 =3D 0xf3b2e4d8</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D 0xf3b7eeb2 &q=
uot;&quot;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 reserve_len =3D 8</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D &lt;optimized out&gt;</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 __func__ =3D &#39;\000&#39; &lt;repeats 34 times&g=
t;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 __PRETTY_FUNCTION__ =3D &#39;\000&=
#39; &lt;repeats 34 times&gt;</div><div>---Type &lt;return&gt; to continue,=
 or q &lt;return&gt; to quit---</div><div><br></div><div>#4=C2=A0 0x000344c=
c in commit_one_metadata_packet (stream=3Dstream@entry=3D0xf3b2e560) at ust=
-consumer.c:2206</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 write_len =3D &lt;op=
timized out&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D &lt;optimized=
 out&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 __PRETTY_FUNCTION__ =3D &quo=
t;commit_one_metadata_packet&quot;</div><div><br></div><div>#5=C2=A0 0x0003=
6538 in lttng_ustconsumer_read_subbuffer (stream=3Dstream@entry=3D0xf3b2e56=
0, ctx=3Dctx@entry=3D0x25e6e8) at ust-consumer.c:2452</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 len =3D 4096</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 subbuf=
_size =3D 4093</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 padding =3D &lt;optimi=
zed out&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -11</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 write_index =3D 1</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ret =3D &lt;optimized out&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ustream =3D &lt;optimized out&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ind=
ex =3D {offset =3D 0, packet_size =3D 575697416355872, content_size =3D 175=
64043391468256584, timestamp_begin =3D 17564043425827782792, timestamp_end =
=3D 34359738496,=C2=A0</div><div>=C2=A0=C2=A0</div><div>Regards</div><div>A=
nders</div><br><div class=3D"gmail_quote"><div dir=3D"ltr">fre 24 nov. 2017=
 kl 20:18 skrev Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@e=
fficios.com">mathieu.desnoyers@efficios.com</a>&gt;:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-serif=
;font-size:12pt;color:#000000"><div><span id=3D"m_-5571751394780357742zwchr=
">----- On Nov 24, 2017, at 3:23 AM, Anders Wallin &lt;<a href=3D"mailto:wa=
llinux@gmail.com" target=3D"_blank">wallinux@gmail.com</a>&gt; wrote:<br></=
span></div></div></div><div><div style=3D"font-family:arial,helvetica,sans-=
serif;font-size:12pt;color:#000000"><div><blockquote style=3D"border-left:2=
px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:no=
rmal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,san=
s-serif;font-size:12pt"><div dir=3D"ltr">Hi,<br><div>architectures that has=
 memory alignment restrictions may/will fail with the=C2=A0</div><div>optim=
ization done in=C2=A051b8f2fa2b972e62117caa946dd3e3565b6ca4a3.</div><div>Pl=
ease revert the patch or make it X86 specific.</div></div></blockquote><div=
><br></div></div></div></div><div><div style=3D"font-family:arial,helvetica=
,sans-serif;font-size:12pt;color:#000000"><div><div>Hi Anders,<br></div><di=
v><br></div><div>This was added in the development cycle of lttng-ust 2.9. =
We could perhaps<br></div><div>add a test on the pointer alignment for arch=
itectures that care about it, and<br></div><div>fallback to memcpy in those=
 cases.<br></div><div><br></div><div>The revert approach would have been ju=
stified if this commit had been backported</div><div>as a &quot;fix&quot; t=
o a stable branch, which is not the case here. We should work on<br></div><=
div>finding an acceptable solution that takes care of dealing with unaligne=
d pointers<br></div><div>on architectures that care about the difference.<b=
r></div><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br=
></div><div><br></div><div><br></div><blockquote style=3D"border-left:2px s=
olid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal=
;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-se=
rif;font-size:12pt"></blockquote></div></div></div><div><div style=3D"font-=
family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><div><block=
quote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5=
px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fon=
t-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><br><d=
iv>Regards</div><br><div>Anders Wallin</div><div>--------------------------=
---------------------------------------------------------------------------=
-------</div><div><div>commit 51b8f2fa2b972e62117caa946dd3e3565b6ca4a3</div=
><div>Author: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@eff=
icios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</div><d=
iv>Date:=C2=A0 =C2=A0Sun Sep 25 12:31:11 2016 -0400</div><br><div>=C2=A0 =
=C2=A0 Performance: implement lttng_inline_memcpy</div><div>=C2=A0 =C2=A0 B=
ecause all length parameters received for serializing data coming from</div=
><div>=C2=A0 =C2=A0 applications go through a callback, they are never cons=
tant, and it</div><div>=C2=A0 =C2=A0 hurts performance to perform a call to=
 memcpy each time.</div><div>=C2=A0 =C2=A0 Signed-off-by: Mathieu Desnoyers=
 &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">ma=
thieu.desnoyers@efficios.com</a>&gt;</div><br><div>diff --git a/libringbuff=
er/backend_internal.h b/libringbuffer/backend_internal.h</div><div>index 90=
088b89..e597cf4d 100644</div><div>--- a/libringbuffer/backend_internal.h</d=
iv><div>+++ b/libringbuffer/backend_internal.h</div><div>@@ -592,6 +592,28 =
@@ int update_read_sb_index(const struct lttng_ust_lib_ring_buffer_config *=
config,</div><div>=C2=A0#define inline_memcpy(dest, src, n)=C2=A0 =C2=A0 me=
mcpy(dest, src, n)</div><div>=C2=A0#endif</div><div>+static inline __attrib=
ute__((always_inline))</div><div>+void lttng_inline_memcpy(void *dest, cons=
t void *src,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0unsigned long len)</div><div>+{</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0switch (len) {</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0case 1:</div><div>+=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(uint8_t *) dest =
=3D *(const uint8_t *) src;</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0case 2:</d=
iv><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(uint16_t =
*) dest =3D *(const uint16_t *) src;</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0ca=
se 4:</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(u=
int32_t *) dest =3D *(const uint32_t *) src;</div><div>+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;</div><div>+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0case 8:</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*(uint64_t *) dest =3D *(const uint64_t *) src;</div><div>+=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;</div><div>+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0default:</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0inline_memcpy(dest, src, len);</div><div>+=C2=A0 =C2=A0=
 =C2=A0 =C2=A0}</div><div>+}</div><div>+</div><div>=C2=A0/*</div><div>=C2=
=A0 * Use the architecture-specific memcpy implementation for constant-size=
d</div><div>=C2=A0 * inputs, but rely on an inline memcpy for length static=
ally unknown.</div><div>@@ -603,7 +625,7 @@ do {=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (__builtin_constant_p(len))=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(dest, src, __le=
n);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 else=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0inline_memcpy(dest, src, __len);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0lttng_inline_memcpy(dest, src, __len);=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \</div><div>=C2=A0} while (0)</div><div>=C2=A0/*</div>=
</div><br><div>------------------------------------------------------------=
----------------------------------------</div><div>Here is one example of a=
 crash, where 0xf3b7eeb2 is not 8 byte aligned;<br></div><br><div>=C2=A0 (g=
db) bt full</div><div>#0=C2=A0 lttng_inline_memcpy (len=3D8, src=3D0xf3b7ee=
b2, dest=3D&lt;optimized out&gt;) at /usr/src/debug/lttng-ust/2.9.1/git/lib=
ringbuffer/backend_internal.h:610</div><div>No locals.</div><div>#1=C2=A0 l=
ib_ring_buffer_write (len=3D8, src=3D0xf3b7eeb2, ctx=3D0xf57c47d0, config=
=3D0xf737c560 &lt;client_config&gt;) at /usr/src/debug/lttng-ust/2.9.1/git/=
libringbuffer/backend.h:100</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 __len =3D=
 8</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 handle =3D 0xf3b2e0c0</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 backend_pages =3D &lt;optimized out&gt;</div><d=
iv>=C2=A0 =C2=A0 =C2=A0 =C2=A0 chanb =3D 0xf3b2e2e0</div><div>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 offset =3D &lt;optimized out&gt;</div><div>#2=C2=A0 lttng_ev=
ent_write (ctx=3D0xf57c47d0, src=3D0xf3b7eeb2, len=3D8) at /usr/src/debug/l=
ttng-ust/2.9.1/git/liblttng-ust/lttng-ring-buffer-metadata-client.h:267</di=
v><div>No locals.</div><div>#3=C2=A0 0xf7337ef8 in ustctl_write_one_packet_=
to_channel (channel=3D&lt;optimized out&gt;, metadata_str=3D0xf3b7eeb2 &quo=
t;&quot;, len=3D&lt;optimized out&gt;) at /usr/src/debug/lttng-ust/2.9.1/gi=
t/liblttng-ust-ctl/ustctl.c:1183</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =
=3D {chan =3D 0xf3b2e290, priv =3D 0x0, handle =3D 0xf3b2e0c0, data_size =
=3D 8, largest_align =3D 1, cpu =3D -1, buf =3D 0xf6909000, slot_size =3D 8=
, buf_offset =3D 163877, pre_offset =3D 163877, tsc =3D 0, rflags =3D 0, ct=
x_len =3D 80, ip =3D 0x0, priv2 =3D 0x0, padding2 =3D &#39;\000&#39; &lt;re=
peats 11 times&gt;, backend_pages =3D 0xf690c000}</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 chan =3D 0xf3b2e4d8</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 str=
 =3D 0xf3b7eeb2 &quot;&quot;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 reserve_=
len =3D 8</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D &lt;optimized out&g=
t;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__ =3D &#39;\000&#39; &lt;re=
peats 34 times&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 __PRETTY_FUNCTION_=
_ =3D &#39;\000&#39; &lt;repeats 34 times&gt;</div><div>---Type &lt;return&=
gt; to continue, or q &lt;return&gt; to quit---</div><div>#4=C2=A0 0x000344=
cc in commit_one_metadata_packet (stream=3Dstream@entry=3D0xf3b2e560) at us=
t-consumer.c:2206</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 write_len =3D &lt;o=
ptimized out&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D &lt;optimize=
d out&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 __PRETTY_FUNCTION__ =3D &qu=
ot;commit_one_metadata_packet&quot;</div><div>#5=C2=A0 0x00036538 in lttng_=
ustconsumer_read_subbuffer (stream=3Dstream@entry=3D0xf3b2e560, ctx=3Dctx@e=
ntry=3D0x25e6e8) at ust-consumer.c:2452</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 len =3D 4096</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 subbuf_size =3D 4093=
</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 padding =3D &lt;optimized out&gt;</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -11</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 write_index =3D 1</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D =
&lt;optimized out&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ustream =3D &lt=
;optimized out&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D {offset =
=3D 0, packet_size =3D 575697416355872, content_size =3D 175640433914682565=
84, timestamp_begin =3D 17564043425827782792, timestamp_end =3D 34359738496=
, events_discarded =3D 313327092840, stream_id =3D 4089446416, stream_insta=
nce_id =3D 17689097291346376608, packet_seq_num =3D 8589934593}</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __PRETTY_FUNCTION__ =3D &quot;lttng_ustconsumer=
_read_subbuffer&quot;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__ =3D &q=
uot;lttng_ustconsumer_read_subbuffer&quot;</div><div>.....</div></div><br><=
/blockquote></div></div></div><div><div style=3D"font-family:arial,helvetic=
a,sans-serif;font-size:12pt;color:#000000"><div><blockquote style=3D"border=
-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-we=
ight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Ar=
ial,sans-serif;font-size:12pt">____________________________________________=
___<br>lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.or=
g" target=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"https://li=
sts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">https:/=
/lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br></blockquote></d=
iv></div></div><div><div style=3D"font-family:arial,helvetica,sans-serif;fo=
nt-size:12pt;color:#000000"><div><br></div><div>-- <br></div><div>Mathieu D=
esnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"=
_blank">http://www.efficios.com</a></div></div></div></blockquote></div></d=
iv>

--001a113cd88c01e2640561671f19--

--===============6143442311900292999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6143442311900292999==--
