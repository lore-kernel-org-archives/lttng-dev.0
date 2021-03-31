Return-Path: <SRS0=91P6=I5=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF655C433B4
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 15:18:22 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61AC60240
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 15:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61AC60240
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F9VLz6mlDzS3l;
	Wed, 31 Mar 2021 11:18:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617203900;
	bh=yreGHg32RtLvLmrypGUuo/w9WWpZcnNTCPNJDjYObgM=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qadBccr3QqsyHm39X0BFeVb85x3m0X85HrcH3VlDV1XwYbNKHvD2rcbWt8L9580e+
	 r9bpMF63Ktrv0weo9x9FLGJ4EN+LpV/6zhegqFBwnsFY3zSd+78sg3LGtX11/2ERv5
	 W9CoVKT6uubuXu1wWpv48Xrky02aSeshePleaF0T20V6Fgwx7x+6HhA5QnHt6jAtB3
	 Xo1mlr9s+QArIYyTKrm9hyMIY14wGPnDAS4tBXGeItX2UPdqF/5tCC3LBzMsApMFHv
	 jbj0IY9WaalZVpFTbuf5bZKdXvW5O93NyCNwAQEcGVgdZkRJD9+QYF6GdtKKYJu4rM
	 e7dNznkTUOvWw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4F9VLx61pJzS3k
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 11:18:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5DF962F65BA
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 11:18:11 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id d6OIRyXVcz8H; Wed, 31 Mar 2021 11:18:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D6D712F627D;
 Wed, 31 Mar 2021 11:18:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D6D712F627D
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 7lwTORRqzzvk; Wed, 31 Mar 2021 11:18:08 -0400 (EDT)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id B8B762F65B8;
 Wed, 31 Mar 2021 11:18:08 -0400 (EDT)
Date: Wed, 31 Mar 2021 11:18:07 -0400
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Message-ID: <20210331151807.GA28307@joraj-alpa>
References: <PR3PR02MB62022E6EDD042CC2AD58D173D17D9@PR3PR02MB6202.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PR3PR02MB62022E6EDD042CC2AD58D173D17D9@PR3PR02MB6202.eurprd02.prod.outlook.com>
Subject: Re: [lttng-dev] Question/Issue compilation ARMv7 of LTTng
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

Hi,

On Tue, Mar 30, 2021 at 10:29:22PM +0000, MONTET Julien via lttng-dev wrote:
> Hello the developpers !
> 
> On my side, userspace and kernel event are working for both x86_64 and 32bits on Ubuntu 20.04.
> One of my main goals is to use LTTng on an armv7 target (Raspbian 32 bits).

Ok.

> 
> I am using Docker to create the environment and to compile the image (Debian 9.3).
> During the compilation of RCU, I get :
> #10 5.868 checking whether the C compiler works... no
> #10 5.982 configure: error: in `/tmp/tmp.T2I20x25bo/userspace-rcu-0.12.2':
> #10 5.983 configure: error: C compiler cannot create executables

I would suggest that you have a look in the config.log file and share with us
the complete file, as always use a paste service if possible.

> 
> My question is the following : Can LTTng be used directly on arm ?

It can absolutely be used on arm.

For example see our portbuild testing matrix here:

URCU:
https://ci.lttng.org/job/liburcu_master_portbuild/

LTTng-tools:
https://ci.lttng.org/job/lttng-tools_master_portbuild/ 

> https://lttng.org/docs/v2.10/#doc-instrumenting-32-bit-app-on-64-bit-system
> I read again the tutorial and it seems we always need a 64-bits platform.

On 32bit only platform you are limited to 32bit tracing and all the limitation
related to 32bit, if any is applicable to your use case.

> 
> Find below a part of my Dockerfile (that looks like the tuto):
> # LTTng RCU - 32 bits
> RUN bin/sh -c 'cd $(mktemp -d)' && \
>     wget https://lttng.org/files/urcu/userspace-rcu-0.12.2.tar.bz2 && \
>     tar -xvf userspace-rcu-0.12.2.tar.bz2 && \
>     cd userspace-rcu-0.12.2 && \
>     ./configure --libdir=/usr/local/lib32 CFLAGS=-m32 && \
>     make && \
>     make install && \
>     ldconfig
> 
> I tried to run the installation on the docker file of gcc-multilib, build-essential, wget... but it doesn't work.

Our project use standard autotools/make mechanism for cross compilation scenarios: https://www.gnu.org/software/automake/manual/html_node/Cross_002dCompilation.html

I am not aware of any problem at this level but after looking around our CI I
think we do not do a lot of cross compilation. Still I know that yocto and
buildroot use cross-compilation for lttng and its dependencies without any major
modification.

Still, we will wait for the config.log file before putting this in the: not a lttng problem.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
