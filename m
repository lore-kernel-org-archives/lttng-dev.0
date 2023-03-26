Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E218C76195
	for <lttng-dev@archiver.kernel.org>; Mon, 27 Mar 2023 14:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679926514;
	bh=37BX1Dnxsx98uQCC80351nNeVRFqbVOwWI79Ro/ybmM=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=S9nmltTgiKsZ/CGeWcZlH5B6NZVkS79CHkbHO1H56l9YU3lXdRDagU3AfevvqTcJM
	 6QijMdtfbl6FaEav/T/Zgnv0JMgdKbLWihMO+ZWttf7s3Ip+0QLz+GUZSk4Xic+lHe
	 +cN4eg1JHqPv4F56qdQzzB5tuJInLnYoE+zFKXnHz/FBBFLVRZH1C/+apeGyY7plt+
	 yfOVkorYKnA/3GLl8ufSyL0Ndt6DqcBZDlmhXrwmVZ/y6s6F1Uc/PDSGY+/NDRh1WI
	 bTcQw4XyqriKIzKwSmRH1uY6sFDOj4zJGVvFd5qqA2GQXMMfNvnUcMz8PYu2wLBH3K
	 UAXVXtn47j6kQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PlZb607V6z2K1p;
	Mon, 27 Mar 2023 10:15:13 -0400 (EDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by lists.lttng.org (Postfix) with ESMTPS id 4Pkzfs2dHbz2JrB
 for <lttng-dev@lists.lttng.org>; Sun, 26 Mar 2023 11:01:25 -0400 (EDT)
Received: by mail-lf1-f44.google.com with SMTP id x17so8092250lfu.5
 for <lttng-dev@lists.lttng.org>; Sun, 26 Mar 2023 08:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679842824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KwV8h1mu4WeAosV53OnZVV2giCe2xXosGO0aKWdSgIg=;
 b=o8ykPGR7fL/fSbB6XGVlJtswyo0ilevSNbmweF3oI+z1Gomg7YU7fg21DVMt3JoyUH
 /dxgfy6hoEdb3VlHaXXhPqV454PonTJ+UHnXrkYbTiX5PfRabzZLk9vsfcVNYXHKFT3S
 Q+WclM2V8fHJMrbveWfSj4HvoDRNT+hb26y3u2I0MgbUbURt4e3gT5zo3626OsWYPGzu
 sPk0h1k3NbLdZstm08yUmarAHaNamj94ljLo8jD+doVLE0hbBUgXm368eCn9MniCFeSv
 rGmihAd/Cw0eeHT56g2+7iq8vy1CbPXD1syIxUkd5FzPDFUnKK98Fd4BkmtzuVw6yZEr
 yOIw==
X-Gm-Message-State: AAQBX9c2zedNwjitIyo2i8iAUEsCw/C6Nr3Zf9oApGkUK7w95jRDeHKi
 eHOMbJlKfqePP0hUqp02jQOpg/UHOCsNqaqLGHw=
X-Google-Smtp-Source: AKy350Z9kcgqrpA5E0BI1MZfGzsCAqTyway+6pfSZLu0THzfBozHkjsfRWngfYcZRhBxKAHyPJtfBF0FCz59zhKb4yQ=
X-Received: by 2002:a19:7419:0:b0:4d8:62e5:4f66 with SMTP id
 v25-20020a197419000000b004d862e54f66mr2434295lfe.7.1679842823430; Sun, 26 Mar
 2023 08:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <CALx39aqN_YvfcDhhKgURZZU-bWZvuiZptbb-kJDYerEex9Q-7A@mail.gmail.com>
In-Reply-To: <CALx39aqN_YvfcDhhKgURZZU-bWZvuiZptbb-kJDYerEex9Q-7A@mail.gmail.com>
Date: Sun, 26 Mar 2023 20:30:10 +0530
Message-ID: <CALx39arqYKMj_M1q_XDBfCSrSruJ5obUuNHeN4Cu7a1sVDwwbw@mail.gmail.com>
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Mon, 27 Mar 2023 10:15:11 -0400
Subject: [lttng-dev]
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
Content-Type: multipart/mixed; boundary="===============3621069226304069417=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3621069226304069417==
Content-Type: multipart/alternative; boundary="000000000000c4e7be05f7cee2e6"

--000000000000c4e7be05f7cee2e6
Content-Type: text/plain; charset="UTF-8"

>
>
> Hi Mathew,
>
> I have a question about this patch for lttng-modules and the use of
> register_kprobe() to fetch the function ptr.
> The question in this regard is especially from PPC64 ELF_ABI_v1
> perspective.
>
> The functions on PPC64 are accessed via the Function descriptor while what
> register_kprobes returns is the entry point of the function.
> Hence using the return pointer tends to interpret the addr as the address
> of the function descriptor and dereferences the ppc_inst as the function
> entry point and crashes
>
> [ 4145.483594] kernel tried to execute exec-protected page
> (7c0802a6fb81ffe0) - exploit attempt? (uid: 0)
>
> here 7c0802a6 is the mfspr instruction from the code text section of the
> kallsyms_lookup_name()
>
> note for PPC_ELF_ABI_v1 the register_kprobes() searches for the dot
> variant of the symbol and only in case if cannot find the dot variant looks
> for the normal symbol.
> register_kprobe() -> kprobe_addr() -> kprobe_lookup_name() [arch variant
> replaces weak symbol]
> https://elixir.bootlin.com/linux/v5.10.174/C/ident/kprobe_lookup_name
>
> Please let me know if i make sense or that i may have missed something.
>
> I have looked at the code of 2.12.8 as well and 2.12.3 verstion of
> lttng-modules.
>
> Regards,
> Shashank
>
>

--000000000000c4e7be05f7cee2e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr"><br>Hi Mathew,<div><br></div><div>I hav=
e a question about this patch for lttng-modules and the use of register_kpr=
obe() to fetch the function ptr.</div><div>The question in this regard is e=
specially from PPC64 ELF_ABI_v1 perspective.</div><div><br></div><div>The f=
unctions on PPC64 are accessed via the Function descriptor while what regis=
ter_kprobes returns is the entry point of the function.=C2=A0</div><div>Hen=
ce using the return pointer tends to interpret=C2=A0the addr as the address=
 of the function descriptor=C2=A0and dereferences the ppc_inst as the funct=
ion entry=C2=A0point=C2=A0and crashes</div><div><br></div><div>[ 4145.48359=
4] kernel tried to execute exec-protected page (7c0802a6fb81ffe0) - exploit=
 attempt? (uid: 0)=C2=A0<br></div><div>=C2=A0</div><div>here 7c0802a6 is th=
e mfspr instruction from the code text section of the kallsyms_lookup_name(=
)</div><div><br></div><div>note for PPC_ELF_ABI_v1 the register_kprobes() s=
earches for the dot variant of the symbol and only in case if cannot find t=
he dot variant looks for the normal symbol.=C2=A0</div><div>register_kprobe=
() -&gt; kprobe_addr() -&gt; kprobe_lookup_name() [arch variant replaces we=
ak symbol]=C2=A0</div><div><a href=3D"https://elixir.bootlin.com/linux/v5.1=
0.174/C/ident/kprobe_lookup_name" target=3D"_blank">https://elixir.bootlin.=
com/linux/v5.10.174/C/ident/kprobe_lookup_name</a>=C2=A0<br></div><div><br>=
</div><div>Please let me know if i make sense or that i may have missed som=
ething.</div><div><br></div><div>I have looked at the code of 2.12.8 as wel=
l and 2.12.3 verstion of lttng-modules.</div><div><br></div><div>Regards,</=
div><div>Shashank</div><div><br></div></div>
</blockquote></div></div>

--000000000000c4e7be05f7cee2e6--

--===============3621069226304069417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3621069226304069417==--
