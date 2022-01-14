Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E44C433F5
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Jan 2022 20:01:33 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JbByN607PzFZ5;
	Fri, 14 Jan 2022 15:01:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642190493;
	bh=xBCmO4W6Fw2q1Yu0iCiC62l+sQHSXRlEi/zCjGTHIOc=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KY471JK20svfHEdKrHk4wcHfWjy4WoCYfbIamI6ZmpzNo8JDNvfOQmigGbtmFnv4M
	 n3ITmDtHgRDW1pzrT0LsJHcl6nk5VxSat8yb24DTNvy+W0yoPJLARiwgXyDJc9J4M3
	 EVum+mYYflvJOu7BJ7cSbS5se/zH67MimsLvvLVLOmeo16TwxD4lntVceMWzB0E/kf
	 5TtFuttBvZQfdmOh1Cfre/n6IyIazEItesdhQ2vZJDpLg2c1PfNklVm6L4e9GClJI+
	 pxDsWQKxhAUm2IRbI3mmd2Qclgakh1v1y2W9iF3os22DGL5L45XAT40dIqYK0HWgXn
	 DjzLE/BXt1QFA==
Received: from fukushima.klipix.org (fukushima.klipix.org [85.12.144.25])
 by lists.lttng.org (Postfix) with ESMTPS id 4JbBkr6QbkzFgK
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jan 2022 14:51:32 -0500 (EST)
Received: from [192.168.1.124] (unknown [192.222.196.137])
 by fukushima.klipix.org (Postfix) with ESMTPSA id 4B0334602C5;
 Fri, 14 Jan 2022 20:51:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.9.1 fukushima.klipix.org 4B0334602C5
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jeremie Galarneau <jgalar@efficios.com>,
 lttng-dev <lttng-dev@lists.lttng.org>
References: <212959050.34078.1642189743892.JavaMail.zimbra@efficios.com>
Message-ID: <f43c86fa-3f65-c97a-e411-44bb886845e4@klipix.org>
Date: Fri, 14 Jan 2022 14:51:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <212959050.34078.1642189743892.JavaMail.zimbra@efficios.com>
Content-Language: en-US
X-Mailman-Approved-At: Fri, 14 Jan 2022 15:01:31 -0500
Subject: Re: [lttng-dev] Transfer of LTTng copyright ownership: Julien
 Desfossez
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
From: Julien Desfossez via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Julien Desfossez <ju@klipix.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-01-14 2:49 p.m., Mathieu Desnoyers wrote:
> Hi Julien,
> 
> In order to facilitate maintenance of the LTTng project, would you agree to
> transfer your copyright ownership for code authored outside of your employment
> at EfficiOS to EfficiOS Inc. ?
> 
> This particularly affects the lttng-tools, lttng-ust and lttng-modules files
> with copyright:
> 
> Copyright (C) 201N Julien Desfossez <julien.desfossez@polymtl.ca>
Yes, no problem !

> Thanks for all your contributions to LTTng !
> 
> Mathieu

Thanks !

Julien
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
