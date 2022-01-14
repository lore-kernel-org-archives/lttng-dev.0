Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC433C433EF
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Jan 2022 19:50:01 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JbBj474DzzFjH;
	Fri, 14 Jan 2022 14:50:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642189801;
	bh=lo9EL51Q23aElltwDCKv5viU2lp98W+mbYce5W7pJ/o=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kZ0qTc9IkvuFLJqfkFIKvxgbwI+GkU/RrIPHQfld0cCi5P+q+Dp/FmtDET1xcnxlk
	 spNq4L3yD3SwlqCn/m4RrhCr4cawily2U4VAWtyfO33CI9QCHIL+JxRy2D5EmoFZZT
	 GnYktHHhdiZwXl8mI+f0JWTrReQIVNjgjgnxdEDkbG1crQv2bAD/1E91FY93VFJ0Z1
	 XhFRDiSsPq1RyuB93CmBhbD4+EzzDeLWeHVra6o8+z2cImD211wi3g5PWsdHnPXMWS
	 G+GPM4B6LFzSegYJLsGnR8TRy+Z/BVxyvNoKLv4K8xKZsWy8V+4EF3EcIZE90xb/Zx
	 RjGwuUimcu+Tg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JbBj43mbYzF9Y
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jan 2022 14:50:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7DE6E2D58ED;
 Fri, 14 Jan 2022 14:50:00 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 8GUU1IQLglSV; Fri, 14 Jan 2022 14:50:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 053DA2D54E3;
 Fri, 14 Jan 2022 14:50:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 053DA2D54E3
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id x51pJKdXJ8bM; Fri, 14 Jan 2022 14:49:59 -0500 (EST)
Received: from [172.16.0.95] (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 by mail.efficios.com (Postfix) with ESMTPSA id D31362D54E0;
 Fri, 14 Jan 2022 14:49:59 -0500 (EST)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>,
 Jeremie Galarneau <jgalar@efficios.com>
References: <1406131863.33975.1642189143774.JavaMail.zimbra@efficios.com>
Message-ID: <57f1e848-56d0-7c0a-d99c-d41d13b0a3c6@efficios.com>
Date: Fri, 14 Jan 2022 14:49:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1406131863.33975.1642189143774.JavaMail.zimbra@efficios.com>
Content-Language: tl
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
From: Simon Marchi via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Simon Marchi <simon.marchi@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-01-14 2:39 p.m., Mathieu Desnoyers wrote:
> Hi Simon,
> 
> In order to facilitate maintenance of the LTTng project, would you agree to
> transfer your copyright ownership for code authored outside of your employment
> at EfficiOS to EfficiOS Inc. ?
> 
> This particularly affects the lttng-tools files with copyright:
> 
> Copyright (C) 201N Simon Marchi <simon.marchi@polymtl.ca>
> 
> Thank you!
> 
> Mathieu

Yes.

Thanks,

Simon
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
