Return-Path: <SRS0=HL3W=AH=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912B5C433E0
	for <lttng-dev@archiver.kernel.org>; Fri, 26 Jun 2020 14:20:20 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082392067D
	for <lttng-dev@archiver.kernel.org>; Fri, 26 Jun 2020 14:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="hOF9bdUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082392067D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49tfDK6QQQz14pJ;
	Fri, 26 Jun 2020 10:20:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1593181218;
	bh=b9UmeNY9o0g7STnGv34LyCe2fhqh0U4WsIxuvw2H37U=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hOF9bdUwpVwI+grmcruQb1RUh4KRN/gEL7BH5vrwNqBxWKdJnhKTjuk5X/iZVD5ZP
	 PvoONU3t470H9QidEEFjcxnb149Sdemi+OAVLHxyK6cwIqe1rJJRedJK3bwLllBWEt
	 NDViYPcXY4FLfTWgKvVNEjHX2En58Ql9jg6pLZZ+DxgP1M4sN/hOBnJ46BHBkovYhU
	 quShSnUWX6rfKBRipotWhbUa5D/xJptv+L1Pk3Qu561uSzzERKWL5f4bPaRlyEpBvZ
	 eJlajixynZWsw/iAyY+zRbHVTlkjD2DN2s9awWU9oRbQQ0P8LvZW9wmSe0Tj0kvg1X
	 hLYfTVRblgFXg==
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by lists.lttng.org (Postfix) with ESMTPS id 49tfDJ42gCz14rw
 for <lttng-dev@lists.lttng.org>; Fri, 26 Jun 2020 10:20:16 -0400 (EDT)
Received: by mail-ej1-x632.google.com with SMTP id l12so9513307ejn.10
 for <lttng-dev@lists.lttng.org>; Fri, 26 Jun 2020 07:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OKlS1bt8bkRk8OmQvCi8W1atZIZNYm4b4WY0FAqNlpc=;
 b=qmBuvMVQ45/dFIB+dIxjM0/O5LNTpwq1pojRLzXIIdfseVVGuy78CT4rF6NFFU5pNV
 WuexCpMX6zcATZDHR/c2nczW7NSNPveFuJw9ARYrrnEVWaogOoBPJcWyLBZlHylOmSRe
 j95VPZLJJkJSy/SGfQHwffQnSrPZefVn9aVjmrYV3OKnUYz1jGSAVdcrvAAJk3asuC/c
 sy+8eqN9VpfmTwmOniDrSl6lVqYW3VO9brbduP21TYDwFsMEhQPoRg/12mBy4zDwY6aB
 Jn5JD53KMdCUoJuOzQVrve/MjsXpqdczpEmXWIFp+NRJG1JiIvxrnF228Jb72IWSWgDo
 rd5w==
X-Gm-Message-State: AOAM530Xx0JZZkOv6y6oxUMfaGwz77y0+SPraMgLFXakhfdnMF3GD1jQ
 uqlLGpAPSiUFpERGFs9PnjrK8QJ8s3jaKuHShhI=
X-Google-Smtp-Source: ABdhPJwrCo6zLUGVbqilSfrvT2XP6a2D/Zh4AdDimZ9sP4MpTRckadD3BwJEV48ISUQGZANXrt5ot+aYQnw+SR2e2QI=
X-Received: by 2002:a17:907:a92:: with SMTP id
 by18mr2965065ejc.116.1593181215128; 
 Fri, 26 Jun 2020 07:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200623143758.GB4160129@jerryopenix>
 <SA0PR15MB38396A864018025F971F2A239E940@SA0PR15MB3839.namprd15.prod.outlook.com>
 <CAAS9doZNif9Cw=kmo0hvKuF_qVBiqX_233JWFr4fTc5A72eLvw@mail.gmail.com>
 <20200624014141.GA4166707@jerryopenix>
In-Reply-To: <20200624014141.GA4166707@jerryopenix>
Date: Fri, 26 Jun 2020 10:19:38 -0400
Message-ID: <CAAS9dob7WzAXX+bqca24ELTbAHkMwQvmgmk_r5ci9FVpO4BQYw@mail.gmail.com>
To: "Liu, Changcheng" <changcheng.liu@intel.com>
Subject: Re: [lttng-dev] get function names with lttng-ust-cyg-profile
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: =?utf-8?q?Christophe_B=C3=A9dard_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?Q?Christophe_B=C3=A9dard?= <bedard.christophe@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: multipart/mixed; boundary="===============5347483182144625207=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200626141938.Mx6oiMncRdEmhqJgzPMwl-1hYmUpv5l39cqiX2-2HGg@z>

--===============5347483182144625207==
Content-Type: multipart/alternative; boundary="00000000000063ff0405a8fd6838"

