Return-Path: <SRS0=jUQg=AK=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E78C433DF
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Jun 2020 13:17:18 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5AD23D58
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Jun 2020 13:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="v+tA76GF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5AD23D58
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49wShC3YyPz16qp;
	Mon, 29 Jun 2020 09:17:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1593436636;
	bh=U5n7w8hvATH+EpOTDth+zvm2P/OGtTyeeW6VoQ6Eahw=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=v+tA76GFh0zKtBjDgws2eulz1RRDYhB20mUjKyK73ecwcCNa6w7/AnODQRtwg7RwV
	 g0uo7+T2WtPMyeI0ARLm1lz9ZmGLllZZAgpCdaphRSd2KFGGewBjCa8NqmOG1yaYrd
	 y8r5IwIto3ClXNrK0CrnCURL0QQKAQUBU1tJCRHOS2y+QN+YSPrJFDhW2bSBRuv1Mn
	 KaICO5QDpHlBIRO1ITKcD5md8PgCFxc2ckR8dhIQ1rBS4aowTL4uFbT4t+nPhw/IzI
	 uGYqZsqj3/c0FWhQr6k3J8RG/uRyG3mWkotrmyhze4tXle7GZQ+Kvy7M9TtLons3j/
	 HTuVog5r7XqCw==
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by lists.lttng.org (Postfix) with ESMTPS id 49vcbG6tlxz16Gm
 for <lttng-dev@lists.lttng.org>; Sun, 28 Jun 2020 00:10:02 -0400 (EDT)
IronPort-SDR: SVPYnxW6KfBbagRFh7A2FGLXVp6q/l5Uh7liCFfNP3u/Wc3sLJBW8HytwOtxU/iYb7n9vxb+Q2
 MvIFxB4bta6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9665"; a="133206587"
X-IronPort-AV: E=Sophos;i="5.75,290,1589266800"; d="scan'208";a="133206587"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2020 21:08:52 -0700
IronPort-SDR: ytbDR3lJu2HlpxVn+Od8c5kyitgOmFS+QgvbFbVe2w0QAoU2XruIJn5UJayjrP/rjDUBRMR41r
 Ht8bav8JiJHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,290,1589266800"; d="scan'208";a="480413955"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.121])
 by fmsmga005.fm.intel.com with ESMTP; 27 Jun 2020 21:08:50 -0700
Date: Sun, 28 Jun 2020 12:05:02 +0800
To: lttng-dev@lists.lttng.org
Cc: changcheng.liu@aliyun.com
Message-ID: <20200628040502.GA36830@jerryopenix>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Mon, 29 Jun 2020 09:17:14 -0400
Subject: [lttng-dev] babeltrace convert call_site addr to func/offset
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
From: "changcheng.liu--- via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: changcheng.liu@aliyun.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200628040502.C0jAu2IwKqIYwtgCi3my2aT2JqMGWx_ulmHt2P21Mco@z>

Hi all,
   I checked lttng-ust-cry-profile source code:
   https://github.com/lttng/lttng-ust/blob/master/liblttng-ust-cyg-profile/lttng-ust-cyg-profile.c

   It traced the runtime virtual-address(VA) of the
   1) called function address
   2) caller address

   The value of VA is different from the linked address.
   Due to ASLR, the VA could be different when running the program every
   time.
   The babeltrace could covert the "ip" in the traced context into
   func/offset. However, there's no context to trace the call_site and
   babeltrace also support convert the "call_site" into func/offset.

   Does lttng community has plan to supply the function to support
   "call_site" context and make babeltrace could convert the "call_site"
   into func/offset format?

B.R.
Changcheng
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
