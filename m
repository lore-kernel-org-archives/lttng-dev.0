Return-Path: <SRS0=A40Q=63=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C531BC433E0
	for <lttng-dev@archiver.kernel.org>; Wed, 13 May 2020 18:04:16 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15BF205CB
	for <lttng-dev@archiver.kernel.org>; Wed, 13 May 2020 18:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="R2PjdcNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15BF205CB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49MjH259x7z22FK;
	Wed, 13 May 2020 14:04:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1589393055;
	bh=rPG1JXg3KWDW2XdOPA858WfbRdONA2FBek+MPOEvIsg=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=R2PjdcNX2KhqGLmpyBnuT2P0rX3yGP1YcDMmI0rJydkB4dHW18xVM38VZEnSb8BEa
	 IL0cbc8bPoIb9/XnqMzvySGy2PydgM1WnfyCCIEJzSvLnJTeop2tgLCowT/VHH1fa4
	 mfe6HzlJD45lr+Wo7HVv4iRUj2Yfgq3LOq4Yls6ZzDAUdSBFEtMTN6rhPJ7PBHobpi
	 nxLRNS2V7Ys3Qj7gyQil/d6RXVmDceWehWdWxT7Fq8IwqbxXq/n57FHiszkxHv1mrz
	 pYO9dxk9XD3TL1U3MbxYYri6IYN/VS/5W53VC7KDj/vQoYaeLaCmJGYmhcKW01+06J
	 ScTRxDWh2oSfw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49MjH117Gfz21s3
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 14:04:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5DBAF2BBE64
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 14:04:06 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id WfJw3vcpCVX1; Wed, 13 May 2020 14:04:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 067742BC061;
 Wed, 13 May 2020 14:04:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 067742BC061
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id id6yAeOSq6c1; Wed, 13 May 2020 14:04:05 -0400 (EDT)
Received: from joraj-alpa (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id 7CBB02BC24E;
 Wed, 13 May 2020 14:04:05 -0400 (EDT)
Date: Wed, 13 May 2020 14:04:04 -0400
To: Abhinav Ranjan <abhi.abhinav240@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20200513180404.GB2381108@joraj-alpa>
References: <CAPC3ern8bkAJDnOwoYh2Om44Q2GWAPsh140FW_aPGVkdUmCwkw@mail.gmail.com>
 <CAPC3erkxTh9dSgahym7xsCjJXOV3D+kto-=UB-ApjSUOWYZVeA@mail.gmail.com>
 <20200513153312.GA2381108@joraj-alpa>
 <CAPC3erkfapoZu_WM=znEyj0ch1YiKeX7-JBiauoLh+Seee0TZA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPC3erkfapoZu_WM=znEyj0ch1YiKeX7-JBiauoLh+Seee0TZA@mail.gmail.com>
Subject: Re: [lttng-dev] Need Help In trace generation for malloc(),
 free() calls etc
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
Message-ID: <20200513180404.QPRqR7zOpPIWT4CjyA6M3fW3p68yA6ZtUWRNtwCwaTs@z>

Hi Abhinav,

Please keep the mailing list in CC for all communication: lttng-dev@lists.lttng.org

If not, I am not interested in helping you further.

On Wed, May 13, 2020 at 09:26:52PM +0530, Abhinav Ranjan wrote:
> Hi! Jonathan thank you so much for your help and reply! Sure I'll not use
> snapshot from next time and follow your advice.
> In fact I figured out the issue, but Jonathan I have one specific doubt I
> wanted to trace malloc , free call from my app only  but after using lttng
> enable-event --userspace lttng_ust_libc:malloc I am seeing several malloc (
> in Trace Compass)   probably from different tracepoints from lttng_ust_libc.

You will see all malloc that the app does for its lifetime since you LD_PRELOAD
the wrapper including any allocation lttng-ust does. Keep in mind that lttng-ust
is not magic, lttng-ust spun threads and do some allocations to do its job.

What outcome do you expect? We might be able to at least get you on the right
path. In other word, what is your end goal?

Cheers

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
