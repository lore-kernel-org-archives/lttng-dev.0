Return-Path: <SRS0=fpp6=IW=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A28FC433DB
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 19:01:04 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2048A619F3
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 19:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2048A619F3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F5HdB6yhSzMgh;
	Wed, 24 Mar 2021 15:01:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1616612463;
	bh=GfiZyHo2BD18dbzcDft8VmeFgMuDAhcZdwKQuKZM/to=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hfDZMjBJUIQqJmP5tXXrq6e1upoACbff11UaNnSFbbj+wT3NPGVEskPlRghYxrdUI
	 /9Sdl8LSjn4Fzq3ji0RdiJibX9XMg9nB7r51AdU46Lej7u+cZXXWaTeXQmwoChadwK
	 r7sjmChlFY28c8ktG38yO2c8IaTJxb7JziWU4egrv4OrFr3FnOKlPmpbm6MgM2ccMH
	 +3u5xdU1/qpM0//5cIc0GW1eaF/Bx9xH4NyROiMYreL7EPpEZ/tbo6kzDMmQKG+gU3
	 euBKy7qCdGOhVBWTGgXIqefxtGcOjdJBuSurbIallaZEo+blJMD3uwGi7Hm2F6vhcf
	 tlDM8XAj2K3ag==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4F5Hd90Tm1zMCy
 for <lttng-dev@lists.lttng.org>; Wed, 24 Mar 2021 15:01:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C210924B8AB
 for <lttng-dev@lists.lttng.org>; Wed, 24 Mar 2021 15:00:54 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id x4lWqBs5NNXm; Wed, 24 Mar 2021 15:00:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5563A24B8AA;
 Wed, 24 Mar 2021 15:00:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5563A24B8AA
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 3LSIMjGkq9Xh; Wed, 24 Mar 2021 15:00:54 -0400 (EDT)
Received: from joraj-alpa (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id 0B25324B8A9;
 Wed, 24 Mar 2021 15:00:53 -0400 (EDT)
Date: Wed, 24 Mar 2021 15:00:53 -0400
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20210324190053.GG344120@joraj-alpa>
References: <PR3PR02MB62023431654FB93182EA21A1D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324142540.GB344120@joraj-alpa>
 <PR3PR02MB6202F969540C279A6A171F83D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324153255.GC344120@joraj-alpa>
 <PR3PR02MB620209CCED35CC62E1C8550FD1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324160629.GE344120@joraj-alpa>
 <20210324163611.GF344120@joraj-alpa>
 <PR3PR02MB6202B24C2EBFF492A659DFF1D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PR3PR02MB6202B24C2EBFF492A659DFF1D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
Subject: Re: [lttng-dev] Issues on basic LTTng trace userspace (tutorial)
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, Mar 24, 2021 at 06:55:37PM +0000, MONTET Julien wrote:
> Hi Jonathan,
> 
> You are absolutely right !
> I have two different lttng :   find /usr -name "*liblttng-ust*" Ubuntu Pastebin<https://paste.ubuntu.com/p/NVtXPhj4fW/>

Glad to know that we are making progress.

> 
> According to you, what would be the best solution to solve this issue ?
> I have indeed a folder named lttng-ust where I have made the (wrong) configure / make.

Go into the lttng folder and do:
  sudo make uninstall
  sudo ldconfig

> 
> 
> I tried to (temporary) remove all the libttng* /usr/local/lib/, but I face this problem :

That should works also.

> /usr/bin/ld: hello-tp.o: in function `__lttng_events_init__hello_world':
> hello-tp.c:(.text+0xe56): undefined reference to `lttng_ust_probe_register'
> /usr/bin/ld: hello-tp.o: in function `__lttng_events_exit__hello_world':
> hello-tp.c:(.text+0xeb2): undefined reference to `lttng_ust_probe_unregister'
> collect2: error: ld returned 1 exit status

Did you remove the -L/usr/local/bin flag? There should be no reason to keep it
at this point.

> 
> In the worst case scenario I am able to get my last clean snapchot.

That is also a good bet :).

-- 
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
