Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F8DC6FD1D
	for <lttng-dev@archiver.kernel.org>; Mon, 27 Mar 2023 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679932535;
	bh=Gmwn9UA51u3nf69Q0LaTgheYz2o2wuU9hCijSojrlQM=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=JFyZTb8ZHkancdFfF4yBvlxByMQLB52lAiyi5//lZLVcB2IHUAK9X3WHSfirMNN77
	 RiFZm8tKan4Dd+Yz5hFxnl1AC/9G3U4KpaQqzGUptYVqZHlykbeG5n6O6xMLXNDhV6
	 eIedPsNNB842xzqgTQhSxJ4zphjkPsiVr7wWM/vNf6VH4vWxNw0P+plAgGJHVpng60
	 cAikPeZZPClDgrtCsrQ7S19uKrQoLHk4WV/HMGdgg42MogddgIh4OCzZwbm9UcKEBU
	 BJX3LaKn5qhcs5jtpqxauml5v2RXaMi2KGpwMtVRflqj4iXz3yFm/ChLp3jUI12mQz
	 JFSUhCBBcTWbw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Plcpt2vpRz2K27;
	Mon, 27 Mar 2023 11:55:34 -0400 (EDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by lists.lttng.org (Postfix) with ESMTPS id 4Plcn61yrSz2Jw5
 for <lttng-dev@lists.lttng.org>; Mon, 27 Mar 2023 11:53:57 -0400 (EDT)
Received: by mail-lf1-f51.google.com with SMTP id i13so12069084lfe.9
 for <lttng-dev@lists.lttng.org>; Mon, 27 Mar 2023 08:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679932375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g4GohJg+E4LfQx6Zuo4ivb11c4nAF2/0T4H2ESuCtOM=;
 b=XzUzGeY1MtSwK4EAW5zTWfAzhpxhQugG7qK0ccmedj2t5IObClVtkExSDZ3cxymcQ5
 OrOFVKOB1nSJqnhl9luucjHEkP8gfn+cmkQD3my1PwzjC4pBh97pXhVi67W//mgT3kUf
 HCPRcztUJtEJbX06GdFm2Bgu3rMW0f0HiJY2CFWEWJpOoo0eV3/0xdueylzSlGPqF7YX
 2OKveH2fS0c70zE/PrCQwnctPJKA4R02KcE2egGapRcMo465OcX83p6n9oESYEWtENPi
 88qZpeZLWwTaTSATmSa2sVQiw3Oj/Sl0dsSqv+Ankh24qIntSLYD471efU/OhM/uWTE3
 qlbg==
X-Gm-Message-State: AAQBX9fw3lIVM786deof03GEAFRKPty90yRPZoGURIsvMK7O9hh5Bbb2
 tpPx3wi/CYeoZmRFom2ETQTQxTqu95H6Pr2Jo/0=
X-Google-Smtp-Source: AKy350YJLtjkkoYz/VSxN8rT7EtuyrP07XjBzRdxM7kT0bKGlVmTEKvqDb+4hMxa7ReFQJobUvFkwmbxjs+FP4qpCIM=
X-Received: by 2002:ac2:5ed9:0:b0:4e9:a3b7:2369 with SMTP id
 d25-20020ac25ed9000000b004e9a3b72369mr3551168lfq.7.1679932374512; Mon, 27 Mar
 2023 08:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <CALx39aqN_YvfcDhhKgURZZU-bWZvuiZptbb-kJDYerEex9Q-7A@mail.gmail.com>
 <CALx39arqYKMj_M1q_XDBfCSrSruJ5obUuNHeN4Cu7a1sVDwwbw@mail.gmail.com>
 <3056c476-0e3a-8cde-39e4-907602d26d76@efficios.com>
In-Reply-To: <3056c476-0e3a-8cde-39e4-907602d26d76@efficios.com>
Date: Mon, 27 Mar 2023 21:22:41 +0530
Message-ID: <CALx39aqPFVKGCv+jqvgdxge6mew0+Wg4cH-PnBB8Z_LhO6rOig@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailman-Approved-At: Mon, 27 Mar 2023 11:55:33 -0400
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
Content-Type: multipart/mixed; boundary="===============2085517413830473185=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2085517413830473185==
Content-Type: multipart/alternative; boundary="0000000000006df6b105f7e3bce2"

--0000000000006df6b105f7e3bce2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 62 #ifdef LTTNG_CONFIG_PPC64_ELF_ABI_V2
 63         /* Substract 4 bytes to get what we originally want */
 64         addr =3D (unsigned long)(((char *)probe.addr) - 4);
 65 #elif defined*(LTTNG_*CONFIG_PPC64_ELF_ABI_V1)   << incorrect MACRO to
used in gerrit review. this is the correct one.
 66         /*
 67          * Build a function descriptor from the address of

/lttng-module-2.13.8/src/wrapper/kallsyms.c:72:32: error: invalid use of
undefined type 'struct func_desc'
|    72 |  kallsyms_lookup_name_func_desc.addr =3D (unsigned long)probe.add=
r;
/lttng-module-2.13.8/src/wrapper/kallsyms.c:73:32: error: invalid use of
undefined type 'struct func_desc'
|    73 |  kallsyms_lookup_name_func_desc.toc =3D ((struct func_desc *)
&sprint_symbol)->toc;

you either want to use func_descr_t
https://elixir.bootlin.com/linux/v5.15.104/source/arch/powerpc/include/asm/=
types.h#L30
or
struct ppc64_opd_entry
https://elixir.bootlin.com/linux/v5.17.15/source/arch/powerpc/include/uapi/=
asm/elf.h#L293


both of which are discontinued from 5.18



On Mon, Mar 27, 2023 at 5:56=E2=80=AFPM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> On 2023-03-26 11:00, yashvardhan kukreti wrote:
> >
> >     Hi Mathew,
> >
> >     I have a question about this patch for lttng-modules and the use of
> >     register_kprobe() to fetch the function ptr.
> >     The question in this regard is especially from PPC64 ELF_ABI_v1
> >     perspective.
> >
> >     The functions on PPC64 are accessed via the Function descriptor
> >     while what register_kprobes returns is the entry point of the
> function.
> >     Hence using the return pointer tends to interpret the addr as the
> >     address of the function descriptor and dereferences the ppc_inst as
> >     the function entry point and crashes
> >
> >     [ 4145.483594] kernel tried to execute exec-protected page
> >     (7c0802a6fb81ffe0) - exploit attempt? (uid: 0)
> >     here 7c0802a6 is the mfspr instruction from the code text section o=
f
> >     the kallsyms_lookup_name()
> >
> >     note for PPC_ELF_ABI_v1 the register_kprobes() searches for the dot
> >     variant of the symbol and only in case if cannot find the dot
> >     variant looks for the normal symbol.
> >     register_kprobe() -> kprobe_addr() -> kprobe_lookup_name() [arch
> >     variant replaces weak symbol]
> >
> https://elixir.bootlin.com/linux/v5.10.174/C/ident/kprobe_lookup_name <
> https://elixir.bootlin.com/linux/v5.10.174/C/ident/kprobe_lookup_name>
> >
> >     Please let me know if i make sense or that i may have missed
> something.
> >
> >     I have looked at the code of 2.12.8 as well and 2.12.3 verstion of
> >     lttng-modules.
>
> Please have a look at commits (from stable-2.12 branch of lttng-modules):
>
> commit 53772db24facd84f1f3ddcf21a1ef5f162608721
> Author: He Zhe <zhe.he@windriver.com>
> Date:   Tue Sep 27 15:59:42 2022 +0800
>
>      wrapper: powerpc64: fix kernel crash caused by do_get_kallsyms
>
> commit 8fe888d86ccad4226b05a536efb73d71bb091062
> Author: Michael Jeanson <mjeanson@efficios.com>
> Date:   Thu Nov 24 14:25:33 2022 -0500
>
>      fix: kallsyms wrapper on ppc64el
>
> I suspect you'll also need this change currently in review:
>
> https://review.lttng.org/c/lttng-modules/+/9113
>
> Please let us know if especially this last change fixes things on your
> side.
>
> Thanks,
>
> Mathieu
>
>
> >
> >     Regards,
> >     Shashank
> >
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
>

--0000000000006df6b105f7e3bce2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>=C2=A062 #ifdef LTTNG_CONFIG_PPC64_ELF_ABI_V2<br>=C2=
=A063 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Substract 4 bytes to get what we origi=
nally want */<br>=C2=A064 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D (unsigned lo=
ng)(((char *)probe.addr) - 4);<br>=C2=A065 #elif defined<b>(LTTNG_</b>CONFI=
G_PPC64_ELF_ABI_V1)=C2=A0 =C2=A0&lt;&lt; incorrect MACRO to used=C2=A0in ge=
rrit review. this is the correct one.<br>=C2=A066 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /*<br>=C2=A067 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Build a function des=
criptor from the address of<br></div><div><br></div>/lttng-module-2.13.8/sr=
c/wrapper/kallsyms.c:72:32: error: invalid use of undefined type &#39;struc=
t func_desc&#39;<br>| =C2=A0 =C2=A072 | =C2=A0kallsyms_lookup_name_func_des=
c.addr =3D (unsigned long)probe.addr;<br><div>/lttng-module-2.13.8/src/wrap=
per/kallsyms.c:73:32: error: invalid use of undefined type &#39;struct func=
_desc&#39;<br>| =C2=A0 =C2=A073 | =C2=A0kallsyms_lookup_name_func_desc.toc =
=3D ((struct func_desc *) &amp;sprint_symbol)-&gt;toc;<br></div><div><br></=
div><div>you either want to use func_descr_t=C2=A0</div><div><a href=3D"htt=
ps://elixir.bootlin.com/linux/v5.15.104/source/arch/powerpc/include/asm/typ=
es.h#L30">https://elixir.bootlin.com/linux/v5.15.104/source/arch/powerpc/in=
clude/asm/types.h#L30</a><br></div><div>or<br></div><div>struct ppc64_opd_e=
ntry</div><div><a href=3D"https://elixir.bootlin.com/linux/v5.17.15/source/=
arch/powerpc/include/uapi/asm/elf.h#L293">https://elixir.bootlin.com/linux/=
v5.17.15/source/arch/powerpc/include/uapi/asm/elf.h#L293</a>=C2=A0<br></div=
><div><br></div><div>both of which are discontinued from 5.18<br><br></div>=
<div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, Mar 27, 2023 at 5:56=E2=80=AFPM Mathieu Desnoyers &=
lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@effi=
cios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On 2023-03-26 11:00, yashvardhan kukreti wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Mathew,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I have a question about this patch for lttng-module=
s and the use of<br>
&gt;=C2=A0 =C2=A0 =C2=A0register_kprobe() to fetch the function ptr.<br>
&gt;=C2=A0 =C2=A0 =C2=A0The question in this regard is especially from PPC6=
4 ELF_ABI_v1<br>
&gt;=C2=A0 =C2=A0 =C2=A0perspective.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The functions on PPC64 are accessed via the Functio=
n descriptor<br>
&gt;=C2=A0 =C2=A0 =C2=A0while what register_kprobes returns is the entry po=
int of the function.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Hence using the return pointer tends to interpret=
=C2=A0the addr as the<br>
&gt;=C2=A0 =C2=A0 =C2=A0address of the function descriptor=C2=A0and derefer=
ences the ppc_inst as<br>
&gt;=C2=A0 =C2=A0 =C2=A0the function entry=C2=A0point=C2=A0and crashes<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 4145.483594] kernel tried to execute exec-protect=
ed page<br>
&gt;=C2=A0 =C2=A0 =C2=A0(7c0802a6fb81ffe0) - exploit attempt? (uid: 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0here 7c0802a6 is the mfspr instruction from the cod=
e text section of<br>
&gt;=C2=A0 =C2=A0 =C2=A0the kallsyms_lookup_name()<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0note for PPC_ELF_ABI_v1 the register_kprobes() sear=
ches for the dot<br>
&gt;=C2=A0 =C2=A0 =C2=A0variant of the symbol and only in case if cannot fi=
nd the dot<br>
&gt;=C2=A0 =C2=A0 =C2=A0variant looks for the normal symbol.<br>
&gt;=C2=A0 =C2=A0 =C2=A0register_kprobe() -&gt; kprobe_addr() -&gt; kprobe_=
lookup_name() [arch<br>
&gt;=C2=A0 =C2=A0 =C2=A0variant replaces weak symbol]<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://elixir.bootlin.com/linux/v5.10.1=
74/C/ident/kprobe_lookup_name" rel=3D"noreferrer" target=3D"_blank">https:/=
/elixir.bootlin.com/linux/v5.10.174/C/ident/kprobe_lookup_name</a> &lt;<a h=
ref=3D"https://elixir.bootlin.com/linux/v5.10.174/C/ident/kprobe_lookup_nam=
e" rel=3D"noreferrer" target=3D"_blank">https://elixir.bootlin.com/linux/v5=
.10.174/C/ident/kprobe_lookup_name</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Please let me know if i make sense or that i may ha=
ve missed something.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I have looked at the code of 2.12.8 as well and 2.1=
2.3 verstion of<br>
&gt;=C2=A0 =C2=A0 =C2=A0lttng-modules.<br>
<br>
Please have a look at commits (from stable-2.12 branch of lttng-modules):<b=
r>
<br>
commit 53772db24facd84f1f3ddcf21a1ef5f162608721<br>
Author: He Zhe &lt;<a href=3D"mailto:zhe.he@windriver.com" target=3D"_blank=
">zhe.he@windriver.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Tue Sep 27 15:59:42 2022 +0800<br>
<br>
=C2=A0 =C2=A0 =C2=A0wrapper: powerpc64: fix kernel crash caused by do_get_k=
allsyms<br>
<br>
commit 8fe888d86ccad4226b05a536efb73d71bb091062<br>
Author: Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com" target=
=3D"_blank">mjeanson@efficios.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Thu Nov 24 14:25:33 2022 -0500<br>
<br>
=C2=A0 =C2=A0 =C2=A0fix: kallsyms wrapper on ppc64el<br>
<br>
I suspect you&#39;ll also need this change currently in review:<br>
<br>
<a href=3D"https://review.lttng.org/c/lttng-modules/+/9113" rel=3D"noreferr=
er" target=3D"_blank">https://review.lttng.org/c/lttng-modules/+/9113</a><b=
r>
<br>
Please let us know if especially this last change fixes things on your side=
.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Shashank<br>
&gt; <br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"https://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.efficios.com</a><br>
<br>
</blockquote></div>

--0000000000006df6b105f7e3bce2--

--===============2085517413830473185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2085517413830473185==--
