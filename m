Return-Path: <SRS0=9v83=E2=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE5DC2D0E4
	for <lttng-dev@archiver.kernel.org>; Fri, 20 Nov 2020 18:47:57 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0582245F
	for <lttng-dev@archiver.kernel.org>; Fri, 20 Nov 2020 18:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="t410yQwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0582245F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Cd5CG6rR6z1LPd;
	Fri, 20 Nov 2020 13:47:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1605898075;
	bh=DzXVAzZUUx9U4OfEw+auolxkkkbVBQESqAYwadwmaVY=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=t410yQwz/XggBlPI+ddi/1VVkZqdpwtdDL2fiYP6bwfgUQb2mp1QG0UmpVAXHR2c6
	 EYTT+dJpt+Urx6BbGqD5CCQJOF8JzqPn8NUEvqGOmpvj+s+MlFtGf6hItVVWYOPdJo
	 4ibbcFEN9jIssY3oKuyTOLE60+tn21q7MJ+mUteUBo+G4wmmPRdL9DrAap6Dz6iJkY
	 r05XVVShhdtqmkrUeKFBhGxagqldK/OPO2K3BNRNjgVyl9+GJj+PFP+1bwbNqQsmo8
	 0HpM5GqY1V4IeAaW4lY5SV6xj7BL8UINuPZ4fDmN5RsDLWigV+JbQ0GJP+1lRXAXmX
	 H0gaTycOelSXw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Cd5CF3Nhdz1LcP
 for <lttng-dev@lists.lttng.org>; Fri, 20 Nov 2020 13:47:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 47E142F9CBA
 for <lttng-dev@lists.lttng.org>; Fri, 20 Nov 2020 13:47:47 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id J4EcXhfRsJ3N; Fri, 20 Nov 2020 13:47:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C210C2F9F09;
 Fri, 20 Nov 2020 13:47:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C210C2F9F09
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id yCkfwXlzZhFh; Fri, 20 Nov 2020 13:47:46 -0500 (EST)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id 9A4E52F9F03;
 Fri, 20 Nov 2020 13:47:46 -0500 (EST)
Date: Fri, 20 Nov 2020 13:47:46 -0500
To: "Weber, John" <jweber1@ball.com>
Cc: "'lttng-dev@lists.lttng.org'" <lttng-dev@lists.lttng.org>
Message-ID: <20201120184746.GF8709@joraj-alpa>
References: <326539938460471c975e791ce6b1c775@ball.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <326539938460471c975e791ce6b1c775@ball.com>
Subject: Re: [lttng-dev] lttng 2.12 install
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi John,

This does not seems to be directly related to the lttng-modules project.

This errors seems to arise because of the compiler you are using to compile
lttng-modules (kernel modules). The RETPOLINE check is part of the kernel build
system, not directly lttng-modules.

I would recommend that you take a look at the /proc/version file and the
compiler that was used to compile your kernel. 

Also note that EfficiOS [1] provide commercial support if you ever need more
in-depth support. 

Cheers

[1] https://www.efficios.com/contact/

On Fri, Nov 20, 2020 at 05:43:00PM +0000, Weber, John via lttng-dev wrote:
> Hi, I have a centos 7.8 workstation that I'm trying to install lttng-modules & lttng-tools from source. Based on your install instructions I'm working on installing the modules part first and its failing. I am getting the error:
> Make entering directory /usr/src/kernels/3.10.0-1127.19.1.el7.x86_64
> Arch/x86/Makefile:166 *** CONFIG_RETPOLINE=y, but not supported by the compiler. Compiler update recommended... stop
> Make: modules error 2
> 
> Help, how can I get this program to install? Im stuck. Also, my work environment is classified so there is no access to internet from high side.
> 
> ----------------------------
> John Weber
> Ball Aerospace
> ITS ND System Administrator
> 10 Longs Peak Dr., Broomfield, CO 80021
> C: 303-807-3608   P: 303-234-2103
> E: jweber1@ball.com
> 
> 
> [cid:image001.jpg@01D6BF29.AD6C5250]
> 
> 
> [cid:image002.jpg@01D6BF29.AD6C5250]<http://www.ball.com/aerospace>
> 
> This message and any enclosures are intended only for the addressee.  Please 
> notify the sender by email if you are not the intended recipient.  If you are 
> not the intended recipient, you may not use, copy, disclose, or distribute this 
> message or its contents or enclosures to any other person and any such actions 
> may be unlawful.  Ball reserves the right to monitor and review all messages 
> and enclosures sent to or from this email address.




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
