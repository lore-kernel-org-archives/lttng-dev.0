Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503BBC433EF
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Jan 2022 20:12:40 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JbCCC161RzFlw;
	Fri, 14 Jan 2022 15:12:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642191159;
	bh=yx3c1EZ+4JCJKriAuB0GSyHoizpZyMkO1izn1vbDCMg=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=xO7AIjuF2E9t2kJOu2vXbhGp4OxWuq6L7ynKn6NQlrEwfLwCwvt0NWTZi8njDuNlj
	 aGxca4RsvF4VYr3BFLeIVM/ijr6Yb520DanwY8BJ7EAbutKT3xZ5nCeo2hVDQTHDz2
	 Iymx0XZYMRK93Fg+xIReZl66sCRkWVfLm3MWQELRo0CojUjlTy0o0ZVektl3pArQff
	 vyxM9K3C79+RVYHLkj6nfQYy6AwJPe4DM8CKniu8cEZkY162wiKRxq0Lb9riuLZUCh
	 ACd2aFJ4xfsEnBNvlgCl95oyFRoWHfzipCWtxCVwwJcqCEViMj0VAuPjVpOnagJWoo
	 hLZW075NPsnyw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JbCCB431HzFVL
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jan 2022 15:12:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 707CB2D5CAD;
 Fri, 14 Jan 2022 15:12:38 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id EzGVK7zS72Q6; Fri, 14 Jan 2022 15:12:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B2D3F2D5CAA;
 Fri, 14 Jan 2022 15:12:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B2D3F2D5CAA
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Vlegl6LbU4ky; Fri, 14 Jan 2022 15:12:37 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id AAEF32D5BB6;
 Fri, 14 Jan 2022 15:12:37 -0500 (EST)
Date: Fri, 14 Jan 2022 15:12:37 -0500 (EST)
To: David Goulet <dgoulet@ev0ke.net>
Cc: Jeremie Galarneau <jgalar@efficios.com>, 
 lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <309056741.34108.1642191157681.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220114193458.xkbuemzdpdxnk5sz@raoul>
References: <1116808546.33968.1642188662159.JavaMail.zimbra@efficios.com>
 <20220114193458.xkbuemzdpdxnk5sz@raoul>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: Transfer of LTTng copyright ownership: David Goulet
Thread-Index: kaBfIrBYlpiGZuELx1+CBR5Dc+mmhQ==
Subject: Re: [lttng-dev] Transfer of LTTng copyright ownership: David Goulet
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Jan 14, 2022, at 2:34 PM, David Goulet dgoulet@ev0ke.net wrote:

> On 14 Jan (14:31:02), Mathieu Desnoyers wrote:
>> Hi David,
>> 
>> In order to facilitate maintenance of the LTTng project, would you agree to
>> transfer your copyright ownership for code authored outside of your employment
>> at EfficiOS to EfficiOS Inc. ?
>> 
>> This particularly affects the lttng-tools and lttng-ust files with copyright:
>> 
>> Copyright (C) 201N David Goulet <david.goulet@polymtl.ca>
> 
> No problem.
> 
> I agree and this email is GPG signed :).

Great, I will CC you on the patches applying the copyright ownership transfer.
Please reply to them publicly with your Signed-off-by tag so I can add it
before merging them.

Thanks,

Mathieu

> 
> Cheers!
> David
> 
> --
> xtN36bqNuwFHhNp1j45nwcCwE5HeLkdFZT9naRvLgG0=

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
