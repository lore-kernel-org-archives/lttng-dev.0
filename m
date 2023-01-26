Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB45C05027
	for <lttng-dev@archiver.kernel.org>; Thu, 26 Jan 2023 20:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1674765459;
	bh=am41u330ZAFhcS5Z+OcAEIgHuu93kgyp1/QZR4H6jWI=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=w8GN6AZD6g3THxwSyMSYZ2jQtl+S1udoHQvmcdSvFJMxeFozoAPjl6/DMC3a8Euup
	 u+oYZ0NwhRU9k5RCdJtgCKHn8hj5i+jigs6iOTJywWILTJ1bFu7vH8np7U8BRXbixy
	 YhgzxXWyfQnqUzmyw3aCOAW6Gd8JeAg1DZuSqbVQSyvl6+lvPsN4h06KfKh80zEwhb
	 gyVUmUTm+D/f6gHPa6ZzAS3OmbvBsHTuGVc+N3J/MZaxOO4gFY9t12MPGHsrU1ISqX
	 25pPZJmlsvvWJ/3zERDKG/923TyvKoPGj9pnTX0sfpGU4tG02tbBG8S3XSasfX58nL
	 sG+VvgGNykQlw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4P2sw24s0Jz1Vx2;
	Thu, 26 Jan 2023 15:37:38 -0500 (EST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by lists.lttng.org (Postfix) with ESMTPS id 4P2rTl1vGvz1W2q
 for <lttng-dev@lists.lttng.org>; Thu, 26 Jan 2023 14:33:15 -0500 (EST)
Received: by mail-pg1-f182.google.com with SMTP id 141so1796040pgc.0
 for <lttng-dev@lists.lttng.org>; Thu, 26 Jan 2023 11:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KyzL9pjEmU8wm4DHHs28TRUPUHXT8A7XQbiaHa50W8E=;
 b=AQgYGhm7Ye1XVGKK0mEZMMT18GwutrD0fkW8wWyj0Nty6TFwkFnLz6L6D/tnjTm/+U
 zMcXazj2mI60BgsVQDo+MPqMIHMAoNfA3zLMstQm7Sg3jyi/EFaO3UB7N53cn+8PFdCp
 OICbY0pKpEHJNFzMAHnh82YZ4vmsoo9IiVZif3V118xikJuP0ajgTgtH53Ao901HT1qe
 wNVZ4+W0Xx+0ThBUq7QOwjSWf03go95PY0GOCIfqLgaBZvQrbG9c93Oo+Fn+BByvon0j
 xr2JnsnTa3yX1EZN/WUAK8EuE0VJJyuO5VaZtDVf9U0YGILDjbWpXnt9DxV3bUz5394f
 e7Tg==
X-Gm-Message-State: AFqh2koixscfxSV60EQkzeoZFH958WKhwzAsDwf9fd4uzL7O5RLCZn7p
 SoHjcvyLXkQ2JOZT9jsk7ZzYA6DU7aK9WsP1w4I=
X-Google-Smtp-Source: AMrXdXsD2n1qo1LH8LCk4sl8ObdgcWNzZy5TAuZDtkAm63ScNosuiJAkp3hdKgenrf3XAeT11lS/dggJVAj+9qUVCpA=
X-Received: by 2002:a63:f017:0:b0:477:bfab:5a81 with SMTP id
 k23-20020a63f017000000b00477bfab5a81mr3690578pgh.64.1674761533490; Thu, 26
 Jan 2023 11:32:13 -0800 (PST)
MIME-Version: 1.0
References: <CAF2baFfZ+sxAGfxGY_or7=JJMxDngZTtfrzruUC5=RnZFD4tvA@mail.gmail.com>
 <954909194.21985.1511551181212.JavaMail.zimbra@efficios.com>
 <CAF2baFecVMCenooHSMcNChMEkevz1taF0VWUxWAyxbUq8kVXSg@mail.gmail.com>
 <1784f4f4-1c5a-5c4b-2041-2327128712d1@efficios.com>
In-Reply-To: <1784f4f4-1c5a-5c4b-2041-2327128712d1@efficios.com>
Date: Thu, 26 Jan 2023 20:32:01 +0100
Message-ID: <CAF2baFebd9hi7GjRYrOV666THGt0nOusp1DdcitL7bn9KOf-yg@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
X-Mailman-Approved-At: Thu, 26 Jan 2023 15:37:37 -0500
Subject: Re: [lttng-dev] lttng-consumerd crash on aarch64 due to x86 arch
 specific optimization
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Anders Wallin via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Anders Wallin <wallinux@gmail.com>
Content-Type: multipart/mixed; boundary="===============6930845206339412935=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6930845206339412935==
Content-Type: multipart/alternative; boundary="000000000000498caf05f32fcef9"

--000000000000498caf05f32fcef9
Content-Type: text/plain; charset="UTF-8"

Hi Matthieu,

I've retired and no longer have access to any arch64  target to test it on.

Regards
Anders


Den ons 25 jan. 2023 13:25Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
skrev:

> Hi Anders,
>
> Sorry for the long delay on this one, can you have a look at the following
> fix ?
>
> https://review.lttng.org/c/lttng-ust/+/9319 Fix: aarch64: do not perform
> unaligned stores
>
> If it passes your testing, I'll merge this into lttng-ust.
>
> Thanks,
>
> Mathieu
>
> On 2017-12-28 09:13, Anders Wallin wrote:
> > Hi Mathieu,
> >
> > I finally got some time to dig into this issue. The crash only happens
> > when metadata is written AND the size of the metadata will end up in a
> > write that is 8,4,2 or 1 bytes long AND
> > that the source or destination is not aligned correctly according to HW
> > limitation. I have not found any simple way to keep the performance
> > enhancement code that is run most of the time.
> > Maybe the metadata writes should have it's own write function instead.
> >
> > Here is an example of a crash (code is from lttng-ust 2.9.1 and
> > lttng-tools 2.9.6) where the size is 8 bytes and the src address is
> > unaligned at 0xf3b7eeb2;
> >
> > #0  lttng_inline_memcpy (len=8, src=0xf3b7eeb2, dest=<optimized out>) at
> > /usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/backend_internal.h:610
> > No locals.
> > #1  lib_ring_buffer_write (len=8, src=0xf3b7eeb2, ctx=0xf57c47d0,
> > config=0xf737c560 <client_config>) at
> > /usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/backend.h:100
> >          __len = 8
> >          handle = 0xf3b2e0c0
> >          backend_pages = <optimized out>
> >          chanb = 0xf3b2e2e0
> >          offset = <optimized out>
> >
> > #2  lttng_event_write (ctx=0xf57c47d0, src=0xf3b7eeb2, len=8) at
> >
> /usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust/lttng-ring-buffer-metadata-client.h:267
> > No locals.
> >
> > #3  0xf7337ef8 in ustctl_write_one_packet_to_channel (channel=<optimized
> > out>, metadata_str=0xf3b7eeb2 "", len=<optimized out>) at
> > /usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust-ctl/ustctl.c:1183
> >          ctx = {chan = 0xf3b2e290, priv = 0x0, handle = 0xf3b2e0c0,
> > data_size = 8, largest_align = 1, cpu = -1, buf = 0xf6909000, slot_size
> > = 8, buf_offset = 163877, pre_offset = 163877, tsc = 0, rflags = 0,
> > ctx_len = 80, ip = 0x0, priv2 = 0x0, padding2 = '\000' <repeats 11
> > times>, backend_pages = 0xf690c000}
> >          chan = 0xf3b2e4d8
> >          str = 0xf3b7eeb2 ""
> >          reserve_len = 8
> >          ret = <optimized out>
> >          __func__ = '\000' <repeats 34 times>
> >          __PRETTY_FUNCTION__ = '\000' <repeats 34 times>
> > ---Type <return> to continue, or q <return> to quit---
> >
> > #4  0x000344cc in commit_one_metadata_packet
> > (stream=stream@entry=0xf3b2e560) at ust-consumer.c:2206
> >          write_len = <optimized out>
> >          ret = <optimized out>
> >          __PRETTY_FUNCTION__ = "commit_one_metadata_packet"
> >
> > #5  0x00036538 in lttng_ustconsumer_read_subbuffer
> > (stream=stream@entry=0xf3b2e560, ctx=ctx@entry=0x25e6e8) at
> > ust-consumer.c:2452
> >          len = 4096
> >          subbuf_size = 4093
> >          padding = <optimized out>
> >          err = -11
> >          write_index = 1
> >          ret = <optimized out>
> >          ustream = <optimized out>
> >          index = {offset = 0, packet_size = 575697416355872,
> > content_size = 17564043391468256584, timestamp_begin =
> > 17564043425827782792, timestamp_end = 34359738496,
> > Regards
> > Anders
> >
> > fre 24 nov. 2017 kl 20:18 skrev Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com <mailto:mathieu.desnoyers@efficios.com
> >>:
> >
> >     ----- On Nov 24, 2017, at 3:23 AM, Anders Wallin <wallinux@gmail.com
> >     <mailto:wallinux@gmail.com>> wrote:
> >
> >         Hi,
> >         architectures that has memory alignment restrictions may/will
> >         fail with the
> >         optimization done in 51b8f2fa2b972e62117caa946dd3e3565b6ca4a3.
> >         Please revert the patch or make it X86 specific.
> >
> >
> >     Hi Anders,
> >
> >     This was added in the development cycle of lttng-ust 2.9. We could
> >     perhaps
> >     add a test on the pointer alignment for architectures that care
> >     about it, and
> >     fallback to memcpy in those cases.
> >
> >     The revert approach would have been justified if this commit had
> >     been backported
> >     as a "fix" to a stable branch, which is not the case here. We should
> >     work on
> >     finding an acceptable solution that takes care of dealing with
> >     unaligned pointers
> >     on architectures that care about the difference.
> >
> >     Thanks,
> >
> >     Mathieu
> >
> >
> >
> >         Regards
> >
> >         Anders Wallin
> >
>  ------------------------------------------------------------------------------------------------------------
> >         commit 51b8f2fa2b972e62117caa946dd3e3565b6ca4a3
> >         Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com
> >         <mailto:mathieu.desnoyers@efficios.com>>
> >         Date:   Sun Sep 25 12:31:11 2016 -0400
> >
> >              Performance: implement lttng_inline_memcpy
> >              Because all length parameters received for serializing data
> >         coming from
> >              applications go through a callback, they are never
> >         constant, and it
> >              hurts performance to perform a call to memcpy each time.
> >              Signed-off-by: Mathieu Desnoyers
> >         <mathieu.desnoyers@efficios.com
> >         <mailto:mathieu.desnoyers@efficios.com>>
> >
> >         diff --git a/libringbuffer/backend_internal.h
> >         b/libringbuffer/backend_internal.h
> >         index 90088b89..e597cf4d 100644
> >         --- a/libringbuffer/backend_internal.h
> >         +++ b/libringbuffer/backend_internal.h
> >         @@ -592,6 +592,28 @@ int update_read_sb_index(const struct
> >         lttng_ust_lib_ring_buffer_config *config,
> >           #define inline_memcpy(dest, src, n)    memcpy(dest, src, n)
> >           #endif
> >         +static inline __attribute__((always_inline))
> >         +void lttng_inline_memcpy(void *dest, const void *src,
> >         +               unsigned long len)
> >         +{
> >         +       switch (len) {
> >         +       case 1:
> >         +               *(uint8_t *) dest = *(const uint8_t *) src;
> >         +               break;
> >         +       case 2:
> >         +               *(uint16_t *) dest = *(const uint16_t *) src;
> >         +               break;
> >         +       case 4:
> >         +               *(uint32_t *) dest = *(const uint32_t *) src;
> >         +               break;
> >         +       case 8:
> >         +               *(uint64_t *) dest = *(const uint64_t *) src;
> >         +               break;
> >         +       default:
> >         +               inline_memcpy(dest, src, len);
> >         +       }
> >         +}
> >         +
> >           /*
> >            * Use the architecture-specific memcpy implementation for
> >         constant-sized
> >            * inputs, but rely on an inline memcpy for length statically
> >         unknown.
> >         @@ -603,7 +625,7 @@ do {
> >                                  \
> >                  if (__builtin_constant_p(len))
> \
> >                          memcpy(dest, src, __len);
>  \
> >                  else
> \
> >         -               inline_memcpy(dest, src, __len);                \
> >         +               lttng_inline_memcpy(dest, src, __len);          \
> >           } while (0)
> >           /*
> >
> >
>  ----------------------------------------------------------------------------------------------------
> >         Here is one example of a crash, where 0xf3b7eeb2 is not 8 byte
> >         aligned;
> >
> >            (gdb) bt full
> >         #0  lttng_inline_memcpy (len=8, src=0xf3b7eeb2, dest=<optimized
> >         out>) at
> >
>  /usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/backend_internal.h:610
> >         No locals.
> >         #1  lib_ring_buffer_write (len=8, src=0xf3b7eeb2,
> >         ctx=0xf57c47d0, config=0xf737c560 <client_config>) at
> >         /usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/backend.h:100
> >                  __len = 8
> >                  handle = 0xf3b2e0c0
> >                  backend_pages = <optimized out>
> >                  chanb = 0xf3b2e2e0
> >                  offset = <optimized out>
> >         #2  lttng_event_write (ctx=0xf57c47d0, src=0xf3b7eeb2, len=8) at
> >
>  /usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust/lttng-ring-buffer-metadata-client.h:267
> >         No locals.
> >         #3  0xf7337ef8 in ustctl_write_one_packet_to_channel
> >         (channel=<optimized out>, metadata_str=0xf3b7eeb2 "",
> >         len=<optimized out>) at
> >         /usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust-ctl/ustctl.c:1183
> >                  ctx = {chan = 0xf3b2e290, priv = 0x0, handle =
> >         0xf3b2e0c0, data_size = 8, largest_align = 1, cpu = -1, buf =
> >         0xf6909000, slot_size = 8, buf_offset = 163877, pre_offset =
> >         163877, tsc = 0, rflags = 0, ctx_len = 80, ip = 0x0, priv2 =
> >         0x0, padding2 = '\000' <repeats 11 times>, backend_pages =
> >         0xf690c000}
> >                  chan = 0xf3b2e4d8
> >                  str = 0xf3b7eeb2 ""
> >                  reserve_len = 8
> >                  ret = <optimized out>
> >                  __func__ = '\000' <repeats 34 times>
> >                  __PRETTY_FUNCTION__ = '\000' <repeats 34 times>
> >         ---Type <return> to continue, or q <return> to quit---
> >         #4  0x000344cc in commit_one_metadata_packet
> >         (stream=stream@entry=0xf3b2e560) at ust-consumer.c:2206
> >                  write_len = <optimized out>
> >                  ret = <optimized out>
> >                  __PRETTY_FUNCTION__ = "commit_one_metadata_packet"
> >         #5  0x00036538 in lttng_ustconsumer_read_subbuffer
> >         (stream=stream@entry=0xf3b2e560, ctx=ctx@entry=0x25e6e8) at
> >         ust-consumer.c:2452
> >                  len = 4096
> >                  subbuf_size = 4093
> >                  padding = <optimized out>
> >                  err = -11
> >                  write_index = 1
> >                  ret = <optimized out>
> >                  ustream = <optimized out>
> >                  index = {offset = 0, packet_size = 575697416355872,
> >         content_size = 17564043391468256584, timestamp_begin =
> >         17564043425827782792, timestamp_end = 34359738496,
> >         events_discarded = 313327092840, stream_id = 4089446416,
> >         stream_instance_id = 17689097291346376608, packet_seq_num =
> >         8589934593}
> >                  __PRETTY_FUNCTION__ = "lttng_ustconsumer_read_subbuffer"
> >                  __func__ = "lttng_ustconsumer_read_subbuffer"
> >         .....
> >
> >         _______________________________________________
> >         lttng-dev mailing list
> >         lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> >         https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >         <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>
> >
> >
> >     --
> >     Mathieu Desnoyers
> >     EfficiOS Inc.
> >     http://www.efficios.com <http://www.efficios.com>
> >
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
>

--000000000000498caf05f32fcef9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Matthieu,<div dir=3D"auto"><br></div><div dir=3D"=
auto">I&#39;ve retired and no longer have access to any arch64=C2=A0 target=
 to test it on.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Re=
gards</div><div dir=3D"auto">Anders</div><br><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">Den ons 25 jan. 2023 13:25Mathieu De=
snoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desno=
yers@efficios.com</a>&gt; skrev:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi=
 Anders,<br>
<br>
Sorry for the long delay on this one, can you have a look at the following =
fix ?<br>
<br>
<a href=3D"https://review.lttng.org/c/lttng-ust/+/9319" rel=3D"noreferrer n=
oreferrer" target=3D"_blank">https://review.lttng.org/c/lttng-ust/+/9319</a=
> Fix: aarch64: do not perform unaligned stores<br>
<br>
If it passes your testing, I&#39;ll merge this into lttng-ust.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
On 2017-12-28 09:13, Anders Wallin wrote:<br>
&gt; Hi Mathieu,<br>
&gt; <br>
&gt; I finally got some time to dig into this issue. The crash only happens=
 <br>
&gt; when metadata is written AND the size of the metadata will end up in a=
 <br>
&gt; write that is 8,4,2 or 1 bytes long AND<br>
&gt; that the source or destination is not aligned correctly according to H=
W <br>
&gt; limitation. I have not found any simple way to keep the performance <b=
r>
&gt; enhancement code that is run most of the time.<br>
&gt; Maybe the metadata writes should have it&#39;s own write function inst=
ead.<br>
&gt; <br>
&gt; Here is an example of a crash (code is from lttng-ust 2.9.1 and <br>
&gt; lttng-tools 2.9.6) where the size is 8 bytes and the src address is <b=
r>
&gt; unaligned at 0xf3b7eeb2;<br>
&gt; <br>
&gt; #0=C2=A0 lttng_inline_memcpy (len=3D8, src=3D0xf3b7eeb2, dest=3D&lt;op=
timized out&gt;) at <br>
&gt; /usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/backend_internal.h:61=
0<br>
&gt; No locals.<br>
&gt; #1=C2=A0 lib_ring_buffer_write (len=3D8, src=3D0xf3b7eeb2, ctx=3D0xf57=
c47d0, <br>
&gt; config=3D0xf737c560 &lt;client_config&gt;) at <br>
&gt; /usr/src/debug/lttng-ust/2.9.1/git/libringbuffer/backend.h:100<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __len =3D 8<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 handle =3D 0xf3b2e0c0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 backend_pages =3D &lt;optimized out&=
gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chanb =3D 0xf3b2e2e0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset =3D &lt;optimized out&gt;<br>
&gt; <br>
&gt; #2=C2=A0 lttng_event_write (ctx=3D0xf57c47d0, src=3D0xf3b7eeb2, len=3D=
8) at <br>
&gt; /usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust/lttng-ring-buffer-meta=
data-client.h:267<br>
&gt; No locals.<br>
&gt; <br>
&gt; #3=C2=A0 0xf7337ef8 in ustctl_write_one_packet_to_channel (channel=3D&=
lt;optimized <br>
&gt; out&gt;, metadata_str=3D0xf3b7eeb2 &quot;&quot;, len=3D&lt;optimized o=
ut&gt;) at <br>
&gt; /usr/src/debug/lttng-ust/2.9.1/git/liblttng-ust-ctl/ustctl.c:1183<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D {chan =3D 0xf3b2e290, priv =
=3D 0x0, handle =3D 0xf3b2e0c0, <br>
&gt; data_size =3D 8, largest_align =3D 1, cpu =3D -1, buf =3D 0xf6909000, =
slot_size <br>
&gt; =3D 8, buf_offset =3D 163877, pre_offset =3D 163877, tsc =3D 0, rflags=
 =3D 0, <br>
&gt; ctx_len =3D 80, ip =3D 0x0, priv2 =3D 0x0, padding2 =3D &#39;\000&#39;=
 &lt;repeats 11 <br>
&gt; times&gt;, backend_pages =3D 0xf690c000}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chan =3D 0xf3b2e4d8<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D 0xf3b7eeb2 &quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reserve_len =3D 8<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D &lt;optimized out&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__ =3D &#39;\000&#39; &lt;repe=
ats 34 times&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __PRETTY_FUNCTION__ =3D &#39;\000&#3=
9; &lt;repeats 34 times&gt;<br>
&gt; ---Type &lt;return&gt; to continue, or q &lt;return&gt; to quit---<br>
&gt; <br>
&gt; #4=C2=A0 0x000344cc in commit_one_metadata_packet <br>
&gt; (stream=3Dstream@entry=3D0xf3b2e560) at ust-consumer.c:2206<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_len =3D &lt;optimized out&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D &lt;optimized out&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __PRETTY_FUNCTION__ =3D &quot;commit=
_one_metadata_packet&quot;<br>
&gt; <br>
&gt; #5=C2=A0 0x00036538 in lttng_ustconsumer_read_subbuffer <br>
&gt; (stream=3Dstream@entry=3D0xf3b2e560, ctx=3Dctx@entry=3D0x25e6e8) at <b=
r>
&gt; ust-consumer.c:2452<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D 4096<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 subbuf_size =3D 4093<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 padding =3D &lt;optimized out&gt;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -11<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_index =3D 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D &lt;optimized out&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ustream =3D &lt;optimized out&gt;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D {offset =3D 0, packet_size=
 =3D 575697416355872, <br>
&gt; content_size =3D 17564043391468256584, timestamp_begin =3D <br>
&gt; 17564043425827782792, timestamp_end =3D 34359738496,<br>
&gt; Regards<br>
&gt; Anders<br>
&gt; <br>
&gt; fre 24 nov. 2017 kl 20:18 skrev Mathieu Desnoyers <br>
&gt; &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank=
" rel=3D"noreferrer">mathieu.desnoyers@efficios.com</a> &lt;mailto:<a href=
=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank" rel=3D"norefer=
rer">mathieu.desnoyers@efficios.com</a>&gt;&gt;:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0----- On Nov 24, 2017, at 3:23 AM, Anders Wallin &l=
t;<a href=3D"mailto:wallinux@gmail.com" target=3D"_blank" rel=3D"noreferrer=
">wallinux@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:wallinux@gmail.com" ta=
rget=3D"_blank" rel=3D"noreferrer">wallinux@gmail.com</a>&gt;&gt; wrote:<br=
>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0architectures that has memory alignme=
nt restrictions may/will<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fail with the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optimization done in=C2=A051b8f2fa2b9=
72e62117caa946dd3e3565b6ca4a3.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Please revert the patch or make it X8=
6 specific.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Anders,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This was added in the development cycle of lttng-us=
t 2.9. We could<br>
&gt;=C2=A0 =C2=A0 =C2=A0perhaps<br>
&gt;=C2=A0 =C2=A0 =C2=A0add a test on the pointer alignment for architectur=
es that care<br>
&gt;=C2=A0 =C2=A0 =C2=A0about it, and<br>
&gt;=C2=A0 =C2=A0 =C2=A0fallback to memcpy in those cases.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The revert approach would have been justified if th=
is commit had<br>
&gt;=C2=A0 =C2=A0 =C2=A0been backported<br>
&gt;=C2=A0 =C2=A0 =C2=A0as a &quot;fix&quot; to a stable branch, which is n=
ot the case here. We should<br>
&gt;=C2=A0 =C2=A0 =C2=A0work on<br>
&gt;=C2=A0 =C2=A0 =C2=A0finding an acceptable solution that takes care of d=
ealing with<br>
&gt;=C2=A0 =C2=A0 =C2=A0unaligned pointers<br>
&gt;=C2=A0 =C2=A0 =C2=A0on architectures that care about the difference.<br=
>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Mathieu<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Regards<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Anders Wallin<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------------------------------------=
-----------------------------------------------------------------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0commit 51b8f2fa2b972e62117caa946dd3e3=
565b6ca4a3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Author: Mathieu Desnoyers &lt;<a href=
=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank" rel=3D"norefer=
rer">mathieu.desnoyers@efficios.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mathieu.=
desnoyers@efficios.com" target=3D"_blank" rel=3D"noreferrer">mathieu.desnoy=
ers@efficios.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Date:=C2=A0 =C2=A0Sun Sep 25 12:31:11=
 2016 -0400<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Performance: implement=
 lttng_inline_memcpy<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Because all length par=
ameters received for serializing data<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0coming from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 applications go throug=
h a callback, they are never<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0constant, and it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hurts performance to p=
erform a call to memcpy each time.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Signed-off-by: Mathieu=
 Desnoyers<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:mathieu.desnoye=
rs@efficios.com" target=3D"_blank" rel=3D"noreferrer">mathieu.desnoyers@eff=
icios.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mathieu.=
desnoyers@efficios.com" target=3D"_blank" rel=3D"noreferrer">mathieu.desnoy=
ers@efficios.com</a>&gt;&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diff --git a/libringbuffer/backend_in=
ternal.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b/libringbuffer/backend_internal.h<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index 90088b89..e597cf4d 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--- a/libringbuffer/backend_internal.=
h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+++ b/libringbuffer/backend_internal.=
h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -592,6 +592,28 @@ int update_read_=
sb_index(const struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttng_ust_lib_ring_buffer_config *con=
fig,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#define inline_memcpy(dest, sr=
c, n)=C2=A0 =C2=A0 memcpy(dest, src, n)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+static inline __attribute__((always_=
inline))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+void lttng_inline_memcpy(void *dest,=
 const void *src,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0unsigned long len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (l=
en) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0case 1:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0*(uint8_t *) dest =3D *(const uint8_t *) src;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0case 2:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0*(uint16_t *) dest =3D *(const uint16_t *) src;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0case 4:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0*(uint32_t *) dest =3D *(const uint32_t *) src;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0case 8:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0*(uint64_t *) dest =3D *(const uint64_t *) src;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0inline_memcpy(dest, src, len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Use the architecture-specif=
ic memcpy implementation for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0constant-sized<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * inputs, but rely on an inli=
ne memcpy for length statically<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unknown.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -603,7 +625,7 @@ do {=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (__bu=
iltin_constant_p(len))=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 memcpy(dest, src, __len);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0inline_memcpy(dest, src, __len);=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0lttng_inline_memcpy(dest, src, __len);=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} while (0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------------------------------------=
---------------------------------------------------------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Here is one example of a crash, where=
 0xf3b7eeb2 is not 8 byte<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aligned;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (gdb) bt full<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#0=C2=A0 lttng_inline_memcpy (len=3D8=
, src=3D0xf3b7eeb2, dest=3D&lt;optimized<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out&gt;) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/src/debug/lttng-ust/2.9.1/git/li=
bringbuffer/backend_internal.h:610<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No locals.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#1=C2=A0 lib_ring_buffer_write (len=
=3D8, src=3D0xf3b7eeb2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx=3D0xf57c47d0, config=3D0xf737c560=
 &lt;client_config&gt;) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/src/debug/lttng-ust/2.9.1/git/li=
bringbuffer/backend.h:100<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __len =
=3D 8<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 handle =
=3D 0xf3b2e0c0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 backend_=
pages =3D &lt;optimized out&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chanb =
=3D 0xf3b2e2e0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset =
=3D &lt;optimized out&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#2=C2=A0 lttng_event_write (ctx=3D0xf=
57c47d0, src=3D0xf3b7eeb2, len=3D8) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/src/debug/lttng-ust/2.9.1/git/li=
blttng-ust/lttng-ring-buffer-metadata-client.h:267<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No locals.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#3=C2=A0 0xf7337ef8 in ustctl_write_o=
ne_packet_to_channel<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(channel=3D&lt;optimized out&gt;, met=
adata_str=3D0xf3b7eeb2 &quot;&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len=3D&lt;optimized out&gt;) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/src/debug/lttng-ust/2.9.1/git/li=
blttng-ust-ctl/ustctl.c:1183<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D =
{chan =3D 0xf3b2e290, priv =3D 0x0, handle =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xf3b2e0c0, data_size =3D 8, largest_=
align =3D 1, cpu =3D -1, buf =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xf6909000, slot_size =3D 8, buf_offs=
et =3D 163877, pre_offset =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0163877, tsc =3D 0, rflags =3D 0, ctx_=
len =3D 80, ip =3D 0x0, priv2 =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0, padding2 =3D &#39;\000&#39; &lt;=
repeats 11 times&gt;, backend_pages =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xf690c000}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chan =3D=
 0xf3b2e4d8<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D =
0xf3b7eeb2 &quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reserve_=
len =3D 8<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D =
&lt;optimized out&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__=
 =3D &#39;\000&#39; &lt;repeats 34 times&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __PRETTY=
_FUNCTION__ =3D &#39;\000&#39; &lt;repeats 34 times&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---Type &lt;return&gt; to continue, o=
r q &lt;return&gt; to quit---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#4=C2=A0 0x000344cc in commit_one_met=
adata_packet<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(stream=3Dstream@entry=3D0xf3b2e560) =
at ust-consumer.c:2206<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_le=
n =3D &lt;optimized out&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D =
&lt;optimized out&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __PRETTY=
_FUNCTION__ =3D &quot;commit_one_metadata_packet&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#5=C2=A0 0x00036538 in lttng_ustconsu=
mer_read_subbuffer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(stream=3Dstream@entry=3D0xf3b2e560, =
ctx=3Dctx@entry=3D0x25e6e8) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ust-consumer.c:2452<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D =
4096<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 subbuf_s=
ize =3D 4093<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 padding =
=3D &lt;optimized out&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D =
-11<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_in=
dex =3D 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D =
&lt;optimized out&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ustream =
=3D &lt;optimized out&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 index =
=3D {offset =3D 0, packet_size =3D 575697416355872,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0content_size =3D 17564043391468256584=
, timestamp_begin =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A017564043425827782792, timestamp_end =
=3D 34359738496,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0events_discarded =3D 313327092840, st=
ream_id =3D 4089446416,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stream_instance_id =3D 17689097291346=
376608, packet_seq_num =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08589934593}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __PRETTY=
_FUNCTION__ =3D &quot;lttng_ustconsumer_read_subbuffer&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__=
 =3D &quot;lttng_ustconsumer_read_subbuffer&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.....<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_____________________________________=
__________<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttng-dev mailing list<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:lttng-dev@lists.ltt=
ng.org" target=3D"_blank" rel=3D"noreferrer">lttng-dev@lists.lttng.org</a> =
&lt;mailto:<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank" r=
el=3D"noreferrer">lttng-dev@lists.lttng.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer noreferrer" target=3D"_=
blank">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lists.lttng.or=
g/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer noreferrer" target=
=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>&=
gt;<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A0Mathieu Desnoyers<br>
&gt;=C2=A0 =C2=A0 =C2=A0EfficiOS Inc.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://www.efficios.com" rel=3D"noreferr=
er noreferrer" target=3D"_blank">http://www.efficios.com</a> &lt;<a href=3D=
"http://www.efficios.com" rel=3D"noreferrer noreferrer" target=3D"_blank">h=
ttp://www.efficios.com</a>&gt;<br>
&gt; <br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"https://www.efficios.com" rel=3D"noreferrer noreferrer" target=
=3D"_blank">https://www.efficios.com</a><br>
<br>
</blockquote></div></div></div>

--000000000000498caf05f32fcef9--

--===============6930845206339412935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6930845206339412935==--
