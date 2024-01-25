Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E76C47258
	for <lttng-dev@archiver.kernel.org>; Thu, 25 Jan 2024 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1706195265;
	bh=MSl+77gccac9nD0j2Z111uhauMJ9wXALOHvn5Rlp8OA=;
	h=To:In-Reply-To:References:Date:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=AHpx+a/yThv1pSbZhfZMb1ENVYYqE9hP3Y+Vb7xnimmZwy/CGC+9Ihkh8LmVOVRTl
	 f4tr2Rvc6F7/xkEuYVfFoEcnJ3aXhQdMcLG+voT0otoHmrKuZu4+Zn5k1bEmTbP6AS
	 84Jv53zPCH+J+9SEP42pOdxTH5SKwWHJBGJYAQbKqPvCUz62MV+EBFCM579qfU+goS
	 xO6R4rdjywYK7rSRGMfivfWgC1gjt7Dt72tv0jz1x3JbC092h285wY7q3HZwj1ttlg
	 xNBz9skpPnOk5VpX1A8l4SkJK1Fuk3DOFq1JmQz8lweyqctzcva1vmRjAXbS1BgV/1
	 GfCiySoD9Ee+A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TLPMN5qBXz1lTQ;
	Thu, 25 Jan 2024 10:07:44 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:b2ee::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4TLPML655gz1lxC
 for <lttng-dev@lists.lttng.org>; Thu, 25 Jan 2024 10:07:42 -0500 (EST)
Received: from localhost (unknown [209.209.33.206])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4TLPML0JVhzVMP;
 Thu, 25 Jan 2024 10:07:42 -0500 (EST)
To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>, lttng-dev@lists.lttng.org
In-Reply-To: <20240125093028.1883839-1-xiangyu.chen@eng.windriver.com>
Organization: EfficiOS
References: <20240125093028.1883839-1-xiangyu.chen@eng.windriver.com>
Date: Thu, 25 Jan 2024 10:07:41 -0500
Message-ID: <87bk99sb7m.fsf@laura>
MIME-Version: 1.0
Subject: Re: [lttng-dev] [PATCH v7 lttng-tools] tests: add
 check_skip_kernel_test to check root user and lttng kernel modules
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Thu, 25 Jan 2024, Xiangyu Chen via lttng-dev <lttng-dev@lists.lttng.org> wrote:
[...]

> Add LTTNG_TOOLS_DISABLE_KERNEL_TESTS to skip the lttng kernel
> features test, this flag can be set via "make":

Is there a reason for this to be passed as a make flags instead of a
configuration option like `--disable-kernel-tests'?
 
-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
