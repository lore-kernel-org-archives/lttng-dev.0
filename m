From: Anders Wallin <wallinux@gmail.com>
Subject: lttng-consumerd crash on aarch64 due to x86 arch
	specific optimization
Date: Fri, 24 Nov 2017 08:23:17 +0000
Message-ID: <CAF2baFfZ+sxAGfxGY_or7=JJMxDngZTtfrzruUC5=RnZFD4tvA__49521.980333566$1511511817$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2673971705103898726=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 by lists.lttng.org (Postfix) with ESMTPS id 3yjq2m6DDNzjZj
 for <lttng-dev@lists.lttng.org>; Fri, 24 Nov 2017 08:23:28 +0000 (UTC)
Received: by mail-ot0-x241.google.com with SMTP id d27so18152766ote.11
 for <lttng-dev@lists.lttng.org>; Fri, 24 Nov 2017 00:23:28 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2673971705103898726==
Content-Type: multipart/alternative; boundary="001a11c03de25bf0d9055eb64485"

--001a11c03de25bf0d9055eb64485
Content-Type: text/plain; charset="UTF-8"

Hi,

architectures that has memory alignment restrictions may/will fail with the
optimization done in 51b8f2fa2b972e62117caa946dd3e3565b6ca4a3.
Please revert the patch or make it X86 specific.

Regards

Anders Wallin

------------------------------------------------------------------------------------------------------------
commit 51b8f2fa2b972e62117caa946dd3e3565b6ca4a3
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Sun Sep 25 12:31:11 2016 -0400

    Performance: implement lttng_inline_memcpy

    Because all length parameters received for serializing data coming from
    applications go through a callback, they are never constant, and it
    hurts performance to perform a call to memcpy each time.

    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

