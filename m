Return-Path: <SRS0=ctY1=KA=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F72BC433ED
	for <lttng-dev@archiver.kernel.org>; Wed,  5 May 2021 13:19:38 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E555E613BE
	for <lttng-dev@archiver.kernel.org>; Wed,  5 May 2021 13:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E555E613BE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FZy3r5zGJz1hbl;
	Wed,  5 May 2021 09:19:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1620220776;
	bh=nqHjOXobjdQ40LvdQ8bJI08ZBrsn0sKTOmPg3iC8aRI=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=lYgx0C2Jm5AaSoMyrW/F0i0peo98HRGOm4UFzsvOzFQ4TaiVPbedl1M8FLb3FfrQH
	 eDpkmvyqXLFB482+lLNphZ0ZyFAmN4ulWudLjYN0kXfyxSQPK4GgXIlGR3rB10Py4j
	 iqCcxITGHmNeFgHOj6uobniJJaee4ADCMvK0eE0jUoURP4VHZgcZx+V4omYl8UulRd
	 I4ei/UJ7Lai+9yRhXVCCKOmBbS1dkMbkmq32fVIj3syc/BlMmjrniy7gprv+WZK4R2
	 NL3qi7J7AvSrv6CrjGiVm1bfvJiXftijmKFxgOKUt8TSRYScwP2y1DJBW4V1cv98f2
	 srZQFc7hdl9cQ==
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by lists.lttng.org (Postfix) with ESMTPS id 4FZtRR0F74z1hmj
 for <lttng-dev@lists.lttng.org>; Wed,  5 May 2021 06:36:18 -0400 (EDT)
Received: by mail-wr1-x431.google.com with SMTP id x5so1252892wrv.13
 for <lttng-dev@lists.lttng.org>; Wed, 05 May 2021 03:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=owDDc3qyshoqOq0xjJsRHd9mss+B1TAui2+ngvwZPo4=;
 b=O7T2gfi5nceVKmXSV+hNcVtJgsPDnmikjYfMnzq1xsa+G0d1JoK9eUMSYhgJugsQoP
 1NHdeXHIxTwbSsSvEd23h7wc7IvvR9D5rDnTNmTyqyF39DEFpWiyuKcAlkXfRAtTTuJV
 aExg4ZI/YW8U9BK6TOgkI6pympz3u7jY7YuFhPz3Pw5UPRbd+jmYTKiPM29/sWK+DV9g
 QQvAR6i/T4gF9JUeUN6+r0itxg0ihECY1le5a5avUko1b9gV2JEFcjbYQKsysizxaqB7
 kjb9wkv+/Bodfnx07S4xbqaxGdVzdBj+Or3g0ykAsXr7on4Au9bTE7dN1thoEvRe6GsX
 JEqw==
X-Gm-Message-State: AOAM533JYaR6nH/EzOYdVTBZgnv9EYnSugWbq7hIr5V3+16Aehb0+TlO
 gKD4U+Gn+NWKtCR4Z9vgzed/QbEXFkdtiwowNFEl7AhlyHwY
X-Google-Smtp-Source: ABdhPJw7Uvvhz6eoXTX3BpLyKFGhUaToWrYcW1Xd9m4E9zzMjqYGowgNleHENqtKuzDjLANraS3zCr58qio1YIY4VeM=
X-Received: by 2002:a05:6000:2ae:: with SMTP id
 l14mr36065471wry.155.1620210977427; 
 Wed, 05 May 2021 03:36:17 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 5 May 2021 12:36:06 +0200
Message-ID: <CAJYn_wj-H2mGYVDSR8mynyh0VcOOcf868s+z9mAc1h0D7B8m2g@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Wed, 05 May 2021 09:19:30 -0400
Subject: [lttng-dev] How to trace a memory leak in my application using LTTng
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
From: bhanu kiran chaluvadi via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: bhanu kiran chaluvadi <nthdimensionalreality@gmail.com>
Content-Type: multipart/mixed; boundary="===============6857342328639809646=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6857342328639809646==
Content-Type: multipart/alternative; boundary="000000000000c552d005c192c346"

--000000000000c552d005c192c346
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a memory leak some where in my c++ application.  Since it was
written in c++98 there are lot of pointer passed back and forth and there
is no clear ownership of the pointers. I was  wondering if it's possible to
check for memory leak and give a value sections to probe for the leak using
LTTng ?  Since i am new, Can you also point me to some sample example to
track memory leak, in case if they are available or can you provide some
instructions to use LTTng in order to trace the leak.

Thank you,
Bhanu Kiran . Chaluvadi ,
Mechanical Engineering ,
National Institute of Technology,Warangal,
India

--000000000000c552d005c192c346
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,=C2=A0<div><br></div><div>I have a memory leak some whe=
re in my c++ application.=C2=A0 Since it was written=C2=A0in c++98 there ar=
e lot of pointer passed back and forth and there is no clear ownership of t=
he pointers. I was=C2=A0 wondering if it&#39;s possible to check for memory=
 leak and give a value sections to probe for the leak using LTTng ?=C2=A0 S=
ince i am new, Can you also point me to some sample example to track memory=
 leak, in case if they are available or can you provide some instructions t=
o use LTTng in order to trace the leak.</div><div><div><br></div>Thank you,=
<br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_sign=
ature">Bhanu Kiran . Chaluvadi ,<div>Mechanical Engineering ,</div><div>Nat=
ional Institute of Technology,Warangal,</div><div>India</div></div></div></=
div>

--000000000000c552d005c192c346--

--===============6857342328639809646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6857342328639809646==--
