Return-Path: <SRS0=PeGe=JD=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09710C433B4
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Apr 2021 23:46:37 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFA96139E
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Apr 2021 23:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFA96139E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FFPLf5SwDz134C;
	Tue,  6 Apr 2021 19:46:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617752795;
	bh=ilGNV/Sg3ZlJaeftczorq/dLg7MacBkUd0EtT5+uIsA=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=OMMOx6O+jesNA4mr1/6XAsdyoEg7LYz4mgYyVGOTceSfnK3OBcAV+QUbbw+7v+1g5
	 0y/6LCjDYmm/Eg6Rbv/v1hsn0R3tQo2jTj0uX7qDV4FhuvRNcQOL98tmwfpt74Df2p
	 dudiLF4Xc3n9xL/63X8RrP6iCbHXfH/zzX4WvpkhSb1Am+femCaTrji8JJFHvEFBVM
	 uy6Swm28a4+08d1rZjonHTgPY9lib2nbj+jmooszDQ+EKPY2D3fqGfeEIdvZQPA2Fl
	 bPdvDhc3CZJZLVKnIBtZPSR0sjrsC8ugq4JuRcCJq9zWRWqogISq1QPuWPg0I97opi
	 nF3amm3gkYYqQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FFPLc6F6rz13SK
 for <lttng-dev@lists.lttng.org>; Tue,  6 Apr 2021 19:46:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5AE9B320941
 for <lttng-dev@lists.lttng.org>; Tue,  6 Apr 2021 19:46:26 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id mwCvcseNjnO9; Tue,  6 Apr 2021 19:46:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 54A9E3208F1;
 Tue,  6 Apr 2021 19:46:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 54A9E3208F1
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id p1fdnID5GFno; Tue,  6 Apr 2021 19:46:25 -0400 (EDT)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id 37057320940;
 Tue,  6 Apr 2021 19:46:25 -0400 (EDT)
Date: Tue, 6 Apr 2021 19:46:21 -0400
To: Ramesh Errabolu <ramesh.errabolu@gmail.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20210406234621.GA913141@joraj-alpa>
References: <mailman.1.1617379201.29396.lttng-dev@lists.lttng.org>
 <CAFGSPryoOne68L4APnOvEgmw=q3WcgVujY1RYbEiO0FwqJnDyw@mail.gmail.com>
 <20210406131139.GC79283@joraj-alpa>
 <CAFGSPrzx05pqvjC7UzxHZWuk38_zhUfBEiq0oUc21-yxggp5tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFGSPrzx05pqvjC7UzxHZWuk38_zhUfBEiq0oUc21-yxggp5tQ@mail.gmail.com>
Subject: Re: [lttng-dev] lttng-dev Digest, Vol 156, Issue 3
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

> I followed your command sequence and noticed a bunch of files being
> created. However when I tried to run babeltrace on these outputs I don't
> see any of the functions that should have been called.  Including below the
> search for symbols.

At least userspace tracing seems to work.

I would recommended, again, that you first try tracing on a dummy application, a
really simple one. Then move to the usage of cyg_profile on that dummy app then
to your application.

The cyg profile events are the following:

  lttng_ust_cyg_profile_fast:func_entry
  lttng_ust_cyg_profile_fast:func_exit

and, when using liblttng-ust-cyg-profile.so:

  lttng_ust_cyg_profile:func_entry
  lttng_ust_cyg_profile:func_exit

I would recommend that you first start grep-ing (lttng_ust_cyg) for this in the
trace to see if any is getting hit and recorded. If it is not the case, take a
step back try with a dummy app and if nothing works with the dummy app we can at
least try to help you from there and remove all other variable since you will be
able to share the dummy app with us.

Cheers
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