diff --git a/libringbuffer/backend_internal.h
b/libringbuffer/backend_internal.h
index 90088b89..e597cf4d 100644
--- a/libringbuffer/backend_internal.h
+++ b/libringbuffer/backend_internal.h
@@ -592,6 +592,28 @@ int update_read_sb_index(const struct
lttng_ust_lib_ring_buffer_config *config,
 #define inline_memcpy(dest, src, n)    memcpy(dest, src, n)
 #endif

+static inline __attribute__((always_inline))
+void lttng_inline_memcpy(void *dest, const void *src,
+               unsigned long len)
+{
+       switch (len) {
+       case 1:
+               *(uint8_t *) dest = *(const uint8_t *) src;
+               break;
+       case 2:
+               *(uint16_t *) dest = *(const uint16_t *) src;
+               break;
+       case 4:
+               *(uint32_t *) dest = *(const uint32_t *) src;
+               break;
+       case 8:
+               *(uint64_t *) dest = *(const uint64_t *) src;
+               break;
+       default:
+               inline_memcpy(dest, src, len);
+       }
+}
+
 /*
  * Use the architecture-specific memcpy implementation for constant-sized
  * inputs, but rely on an inline memcpy for length statically unknown.
@@ -603,7 +625,7 @@ do {
            \
        if (__builtin_constant_p(len))                          \
                memcpy(dest, src, __len);                       \
        else                                                    \
-               inline_memcpy(dest, src, __len);                \
+               lttng_inline_memcpy(dest, src, __len);          \
 } while (0)

 /*

----------------------------------------------------------------------------------------------------
Here is one example of a crash, where 0xf3b7eeb2 is not 8 byte aligned;

  (gdb) bt full
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
= 34359738496, events_discarded = 313327092840, stream_id = 4089446416,
stream_instance_id = 17689097291346376608, packet_seq_num = 8589934593}
        __PRETTY_FUNCTION__ = "lttng_ustconsumer_read_subbuffer"
        __func__ = "lttng_ustconsumer_read_subbuffer"
.....

--001a11c03de25bf0d9055eb64485
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>architectures that has memory align=
ment restrictions may/will fail with the=C2=A0</div><div>optimization done =
in=C2=A051b8f2fa2b972e62117caa946dd3e3565b6ca4a3.</div><div>Please revert t=
he patch or make it X86 specific.</div><div><br></div><div>Regards</div><di=
v><br></div><div>Anders Wallin</div><div>=C2=A0</div><div>-----------------=
---------------------------------------------------------------------------=
----------------</div><div><div>commit 51b8f2fa2b972e62117caa946dd3e3565b6c=
a4a3</div><div>Author: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desn=
oyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;</div><div>Date:=
=C2=A0 =C2=A0Sun Sep 25 12:31:11 2016 -0400</div><div><br></div><div>=C2=A0=
 =C2=A0 Performance: implement lttng_inline_memcpy</div><div>=C2=A0 =C2=A0=
=C2=A0</div><div>=C2=A0 =C2=A0 Because all length parameters received for s=
erializing data coming from</div><div>=C2=A0 =C2=A0 applications go through=
 a callback, they are never constant, and it</div><div>=C2=A0 =C2=A0 hurts =
performance to perform a call to memcpy each time.</div><div>=C2=A0 =C2=A0=
=C2=A0</div><div>=C2=A0 =C2=A0 Signed-off-by: Mathieu Desnoyers &lt;<a href=
=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</=
a>&gt;</div><div><br></div><div>diff --git a/libringbuffer/backend_internal=
.h b/libringbuffer/backend_internal.h</div><div>index 90088b89..e597cf4d 10=
0644</div><div>--- a/libringbuffer/backend_internal.h</div><div>+++ b/libri=
ngbuffer/backend_internal.h</div><div>@@ -592,6 +592,28 @@ int update_read_=
sb_index(const struct lttng_ust_lib_ring_buffer_config *config,</div><div>=
=C2=A0#define inline_memcpy(dest, src, n)=C2=A0 =C2=A0 memcpy(dest, src, n)=
</div><div>=C2=A0#endif</div><div>=C2=A0</div><div>+static inline __attribu=
te__((always_inline))</div><div>+void lttng_inline_memcpy(void *dest, const=
 void *src,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0unsigned long len)</div><div>+{</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0sw=
itch (len) {</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0case 1:</div><div>+=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(uint8_t *) dest =3D *=
(const uint8_t *) src;</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0case 2:</div><di=
v>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(uint16_t *) des=
t =3D *(const uint16_t *) src;</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0case 4=
:</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(uint3=
2_t *) dest =3D *(const uint32_t *) src;</div><div>+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;</div><div>+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0case 8:</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0*(uint64_t *) dest =3D *(const uint64_t *) src;</div><div>+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;</div><div>+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0default:</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0inline_memcpy(dest, src, len);</div><div>+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0}</div><div>+}</div><div>+</div><div>=C2=A0/*</div><div>=C2=A0=
 * Use the architecture-specific memcpy implementation for constant-sized</=
div><div>=C2=A0 * inputs, but rely on an inline memcpy for length staticall=
y unknown.</div><div>@@ -603,7 +625,7 @@ do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
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
=C2=A0 =C2=A0 =C2=A0 \</div><div>=C2=A0} while (0)</div><div>=C2=A0</div><d=
iv>=C2=A0/*</div></div><div><br></div><div>--------------------------------=
--------------------------------------------------------------------</div><=
div>Here is one example of a crash, where 0xf3b7eeb2 is not 8 byte aligned;=
<br></div><div><br></div><div>=C2=A0 (gdb) bt full</div><div>#0=C2=A0 lttng=
_inline_memcpy (len=3D8, src=3D0xf3b7eeb2, dest=3D&lt;optimized out&gt;) at=
 /usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/backend_internal.h:610</d=
iv><div>No locals.</div><div>#1=C2=A0 lib_ring_buffer_write (len=3D8, src=
=3D0xf3b7eeb2, ctx=3D0xf57c47d0, config=3D0xf737c560 &lt;client_config&gt;)=
 at /usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/backend.h:100</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 __len =3D 8</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 handle =3D 0xf3b2e0c0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 backend_=
pages =3D &lt;optimized out&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 chanb=
 =3D 0xf3b2e2e0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 offset =3D &lt;optimi=
zed out&gt;</div><div>#2=C2=A0 lttng_event_write (ctx=3D0xf57c47d0, src=3D0=
xf3b7eeb2, len=3D8) at /usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust/lttn=
g-ring-buffer-metadata-client.h:267</div><div>No locals.</div><div>#3=C2=A0=
 0xf7337ef8 in ustctl_write_one_packet_to_channel (channel=3D&lt;optimized =
out&gt;, metadata_str=3D0xf3b7eeb2 &quot;&quot;, len=3D&lt;optimized out&gt=
;) at /usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust-ctl/ustctl.c:1183</di=
v><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D {chan =3D 0xf3b2e290, priv =3D 0=
x0, handle =3D 0xf3b2e0c0, data_size =3D 8, largest_align =3D 1, cpu =3D -1=
, buf =3D 0xf6909000, slot_size =3D 8, buf_offset =3D 163877, pre_offset =
=3D 163877, tsc =3D 0, rflags =3D 0, ctx_len =3D 80, ip =3D 0x0, priv2 =3D =
0x0, padding2 =3D &#39;\000&#39; &lt;repeats 11 times&gt;, backend_pages =
=3D 0xf690c000}</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 chan =3D 0xf3b2e4d8</=
div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D 0xf3b7eeb2 &quot;&quot;</div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 reserve_len =3D 8</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ret =3D &lt;optimized out&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 __func__ =3D &#39;\000&#39; &lt;repeats 34 times&gt;</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 __PRETTY_FUNCTION__ =3D &#39;\000&#39; &lt;repeats=
 34 times&gt;</div><div>---Type &lt;return&gt; to continue, or q &lt;return=
&gt; to quit---</div><div>#4=C2=A0 0x000344cc in commit_one_metadata_packet=
 (stream=3Dstream@entry=3D0xf3b2e560) at ust-consumer.c:2206</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 write_len =3D &lt;optimized out&gt;</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D &lt;optimized out&gt;</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __PRETTY_FUNCTION__ =3D &quot;commit_one_metadata_packet&=
quot;</div><div>#5=C2=A0 0x00036538 in lttng_ustconsumer_read_subbuffer (st=
ream=3Dstream@entry=3D0xf3b2e560, ctx=3Dctx@entry=3D0x25e6e8) at ust-consum=
er.c:2452</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D 4096</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 subbuf_size =3D 4093</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 padding =3D &lt;optimized out&gt;</div><div>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 err =3D -11</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 write_index =3D 1=
</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D &lt;optimized out&gt;</div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ustream =3D &lt;optimized out&gt;</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D {offset =3D 0, packet_size =3D 57569=
7416355872, content_size =3D 17564043391468256584, timestamp_begin =3D 1756=
4043425827782792, timestamp_end =3D 34359738496, events_discarded =3D 31332=
7092840, stream_id =3D 4089446416, stream_instance_id =3D 17689097291346376=
608, packet_seq_num =3D 8589934593}</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 _=
_PRETTY_FUNCTION__ =3D &quot;lttng_ustconsumer_read_subbuffer&quot;</div><d=
iv>=C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__ =3D &quot;lttng_ustconsumer_read_su=
bbuffer&quot;</div><div>.....</div></div>

--001a11c03de25bf0d9055eb64485--

--===============2673971705103898726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2673971705103898726==--
