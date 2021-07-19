Return-Path: <SRS0=9+xD=ML=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E78C07E95
	for <lttng-dev@archiver.kernel.org>; Mon, 19 Jul 2021 21:31:57 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4839460FF0
	for <lttng-dev@archiver.kernel.org>; Mon, 19 Jul 2021 21:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4839460FF0
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4GTFRH4rRqz14Pt;
	Mon, 19 Jul 2021 17:31:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1626730316;
	bh=F7GVpweV3ZLZT50Sb5I7nC79TKW9nrsyytMQpfv3ayI=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wbcjbMqDZbxsVpDsKSfU2hvMLNYhb4BLHI7Bqru7093NkrH7DzAbl8eEf+tW284Dk
	 nsR1ElwbJB49Wj94XZjgY+KRk3+AGNVHkGMkv247XvnqSbdqZ0uAT6sYiYfjKRc6xs
	 os+N+vAk0+ZhKqpZbxR0NRVXmTp4Dzb7e19cZnCk920vjRvZe/iQQgBw8InCGuc6uY
	 aoU7UzouJCM64xwNyppGkDm4q9CHr1pWO0N8gonbNfhFdfIeyTrThnEDbeYqvq8GJy
	 KXab9vNuPeRqMSHQWyp+fFcmCe9kPEnx0Hr/Hn4e1bnd00/FO1qMe7s9A2qV25bABq
	 iVnLTxU4lRTRg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4GTFRF5RK5z14XZ
 for <lttng-dev@lists.lttng.org>; Mon, 19 Jul 2021 17:31:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 12D6C36BCD1
 for <lttng-dev@lists.lttng.org>; Mon, 19 Jul 2021 17:31:47 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id lV_fpJfjTv17; Mon, 19 Jul 2021 17:31:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C81EE36BA41;
 Mon, 19 Jul 2021 17:31:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C81EE36BA41
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id z782aA4LZ30C; Mon, 19 Jul 2021 17:31:45 -0400 (EDT)
Received: from joraj-alpa (modemcable014.202-131-66.mc.videotron.ca
 [66.131.202.14])
 by mail.efficios.com (Postfix) with ESMTPSA id A34DC36BBA2;
 Mon, 19 Jul 2021 17:31:45 -0400 (EDT)
Date: Mon, 19 Jul 2021 17:31:45 -0400
To: Evan Galea <evanjamesgalea@gmail.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20210719213145.GC608796@joraj-alpa>
References: <CAA+-46pxTLb0trHLGhLwwdf2N5YJQ90mdGtdxm0hn+Gcx=NMoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAA+-46pxTLb0trHLGhLwwdf2N5YJQ90mdGtdxm0hn+Gcx=NMoQ@mail.gmail.com>
Subject: Re: [lttng-dev] quick question about setting up lttng on Redhat
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

Hello,

On Mon, Jul 19, 2021 at 09:40:06AM -0400, Evan Galea via lttng-dev wrote:
> Hello there
> 
> We have been considering setting up Redhat on my system and have learned
> that Lttng packages are supported. I was hoping to quickly learn the answer

EfficiOS provides commercial support for RedHat. Please contact
sales@efficios.com if you need commercial support.

> to two questions:
> 
> 1: As Redhat is based on Fedora, Do I just use the instructions for Fedora?
> I know it's probably a stupid question but I just want to make sure I'm
> doing everything correctly.

I do not think so, since the packages repository are not the same AFAIK.

If you are using RHEL 7 and okai with using lttng 2.10, you can have a look here
http://packages.efficios.com/

Installing from source is also a possibility. The only major hurdle might be
lttng-modules depending on your kernel version.

> 
> 2: Are there any differences between Lttng on Redhat and Lttng on Ubuntu or
> are they simply the same? Again just need to make absolutely sure as I
> don't want to do anything without first knowing

At the functionality level, it will be the same. Distros do not influence the
functionality we expose. At least not for now...

For Ubuntu, the lttng project have multiple PPA depending on your need.

https://launchpad.net/~lttng

> 
> Thank you for your time and sorry if the answers to these questions are
> somewhere I didn't look.
> 
> Evan Galea

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
