Return-Path: <SRS0=Aspu=I3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C835AC433C1
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Mar 2021 13:54:13 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3F4617C9
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Mar 2021 13:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3F4617C9
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F8DZr0KcWzQNW;
	Mon, 29 Mar 2021 09:54:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617026052;
	bh=MtMpeKQp4FE1DYwGlPaxXgOhx1kX6SEIbDAegYtLmyE=;
	h=To:References:Date:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=oa2FeKpvhvfNGEntMP6dKK55CZl53jIlgYMSeSTzsMrMQX47XQ5LeK3oUlEu67ket
	 wlQlfeElr/5+7upCzZqtcnsnDLULct85sG68LxQSRffhDAWPiuID8M2TxkFjhydz7l
	 ABoUScEx9UOUUi3Fyri6s9gj2cfeF57SVjP0OFxtl4Lahdsmry2vsmeOdG9hZopz4v
	 tsqPMWwRvAKTxBw9ipYWhluClLdrsjAqYACvMUPdAlOmFstkOn0Qq1x9t8et1k8F6H
	 wN/S1cpBPW6/wO2ykT3e319d0U6iEhfjdYhrB5XcJyj3SMoHlR6WJzen58aXSII18Q
	 bBMVu1vq0uNcQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4F8DZp3WDXzQ7N
 for <lttng-dev@lists.lttng.org>; Mon, 29 Mar 2021 09:54:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 584372E0739
 for <lttng-dev@lists.lttng.org>; Mon, 29 Mar 2021 09:54:04 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 5kJZxsAVMKHu for <lttng-dev@lists.lttng.org>;
 Mon, 29 Mar 2021 09:54:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 384B42E05B5
 for <lttng-dev@lists.lttng.org>; Mon, 29 Mar 2021 09:54:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 384B42E05B5
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id WkCAaTPvRN4b for <lttng-dev@lists.lttng.org>;
 Mon, 29 Mar 2021 09:54:03 -0400 (EDT)
Received: from [10.10.0.241] (wg.multivax.ca [144.217.40.155])
 by mail.efficios.com (Postfix) with ESMTPSA id 26F892E0638
 for <lttng-dev@lists.lttng.org>; Mon, 29 Mar 2021 09:54:03 -0400 (EDT)
To: lttng-dev@lists.lttng.org
References: <18f8e21c-f82a-8a63-fd30-4acbd843cc68@windriver.com>
Message-ID: <da06aa44-d0fa-76df-607c-9713d4799cb4@efficios.com>
Date: Mon, 29 Mar 2021 09:54:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <18f8e21c-f82a-8a63-fd30-4acbd843cc68@windriver.com>
Content-Language: en-US
Subject: Re: [lttng-dev] [BUG lttng-modules] lttng-module compile failed
 with the v5.12 kernel
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2021-03-29 02 h 34, Xu, Yanfei via lttng-dev wrote:
> Hi experts,
> 
> I found a file named lttng-statedump-impl.c in lttng-module is always
> compiled failed. The file use some functions which were export from
> kernel. But the v5.12 kernel unexport them by 'commit bc359d03c7ec
> ("block: add a disk_uevent helper")'.
> 
> The function are disk_part_iter_init()\disk_part_iter_next()
> \disk_part_iter_exit()
> 
> Thanks,
> Yanfei

Hi,

Can you have a look at this patch, it needs more testing :

https://review.lttng.org/c/lttng-modules/+/5050

Thanks,

Michael
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
