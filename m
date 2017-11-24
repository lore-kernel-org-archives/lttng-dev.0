From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng-consumerd crash on aarch64 due to x86
	arch	specific optimization
Date: Fri, 24 Nov 2017 19:19:41 +0000 (UTC)
Message-ID: <954909194.21985.1511551181212.JavaMail.zimbra__44399.9230782085$1511551128$gmane$org@efficios.com>
References: <CAF2baFfZ+sxAGfxGY_or7=JJMxDngZTtfrzruUC5=RnZFD4tvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4719257690877811848=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3yk5Zf6B5XzjKt
 for <lttng-dev@lists.lttng.org>; Fri, 24 Nov 2017 19:18:34 +0000 (UTC)
In-Reply-To: <CAF2baFfZ+sxAGfxGY_or7=JJMxDngZTtfrzruUC5=RnZFD4tvA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Anders Wallin <wallinux@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4719257690877811848==
Content-Type: multipart/alternative;
	boundary="=_ff78c6c6-5457-47ce-acfa-f36ef676546a"

--=_ff78c6c6-5457-47ce-acfa-f36ef676546a
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Nov 24, 2017, at 3:23 AM, Anders Wallin <wallinux@gmail.com> wrote: 

> Hi,
> architectures that has memory alignment restrictions may/will fail with the
> optimization done in 51b8f2fa2b972e62117caa946dd3e3565b6ca4a3.
> Please revert the patch or make it X86 specific.

Hi Anders, 

This was added in the development cycle of lttng-ust 2.9. We could perhaps 
add a test on the pointer alignment for architectures that care about it, and 
fallback to memcpy in those cases. 

The revert approach would have been justified if this commit had been backported 
as a "fix" to a stable branch, which is not the case here. We should work on 
finding an acceptable solution that takes care of dealing with unaligned pointers 
on architectures that care about the difference. 

Thanks, 

Mathieu 

> Regards

> Anders Wallin
> ------------------------------------------------------------------------------------------------------------
> commit 51b8f2fa2b972e62117caa946dd3e3565b6ca4a3
> Author: Mathieu Desnoyers < [ mailto:mathieu.desnoyers@efficios.com |
> mathieu.desnoyers@efficios.com ] >
> Date: Sun Sep 25 12:31:11 2016 -0400

> Performance: implement lttng_inline_memcpy
> Because all length parameters received for serializing data coming from
> applications go through a callback, they are never constant, and it
> hurts performance to perform a call to memcpy each time.
> Signed-off-by: Mathieu Desnoyers < [ mailto:mathieu.desnoyers@efficios.com |
> mathieu.desnoyers@efficios.com ] >

