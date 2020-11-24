Return-Path: <SRS0=lmbG=E6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF93C56202
	for <lttng-dev@archiver.kernel.org>; Tue, 24 Nov 2020 21:41:16 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B9C206E5
	for <lttng-dev@archiver.kernel.org>; Tue, 24 Nov 2020 21:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="Ef2eZEnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B9C206E5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CgcsP2lYfz1Nh1;
	Tue, 24 Nov 2020 16:41:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1606254074;
	bh=3vPBuqedxGsGo+LcaUaLgKVBF8l0yVCtkla0n1pKlcQ=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Ef2eZEnLaUV+haabZofHK5ZLLhgtD4EwsQSLEOL9OutwbWKSCK/batzNXVe9mRqn4
	 z0N+xGFjst9jsV3cEqs0LdneuTbeNbmpH1r6NcJlx38hJS3O6cdrJD3SWtS1jiyL8z
	 N74D1UGM5LmCQEqvPkxJja4NCWhh7t11XcLR7d+M9tmqi3t40GCaOy1tUdm7J5tpvl
	 5xFWL6xqxq0OmOi0tZ69WeOfsEapV6IaqUPO31oCKraQBjXLU7oolOqIYwjV3XwOiN
	 Nsy8Rxd/GEhdLEH1o7Zt+gHaH2lnXo6rtlh8u/FZlfnTYrRmONt2XAJjJ24WPUrAiD
	 8ZLoPWOzH8Y3A==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CgcsM5f5Bz1NbW
 for <lttng-dev@lists.lttng.org>; Tue, 24 Nov 2020 16:41:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 63675274DC9;
 Tue, 24 Nov 2020 16:41:05 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id qpq1JOKeeVLM; Tue, 24 Nov 2020 16:41:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id F20B0275004;
 Tue, 24 Nov 2020 16:41:04 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F20B0275004
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id cXPKZDoTBmdS; Tue, 24 Nov 2020 16:41:04 -0500 (EST)
Received: from [10.10.0.55] (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
 by mail.efficios.com (Postfix) with ESMTPSA id DB584274EB0;
 Tue, 24 Nov 2020 16:41:04 -0500 (EST)
To: "Weber, John" <jweber1@ball.com>,
 'Jonathan Rajotte-Julien' <jonathan.rajotte-julien@efficios.com>
Cc: "'lttng-dev@lists.lttng.org'" <lttng-dev@lists.lttng.org>
References: <326539938460471c975e791ce6b1c775@ball.com>
 <20201120184746.GF8709@joraj-alpa>
 <8602eba582ba4806b5bf307cceef521d@ball.com>
 <20201124202138.GA769862@joraj-alpa>
 <aefcb4673adb4b3980bb0612a81f8d87@ball.com>
Message-ID: <aad4e816-2ff5-5f8b-fe56-108b17fcaf47@efficios.com>
Date: Tue, 24 Nov 2020 16:41:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <aefcb4673adb4b3980bb0612a81f8d87@ball.com>
Content-Language: en-US
Subject: Re: [lttng-dev] [EXTERNAL] Re: lttng 2.12 install
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2020-11-24 16 h 02, Weber, John via lttng-dev wrote:
> Ok, it I get what you're saying then I am modifying make on the command line while running make? Still the same problem. I don't think it is using the gcc I am specifying as it continues to look in: /usr/src/kernels/3.10.0-1127.19.1.el7.x86_64/
> And I suspect it is still seeing the OS version of gcc (4.8.5) instead of the 6.3.1 provided by devtoolset-6.
> Do you have some pixy dust??

Running this will get you verbose output while building which should 
help you determine which compiler and other tools are used :

   make CC="/opt/rh/devtoolset-6/root/bin/gcc" V=1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