--00000000000063ff0405a8fd6838
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 23 Jun 2020 at 21:45, Liu, Changcheng <changcheng.liu@intel.com>
wrote:

> Do you know how to print the call site function_name/offset?
> For example:
>             11     getchar();
>             12
>             13     x = add3(x);
> Currently, it only shows call_site address instead of function name with
> offset.
>
> func_entry: { cpu_id = 2 }, { ip = 0x55CFA4F5C1EE, debug_info = { bin =
> "instrument+0x11ee", func = "main+0", src = "instrument.c:7" }, vpid = 8523
> }, { addr = 0x55CFA4F5C1EE, call_site = 0x7F27C4B1E0B3 }
> func_entry: { cpu_id = 1 }, { ip = 0x55CFA4F5C1A9, debug_info = { bin =
> "instrument+0x11a9", func = "add3+0", src = "instrument.c:3" }, vpid = 8523
> }, { addr = 0x55CFA4F5C1A9, call_site = 0x55CFA4F5C237 }
> func_exit: { cpu_id = 1 }, { ip = 0x55CFA4F5C1A9, debug_info = { bin =
> "instrument+0x11a9", func = "add3+0", src = "instrument.c:3" }, vpid = 8523
> }, { addr = 0x55CFA4F5C1A9, call_site = 0x55CFA4F5C237 }
> func_exit: { cpu_id = 1 }, { ip = 0x55CFA4F5C1EE, debug_info = { bin =
> "instrument+0x11ee", func = "main+0", src = "instrument.c:7" }, vpid = 8523
> }, { addr = 0x55CFA4F5C1EE, call_site = 0x7F27C4B1E0B3 }
>

 Maybe I'm missing something, but isn't it right here? E.g.

debug_info = { bin = "instrument+0x11ee", func = "main+0", src =
> "instrument.c:7" }
>

Otherwise, I don't think babeltrace can provide any more information.


Christophe

--00000000000063ff0405a8fd6838
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Tue, 23 Jun 2020 at 21:45, Liu, Chan=
gcheng &lt;<a href=3D"mailto:changcheng.liu@intel.com">changcheng.liu@intel=
.com</a>&gt; wrote:</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Do you know how to print the call site function_name/offset?<br>
For example:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 11=C2=A0 =C2=A0 =C2=A0getchar();<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 12<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 13=C2=A0 =C2=A0 =C2=A0x =3D add3(=
x);<br>
Currently, it only shows call_site address instead of function name with of=
fset.<br>
<br>
func_entry: { cpu_id =3D 2 }, { ip =3D 0x55CFA4F5C1EE, debug_info =3D { bin=
 =3D &quot;instrument+0x11ee&quot;, func =3D &quot;main+0&quot;, src =3D &q=
uot;instrument.c:7&quot; }, vpid =3D 8523 }, { addr =3D 0x55CFA4F5C1EE, cal=
l_site =3D 0x7F27C4B1E0B3 }<br>
func_entry: { cpu_id =3D 1 }, { ip =3D 0x55CFA4F5C1A9, debug_info =3D { bin=
 =3D &quot;instrument+0x11a9&quot;, func =3D &quot;add3+0&quot;, src =3D &q=
uot;instrument.c:3&quot; }, vpid =3D 8523 }, { addr =3D 0x55CFA4F5C1A9, cal=
l_site =3D 0x55CFA4F5C237 }<br>
func_exit: { cpu_id =3D 1 }, { ip =3D 0x55CFA4F5C1A9, debug_info =3D { bin =
=3D &quot;instrument+0x11a9&quot;, func =3D &quot;add3+0&quot;, src =3D &qu=
ot;instrument.c:3&quot; }, vpid =3D 8523 }, { addr =3D 0x55CFA4F5C1A9, call=
_site =3D 0x55CFA4F5C237 }<br>
func_exit: { cpu_id =3D 1 }, { ip =3D 0x55CFA4F5C1EE, debug_info =3D { bin =
=3D &quot;instrument+0x11ee&quot;, func =3D &quot;main+0&quot;, src =3D &qu=
ot;instrument.c:7&quot; }, vpid =3D 8523 }, { addr =3D 0x55CFA4F5C1EE, call=
_site =3D 0x7F27C4B1E0B3 }<br></blockquote><div><br></div><div>=C2=A0Maybe =
I&#39;m missing something, but isn&#39;t it right here? E.g.</div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">debug_info =3D { bi=
n =3D &quot;instrument+0x11ee&quot;, func =3D &quot;main+0&quot;, src =3D &=
quot;instrument.c:7&quot; }<br></blockquote><div><br></div><div>Otherwise, =
I don&#39;t think babeltrace can provide any more information.</div><div><b=
r></div><div><br></div><div>Christophe</div><div><br></div></div></div>

--00000000000063ff0405a8fd6838--

--===============5347483182144625207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5347483182144625207==--
