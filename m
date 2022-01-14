Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822CBC433F5
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Jan 2022 20:12:31 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JbCC24m5RzFdJ;
	Fri, 14 Jan 2022 15:12:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642191150;
	bh=QYKjwvvsA7TfZGhf5mfeD4oTq2Xj54xAui7LZedYlqA=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YLVjwU1DUPFHFYskjm0atf0argKjn/fSZvhSRjlQbFKwa5LR9QRSfK6CVReWJbJ+i
	 UOPkovy3p3Qvmm2urvlVG35lPsnShlI+LckchCqjMmnTWpia1bxGYXosR+dwy9ype4
	 fvp+/e99L9gUzJpEt7rPMcC1pE61krhJtfsOMpLBgofO0Hfp/4JdPAOeuLLyawL0fX
	 BWEaPAgRxb7ol3r7vF9e4aa8+9OQ1ELCllfMUpRN/F/hlRbdlxba3YuLNwS7hjx3sF
	 6TWTSQawLFsLjyUC7EmOwKug7m9uJjUByJrwHRdvhhJvrOAyHmigxAjbnP7Q9ARn7T
	 5B8gVsNnGo/HA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JbCC05DMSzFPs
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jan 2022 15:12:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B05112D5B5E;
 Fri, 14 Jan 2022 15:12:28 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Z0zk9tuqJC_F; Fri, 14 Jan 2022 15:12:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 85C502D5B5B;
 Fri, 14 Jan 2022 15:12:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 85C502D5B5B
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id P1WhCxFo_7RA; Fri, 14 Jan 2022 15:12:28 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 7599F2D5308;
 Fri, 14 Jan 2022 15:12:28 -0500 (EST)
Date: Fri, 14 Jan 2022 15:12:28 -0500 (EST)
To: Simon Marchi <simon.marchi@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, 
 Jeremie Galarneau <jgalar@efficios.com>
Message-ID: <516333253.34107.1642191148459.JavaMail.zimbra@efficios.com>
In-Reply-To: <57f1e848-56d0-7c0a-d99c-d41d13b0a3c6@efficios.com>
References: <1406131863.33975.1642189143774.JavaMail.zimbra@efficios.com>
 <57f1e848-56d0-7c0a-d99c-d41d13b0a3c6@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: Transfer of LTTng copyright ownership: Simon Marchi
Thread-Index: gxTq7En4Yk7g8Lci3YJDrgoX6Xk3jw==
Subject: Re: [lttng-dev] Transfer of LTTng copyright ownership: Simon Marchi
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



----- On Jan 14, 2022, at 2:49 PM, Simon Marchi simon.marchi@efficios.com wrote:

> On 2022-01-14 2:39 p.m., Mathieu Desnoyers wrote:
>> Hi Simon,
>> 
>> In order to facilitate maintenance of the LTTng project, would you agree to
>> transfer your copyright ownership for code authored outside of your employment
>> at EfficiOS to EfficiOS Inc. ?
>> 
>> This particularly affects the lttng-tools files with copyright:
>> 
>> Copyright (C) 201N Simon Marchi <simon.marchi@polymtl.ca>
>> 
>> Thank you!
>> 
>> Mathieu
> 
> Yes.

Great, I will CC you on the patches applying the copyright ownership transfer.
Please reply to them publicly with your Signed-off-by tag so I can add it
before merging them.

Thanks,

Mathieu

> 
> Thanks,
> 
> Simon

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
