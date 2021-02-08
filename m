Return-Path: <SRS0=zN6S=HK=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD0EC433DB
	for <lttng-dev@archiver.kernel.org>; Mon,  8 Feb 2021 18:05:37 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CDF264E54
	for <lttng-dev@archiver.kernel.org>; Mon,  8 Feb 2021 18:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDF264E54
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DZDTV2rY8z19Ky;
	Mon,  8 Feb 2021 13:05:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1612807535;
	bh=Hlxn590lOzPeRNF1m2gAqBYV9aoIENOHx/7p4aCJ2l8=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=cwVYw6hAfklRYg86Cn8wcC7ZkKbzhXEkWAWcV0VBtjHcO3ZW+ajI3XMMW2NulXvBa
	 a692Y7h9viTFfvKtFS+tLsC+LU1sOQpNzmq2Ar/jeWFFgF2jU0sc/pl6Ji3J5/8S3j
	 TioDw7hX3uzIsUo2j3fWSHtHIuXkObrRupsWK0fNc9t94RQZ8j+jJ5M4zZY2HNrm+R
	 aQn1QYH3XLFBBz8pH+1x2y4Zdnz6Hxj1hD6JMzxAI9w4XZzrMsxW9ueALhxcKXnYWY
	 Kz+3jxc2A0ma9bkehkgYJ/k7KGbC2y7a7725zbCrcAXCdIph+tZrqhXc9wyPpH1Xlt
	 9di8JA+1S4FIg==
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by lists.lttng.org (Postfix) with ESMTPS id 4DZDTS2q8Lz19NQ
 for <lttng-dev@lists.lttng.org>; Mon,  8 Feb 2021 13:05:32 -0500 (EST)
Received: by mail-lf1-x12d.google.com with SMTP id m22so23680098lfg.5
 for <lttng-dev@lists.lttng.org>; Mon, 08 Feb 2021 10:05:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=mW0okUvHNb59BoEEIjzKv6qDL3pN5wtwWbBDVXcqoeU=;
 b=g4dYzF3UjrK8LhptCv1ZHylkTRXtO9XOWXZRSpZZ2Pr0JS5oQGTY3q3BPE4yzd1TJ4
 A4Kj9kCZfmkx8h9OKyNBuMgUvmVmh17VnRuLZjIgeezDpTGihAjGLVItIf7IG9UGc5KV
 Jb37o6vZChYg1jIZ8eis2OeTpgXzISuxO/4lRXFlDCosDOTY8L6OfjdYFGebNRqD6nfr
 yRdfpwLjBMcRCs3TbqZcMk2vat81U1QxTSZPWuYHu5yHD6tmkwUR5jo9OwxE6dyOTEev
 wOJz5x7CtHAv1G4x7DUctDFrvp9JrTA2MRNKs2/FNAJaPA+h+CnNLT0oAyI1bS9CzCUT
 rd6g==
X-Gm-Message-State: AOAM532jT0GBvz3ubPmF24DkfWTVJN3gC9M2N9psBBoOOw/66PPfdPHw
 HwK+S1R8gdqf7deuaFz0+Q9mi4mXVZDo/vpse+9KA6JymRWazduN
X-Google-Smtp-Source: ABdhPJwjOCKZ4vdIXuWoA1qyVSk08A7e4ssetKkxNfCIYf2aeFzeokMhpb2QEXb7wkbGJdJHlgWFF51KOi7+g2E6B+I=
X-Received: by 2002:a19:431b:: with SMTP id q27mr10867122lfa.137.1612807530391; 
 Mon, 08 Feb 2021 10:05:30 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 8 Feb 2021 12:04:53 -0600
Message-ID: <CAK7B4KcwnAK_u5t-F_ujjeG=mnEXBAtr4PfdcHuhqccrRmbo_Q@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] LTTng Support for Network Namespace
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
Cc: Yan Chen <ychen@northwestern.edu>,
 Xutong Chen <XutongChen2021@u.northwestern.edu>
Content-Type: multipart/mixed; boundary="===============8801218452634629091=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8801218452634629091==
Content-Type: multipart/alternative; boundary="000000000000f0bf3205bad703b5"

--000000000000f0bf3205bad703b5
Content-Type: text/plain; charset="UTF-8"

Dear LTTng developers,

I was wondering if LTTng currently (or in the future) supports network
namespaces. For instance, an ambiguity in the logs would make problems for
future system analysis.

Taking the "bind" system call, that would help us distinguish between
different local IP addresses when two or more container instances are
running on the host, given that the "umyaddr" field is an address inside
the memory, how would we recover the local addresses after the trace has
been collected?

syscall_entry_bind: { cpu_id = 1 }, { mnt_ns = 4026532553, pid = 532, tid =
532, vtid = 532, vpid = 532 }, { fd = 14, umyaddr = 93827759199256, addrlen
= 12 }


Thanks, we appreciate the help beforehand!


Mohammad

--000000000000f0bf3205bad703b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Dear LTTng developers,<d=
iv><br></div><div>I was wondering if LTTng currently (or in the future) sup=
ports network namespaces. For instance, an ambiguity=C2=A0in the logs would=
 make problems for future system analysis.</div><div><br></div><div>Taking =
the &quot;bind&quot; system call, that would help us distinguish between di=
fferent local IP addresses when two or more container instances are running=
 on the host, given that the &quot;umyaddr&quot; field is an address inside=
 the memory, how would we recover the local addresses after the trace has b=
een collected?</div><div><br></div><div><font face=3D"monospace">syscall_en=
try_bind: { cpu_id =3D 1 }, { mnt_ns =3D 4026532553, pid =3D 532, tid =3D 5=
32, vtid =3D 532, vpid =3D 532 }, { fd =3D 14, umyaddr =3D 93827759199256, =
addrlen =3D 12 }</font><br></div><div><font face=3D"monospace"><br></font><=
/div><div><font face=3D"monospace"><br></font></div><div><font face=3D"aria=
l, sans-serif">Thanks, we appreciate the help beforehand!</font></div><div>=
<font face=3D"arial, sans-serif"><br></font></div><div><font face=3D"arial,=
 sans-serif"><br></font></div><div>Mohammad</div></div></div></div>

--000000000000f0bf3205bad703b5--

--===============8801218452634629091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8801218452634629091==--
