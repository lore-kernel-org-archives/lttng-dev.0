Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D58C433F5
	for <lttng-dev@archiver.kernel.org>; Fri, 17 Dec 2021 21:12:11 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JG1rn3R6cz1w2H;
	Fri, 17 Dec 2021 16:12:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1639775530;
	bh=Q8vfLPhnt6MkWqH92ETL6US1JaddvhGJIPj8TmBvY00=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=CS0F2aIRTFr8jR7F9rgldi2AyuyghrMJPO8ED7+kX0f3Mrd0JktGiQ0ATePGQBOKn
	 CzqfyvSiD/XdRyHkOLOq+7COWILYFqHX7qQPEhsyVTANQ5ZdpjvsvTbN8Ctb7WeXUv
	 v4CjkQ1FBtHuYIh8ClvUynA+C8Ys12a6A3sMOPeztQA0oZ2PvQlPDo5cLLAR5uCNT6
	 kDFmu0mYaS9r9dhUht7errRc7UWQ40v5n5mrA/x/uOXrdmwmccN9X98kQAs4n5aXpv
	 VZT2MZg87Y8PbrLecyU6GD23+SB51lmzgDTSIwlR3DwFWRyt0hCVve48v9XOWhJ6IA
	 zKY+HvdYmX3+A==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JG1rl4FGKz1wRT
 for <lttng-dev@lists.lttng.org>; Fri, 17 Dec 2021 16:12:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 107623C3124
 for <lttng-dev@lists.lttng.org>; Fri, 17 Dec 2021 16:12:01 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id DoXXCL7p8SaY; Fri, 17 Dec 2021 16:12:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 97CA93C3122;
 Fri, 17 Dec 2021 16:12:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 97CA93C3122
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id I33RU39FJmu7; Fri, 17 Dec 2021 16:12:00 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 8C79E3C3121;
 Fri, 17 Dec 2021 16:12:00 -0500 (EST)
Date: Fri, 17 Dec 2021 16:12:00 -0500 (EST)
To: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, 
 tracecompass-dev <tracecompass-dev@eclipse.org>
Message-ID: <1376185172.1013.1639775520509.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - GC95 (Linux)/8.8.15_GA_4177)
Thread-Index: e+vGDsgJ/OsR/BfIe24DMbqxdy9tPg==
Thread-Topic: CTF2-SPECRC-3.0: Common Trace Format version 2 release candidate
Subject: [lttng-dev] CTF2-SPECRC-3.0: Common Trace Format version 2 release
 candidate
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <pproulx@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello,

This is an update of the CTF 2 specification release candidate from
v2.0 to v3.0.

This document, named CTF2-SPECRC-3.0, is available here:

    <https://diamon.org/ctf/files/CTF2-SPECRC-3.0.html>

See the first section, "Revision history", to learn what changed.

As always, please feel free to provide feedback.

Philippe Proulx
EfficiOS Inc.
https://efficios.com/
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
