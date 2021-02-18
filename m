Return-Path: <SRS0=Fgvg=HU=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5A1C433E0
	for <lttng-dev@archiver.kernel.org>; Thu, 18 Feb 2021 22:20:15 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127C060202
	for <lttng-dev@archiver.kernel.org>; Thu, 18 Feb 2021 22:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127C060202
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DhTfj4XMQz2lR;
	Thu, 18 Feb 2021 17:20:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1613686814;
	bh=wRg0VOtDwtbrG6uo5jfZKsCQOA3Ylfewqza1k9NzSks=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=bwhRn+/wKNbQjUKhkoUgXdyN+VGBESC5eMHUUbRCzs00HgAlzkCXefW8j4TCu8ZO8
	 mNB2J/SK4igabaTziXzksAKNlKzD3nxqguBrb3jBJRWobvzUcnghHfUcTsDoH+28Nd
	 5sbQzhAKklUQed7xe1jjHJBonTaIJIOUYziVvpJWBusUE6GVutUGZq1tvSEFTpj8Sy
	 oGK1kG8DzQ9nio07hQigNKT9StkJ4It7NaDpMcaA9sJp3MFvxzm9OILt8GcpavrQhI
	 sPy7u2lQpSO57xhG6G/4YbeQrRObiA0WdEOYCK3XFMuM4NtEk7RVvSUX0hbasuTGRz
	 oOD1ASzJCHokQ==
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by lists.lttng.org (Postfix) with ESMTPS id 4DhTfg1v0zz2ht
 for <lttng-dev@lists.lttng.org>; Thu, 18 Feb 2021 17:20:11 -0500 (EST)
Received: by mail-lj1-x22f.google.com with SMTP id v6so8841201ljh.9
 for <lttng-dev@lists.lttng.org>; Thu, 18 Feb 2021 14:20:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=fhND2Z2ylOMoV8jxx+AXcDH9UFWXK22VPgC+Hjm7JoM=;
 b=UZFtnt+sVajowC9TTQP/r0zb9MUPVSMhhyGXB5FojFgbV50yu69JaMXXfh1/OdmQEl
 /jt3I9HiTlSASHc8TiINB/XyvjJCMCvgGCRcy70N+VtlYq/91RAjm/tBp/ET6A2eJnaC
 95EEURlGaOenO0To77k0Mhaku3v7DhhAE01UHI4NzPob3yJZbziQCjZAKUfoSyZVcazb
 2ZlvqoFlMX4lY+n3bsEVCQq8+w+CZKXARviHtjE92vwWu0oT+I3x+nV6FUfrPpYHwrnp
 BXKPrc659FlvUXq+e9MfbidJM4/M7stmh/Yo9QDh+TvezHMIrvsq6wPOcfOvslHbz3rg
 N8Ag==
X-Gm-Message-State: AOAM533nyj7hVCDtfd+bmCKIU+QHdhW9rW48VFrPfsiV0D+NLMOfUWCG
 CW+rORLRd19Wi7Ngw8xFXkTCM2/RYbcS9+BWyxLdQSLJIo8=
X-Google-Smtp-Source: ABdhPJzEEcfgcBocmSUawQ8ruuYqUSC0/yBBz0oRoFv5b/r4kRvafOb2mBcHSZzZ1jMXOIylh3hQP0ajAfED5mEV4+I=
X-Received: by 2002:a05:651c:315:: with SMTP id
 a21mr3671558ljp.407.1613686808767; 
 Thu, 18 Feb 2021 14:20:08 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 18 Feb 2021 17:19:58 -0500
Message-ID: <CAKdQdUNpv-X5QtM_Liee+7WV9o+dz5-95imAB8JF=eVw8LEBQg@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] dump the trace for analysis at debugging breakpoint
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Yonghong Yan via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: yyan7@uncc.edu
Content-Type: multipart/mixed; boundary="===============6041177300156105401=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6041177300156105401==
Content-Type: multipart/alternative; boundary="00000000000003ff5605bba3bd96"

--00000000000003ff5605bba3bd96
Content-Type: text/plain; charset="UTF-8"

I have not yet tested but would like to ask first. If I am using LTTng-UST
to trace a program that is also being debugged, at the debug breakpoint
that the program stops,  are we able to let the traces be dumped so they
can be viewed by a viewer (tracecompass or babeltrace)?

Thank you
Yonghong

--00000000000003ff5605bba3bd96
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I have not yet tested but would like to ask first. If I am=
 using LTTng-UST to trace a program that is also being debugged, at the deb=
ug breakpoint that the program stops,=C2=A0=C2=A0are we able to let the tra=
ces be dumped so they can be viewed by a viewer (tracecompass or babeltrace=
)?<br clear=3D"all"><div><br></div>Thank you<div dir=3D"ltr" class=3D"gmail=
_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div d=
ir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"></div></=
div></div></div></div></div></div></div><div>Yonghong</div></div>

--00000000000003ff5605bba3bd96--

--===============6041177300156105401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6041177300156105401==--
