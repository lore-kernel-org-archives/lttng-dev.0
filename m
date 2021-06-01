Return-Path: <SRS0=U5mz=K3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504B0C4708F
	for <lttng-dev@archiver.kernel.org>; Tue,  1 Jun 2021 18:56:27 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F7F613BD
	for <lttng-dev@archiver.kernel.org>; Tue,  1 Jun 2021 18:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F7F613BD
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FvhG06J6kz5LW;
	Tue,  1 Jun 2021 14:56:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1622573785;
	bh=TuqvlK/7zBZTort66gxel/JcRHwmHqrnWfuvVyWGVqE=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=xUM7AvY5qF0XOrl3oQuwvxHKsitSgPeeXgfcTM2fpRiupziPBaJAO3cCwoyPadzDx
	 DJH/WnHmKSdWvoGolU30HGzrtK06F5sXFxAS5E34x00qgbp2fGCae3/ssVjdW/7yf1
	 OOX78BzqYL1o8nukA12qowwoO+lzTt5CSx/Z/ZzxG3a/JVY4lZ8qcvfJuySczxgVpR
	 wpeAu0Dln3KQSv/LITzDYRmk1Ner+N4tYYP+bZS6Vr3JAKXe6akgxjkuprKF9t/TtL
	 z8OuTcmjYGPUM+8e+sX3++4cE1btY+SriAr4KhiO2MlHYNnkX6IMYfJndwwZmluVa1
	 rx+oFwh2cwpAw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FvhFz0fZkz5FT
 for <lttng-dev@lists.lttng.org>; Tue,  1 Jun 2021 14:56:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B93D02EAB6C
 for <lttng-dev@lists.lttng.org>; Tue,  1 Jun 2021 14:56:16 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id RLKIiHnk21WV; Tue,  1 Jun 2021 14:56:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3A0822EAF60;
 Tue,  1 Jun 2021 14:56:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3A0822EAF60
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 6VOR1q5F6PHI; Tue,  1 Jun 2021 14:56:16 -0400 (EDT)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id 1D1BF2EAF5F;
 Tue,  1 Jun 2021 14:56:16 -0400 (EDT)
Date: Tue, 1 Jun 2021 14:56:15 -0400
To: public@triplanets.com
Cc: lttng-dev@lists.lttng.org
Message-ID: <20210601185615.GA388028@joraj-alpa>
References: <00e701d7567f$cd20c070$67624150$@triplanets.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00e701d7567f$cd20c070$67624150$@triplanets.com>
Subject: Re: [lttng-dev] Syntax error running lttng
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

On Tue, Jun 01, 2021 at 10:48:13AM +1000, Merlin via lttng-dev wrote:
> Hi,
> 
>  
> 
> I have compiled LTTNG for ARM but when I try to run the executable, I get
> this error:

Do you have any of the logs for the lttng-tools project?

That would be `config.log` and the output from `make` and `make install`

> 
>  
> 
> lttng: line 1: syntax error: unexpected "("

Hmmm that does not look like an error from a elf executable.

Do you have any bash or shell alias for the lttng command?

Please provide the output of the following commands:
  $ file $(which lttng)
  $ head -n 10 $(which lttng)



> lttng-sessiond

If this happens also on the `lttng-sessiond` via command line but works using a
service, it would point to weird shell setup.
> 
>   all produce the same error.
> 
>  
> 
> There were no compiler errors.  I am at a loss to understand what it is
> complaining about from the message.

Me too.

> 
>  
> 
> Modules seem to load fine.

Modules are loaded by the lttng-sessiond executable. Here only the CLI
executable seems to be having some problem.

-- 
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
