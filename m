Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848D7EB64D9
	for <lttng-dev@archiver.kernel.org>; Mon, 10 Jul 2023 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1689004320;
	bh=py7hAEyZACrLTqqVUGPQZgfgawFWd1XQUlWlcCN7ei4=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=YZp+E8jknADFs8h2KYeUCw5ZfSC4UTq1isIFy+9dDoB/JhSp5CbIjHVA9Gw8a/1km
	 q+ea3Cs9jgG9jbNsH75WppCwovdIFkJ18iI4KADFwsnCYfth2tpRSseWaIMqvz28SC
	 kCDQXGccnVgieWwoEsl+nPFTBet2gFE/g7/IGXGm9kcgQzEmZyaaSheAR38rPLLM4J
	 P2zX+uLjvwCad2SpkhgE798hSXipUj2O5mOO6QoUss9bu3OCaClaMvHtEq6f58UEhe
	 0cgLHq3lrNWFAocQUDn61Nrao0Ls/hoRKPJ1Yiduesm8c8LO0JCL4zHM6uve5V0U1a
	 CXCk6JUIkv3pA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4R07mH2RKkz28Ts;
	Mon, 10 Jul 2023 11:51:59 -0400 (EDT)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by lists.lttng.org (Postfix) with ESMTPS id 4R07mF2BV3z289N
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jul 2023 11:51:57 -0400 (EDT)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99313a34b2dso542052266b.1
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jul 2023 08:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689004315; x=1691596315;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G/60khv6l+TtfsFPONh+hKpx3elmYDDan/TQcClpoWI=;
 b=VoOtVr7Zfp+qcYqZr5NbUCIcJ4CtM1Gu3F/SP/nVPidXwIypKT0bSMrsyxmhIFqiM3
 93mSN1mh0x5qXIOH1zqTi/aZl0syhSD9p5BsL1Rvuuaj2gEjFlHkcfU59nT7sWy7BB59
 fOBiW8796dPF1OCOOOOGNje5QUuGOUQDCmRICKNK8lbaV/vdL1UxoRr7YN6Y99yHUNzk
 E/8e8AUM3dEF18fGwMbjU3XI1IjPC+1kYST4Ba5zVZdnWPrJtANYvtMtgzhi47LfGwxl
 OVez6QWy1HEYDvfauRpIzrvfnc/zIOKpTSWbx/phVgdZ8SQgzFEU3aAyCVv2ZsdLkE9N
 np7w==
X-Gm-Message-State: ABy/qLZg6IsnUzVO8Wxqsn+bv6KOkA4rAO/3QZgF+BxHynH/kTG6Mw/7
 LiQeCe0t/OVOJ/oqXurIQDuWq5Z4qQ1m4+d5D32U2NQsXvTdrA==
X-Google-Smtp-Source: APBJJlEms5jAVU0+glgdy0fAfBB+uA9XceVYMMJGwbEaaylRb99YUWUj12MZ9/Q/pWYWT3C8nVZyyGMXPe3rv0ARAQY=
X-Received: by 2002:a17:906:9614:b0:989:5d0:3189 with SMTP id
 s20-20020a170906961400b0098905d03189mr11776161ejx.33.1689004315247; Mon, 10
 Jul 2023 08:51:55 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 10 Jul 2023 11:49:57 -0400
Message-ID: <CAMxxxdMyENFGH+c0z-XE=TZFPNCmtAG1M2UAXBm_ET5pnq=fgQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] delay in Java/python events
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
From: Adel Belkhiri via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Adel Belkhiri <adel.belkhiri@gmail.com>
Content-Type: multipart/mixed; boundary="===============8066301823102000707=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8066301823102000707==
Content-Type: multipart/alternative; boundary="0000000000003c0721060023f6d3"

--0000000000003c0721060023f6d3
Content-Type: text/plain; charset="UTF-8"

Hello LTTng community,

Currently, I'm tracing a java (and Python) application using LTTng. I
noticed there is a considerable delay between the time the tracepoint
instruction is executed and the time its corresponding event is recorded by
LTTng. It seems that the problem comes from the fact that LTTng uses agents
to handle java/Python events. Is there any benchmark measuring such delay?
Is it possible to minimize this delay (for example by flushing the logger)?
Currently, I'm considering putting my tracepoints in a shared library and
calling them from within Java code using JNI so that events recording will
be "synchronous" with application code execution. Is there any other
technique that I can use? Thank you for your help.

Adel

--0000000000003c0721060023f6d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello LTTng community,<br><br>Currently, I&#39;m tracing a=
 java (and Python) application using LTTng. I noticed there is a considerab=
le delay between the time the tracepoint instruction is executed and the ti=
me its corresponding event is recorded by LTTng. It seems that the problem =
comes from the fact that LTTng uses agents to handle java/Python events. Is=
 there any benchmark measuring such delay? Is it possible to minimize this =
delay (for example by flushing the logger)? Currently, I&#39;m considering =
putting my tracepoints in a shared library and calling them from within Jav=
a code using JNI so that events recording will be &quot;synchronous&quot; w=
ith application code execution. Is there any other technique that I can use=
? Thank you for your help.<br><br>Adel<br></div>

--0000000000003c0721060023f6d3--

--===============8066301823102000707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8066301823102000707==--
