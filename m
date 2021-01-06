Return-Path: <SRS0=0ltL=GJ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162E6C433E0
	for <lttng-dev@archiver.kernel.org>; Wed,  6 Jan 2021 16:49:02 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162A22312F
	for <lttng-dev@archiver.kernel.org>; Wed,  6 Jan 2021 16:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162A22312F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4D9wLM0dkvzNbm;
	Wed,  6 Jan 2021 11:48:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1609951739;
	bh=va//bRw0cNnSP15jdJmFAvh35jWCIdRa3THvQpkp7GQ=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=x4RBudK0a6f+7rn0aLPUXpusBkIvshG+2r6/ce4d72SRL5Qg8SQMpdlVnn+AEIGUc
	 QYqo8RWsDmkO60K/55mOnuC0InfDr18JQgtqZ81nkvAz4MYTQVjIlh200/56SCmQ8U
	 aQ49QII02//dlCeCC8gtZDKkMlXqV+6/q/p78VDzjJHjLPPJlAXZr/HTbATd8oo37a
	 /8ZW7BZLap0kbfVSs65fXSMdpoXGfnRfqwhS/XKAHL8uuWFhEA27h4qpCrOuhnP5Bb
	 g6sovheLEM9FgflRxPHX2GyaNRQMC5ylxOzCO6TBT+A7UTyjt0JDf7Dl1bzArQ+ObS
	 SvswYwvlrNOyQ==
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by lists.lttng.org (Postfix) with ESMTPS id 4D9v3k6nwXzNl7
 for <lttng-dev@lists.lttng.org>; Wed,  6 Jan 2021 10:51:14 -0500 (EST)
Received: by mail-lf1-x132.google.com with SMTP id x20so7456604lfe.12
 for <lttng-dev@lists.lttng.org>; Wed, 06 Jan 2021 07:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=Hefw/415Lg03T99a3pZ1SsBsH/0UMMfmrstdBiKyFpY=;
 b=QoTZgCqeGkXZKrKp1dsRsVZBSIH9NLb28d/sD/Sp8VnBf+IrH9jffunx39cd13lwO9
 h5InDMhhLKIXY9uJbTv2kEw/6hbgSA2Bq1WmUpbtOKCBuIDIXOfMdF1275ZNwbhSDTfp
 uJnfwS4ee4TdnlVNFYQhqWVH11FZrt/Fu1vZ2bJ9dOSi0QAQWgLfY9bBMqV1j/QKPaMS
 9E0Jwe30kKxmTHtpN/F1V/fhJRPjcpCVGg+xy2fUTyNoo6YppW4IlnSsJWvNJC9FOBni
 /4oimLLLLNUZ5hhM50F6yUo8fnV4iZcxABAU0ZPWP/XpaGFIjBifcXGM7etZn9MQwrFX
 /NXQ==
X-Gm-Message-State: AOAM530955tg8/czHDv90YU1dAUIxV9HCahwNu4wTidFcfNJ/IzxRbL3
 J4e7fSCGNLSbc1rQoMqZukOjJD2BzNe8t+j9rmWOL8DoAYptQg==
X-Google-Smtp-Source: ABdhPJxvFdtKhIw8AGzWs8opbl1oJoBmSGj/ihAH9/gYIqvRNg+49dCeiX/Urc9M8jrQ6LUFcZibWZ+vKBOIBVdn5rU=
X-Received: by 2002:a19:40d6:: with SMTP id n205mr2051174lfa.24.1609948273115; 
 Wed, 06 Jan 2021 07:51:13 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 6 Jan 2021 09:50:36 -0600
Message-ID: <CAK7B4KePHyJFCwAczqcqz+05Ts8AVm0Xh9f4hwSBKaVhQLz8cw@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Cc: Yan Chen <ychen@northwestern.edu>,
 Xutong Chen <XutongChen2021@u.northwestern.edu>
X-Mailman-Approved-At: Wed, 06 Jan 2021 11:48:57 -0500
Subject: [lttng-dev] LTTng Support for Mount Namespace
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
Content-Type: multipart/mixed; boundary="===============3791180039674183041=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3791180039674183041==
Content-Type: multipart/alternative; boundary="000000000000ed1bae05b83d4a2d"

--000000000000ed1bae05b83d4a2d
Content-Type: text/plain; charset="UTF-8"

Dear LTTng developers,

Our group at Northwestern has been using your amazing tool for the purpose
of provenance tracking on Linux-based systems and we are very fond of the
performance and accuracy it provides.

Our analysis shows that mnt_ns context is supported in the 2.12 version of
LTTng. However, though, adding the mnt_ns context using the add-context command
produces this error:

Error: mnt_ns: Context unavailable on this kernel

We have tried adding the context to the more recent version of the kernel
(5.8) on Ubuntu 20.04, as well as older kernel versions such as the 4.4
version on Ubuntu 16.04. However, we always receive the above error trying
to add the mnt_ns context.

We could not find which kernel versions are supported for adding this
context, or whether they need to be built with special flags. I would
appreciate your guidance on resolving this issue.


Thank you,
Mohammad

--000000000000ed1bae05b83d4a2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Dear LTTng developers,<div><br></div><div=
>Our group at Northwestern has been using your amazing tool for the purpose=
 of provenance tracking on Linux-based systems and we are very fond of the =
performance and accuracy it provides.</div><div><br></div><div>Our analysis=
 shows that mnt_ns context is supported in the 2.12 version of LTTng. Howev=
er, though, adding the mnt_ns context using the<font face=3D"monospace">=C2=
=A0add-context </font><font face=3D"arial, sans-serif">command produces thi=
s error:</font></div><div><font face=3D"arial, sans-serif"><br></font></div=
><div><font face=3D"monospace">Error: mnt_ns: Context unavailable on this k=
ernel</font><br></div><div><font face=3D"arial, sans-serif"><br></font></di=
v><div><font face=3D"arial, sans-serif">We have tried adding the context to=
 the more recent version of the kernel (5.8) on Ubuntu 20.04, as well as ol=
der kernel versions such as the 4.4 version on Ubuntu 16.04. However, we al=
ways receive the above error trying to add the mnt_ns context.</font></div>=
<div><font face=3D"arial, sans-serif"><br></font></div><div><font face=3D"a=
rial, sans-serif">We could not find which kernel versions are supported for=
 adding this context, or whether they need to be built with special flags. =
I would appreciate your guidance on resolving this issue.</font></div><div>=
<font face=3D"arial, sans-serif"><br></font></div><div><font face=3D"arial,=
 sans-serif"><br></font></div><div><font face=3D"arial, sans-serif">Thank y=
ou,</font></div><div><font face=3D"arial, sans-serif">Mohammad</font></div>=
<div><font face=3D"arial, sans-serif"><br></font></div><div><font face=3D"a=
rial, sans-serif"><br></font></div></div></div>

--000000000000ed1bae05b83d4a2d--

--===============3791180039674183041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3791180039674183041==--
