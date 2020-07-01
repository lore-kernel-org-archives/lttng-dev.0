Return-Path: <SRS0=qFiG=AM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EF2C433DF
	for <lttng-dev@archiver.kernel.org>; Wed,  1 Jul 2020 15:58:12 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E803206C3
	for <lttng-dev@archiver.kernel.org>; Wed,  1 Jul 2020 15:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="vsh8wVxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E803206C3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49xm8y6h77z18hR;
	Wed,  1 Jul 2020 11:58:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1593619091;
	bh=WKO+wXXPPMz9+EPwu9rfs7P1mEnINVH77OlNSAzJ+tE=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=vsh8wVxpmpGPsTohhy2cmcicoY5qbF8PATBJZedYyHBvXgYhTdyd4y46/owKXYwdH
	 qrSlVCCrLWBcjqPORG3Awej6haOYefBQ3Iy9yU8EgcNymH6o69J+/NSXKGCKBWbE1U
	 9XE6bjvsiC9xr4lJaL/2q5qr8ktnTqMNxUqW2LplCM2ZDkQozZhmivGa0hojEAH0nA
	 1xVbbPi1zSW0kDebs0bboHDquDOutHuu5JdVC14PB+20Zq6AaBP4bTFdOroSEPKGLC
	 UeHVCwaCtKeTbjrIpyOSmNnn3IDtKysTe3wubIzdxa6AVhee+iD2XFrjVEAvnMzJXp
	 Yc58rzmZ2U57w==
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.lttng.org (Postfix) with ESMTPS id 49xm8w5G3gz18yY
 for <lttng-dev@lists.lttng.org>; Wed,  1 Jul 2020 11:58:08 -0400 (EDT)
IronPort-SDR: 3Btr6Xwhc5KmQJQPvn4EbOdBGzPrYr40/zOERI7XeeHmQfy5YCFykBkqGsPYjuyn42mgjGG5pa
 ebJH5E42caUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="146612029"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; d="scan'208";a="146612029"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 08:56:58 -0700
IronPort-SDR: haIJ4sWRI2qXdbMOMAfhCvfDqbagOUUaG3U8wMI67Ho0wI4RPvPypcLCEstRCiyDuh24NiuIfe
 LU1p2iT2qXJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; d="scan'208";a="455151135"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.121])
 by orsmga005.jf.intel.com with ESMTP; 01 Jul 2020 08:56:57 -0700
Date: Wed, 1 Jul 2020 23:53:09 +0800
To: lttng-dev@lists.lttng.org
Message-ID: <20200701155309.GA99920@jerryopenix>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Subject: [lttng-dev] convert call_site to func/offset
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
From: "Liu, Changcheng via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Liu, Changcheng" <changcheng.liu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200701155309.zLvJ4JQUL1VfwgJ85o_vxt_polzCgjyoXj3qF6t1pyk@z>

Hi all,
    I checked __cyg_profile_func_enter implementation.
    The caller address is recorded into call_site field.

    Does anyone know how to let babeltrace show the call_site into
    "func/offset" format instead of the running virtual address?
    
B.R.
Changcheng
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
