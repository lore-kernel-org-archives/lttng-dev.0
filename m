Return-Path: <SRS0=8WX2=D3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AC3C4363A
	for <lttng-dev@archiver.kernel.org>; Tue, 20 Oct 2020 15:01:29 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318E021D7B
	for <lttng-dev@archiver.kernel.org>; Tue, 20 Oct 2020 15:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="MoivSM3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318E021D7B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CFxfG3Pjvz14Ww;
	Tue, 20 Oct 2020 11:01:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1603206086;
	bh=VflwXYEm1bTrPFyS3qDTnqyCHeZj0RuV7p6dDW54FVw=;
	h=To:References:Date:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=MoivSM3jLwPqTVUy2mTaZc2qNtoOt4GRHAKTbEr4NzOAZefcc47XhcbI8yL6kzLzd
	 HxMkoliIGsh1ufm6eVX+mBGaCm06eQySJsiN/yk8KxrfX6ewxnm8ZcEpmy0bouu5oG
	 LSTgQBeCqU9Fp/KalwsSu79hLQGw/m4nU514IK7FI9hdcYkJAHcRT3zYvk2E2c90dX
	 lmVQJSPtFEm+pJCpUzOogHkdie5f/vrAq3EH0aG+5KlrG9iHRvwb8qOLFaavRQqYw0
	 1mW/o39X5lwRVE0pgUNJEdUeMxU9EKyQP95dYqL8wcnFOjgQkZl5CQdTvojhNaCcsL
	 neKElY8eeQF4g==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CFxfD6gl1z14rZ
 for <lttng-dev@lists.lttng.org>; Tue, 20 Oct 2020 11:01:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 89F6B2DA8A7
 for <lttng-dev@lists.lttng.org>; Tue, 20 Oct 2020 11:01:18 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ccs8tI6VcXXI for <lttng-dev@lists.lttng.org>;
 Tue, 20 Oct 2020 11:01:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 511952DA3EA
 for <lttng-dev@lists.lttng.org>; Tue, 20 Oct 2020 11:01:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 511952DA3EA
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id eOdeStb6CBWo for <lttng-dev@lists.lttng.org>;
 Tue, 20 Oct 2020 11:01:18 -0400 (EDT)
Received: from [10.10.0.55] (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
 by mail.efficios.com (Postfix) with ESMTPSA id 395122DA8A4
 for <lttng-dev@lists.lttng.org>; Tue, 20 Oct 2020 11:01:18 -0400 (EDT)
To: lttng-dev@lists.lttng.org
References: <SA9PR09MB57258DA2DB866F09A1950BBAC41E0@SA9PR09MB5725.namprd09.prod.outlook.com>
Message-ID: <e217db77-248a-d598-e906-3091e04a0863@efficios.com>
Date: Tue, 20 Oct 2020 11:01:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <SA9PR09MB57258DA2DB866F09A1950BBAC41E0@SA9PR09MB5725.namprd09.prod.outlook.com>
Content-Language: en-US
Subject: Re: [lttng-dev] lttng-tool for configure for `liburcu` doesn't use
 PKG_CONFIG
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

On 2020-10-19 18 h 22, Applencourt, Thomas via lttng-dev wrote:
> Hi,
> 
> When having `lurcu-cds` in the PKG_CONFIG_PATH but not in the LD_LIBRARY 
> or CPATH it's not picket up by the configure script.
> 
> Regards,
> Thomas

For which version of babeltrace? From git or a release tarball?
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
