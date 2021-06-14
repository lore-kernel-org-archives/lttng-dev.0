Return-Path: <SRS0=S5hD=LI=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FE3C2B9F4
	for <lttng-dev@archiver.kernel.org>; Mon, 14 Jun 2021 20:01:06 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6486124B
	for <lttng-dev@archiver.kernel.org>; Mon, 14 Jun 2021 20:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6486124B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4G3j4S2Y0rzCGN;
	Mon, 14 Jun 2021 16:00:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1623700857;
	bh=LamtaIWKM77NXqnyC3wV43krGtlozziYBzZgBMkGfww=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=WWeeqCKgSf1oneh0KRFPxnITUInVuUJ9oYUbX5BIkyrM2YrAHRJeEllex8Mq3lwJF
	 3JD5+E8DZSyxNilZR6nvEAhDMf8qjEB8sr4nuGVvvMBCcGr0SPXMQD3LdJLKvBIk9t
	 bWVuAZqDIBYi4hl07nL8ZnDTkHh/uVUSMMlcLPHLQ0wDnm+3JVqh7OiBtihA+BS82s
	 0cXP2Jgc1LvRkr8MYFH2M3w9qC5U/wEVbj9l5ixCV43UbQc25hQm0a4piUq+FJwqi6
	 fHG9nJ0hJw6Qe2HOv43oQefs0TgiaiMmZBougQz8ng9dKfHx/4OVgaJ08BkzCdcVX3
	 VBNPrrWKvHtDQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4G3j4Q0Z4JzCG9
 for <lttng-dev@lists.lttng.org>; Mon, 14 Jun 2021 16:00:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B61CB338C37;
 Mon, 14 Jun 2021 16:00:47 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id RqnuwsdBNjmw; Mon, 14 Jun 2021 16:00:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3B1EC338C36;
 Mon, 14 Jun 2021 16:00:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3B1EC338C36
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 1eXn_aLqtaBg; Mon, 14 Jun 2021 16:00:47 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 2CFC9338C35;
 Mon, 14 Jun 2021 16:00:47 -0400 (EDT)
Date: Mon, 14 Jun 2021 16:00:47 -0400 (EDT)
To: Philippe Proulx <pproulx@efficios.com>, 
 Jeremie Galarneau <jgalar@efficios.com>, rostedt <rostedt@goodmis.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1119833442.5505.1623700847146.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF89 (Linux)/8.8.15_GA_4026)
Thread-Index: JSQsPrsm8IjR1ZwU6ECTP0Qsydf7og==
Thread-Topic: Usage example of libbabeltrace (babeltrace2) to read CTF traces
 from a GUI
Subject: [lttng-dev] Usage example of libbabeltrace (babeltrace2) to read
 CTF traces from a GUI
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Philippe, Hi Jeremie,

Steven is interested to use libbabeltrace as a CTF trace reader in the KernelShark
project. It's a GUI which shows Linux kernel traces.

He notices that most of the documented usage examples of the libbabeltrace API
focus on use-cases where a custom trace format is converted into CTF.

I know that the babeltrace2 program is the main user of libbabeltrace at this
point, and that it reads CTF as source.

For using libbabeltrace as CTF reader for a GUI, what would be the best examples
to look at as starting point ? Perhaps the babeltrace2 binary, or just adapt a
smaller example program and change the custom trace format source to "ctf.fs" ?
Or anything else ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
