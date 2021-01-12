Return-Path: <SRS0=q6Pr=GQ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DDCC433E0
	for <lttng-dev@archiver.kernel.org>; Wed, 13 Jan 2021 14:48:04 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C79A2313C
	for <lttng-dev@archiver.kernel.org>; Wed, 13 Jan 2021 14:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C79A2313C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DG9KY0X5dzQkJ;
	Wed, 13 Jan 2021 09:48:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1610549281;
	bh=yjqBHNkYkXW2+7sGSQSzvXXVmxMPbiXkL3EulacSLRA=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MfW0zdVUh48wDVDz1edcrV/fcU/Cq2ND+z9kY2jzwH+9r10Ssmal7SPWhILcaW/SI
	 f9lT6HhbvzAm+xvfieTZYKKx67iNdIrbx53RemvmY5dJ5AmWBiIbU5TXDKy2r/OdKd
	 St7j06rgTdrtrevflzVfr9j/tiM3TRhFl1HN5KpLMwM7xBC+XDmkZjjIai0pQLn1ux
	 FhMxYU8GLRIm5fKxCTGMa3dXCJ5MziaDxHQE7UVzqww2zhEl6SuW5QDcnFI1fDVp5s
	 8wsifmzFd7YNAMTCuWsNRYYWxK2ekP3I66yWog/2ZEjb/8MKyFQnNLxuE14PkJJm8B
	 vSZ+MMVE2pubQ==
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by lists.lttng.org (Postfix) with ESMTPS id 4DFj0J0r95zQCt
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jan 2021 15:31:27 -0500 (EST)
Received: by mail-lf1-x136.google.com with SMTP id u25so5374325lfc.2
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jan 2021 12:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eHmtvHZzD5o+5sJPi91OqY0rDjm3Daxm9ai403xUUtI=;
 b=FQoXoxjsFo0uB/v59W5vqoos/p8Zh6CMitLMb1ZHRUKmsar+iavTkFACYXj4OcBcXL
 Jony5cu/Mb0fhreH/EzYTUzmMXujBc3grhUHZDHJQJCMVmmXUkN18ElTkjX2xb2Ge87q
 WHzapuNUGaPrRBhVRaXn8+LCrwCYcN+IQlcsK/elm38NcQJCjEkoa8i59g3ZfxpJbYTw
 bYDldVKiCGCjebGD2yICW4LcIRTAipa+C8Bh0VGKFTAYIkovg378iIxDOxnQgDxZTrQh
 oP2fPQMsRknFkgBkMgtaExvA0yfeo+ae054oxkXCv70cQFph6sQP4SowjHRXRxhrBl3B
 ZOFA==
X-Gm-Message-State: AOAM531aguBI7V4zvJFUDBbuL4qZEU9HsJRA9kT9jxvgRKClaEgpdmVq
 eKuSimYeR5/jZDDFtozTOzRzncKp/oJN46rkBRcR7Q==
X-Google-Smtp-Source: ABdhPJzO5pa0AyvHbgdoOEs+XTxZUP9XWRX0joqdUm7lAMIgvGI4pLxetSY+9L/avdfHUVpZCVHb1838Zeh2Hr1kzKY=
X-Received: by 2002:a19:2d1d:: with SMTP id k29mr263018lfj.271.1610483485901; 
 Tue, 12 Jan 2021 12:31:25 -0800 (PST)
MIME-Version: 1.0
References: <CAK7B4KePHyJFCwAczqcqz+05Ts8AVm0Xh9f4hwSBKaVhQLz8cw@mail.gmail.com>
 <977d5fa1-ff33-f99e-5be9-7c53ff6adfc4@efficios.com>
 <CAK7B4KfwwC6UbuBTzJSqTHiyuDxgjAPRryYYq7vLRJSWs=2W0g@mail.gmail.com>
 <f13d262c-560a-849e-c3f2-0c0d6e67e27b@efficios.com>
 <CAK7B4Kc9bED7q9_6HsCqLT1dhJEjjNY93cspZ7Nb_Ztpn+=ERg@mail.gmail.com>
 <869ac606-375e-b15c-9eec-6501865b5c52@efficios.com>
In-Reply-To: <869ac606-375e-b15c-9eec-6501865b5c52@efficios.com>
Date: Tue, 12 Jan 2021 14:30:49 -0600
Message-ID: <CAK7B4KfTzaK8ysqoEnWAbsF2fm_E8cMgPx2e0jV9tuASXM=vyQ@mail.gmail.com>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org, Yan Chen <ychen@northwestern.edu>, 
 Xutong Chen <XutongChen2021@u.northwestern.edu>
