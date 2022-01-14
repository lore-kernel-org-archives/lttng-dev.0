Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B5DC433EF
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Jan 2022 19:39:12 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JbBSb03HRzFcl;
	Fri, 14 Jan 2022 14:39:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642189151;
	bh=ccBAUZiN7izL3y1O3kQxLrHK2IA+qH9r/N/WsbAtPqQ=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=USJJYcyKt2fWZz5LHdTvXgZ5fy0rd9ehVjCm7Qt24cZ8pV4gLpOWRHwgSXZKkFbS4
	 zFdp6n9d0qI+OV7LHXlAEXN4NyNwxcwFwSMySRYBmKLK7HvA3/ZL+TKS29NX8ZDJkK
	 4T3aOu8mS/jsYLNR1cxMlwEg3+VRa5uCku9v71gG4e+wlgV2Ax4eEFGyHl9TCb9DZ/
	 p1Ly4oqKKR3Key6QHjZB2R2Ldi8zYFuHLw5r1XD+aObBn64UlkCZuhDNIVQXMcekDt
	 tPocI+9UULpqhaF+doUf9toLqcbJnHAoK/efMX8GpPQJKQ1wEEYM6FBpVYvrtzUsmF
	 i6qO5DtSHaL0Q==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JbBSZ3LjDzF4W
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jan 2022 14:39:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2DAA82D570C;
 Fri, 14 Jan 2022 14:39:04 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ueWmuq4b4K6P; Fri, 14 Jan 2022 14:39:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D1AA52D570A;
 Fri, 14 Jan 2022 14:39:03 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D1AA52D570A
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 7ELJln-Z9EHt; Fri, 14 Jan 2022 14:39:03 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id C5FBB2D561F;
 Fri, 14 Jan 2022 14:39:03 -0500 (EST)
Date: Fri, 14 Jan 2022 14:39:03 -0500 (EST)
To: Simon Marchi <simon.marchi@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, 
 Jeremie Galarneau <jgalar@efficios.com>
Message-ID: <1406131863.33975.1642189143774.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Index: EtEvCSbRggwgMDVTddKLaRGfW2ePxw==
Thread-Topic: Transfer of LTTng copyright ownership: Simon Marchi
Subject: [lttng-dev] Transfer of LTTng copyright ownership: Simon Marchi
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

Hi Simon,

In order to facilitate maintenance of the LTTng project, would you agree to
transfer your copyright ownership for code authored outside of your employment
at EfficiOS to EfficiOS Inc. ?

This particularly affects the lttng-tools files with copyright:

Copyright (C) 201N Simon Marchi <simon.marchi@polymtl.ca>

Thank you!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
