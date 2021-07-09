Return-Path: <SRS0=UBvy=MB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D54C07E9B
	for <lttng-dev@archiver.kernel.org>; Fri,  9 Jul 2021 08:31:11 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBCC613CA
	for <lttng-dev@archiver.kernel.org>; Fri,  9 Jul 2021 08:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBCC613CA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4GLmZv35Zjz1056;
	Fri,  9 Jul 2021 04:31:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1625819464;
	bh=AkYy7kja7+68KVW2yDydawJMkQnhGrJxXfJJL89jlHM=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=U2Bp3DzN6VU02XzE4l9OTTWmrv3fc85/VPvIYmesVJPXMq5uz1iaeluZwjzx88eZr
	 n1jTaKkaw0VEUii63cl8k06Hn2bG1c8AyG8HO7bq+4Cc/xtLMwAdY92CkUA1/vwlUP
	 RZsxjrpLk3qAxYWM3gf3kVUjm5GgIKTU6mN8Kj8SWgS3Y5LSKn0bDbmvKRAcwpRUdR
	 zLZin12WgyoEU4avc5TT3HzFL0uXpOvdm3N+kCjrW1juPHC7pk8vTbGPUNIhRU6xJy
	 A9ly+eHn73719OqsK6B093pS4nQ+rnnGSHy266xLEDeMcoJnq+xXk7U3osdQt3OFR2
	 UWP95PXOsrTdw==
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by lists.lttng.org (Postfix) with ESMTPS id 4GLmZt11VXzysZ
 for <lttng-dev@lists.lttng.org>; Fri,  9 Jul 2021 04:31:01 -0400 (EDT)
Received: by mail-oi1-x230.google.com with SMTP id a189so1100469oii.2
 for <lttng-dev@lists.lttng.org>; Fri, 09 Jul 2021 01:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=dz61t+UpZ4zgRWpkSyiq+t+0lp5an8nv1rzM5nTs97E=;
 b=NFcqviiKsmbZEwe853oP9WrRlUW8LUhLhRYS1EwQC5PlAQzXYxIKXPjZB3AcvhVnKV
 ee95HhzLqbw0O9ND78zPRafBsihTGBzEALveU9wvyRr/rx6gyPwCyLQ3LBydmrkehHwQ
 A2z4+TJ85DQQoYXyR0f7v/2fPov7ygUjoHQ688nPFZYl4st9DV+tfX8jwBVQgknnKFih
 2wEEo7X4zD1x1Y8zi9/1NcSe6EGimXGMv3F6mWDeYAOxf+LVLuJ6zNITVsfEa7WPkrbN
 mQQz6cMVi7r/+/mPRY0Eo1JoMvt0noK2yko8en5LXvSOj5eFfYMeCY6l4KKtDSNblAcu
 fQhg==
X-Gm-Message-State: AOAM5335p5SE6+3l8n/WPMnydYiQs9nJe44kahoFvvCOHC1h8hNJzZd4
 nMFgKTDRzRSRE7apW+VpAA9EuQjhhqBMhgb5Bz/LZD2Y3I4=
X-Google-Smtp-Source: ABdhPJyBikqXWfxKFgZB7dgNhtzCblzZSWOk8upGaTyGRqLihxbMHaOalHpuxrCARX6vcMPXWXOP2O5mQwHY15/ixL0=
X-Received: by 2002:aca:4d10:: with SMTP id a16mr112410oib.41.1625819459033;
 Fri, 09 Jul 2021 01:30:59 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 9 Jul 2021 04:30:48 -0400
Message-ID: <CAA+-46q3vLWvu6WNueSybHZ-7hE=S=eZo1WWXDDq7YOa7hyjWg@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] unable to add callstack-user context
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
From: Evan Galea via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Evan Galea <evanjamesgalea@gmail.com>
Content-Type: multipart/mixed; boundary="===============8993784453582673371=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8993784453582673371==
Content-Type: multipart/alternative; boundary="000000000000531c2905c6ac9703"

--000000000000531c2905c6ac9703
Content-Type: text/plain; charset="UTF-8"

Hi there, I'm a little new to lttng and tracing in general. I am using a
Java Userspace agent, which is working well, but I am having trouble adding
callstack context to my tracing channels. I'm not sure if it's relevant but
running 'lttng add-context --list" shows callstack-user in the list.

the commands I input are:

lttng create
lttng enable-channel --userspace mychannel
lttng enable-event --userspace --all --channel mychannel
lttng add-context --userspace --channel mychannel --type callstack-user
>Error: callstack-user: UST invalid context

When I run the following command instead:
lttng add-context --userspace --channel mychannel --type vpid

I am able to get it to work and I see vpid appear in my traces. Are there
any other things I need to set up first to be able to use it?

also, are there any commands that can list the per-domain contexts
available?

--000000000000531c2905c6ac9703
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi there, I&#39;m a little new to lt=
tng and tracing in general. I am using a Java Userspace agent, which is wor=
king well, but I am having trouble adding callstack context to my tracing c=
hannels. I&#39;m not sure if it&#39;s relevant but running &#39;lttng add-c=
ontext --list&quot; shows callstack-user in the list.</div><div><br></div><=
div>the commands I input are:<br></div><div><br></div><div>lttng create <br=
></div><div>lttng enable-channel --userspace mychannel</div><div>lttng enab=
le-event --userspace --all --channel mychannel<br></div><div>lttng add-cont=
ext --userspace --channel mychannel --type callstack-user</div><div>&gt;Err=
or: callstack-user: UST invalid context</div><div><br></div><div>When I run=
 the following command instead:<br></div><div>lttng add-context --userspace=
 --channel mychannel --type vpid</div><div><br></div><div>I am able to get =
it to work and I see vpid appear in my traces. Are there any other things I=
 need to set up first to be able to use it?</div><div><br></div><div>also, =
are there any commands that can list the per-domain contexts available?<i> =
</i><br></div></div></div>

--000000000000531c2905c6ac9703--

--===============8993784453582673371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8993784453582673371==--
