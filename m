Return-Path: <SRS0=W2C5=J7=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CF2C433B4
	for <lttng-dev@archiver.kernel.org>; Tue,  4 May 2021 13:16:34 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A218161008
	for <lttng-dev@archiver.kernel.org>; Tue,  4 May 2021 13:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A218161008
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FZL2l6VPwz1gqm;
	Tue,  4 May 2021 09:16:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1620134192;
	bh=mguj/X4g77VcALyTHCgcPIll74rlI/ZbgoirZjU87ls=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Vp1cPos59A7lvjln/HCAF0E7qP+QoZLVWcNLrW36ReN/OfNgmdRuloiPItCqGpxSF
	 RiodMuADbSC+44zCkviYTWRDlTAnwn4qP8noWmJCP/DKKxNnd7UPwaOJSZrXiFPOdF
	 UWzrK3+EFSXU/arYTSu2BJYrgszhT7JC5OJtZpoAXyZGVp+42Tu89KEqOe1kzo/3FT
	 wUxOXmPouvQo2rxeFGTglZmKAjqZ9jU1E8cNbw1wHPOyWt/Lz7bM9DMD6psBLUuo2c
	 0H2+y2D7RLOFr893kVfy496zB/68f385NpmVSm8XBWssc46SqBp5yhbQtzVVjx0IhK
	 aSbizXWGpMXDw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FZL2k4PWDz1h08
 for <lttng-dev@lists.lttng.org>; Tue,  4 May 2021 09:16:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 149BC2E27C2
 for <lttng-dev@lists.lttng.org>; Tue,  4 May 2021 09:16:24 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id sjM_QnWhLrMb; Tue,  4 May 2021 09:16:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id ADA142E298A;
 Tue,  4 May 2021 09:16:23 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com ADA142E298A
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id EGd8wClf5-dH; Tue,  4 May 2021 09:16:23 -0400 (EDT)
Received: from joraj-alpa (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id 4DDFA2E27C0;
 Tue,  4 May 2021 09:16:23 -0400 (EDT)
Date: Tue, 4 May 2021 09:16:22 -0400
To: Eqbal <eqbalzee@gmail.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20210504131622.GA346954@joraj-alpa>
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

Could you also test against babeltrace 1.5? It might give us a bit of a head
start to debug this if it turns out to be unexpected behaviour.

-- 
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
