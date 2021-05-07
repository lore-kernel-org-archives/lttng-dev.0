Return-Path: <SRS0=RQiO=KC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A42C433B4
	for <lttng-dev@archiver.kernel.org>; Fri,  7 May 2021 18:05:48 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891DB610D2
	for <lttng-dev@archiver.kernel.org>; Fri,  7 May 2021 18:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891DB610D2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FcJK52mTMz1k1r;
	Fri,  7 May 2021 14:05:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1620410746;
	bh=XjmwK69kN23Ma6i76ZDCJPMIezx974+d8EuEC8JdhmU=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IzfUK+L8YrHy1kD5BDBBYBGHIKNjGCjJdJ9seltfGCEInKUYG5sDSZAn1abS/ye+8
	 p/EJMfUrc/a6yiEbPhP2JhnsEOa1MuJeVO7DgOy2yQsEY9HEMlUmhXUc5nrX56n8UA
	 NyhNN8ju8c1LeHR4+zn3SFHwJAZENwK1csbYBvPhar+ftcsNSBCROJKqFaAGFWwkhi
	 TEVmOR7lNGN37b8OCczKOR4lb8x4miwH+f2y5AMmarZJ4rHgP+7ZQUlRdegGjdzHMs
	 nwFFr6RR/jUxZ5GlvcWo4MWRd0OS8Wxr/f9cbJGAea511n+fUOMcxckKZFp8/o8Arq
	 bnn8oXCgx1m5A==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FcJK34HKbz1kCj
 for <lttng-dev@lists.lttng.org>; Fri,  7 May 2021 14:05:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4A27F31C828
 for <lttng-dev@lists.lttng.org>; Fri,  7 May 2021 14:05:37 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Wpomee889_Qb; Fri,  7 May 2021 14:05:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4812431CAC2;
 Fri,  7 May 2021 14:05:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4812431CAC2
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Uz2x9ZukFTgS; Fri,  7 May 2021 14:05:36 -0400 (EDT)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id 1AB8731CB2B;
 Fri,  7 May 2021 14:05:36 -0400 (EDT)
Date: Fri, 7 May 2021 14:05:32 -0400
To: Eqbal <eqbalzee@gmail.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20210507180532.GA1227214@joraj-alpa>
References: <CAPj=WkjEZN+_NgrnF3djfF_jCyp+D195e+KpzqzAK9kfmrTu6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPj=WkjEZN+_NgrnF3djfF_jCyp+D195e+KpzqzAK9kfmrTu6Q@mail.gmail.com>
Subject: Re: [lttng-dev] lttng live event loss with babeltrace2
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

See https://github.com/lttng/lttng-tools/commit/c876d657fb08a91ca7c907b92f1b7604aee664ee . 

We would appreciate your feedback on this if possible based on your use case.

Cheers

On Mon, May 03, 2021 at 05:05:10PM -0700, Eqbal via lttng-dev wrote:
> Hi,
> 
> I have a lttng live session trace consumer application using libbabeltrace2
> where I create a graph to consume lttng live session traces and output to
> another sink. I am running the graph in a loop at some polling interval as
> long as I get BT_GRAPH_RUN_STATUS_AGAIN status. What I am noticing is that
> if my polling interval is large enough I tend to lose either all or some of
> the events. I experimented with various polling intervals and it seems if
> the polling interval is less than *DELAYUS *from "lttng-create
> --live=DELAYUS" option then I am able to get all the events, otherwise I
> tend to lose events.
> 
> Here are the steps I follow:
> 1. start session daemon and relay daemon
> 2. create a live session (with default delay of 1s), enable events and start
> 3. Start my application (hello world example from lttng docs)
> 4. Start the consumer application built using libbabeltrace that connects
> to the live session
> 
> I noticed that the events are actually persisted in the ~/lttng-traces by
> the relay daemon, but it does not reach babeltrace consumer application. I
> have noticed the same behavior with babeltrace2 cli.
> 
> I would like to understand what is the reason for such behavior and if
> playing with the polling interval in relation to the DELAYUS value is the
> right thing to do.
> 
> Thanks,
> Eqbal

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
