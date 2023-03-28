Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB90CC76196
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Mar 2023 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1680010538;
	bh=3r7reVY+IIlcpnD23lFq0eHEGZe65T4y43GPf0CYP30=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=eeVQ7eF0GFU8M3n4nZKJfyU1TWRA+v2LjfDlJPDHgMVpsNFXMjiNJ8ztAHtlOFe0e
	 +xRyrc2sjtuHArttajCunbJBQHZWZeYuXsQOZwmXfspZ//YyvlM7HCH7KNHd+3M1Io
	 wiarRLU8WCwP/5oMg0rUSNrxpiXF/D8yEaQxhkUA6dDcvpHNGClzcykM9Noe8Kqgrg
	 DxIgGWXxE9WlOT9h3X+wm5HdnI/+AyNuAe1MtdpnmKhuQQ13lJbLVWZzy8y1dnhDOR
	 9nPt4H2a6l3qgxW4kRyMJ6f8O32g3N89QPzNhNAlNcjBNZUsgWOooE3JTzFDC61LkZ
	 xLqGJU9U2mV3g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Pm9fx5Ftgz2KpP;
	Tue, 28 Mar 2023 09:35:37 -0400 (EDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by lists.lttng.org (Postfix) with ESMTPS id 4Pm9fw366hz2KX8
 for <lttng-dev@lists.lttng.org>; Tue, 28 Mar 2023 09:35:34 -0400 (EDT)
Received: by mail-lf1-f54.google.com with SMTP id j11so15818612lfg.13
 for <lttng-dev@lists.lttng.org>; Tue, 28 Mar 2023 06:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680010473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U7XlZTrqCy5Mc5nGzbv85zYE4vAxkR7uRakMg7FRu+g=;
 b=MIf+g5PJhJvLTE3iU7D/DmKqAjurVh5VI4cVmVUZ+EuSmP6knL1uc1X7V+g2h6+w02
 brO0NI1WexWQ20k1wDU7uy2esiGLawmVE+GLf0P0IwBb6XDJWhC4rSkzyZD1WJQyA6vX
 U9eHv1ekYYpbI0LKIuk8PA/vDxXEw4DfgpbH7gATPl1NqR0phrSrOH98LBhcT+fArsnP
 x+VOKoZIr6/SFB59KzfBuJBRWSdyW0+XuKRfFzCSPnQ25DbKKrM3nOGDa/Jz0T6KluLX
 mXGVuIQsmXqFFxA2gpojtMRb7QVoH+mjYfDQNRvcGX6NOWdL1wR0BRkFPXS5f07kLir+
 RPSw==
X-Gm-Message-State: AAQBX9ebWPThr8gmwZXelu0UKo5H3H3IfN8xTDTGUa5ipVgMju1DG8Jq
 APtc56UYZ4gmmWrwR8SIxh9t+ktdknHxXwaNF2k7wFVO8R4=
X-Google-Smtp-Source: AKy350aRqbXWr4+wzcIHxt4v5vww4wQZo5oFo/f0UvNm6EuUVla2NUggsNOYpqZtPhyAANpUGJJrCRw2ngiFb3H0CHE=
X-Received: by 2002:a19:7419:0:b0:4d8:62e5:4f66 with SMTP id
 v25-20020a197419000000b004d862e54f66mr4504020lfe.7.1680010472369; Tue, 28 Mar
 2023 06:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <CALx39aqN_YvfcDhhKgURZZU-bWZvuiZptbb-kJDYerEex9Q-7A@mail.gmail.com>
 <CALx39arqYKMj_M1q_XDBfCSrSruJ5obUuNHeN4Cu7a1sVDwwbw@mail.gmail.com>
 <3056c476-0e3a-8cde-39e4-907602d26d76@efficios.com>
 <CALx39aqPFVKGCv+jqvgdxge6mew0+Wg4cH-PnBB8Z_LhO6rOig@mail.gmail.com>
 <9bf67681-e3c7-0b25-07b7-40c0a85aee67@efficios.com>
In-Reply-To: <9bf67681-e3c7-0b25-07b7-40c0a85aee67@efficios.com>
Date: Tue, 28 Mar 2023 19:04:19 +0530
Message-ID: <CALx39aoCGt97U7HHqj=nrEZ4x_L+_2dZRp10i2qiBgUo0COH5g@mail.gmail.com>
To: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [lttng-dev]
 https://lists.lttng.org/pipermail/lttng-dev/2020-May/029631.html
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
From: yashvardhan kukreti via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: yashvardhan kukreti <yashvardhankukreti@gmail.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: multipart/mixed; boundary="===============8924024269074844514=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8924024269074844514==
Content-Type: multipart/alternative; boundary="0000000000006cb39205f7f5ebfd"

--0000000000006cb39205f7f5ebfd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Michael, the patch is working

[  157.606699]  SK DEBUG look up symbol .kallsyms_lookup_name
[  157.613527]  SK DEBUG look up symbol get_pfnblock_flags_mask
[  157.644191] LTTng: Loaded modules v2.13.8 (Nordicit=C3=A9) -
devtool-base-1-g1011df74-dirty

Regards,
Shahank

On Mon, Mar 27, 2023 at 11:59=E2=80=AFPM Michael Jeanson <mjeanson@efficios=
.com>
wrote:

> On 2023-03-27 11:52, yashvardhan kukreti wrote:
> >   62 #ifdef LTTNG_CONFIG_PPC64_ELF_ABI_V2
> >   63         /* Substract 4 bytes to get what we originally want */
> >   64         addr =3D (unsigned long)(((char *)probe.addr) - 4);
> >   65 #elif defined*(LTTNG_*CONFIG_PPC64_ELF_ABI_V1)   << incorrect MACR=
O
> to
> > used in gerrit review. this is the correct one.
> >   66         /*
> >   67          * Build a function descriptor from the address of
> >
> > /lttng-module-2.13.8/src/wrapper/kallsyms.c:72:32: error: invalid use o=
f
> > undefined type 'struct func_desc'
> > |    72 |  kallsyms_lookup_name_func_desc.addr =3D (unsigned
> long)probe.addr;
> > /lttng-module-2.13.8/src/wrapper/kallsyms.c:73:32: error: invalid use o=
f
> > undefined type 'struct func_desc'
> > |    73 |  kallsyms_lookup_name_func_desc.toc =3D ((struct func_desc *)
> > &sprint_symbol)->toc;
> >
> > you either want to use func_descr_t
> >
> https://elixir.bootlin.com/linux/v5.15.104/source/arch/powerpc/include/as=
m/types.h#L30
> <
> https://elixir.bootlin.com/linux/v5.15.104/source/arch/powerpc/include/as=
m/types.h#L30
> >
> > or
> > struct ppc64_opd_entry
> >
> https://elixir.bootlin.com/linux/v5.17.15/source/arch/powerpc/include/uap=
i/asm/elf.h#L293
> <
> https://elixir.bootlin.com/linux/v5.17.15/source/arch/powerpc/include/uap=
i/asm/elf.h#L293
> >
> >
> > both of which are discontinued from 5.18
>
>
> Hi,
>
> I updated the patch at https://review.lttng.org/c/lttng-modules/+/9113 to
> support kernels older than v5.18. It's only build tested on v5.17 and
> v5.18.
>
> Michael
>
>

--0000000000006cb39205f7f5ebfd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks=C2=A0Michael, the patch is working<div><br></div><d=
iv>[ =C2=A0157.606699] =C2=A0SK DEBUG look up symbol .kallsyms_lookup_name<=
br>[ =C2=A0157.613527] =C2=A0SK DEBUG look up symbol get_pfnblock_flags_mas=
k<br>[ =C2=A0157.644191] LTTng: Loaded modules v2.13.8 (Nordicit=C3=A9) - d=
evtool-base-1-g1011df74-dirty<br></div><div><br></div><div>Regards,</div><d=
iv>Shahank=C2=A0</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Mon, Mar 27, 2023 at 11:59=E2=80=AFPM Michael Jean=
son &lt;<a href=3D"mailto:mjeanson@efficios.com">mjeanson@efficios.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 20=
23-03-27 11:52, yashvardhan kukreti wrote:<br>
&gt;=C2=A0 =C2=A062 #ifdef LTTNG_CONFIG_PPC64_ELF_ABI_V2<br>
&gt;=C2=A0 =C2=A063 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Substract 4 bytes to get=
 what we originally want */<br>
&gt;=C2=A0 =C2=A064 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D (unsigned long)(((=
char *)probe.addr) - 4);<br>
&gt;=C2=A0 =C2=A065 #elif defined*(LTTNG_*CONFIG_PPC64_ELF_ABI_V1)=C2=A0 =
=C2=A0&lt;&lt; incorrect MACRO to <br>
&gt; used=C2=A0in gerrit review. this is the correct one.<br>
&gt;=C2=A0 =C2=A066 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A067 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Build a function de=
scriptor from the address of<br>
&gt; <br>
&gt; /lttng-module-2.13.8/src/wrapper/kallsyms.c:72:32: error: invalid use =
of <br>
&gt; undefined type &#39;struct func_desc&#39;<br>
&gt; | =C2=A0 =C2=A072 | =C2=A0kallsyms_lookup_name_func_desc.addr =3D (uns=
igned long)probe.addr;<br>
&gt; /lttng-module-2.13.8/src/wrapper/kallsyms.c:73:32: error: invalid use =
of <br>
&gt; undefined type &#39;struct func_desc&#39;<br>
&gt; | =C2=A0 =C2=A073 | =C2=A0kallsyms_lookup_name_func_desc.toc =3D ((str=
uct func_desc *) <br>
&gt; &amp;sprint_symbol)-&gt;toc;<br>
&gt; <br>
&gt; you either want to use func_descr_t<br>
&gt; <a href=3D"https://elixir.bootlin.com/linux/v5.15.104/source/arch/powe=
rpc/include/asm/types.h#L30" rel=3D"noreferrer" target=3D"_blank">https://e=
lixir.bootlin.com/linux/v5.15.104/source/arch/powerpc/include/asm/types.h#L=
30</a> &lt;<a href=3D"https://elixir.bootlin.com/linux/v5.15.104/source/arc=
h/powerpc/include/asm/types.h#L30" rel=3D"noreferrer" target=3D"_blank">htt=
ps://elixir.bootlin.com/linux/v5.15.104/source/arch/powerpc/include/asm/typ=
es.h#L30</a>&gt;<br>
&gt; or<br>
&gt; struct ppc64_opd_entry<br>
&gt; <a href=3D"https://elixir.bootlin.com/linux/v5.17.15/source/arch/power=
pc/include/uapi/asm/elf.h#L293" rel=3D"noreferrer" target=3D"_blank">https:=
//elixir.bootlin.com/linux/v5.17.15/source/arch/powerpc/include/uapi/asm/el=
f.h#L293</a> &lt;<a href=3D"https://elixir.bootlin.com/linux/v5.17.15/sourc=
e/arch/powerpc/include/uapi/asm/elf.h#L293" rel=3D"noreferrer" target=3D"_b=
lank">https://elixir.bootlin.com/linux/v5.17.15/source/arch/powerpc/include=
/uapi/asm/elf.h#L293</a>&gt;<br>
&gt; <br>
&gt; both of which are discontinued from 5.18<br>
<br>
<br>
Hi,<br>
<br>
I updated the patch at <a href=3D"https://review.lttng.org/c/lttng-modules/=
+/9113" rel=3D"noreferrer" target=3D"_blank">https://review.lttng.org/c/ltt=
ng-modules/+/9113</a> to <br>
support kernels older than v5.18. It&#39;s only build tested on v5.17 and v=
5.18.<br>
<br>
Michael<br>
<br>
</blockquote></div>

--0000000000006cb39205f7f5ebfd--

--===============8924024269074844514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8924024269074844514==--