X-Mailman-Approved-At: Wed, 13 Jan 2021 09:47:59 -0500
Subject: Re: [lttng-dev] LTTng Support for Mount Namespace
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
From: Mohammad Kavousi via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mohammad Kavousi <kavousi@u.northwestern.edu>
Content-Type: multipart/mixed; boundary="===============1361040407645835635=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1361040407645835635==
Content-Type: multipart/alternative; boundary="000000000000181e5f05b8b9e851"

--000000000000181e5f05b8b9e851
Content-Type: text/plain; charset="UTF-8"

Before, I was installing using the ppa repository. Based on your
instructions, I made lttng using the source code in a totally new
environment, having the mount.h under '/lib/modules/$(uname -r)/build/fs'.

I removed the "ifneq" and "endif" statements for 'Makefile' and
'Kbuild.common' which were surrounding "mnt_ns_dep". lttng was installed
successfully and the kernel trace session started, but I'm still getting
the same error.

As a hint, in the build process for lttng-modules, I found messages such as
"./fs/ext4/*.h not found". Is that part of the problem? Meaning, is
enabling the mnt context filesystem-specific?



On Tue, Jan 12, 2021 at 12:51 PM Michael Jeanson <mjeanson@efficios.com>
wrote:

> On 2021-01-12 12 h 29, Mohammad Kavousi wrote:
> > Thanks again for your reply,
> >
> > To be specific, I did exactly this:
> >
> > - Install linux source code, then copy the mentioned file to the folder
> > using: cp
> > /usr/src/linux-headers-5.4.0-59/fs/mount.h /lib/modules/$(uname -r)/build
>
> The path to the header has to stay the same, so you would need to copy
> it to '/lib/modules/$(uname -r)/build/fs'.
>
> The rest of the steps seem fine.
>
> One thing you can do if it still doesn't work, is modify 'Makefile' and
> 'Kbuild.common' in the lttng-modules source directory and remove the
> conditions on 'mnt_ns_dep'. That would make the build fail when
> 'fs/mount.h' isn't found and may help you find the cause.
>
> >
> > - Run sudo dkms autoinstall (I also did reboot)
> >
> > - Create the session and attempt to add the context
> >
> > However, I'm getting the same error.
>

--000000000000181e5f05b8b9e851
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Before, I was installing using the ppa repository. Based o=
n your instructions, I made lttng using the source code in a totally new en=
vironment, having the mount.h under &#39;/lib/modules/$(uname -r)/build/fs&=
#39;.<div><br></div><div>I removed the &quot;ifneq&quot; and &quot;endif&qu=
ot; statements for &#39;Makefile&#39; and &#39;Kbuild.common&#39; which wer=
e surrounding &quot;mnt_ns_dep&quot;. lttng was installed successfully and =
the kernel trace session started, but I&#39;m still getting the same error.=
</div><div><br></div><div>As a hint, in the build process for lttng-modules=
, I found messages such as &quot;./fs/ext4/*.h not found&quot;. Is that par=
t of the problem? Meaning, is enabling the mnt context filesystem-specific?=
</div><div><br></div><div><br></div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 12, 2021 at 12:51 PM Michae=
l Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com">mjeanson@efficios.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On 2021-01-12 12 h 29, Mohammad Kavousi wrote:<br>
&gt; Thanks again for your reply,<br>
&gt; <br>
&gt; To be specific, I did exactly this:<br>
&gt; <br>
&gt; - Install linux source code, then copy the mentioned file to the folde=
r <br>
&gt; using:=C2=A0cp <br>
&gt; /usr/src/linux-headers-5.4.0-59/fs/mount.h=C2=A0/lib/modules/$(uname -=
r)/build<br>
<br>
The path to the header has to stay the same, so you would need to copy <br>
it to &#39;/lib/modules/$(uname -r)/build/fs&#39;.<br>
<br>
The rest of the steps seem fine.<br>
<br>
One thing you can do if it still doesn&#39;t work, is modify &#39;Makefile&=
#39; and <br>
&#39;Kbuild.common&#39; in the lttng-modules source directory and remove th=
e <br>
conditions on &#39;mnt_ns_dep&#39;. That would make the build fail when <br=
>
&#39;fs/mount.h&#39; isn&#39;t found and may help you find the cause.<br>
<br>
&gt; <br>
&gt; - Run sudo dkms autoinstall (I also did reboot)<br>
&gt; <br>
&gt; - Create the session and attempt to add the context<br>
&gt; <br>
&gt; However, I&#39;m getting the same error.<br>
</blockquote></div>

--000000000000181e5f05b8b9e851--

--===============1361040407645835635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1361040407645835635==--
