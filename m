Return-Path: <SRS0=qFiG=AM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85849C433E1
	for <lttng-dev@archiver.kernel.org>; Wed,  1 Jul 2020 16:25:24 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A9A20760
	for <lttng-dev@archiver.kernel.org>; Wed,  1 Jul 2020 16:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="OEcSkqEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A9A20760
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49xmmL3YPVz18wd;
	Wed,  1 Jul 2020 12:25:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1593620723;
	bh=kIiWdqDlNgZpR9lPRKTBbccH1JqJv90ucanoCA2ZPwo=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=OEcSkqEzjo8qMhTnlNA1/YBniUfHJiErya46y/Yo+0v4TB3DWsOuhHkPigPFLEFZV
	 yYbPgL+TlLNUzjS9fAf2pLTOfdmooZ5HtwaWrc1JQlM80K9G5/YftYvFJK2oSD5ot+
	 1zEquDsChYlhdf3nfC2IvQDpq1PMH8SifcJJMmOFu86d+P5rxZA7UCQEjaWz4ISw7b
	 JC/kpTHMCUfGr2sWDzFHjvwSoR1m6b0g78r5qLzsVq+YmYSZvA+Bk0MYnP/0TEobDr
	 ag4uwDeVbSf2/cwRRbjIg7KlAu/9a2CHfgas55fBxMU75cpkda0VEc+0e2vDs2Oq2c
	 iBBWsgV7O4vZw==
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by lists.lttng.org (Postfix) with ESMTPS id 49xmmK1qbsz18mG
 for <lttng-dev@lists.lttng.org>; Wed,  1 Jul 2020 12:25:21 -0400 (EDT)
Received: by mail-pg1-f176.google.com with SMTP id p3so11962360pgh.3
 for <lttng-dev@lists.lttng.org>; Wed, 01 Jul 2020 09:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X5cXWksHy+zfxBxWR43C/M9TBqfIX5WaaODrL14wRBk=;
 b=re7fEgWJKk1eGITf+Ad1J+pvIF+yBhlLz6Cq4g4NQmb77eW4iKSkBjKtBjdgAH3uMP
 36XcYMvFA3AV0rHfaJ4ntfllD3A8YPVk+Ne9SS+YE+4k3SN8oOWpmVDknqR2iYi22KnR
 VUpUAmqev+DheauUa44LZr2tyD9474jG93TMs+qa/8lXsYnEf0Q2gsYouQ2wdKyP/zr6
 zK+zTIhMSHZrr7w9xUKE0hI45girnWKkMqhT/9Dn5HvdfUR5iz3UYIHPEV0Z1TiE6A/L
 ws5oHjhG8ZfTh1SnCoegbv71XELk1oYcgC+nJs1DJJPXFDfBHPvaEZ2h0AEtTsdGo4p2
 6obw==
X-Gm-Message-State: AOAM5336ux4nxLTvyBCxcY2Qqg2L5bq+k3/c54AVFevZzV2oruh+x5lK
 l8oK5iGTKgRDdkX+R8OrIjgYs7mpC9EJbirzKNQ=
X-Google-Smtp-Source: ABdhPJyxeFlcRqjgz7+TkyGOVkh5mG1KOKOxCNweedflQ6b0CUpEzvbprBY1qnFvV7rFImcOFB8MnFTncKG6bfQtIfk=
X-Received: by 2002:a62:d103:: with SMTP id z3mr13138244pfg.317.1593620720022; 
 Wed, 01 Jul 2020 09:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200701155309.GA99920@jerryopenix>
In-Reply-To: <20200701155309.GA99920@jerryopenix>
Date: Wed, 1 Jul 2020 12:25:08 -0400
Message-ID: <CADcCL0jxNy9hbvxpnQdKF_QGXYSeWD2WT+enFJO5UB7wAA8Bqw@mail.gmail.com>
To: "Liu, Changcheng" <changcheng.liu@intel.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] convert call_site to func/offset
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
From: Francis Deslauriers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Francis Deslauriers <francis.deslauriers@efficios.com>
Content-Type: multipart/mixed; boundary="===============1915000930479380642=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200701162508.ouEMs-bzYTlDsqzYINdtwP9nkpwbe-o7PZ7BqPuyK-A@z>

--===============1915000930479380642==
Content-Type: multipart/alternative; boundary="000000000000ec806505a963bc85"

--000000000000ec806505a963bc85
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Changcheng,

This is not currently supported by Babeltrace. It could probably be done
the same way we do it with the "ip" and "vpid" contexts in the debug-info
component class but it's not done yet.

Thanks,
Francis

Le mer. 1 juill. 2020, =C3=A0 11 h 58, Liu, Changcheng via lttng-dev <
lttng-dev@lists.lttng.org> a =C3=A9crit :

> Hi all,
>     I checked __cyg_profile_func_enter implementation.
>     The caller address is recorded into call_site field.
>
>     Does anyone know how to let babeltrace show the call_site into
>     "func/offset" format instead of the running virtual address?
>
> B.R.
> Changcheng
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>


--=20
Francis Deslauriers
Computer Engineer
EfficiOS inc.

--000000000000ec806505a963bc85
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Changcheng,</div><div><br></div><div>This is not c=
urrently supported by Babeltrace. It could probably be done the same way we=
 do it with the &quot;ip&quot; and &quot;vpid&quot; contexts in the debug-i=
nfo component class but it&#39;s not done yet.</div><div><br></div><div>Tha=
nks,</div><div>Francis<br></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">Le mer. 1 juill. 2020, =C3=A0 11 h 58, Liu,=
 Changcheng via lttng-dev &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org">=
lttng-dev@lists.lttng.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Hi all,<br>
=C2=A0 =C2=A0 I checked __cyg_profile_func_enter implementation.<br>
=C2=A0 =C2=A0 The caller address is recorded into call_site field.<br>
<br>
=C2=A0 =C2=A0 Does anyone know how to let babeltrace show the call_site int=
o<br>
=C2=A0 =C2=A0 &quot;func/offset&quot; format instead of the running virtual=
 address?<br>
<br>
B.R.<br>
Changcheng<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div>Francis De=
slauriers</div><div dir=3D"ltr">Computer Engineer<div>EfficiOS inc.</div></=
div></div></div></div></div></div>

--000000000000ec806505a963bc85--

--===============1915000930479380642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1915000930479380642==--
