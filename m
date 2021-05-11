Return-Path: <SRS0=3D3p=KG=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33597C433B4
	for <lttng-dev@archiver.kernel.org>; Tue, 11 May 2021 01:15:06 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD206161C
	for <lttng-dev@archiver.kernel.org>; Tue, 11 May 2021 01:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD206161C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FfKj34fcXz1lrD;
	Mon, 10 May 2021 21:15:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1620695704;
	bh=Qq9Jv3cevd2rFdI2W7kUdvdMF37N5I/sYEzJFnc2iWg=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=twlxEbaWhLaw+5mdlHPhlKOYj80m0oAFXwWe24DV2Oajlp2o4mdqu8b1kWljRgEnS
	 38kloAxfiuY7xjwzJFqfMWMZJXcefX8jIw7cVP8x8o84pgM0BGlPx8i+6tRhJcA2RE
	 LBm/ZWyD+al4qMynuH8rZUpeMII3LsNb1Fnz3/u5K5uCiDT+CYUCeWD/2Znw6q+ZMc
	 OdZygck96M05AbyYcI32u46oGvidUqANYSbWUZK+dO75DhwDMwDwX6SiC5Erw66m9X
	 E5IG/hpNFMa30e1YCSAmDi52Kt8Woqgy8WtGDchdXuS22vXSn3P3cl31lrGnSkVGaQ
	 QrAQkwONsNOsA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FfKj11QPGz1lr7
 for <lttng-dev@lists.lttng.org>; Mon, 10 May 2021 21:15:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CE8ED347B3B
 for <lttng-dev@lists.lttng.org>; Mon, 10 May 2021 21:14:54 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id EI55p3w6OO7N; Mon, 10 May 2021 21:14:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5B6C1347C2E;
 Mon, 10 May 2021 21:14:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5B6C1347C2E
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id htUIzRyV29Zy; Mon, 10 May 2021 21:14:54 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 4BDBD3479E4;
 Mon, 10 May 2021 21:14:54 -0400 (EDT)
Date: Mon, 10 May 2021 21:14:54 -0400 (EDT)
To: Eqbal <eqbalzee@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1156967432.37397.1620695694212.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAPj=Wkgmf1xGq0H4ka5B5KyXipGReFMuQo4=aMK5NS6fPVL3oA@mail.gmail.com>
References: <CAPj=WkjEZN+_NgrnF3djfF_jCyp+D195e+KpzqzAK9kfmrTu6Q@mail.gmail.com>
 <20210507180532.GA1227214@joraj-alpa>
 <CAPj=Wkgmf1xGq0H4ka5B5KyXipGReFMuQo4=aMK5NS6fPVL3oA@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Linux)/8.8.15_GA_4007)
Thread-Topic: lttng live event loss with babeltrace2
Thread-Index: WCkwGOXYVXpSVj8E2HspOf3nc4OjIA==
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

> I ran my test with the new changes and it seems to improve the lossiness but not
> eliminate it. For example it seems in the hello world example that if the
> application exits too quickly after emitting the tracepoint, we might still
> lose some events in the consumer even though they are present in the relayd
> output folder.

Here by consumer you mean a "live reader" right? If so I would suggest you use the term 
"live consumer reader" or "live reader" since "consumer" alone can yield some confusion 
with lttng-consumerd. 

I would need a reproducer for this, you can base yourself on the reproducer in the commit message for the previous fix. 
AFAIK there is no valid reason for this to happen, at 
least based on my review of the code for the fix we just merged.
(This is only valid for per-uid tracing, per-pid tracing and lttng live have not so minor limitation inherent to the current lttng-live implementation) 

> I don't quite understand why that is. Would love some explanations on the
> various timing windows where we have a potential to lose the events on the
> consumer side.

From a live reader perspective, in per-uid mode, there should be no "loss" of event from the moment the viewer is attached and 
the moment it detach. Here "loss" mean that the events are present in the trace gathered by lttng-relayd but not by the live 
reader for the same "time window". This is only valid if the viewer is not "late" and have consumed everything at the moment it detach.


Cheers

----- Original Message -----
> From: "Eqbal" <eqbalzee@gmail.com>
> To: "Jonathan Rajotte-Julien" <jonathan.rajotte-julien@efficios.com>
> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Monday, May 10, 2021 8:35:41 PM
> Subject: Re: [lttng-dev] lttng live event loss with babeltrace2

Hi, 

> I ran my test with the new changes and it seems to improve the lossiness but not
> eliminate it. For example it seems in the hello world example that if the
> application exits too quickly after emitting the tracepoint, we might still
> lose some events in the consumer even though they are present in the relayd
> output folder.

Here by consumer you mean a "live reader" right? If so I would suggest you use the term "live consumer reader" or "live reader" since "consumer" alone can yield some confusion with lttng-consumerd. 

I would need a reproducer for this, you can base yourself on the reproducer in the commit message for the previous fix. 
AFAIK there is no valid reason for this to happen, at least based on my review of the code for the fix we just merged. (This is only valid for per-uid tracing, per-pid tracing and lttng live have not so minor limitation inherent to the current lttng-live implementation) 

> I don't quite understand why that is. Would love some explanations on the
> various timing windows where we have a potential to lose the events on the
> consumer side.

From a live reader perspective, in per-uid mode, there should be no "loss" of event from the moment the viewer is attached and the moment it detach. Here "loss" mean that the events are present in the trace gathered by lttng-relayd but not by the live reader for the same "time window". This is only valid if the viewer is not "late" and have consumed everything at the detach moment. 

Cheers 
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
