Return-Path: <SRS0=fpp6=IW=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEEDC433C1
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 14:25:52 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B44961580
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 14:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B44961580
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F59Wf27xQzMLS;
	Wed, 24 Mar 2021 10:25:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1616595950;
	bh=K9tnV2xP3T3TKomdrpHzpt9g6yq3zeYyoZQ78Fv6MlI=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zX5IeO0jqwCxUKRnLTRYnIiaAXzm0Jf0S/0ZSkMOWf86+bywAu6yWd1+vpPIPyU9g
	 yejgQLwPtyFf+F53XlWD2EnlwgwW7aXDWm1jNCqeehn5gugJutLVqZos4N4iXCFUOU
	 oTtHyPQz2PZVCTQUlBsQuuogSquQNDiBDTq7wWn7xVNntmejs74ggnCiQ4Y/jryt0L
	 Qec3EdNhmqxaisxSTBrw9HB45ySF5DuuRNI9HEtToRL0772ji5JCF5QdxZIpAX/Oqs
	 eoVcdoi+uoJriym7x1cRg2AspnO6Hpiw2WKHMIL/jpTJSZ8CV2D29VlGldcLQvTyf3
	 0ohstWV1haHRQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4F59Wd0DWfzMLR
 for <lttng-dev@lists.lttng.org>; Wed, 24 Mar 2021 10:25:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9DA9E248B65
 for <lttng-dev@lists.lttng.org>; Wed, 24 Mar 2021 10:25:42 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id SRIxBB843So8; Wed, 24 Mar 2021 10:25:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1E1FF248BB3;
 Wed, 24 Mar 2021 10:25:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1E1FF248BB3
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 5AgS4gF_YOpd; Wed, 24 Mar 2021 10:25:42 -0400 (EDT)
Received: from joraj-alpa (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id B0DD024887C;
 Wed, 24 Mar 2021 10:25:41 -0400 (EDT)
Date: Wed, 24 Mar 2021 10:25:40 -0400
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Message-ID: <20210324142540.GB344120@joraj-alpa>
References: <PR3PR02MB62023431654FB93182EA21A1D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PR3PR02MB62023431654FB93182EA21A1D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
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

Hi Julien,

On Wed, Mar 24, 2021 at 11:29:04AM +0000, MONTET Julien via lttng-dev wrote:
> Hello the LTTng team !
> 
> I would like, at first, to thank you for your projet and your impressive work !
> 
> For the past few days I have been trying to learn how to use lttng (v2.12).
> 
> I followed the installation on your website for an Ubuntu 20.04.
> [cid:c663399f-0584-43d3-90c5-3aa277ee7020]

Good. So just to validate you used the stable 2.12 PPA as described in this
section [1] ?.

[1] https://lttng.org/docs/v2.12/#doc-ubuntu-ppa

> 
> The steps to get the trace of a Linux kernel and the babel trace are great !
> 
> However, I am stuck for the 'Trace a user application' : https://lttng.org/docs/v2.12/#doc-tracing-your-own-user-application
> Compilation steps are ok, it launches without error but lttng list --userspace  gives me nothing.

When you perform the `lttng list --userspace` command is your user application
running? If not, `lttng list --userspace` can only list running application.

If your application is running, we will need to go a bit further and have some
debug info.

You can at least check if lttng-ust, on the application side, can successfully
communicate with the lttng-sessiond process. For this, you will have to use
LTTNG_UST_DEBUG.

Here's how to us it:

 1) Make sure a lttng-sessiond is present,
 2) Start your application like so:  LTTNG_UST_DEBUG=1 your_application,
 3) Debug messages from lttng-ust should appear on the stderr.

Please use a paste service [2] to share this information with us. 

[2] https://paste.ubuntu.com/

Au plaisir!

-- 
Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