> diff --git a/libringbuffer/backend_internal.h b/libringbuffer/backend_internal.h
> index 90088b89..e597cf4d 100644
> --- a/libringbuffer/backend_internal.h
> +++ b/libringbuffer/backend_internal.h
> @@ -592,6 +592,28 @@ int update_read_sb_index(const struct
> lttng_ust_lib_ring_buffer_config *config,
> #define inline_memcpy(dest, src, n) memcpy(dest, src, n)
> #endif
> +static inline __attribute__((always_inline))
> +void lttng_inline_memcpy(void *dest, const void *src,
> + unsigned long len)
> +{
> + switch (len) {
> + case 1:
> + *(uint8_t *) dest = *(const uint8_t *) src;
> + break;
> + case 2:
> + *(uint16_t *) dest = *(const uint16_t *) src;
> + break;
> + case 4:
> + *(uint32_t *) dest = *(const uint32_t *) src;
> + break;
> + case 8:
> + *(uint64_t *) dest = *(const uint64_t *) src;
> + break;
> + default:
> + inline_memcpy(dest, src, len);
> + }
> +}
> +
> /*
> * Use the architecture-specific memcpy implementation for constant-sized
> * inputs, but rely on an inline memcpy for length statically unknown.
> @@ -603,7 +625,7 @@ do { \
> if (__builtin_constant_p(len)) \
> memcpy(dest, src, __len); \
> else \
> - inline_memcpy(dest, src, __len); \
> + lttng_inline_memcpy(dest, src, __len); \
> } while (0)
> /*

> ----------------------------------------------------------------------------------------------------
> Here is one example of a crash, where 0xf3b7eeb2 is not 8 byte aligned;

> (gdb) bt full
> #0 lttng_inline_memcpy (len=8, src=0xf3b7eeb2, dest=<optimized out>) at
> /usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/backend_internal.h:610
> No locals.
> #1 lib_ring_buffer_write (len=8, src=0xf3b7eeb2, ctx=0xf57c47d0,
> config=0xf737c560 <client_config>) at
> /usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/backend.h:100
> __len = 8
> handle = 0xf3b2e0c0
> backend_pages = <optimized out>
> chanb = 0xf3b2e2e0
> offset = <optimized out>
> #2 lttng_event_write (ctx=0xf57c47d0, src=0xf3b7eeb2, len=8) at
> /usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust/lttng-ring-buffer-metadata-client.h:267
> No locals.
> #3 0xf7337ef8 in ustctl_write_one_packet_to_channel (channel=<optimized out>,
> metadata_str=0xf3b7eeb2 "", len=<optimized out>) at
> /usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust-ctl/ustctl.c:1183
> ctx = {chan = 0xf3b2e290, priv = 0x0, handle = 0xf3b2e0c0, data_size = 8,
> largest_align = 1, cpu = -1, buf = 0xf6909000, slot_size = 8, buf_offset =
> 163877, pre_offset = 163877, tsc = 0, rflags = 0, ctx_len = 80, ip = 0x0, priv2
> = 0x0, padding2 = '\000' <repeats 11 times>, backend_pages = 0xf690c000}
> chan = 0xf3b2e4d8
> str = 0xf3b7eeb2 ""
> reserve_len = 8
> ret = <optimized out>
> __func__ = '\000' <repeats 34 times>
> __PRETTY_FUNCTION__ = '\000' <repeats 34 times>
> ---Type <return> to continue, or q <return> to quit---
> #4 0x000344cc in commit_one_metadata_packet (stream=stream@entry=0xf3b2e560) at
> ust-consumer.c:2206
> write_len = <optimized out>
> ret = <optimized out>
> __PRETTY_FUNCTION__ = "commit_one_metadata_packet"
> #5 0x00036538 in lttng_ustconsumer_read_subbuffer
> (stream=stream@entry=0xf3b2e560, ctx=ctx@entry=0x25e6e8) at ust-consumer.c:2452
> len = 4096
> subbuf_size = 4093
> padding = <optimized out>
> err = -11
> write_index = 1
> ret = <optimized out>
> ustream = <optimized out>
> index = {offset = 0, packet_size = 575697416355872, content_size =
> 17564043391468256584, timestamp_begin = 17564043425827782792, timestamp_end =
> 34359738496, events_discarded = 313327092840, stream_id = 4089446416,
> stream_instance_id = 17689097291346376608, packet_seq_num = 8589934593}
> __PRETTY_FUNCTION__ = "lttng_ustconsumer_read_subbuffer"
> __func__ = "lttng_ustconsumer_read_subbuffer"
> .....

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_ff78c6c6-5457-47ce-acfa-f36ef676546a
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Nov 24, 2017, at 3:23 AM, Anders Wallin &lt;wallinux@gmail.com=
&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquot=
e style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;c=
olor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fa=
mily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Hi,<br><d=
iv>architectures that has memory alignment restrictions may/will fail with =
the&nbsp;</div><div>optimization done in&nbsp;51b8f2fa2b972e62117caa946dd3e=
3565b6ca4a3.</div><div>Please revert the patch or make it X86 specific.</di=
v></div></blockquote><div><br></div><div>Hi Anders,<br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><div>This was added in the devel=
opment cycle of lttng-ust 2.9. We could perhaps<br></div><div>add a test on=
 the pointer alignment for architectures that care about it, and<br data-mc=
e-bogus=3D"1"></div><div>fallback to memcpy in those cases.<br data-mce-bog=
us=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>The revert approach=
 would have been justified if this commit had been backported</div><div>as =
a "fix" to a stable branch, which is not the case here. We should work on<b=
r></div><div>finding an acceptable solution that takes care of dealing with=
 unaligned pointers<br></div><div>on architectures that care about the diff=
erence.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><=
div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></d=
iv><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left=
:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:=
normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,s=
ans-serif;font-size:12pt;"><div dir=3D"ltr"><br><div>Regards</div><br><div>=
Anders Wallin</div><div>---------------------------------------------------=
---------------------------------------------------------</div><div><div>co=
mmit 51b8f2fa2b972e62117caa946dd3e3565b6ca4a3</div><div>Author: Mathieu Des=
noyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_bla=
nk">mathieu.desnoyers@efficios.com</a>&gt;</div><div>Date:&nbsp; &nbsp;Sun =
Sep 25 12:31:11 2016 -0400</div><br><div>&nbsp; &nbsp; Performance: impleme=
nt lttng_inline_memcpy</div><div>&nbsp; &nbsp; Because all length parameter=
s received for serializing data coming from</div><div>&nbsp; &nbsp; applica=
tions go through a callback, they are never constant, and it</div><div>&nbs=
p; &nbsp; hurts performance to perform a call to memcpy each time.</div><di=
v>&nbsp; &nbsp; Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"mailto:math=
ieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.co=
m</a>&gt;</div><br><div>diff --git a/libringbuffer/backend_internal.h b/lib=
ringbuffer/backend_internal.h</div><div>index 90088b89..e597cf4d 100644</di=
v><div>--- a/libringbuffer/backend_internal.h</div><div>+++ b/libringbuffer=
/backend_internal.h</div><div>@@ -592,6 +592,28 @@ int update_read_sb_index=
(const struct lttng_ust_lib_ring_buffer_config *config,</div><div>&nbsp;#de=
fine inline_memcpy(dest, src, n)&nbsp; &nbsp; memcpy(dest, src, n)</div><di=
v>&nbsp;#endif</div><div>+static inline __attribute__((always_inline))</div=
><div>+void lttng_inline_memcpy(void *dest, const void *src,</div><div>+&nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;unsigned long len)</div=
><div>+{</div><div>+&nbsp; &nbsp; &nbsp; &nbsp;switch (len) {</div><div>+&n=
bsp; &nbsp; &nbsp; &nbsp;case 1:</div><div>+&nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp;*(uint8_t *) dest =3D *(const uint8_t *) src;</div>=
<div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;</div><d=
iv>+&nbsp; &nbsp; &nbsp; &nbsp;case 2:</div><div>+&nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;*(uint16_t *) dest =3D *(const uint16_t *) sr=
c;</div><div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;=
</div><div>+&nbsp; &nbsp; &nbsp; &nbsp;case 4:</div><div>+&nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*(uint32_t *) dest =3D *(const uint32=
_t *) src;</div><div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;break;</div><div>+&nbsp; &nbsp; &nbsp; &nbsp;case 8:</div><div>+&nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*(uint64_t *) dest =3D *(cons=
t uint64_t *) src;</div><div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;break;</div><div>+&nbsp; &nbsp; &nbsp; &nbsp;default:</div><div>+=
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;inline_memcpy(dest, =
src, len);</div><div>+&nbsp; &nbsp; &nbsp; &nbsp;}</div><div>+}</div><div>+=
</div><div>&nbsp;/*</div><div>&nbsp; * Use the architecture-specific memcpy=
 implementation for constant-sized</div><div>&nbsp; * inputs, but rely on a=
n inline memcpy for length statically unknown.</div><div>@@ -603,7 +625,7 @=
@ do {&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; \</div><div>&nbsp; &nbsp; &nbsp; &nbsp; if (__builtin_constant_p(len))=
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; \</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; memcpy(dest, src, __len);&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\</div><div>&nbsp; &nbsp; &nbsp; =
&nbsp; else&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \</div><div>-&nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;inline_memcpy(dest, src, __len);&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \</div><div>+&nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lttng_inline_memcpy(dest, src, __=
len);&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \</div><div>&nbsp;} while (0)</div>=
<div>&nbsp;/*</div></div><br><div>-----------------------------------------=
-----------------------------------------------------------</div><div>Here =
is one example of a crash, where 0xf3b7eeb2 is not 8 byte aligned;<br></div=
><br><div>&nbsp; (gdb) bt full</div><div>#0&nbsp; lttng_inline_memcpy (len=
=3D8, src=3D0xf3b7eeb2, dest=3D&lt;optimized out&gt;) at /usr/src/debug/ltt=
ng-ust/2.9.1/git/libringbuffer/backend_internal.h:610</div><div>No locals.<=
/div><div>#1&nbsp; lib_ring_buffer_write (len=3D8, src=3D0xf3b7eeb2, ctx=3D=
0xf57c47d0, config=3D0xf737c560 &lt;client_config&gt;) at /usr/src/debug/lt=
tng-ust/2.9.1/git/libringbuffer/backend.h:100</div><div>&nbsp; &nbsp; &nbsp=
; &nbsp; __len =3D 8</div><div>&nbsp; &nbsp; &nbsp; &nbsp; handle =3D 0xf3b=
2e0c0</div><div>&nbsp; &nbsp; &nbsp; &nbsp; backend_pages =3D &lt;optimized=
 out&gt;</div><div>&nbsp; &nbsp; &nbsp; &nbsp; chanb =3D 0xf3b2e2e0</div><d=
iv>&nbsp; &nbsp; &nbsp; &nbsp; offset =3D &lt;optimized out&gt;</div><div>#=
2&nbsp; lttng_event_write (ctx=3D0xf57c47d0, src=3D0xf3b7eeb2, len=3D8) at =
/usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust/lttng-ring-buffer-metadata-=
client.h:267</div><div>No locals.</div><div>#3&nbsp; 0xf7337ef8 in ustctl_w=
rite_one_packet_to_channel (channel=3D&lt;optimized out&gt;, metadata_str=
=3D0xf3b7eeb2 "", len=3D&lt;optimized out&gt;) at /usr/src/debug/lttng-ust/=
2.9.1/git/liblttng-ust-ctl/ustctl.c:1183</div><div>&nbsp; &nbsp; &nbsp; &nb=
sp; ctx =3D {chan =3D 0xf3b2e290, priv =3D 0x0, handle =3D 0xf3b2e0c0, data=
_size =3D 8, largest_align =3D 1, cpu =3D -1, buf =3D 0xf6909000, slot_size=
 =3D 8, buf_offset =3D 163877, pre_offset =3D 163877, tsc =3D 0, rflags =3D=
 0, ctx_len =3D 80, ip =3D 0x0, priv2 =3D 0x0, padding2 =3D '\000' &lt;repe=
ats 11 times&gt;, backend_pages =3D 0xf690c000}</div><div>&nbsp; &nbsp; &nb=
sp; &nbsp; chan =3D 0xf3b2e4d8</div><div>&nbsp; &nbsp; &nbsp; &nbsp; str =
=3D 0xf3b7eeb2 ""</div><div>&nbsp; &nbsp; &nbsp; &nbsp; reserve_len =3D 8</=
div><div>&nbsp; &nbsp; &nbsp; &nbsp; ret =3D &lt;optimized out&gt;</div><di=
v>&nbsp; &nbsp; &nbsp; &nbsp; __func__ =3D '\000' &lt;repeats 34 times&gt;<=
/div><div>&nbsp; &nbsp; &nbsp; &nbsp; __PRETTY_FUNCTION__ =3D '\000' &lt;re=
peats 34 times&gt;</div><div>---Type &lt;return&gt; to continue, or q &lt;r=
eturn&gt; to quit---</div><div>#4&nbsp; 0x000344cc in commit_one_metadata_p=
acket (stream=3Dstream@entry=3D0xf3b2e560) at ust-consumer.c:2206</div><div=
>&nbsp; &nbsp; &nbsp; &nbsp; write_len =3D &lt;optimized out&gt;</div><div>=
&nbsp; &nbsp; &nbsp; &nbsp; ret =3D &lt;optimized out&gt;</div><div>&nbsp; =
&nbsp; &nbsp; &nbsp; __PRETTY_FUNCTION__ =3D "commit_one_metadata_packet"</=
div><div>#5&nbsp; 0x00036538 in lttng_ustconsumer_read_subbuffer (stream=3D=
stream@entry=3D0xf3b2e560, ctx=3Dctx@entry=3D0x25e6e8) at ust-consumer.c:24=
52</div><div>&nbsp; &nbsp; &nbsp; &nbsp; len =3D 4096</div><div>&nbsp; &nbs=
p; &nbsp; &nbsp; subbuf_size =3D 4093</div><div>&nbsp; &nbsp; &nbsp; &nbsp;=
 padding =3D &lt;optimized out&gt;</div><div>&nbsp; &nbsp; &nbsp; &nbsp; er=
r =3D -11</div><div>&nbsp; &nbsp; &nbsp; &nbsp; write_index =3D 1</div><div=
>&nbsp; &nbsp; &nbsp; &nbsp; ret =3D &lt;optimized out&gt;</div><div>&nbsp;=
 &nbsp; &nbsp; &nbsp; ustream =3D &lt;optimized out&gt;</div><div>&nbsp; &n=
bsp; &nbsp; &nbsp; index =3D {offset =3D 0, packet_size =3D 575697416355872=
, content_size =3D 17564043391468256584, timestamp_begin =3D 17564043425827=
782792, timestamp_end =3D 34359738496, events_discarded =3D 313327092840, s=
tream_id =3D 4089446416, stream_instance_id =3D 17689097291346376608, packe=
t_seq_num =3D 8589934593}</div><div>&nbsp; &nbsp; &nbsp; &nbsp; __PRETTY_FU=
NCTION__ =3D "lttng_ustconsumer_read_subbuffer"</div><div>&nbsp; &nbsp; &nb=
sp; &nbsp; __func__ =3D "lttng_ustconsumer_read_subbuffer"</div><div>.....<=
/div></div><br>_______________________________________________<br>lttng-dev=
 mailing list<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-b=
in/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></div><div dat=
a-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS I=
nc.<br>http://www.efficios.com</div></div></body></html>
--=_ff78c6c6-5457-47ce-acfa-f36ef676546a--

--===============4719257690877811848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4719257690877811848==--
