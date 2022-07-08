Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DE5C433EF
	for <lttng-dev@archiver.kernel.org>; Fri,  8 Jul 2022 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1657293005;
	bh=8bFhj5L2W+Y/nD/6nyS8nmwQwTC3ZeUg1umyVdegmeY=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=lFDeBw0GsmBXO/l/cgNGa0MoiOZog11qf5ul3ApVC3Z5c3m0ruWxp8RPw2dCCn413
	 DBX0S3zYhLm2+aqewKvM413j0InrImzX9gEB3xQ0W5kwRCdGgvqtFhWuNsi85cJNtn
	 KjQOfHr1evF/iZMhz7ofiKlpQBp4fDQ3l7Oo1G9g4qVqrUcQgpxB/1weckSl7ejBql
	 iLvdRaOJ59WeGYUiPpPkriyUTaErmEvDi+3RIJHEVcTIgYELDOTWN/YAwhTdRqw8fS
	 S3XAXR5jvM+YurpANBryuyjSsUvuPuMbtzdpn8P+6AZ00rMQewGDkokCtFX0UU0L+0
	 A228pflOhaCoA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LfcCJ46nPzL22;
	Fri,  8 Jul 2022 11:10:04 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LfcCH0TRwzL9q
 for <lttng-dev@lists.lttng.org>; Fri,  8 Jul 2022 11:10:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9FFC7433535
 for <lttng-dev@lists.lttng.org>; Fri,  8 Jul 2022 11:10:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 2EkE0v2nF24k; Fri,  8 Jul 2022 11:10:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 20E5C4334C9;
 Fri,  8 Jul 2022 11:10:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 20E5C4334C9
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id rznb7oReeala; Fri,  8 Jul 2022 11:10:01 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 0E9B64332DA;
 Fri,  8 Jul 2022 11:10:01 -0400 (EDT)
Date: Fri, 8 Jul 2022 11:10:01 -0400 (EDT)
To: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, 
 tracecompass-dev <tracecompass-dev@eclipse.org>
Message-ID: <1375343872.61160.1657293001003.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - GC97 (Linux)/8.8.15_GA_4304)
Thread-Index: /Om+YeB+rz2Xpa05KPALAKKLGOkhqg==
Thread-Topic: CTF2-SPECRC-6.0: Common Trace Format version 2 release candidate
Subject: [lttng-dev] CTF2-SPECRC-6.0: Common Trace Format version 2 release
 candidate
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <pproulx@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello,

This is an update of the CTF 2 specification release candidate from
v5.0 to v6.0.

This document, named CTF2-SPECRC-6.0, is available here:

    <https://diamon.org/ctf/files/CTF2-SPECRC-6.0.html>

See the first section, "Revision history", to learn what changed.

As always, please feel free to provide feedback.

Philippe Proulx
EfficiOS Inc.
https://efficios.com/
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
