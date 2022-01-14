Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13353C433F5
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Jan 2022 20:12:25 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JbCBv6WsvzFSC;
	Fri, 14 Jan 2022 15:12:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642191144;
	bh=qGwkbxYJ6FXNLKNi3TtHGLe30VQdwengVnpBvBGpzIs=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=HY78Qpb7GrFzPgIc/m/igoTBUDeXhtSQDhWhIfZoNESLKlQ0B6GIb4nKPIGYh/Sgh
	 5JMJtQHvyBJ4NURs1BTbVpQQ30kiMVcYqiddDd9opQQVOIupkPlVp542BLKQOZWuLn
	 Vd/wSg0aXGwbW8p6tgnThL+CjYIvX6h/alez/JLaS6GRC0Vs36Ll3oMgEXucdPWV9K
	 ZblxgUaFzoeYBMw1B/uLJL3w82Qv++V8N2KJK7Q1IbO+vB7WPe8QYqmmgPKEWTu3kD
	 VvELzPtIxwZuO2EG4TLj3hrbKfaG/IYKt+Nu9dfjkzteu64HxNtG1efjRB682xk8gm
	 MbXfk5UtVoy5g==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JbCBt2ZGHzFCt
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jan 2022 15:12:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 185282D5D17;
 Fri, 14 Jan 2022 15:12:16 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id aMPSN0wGrDZE; Fri, 14 Jan 2022 15:12:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C262C2D5A66;
 Fri, 14 Jan 2022 15:12:15 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C262C2D5A66
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id HW59XR8-D4m9; Fri, 14 Jan 2022 15:12:15 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id AE20E2D52F2;
 Fri, 14 Jan 2022 15:12:15 -0500 (EST)
Date: Fri, 14 Jan 2022 15:12:15 -0500 (EST)
To: Julien Desfossez <ju@klipix.org>
Cc: Jeremie Galarneau <jgalar@efficios.com>, 
 lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <25936100.34106.1642191135598.JavaMail.zimbra@efficios.com>
In-Reply-To: <f43c86fa-3f65-c97a-e411-44bb886845e4@klipix.org>
References: <212959050.34078.1642189743892.JavaMail.zimbra@efficios.com>
 <f43c86fa-3f65-c97a-e411-44bb886845e4@klipix.org>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: Transfer of LTTng copyright ownership: Julien Desfossez
Thread-Index: Maw6Rl6mciXMKpuFP1bOHhn0cjxafQ==
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Jan 14, 2022, at 2:51 PM, Julien Desfossez ju@klipix.org wrote:

> On 2022-01-14 2:49 p.m., Mathieu Desnoyers wrote:
>> Hi Julien,
>> 
>> In order to facilitate maintenance of the LTTng project, would you agree to
>> transfer your copyright ownership for code authored outside of your employment
>> at EfficiOS to EfficiOS Inc. ?
>> 
>> This particularly affects the lttng-tools, lttng-ust and lttng-modules files
>> with copyright:
>> 
>> Copyright (C) 201N Julien Desfossez <julien.desfossez@polymtl.ca>
> Yes, no problem !

Great, I will CC you on the patches applying the copyright ownership transfer.
Please reply to them publicly with your Signed-off-by tag so I can add it
before merging them.

Thanks,

Mathieu

> 
>> Thanks for all your contributions to LTTng !
>> 
>> Mathieu
> 
> Thanks !
> 
> Julien

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
