Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB47C433F5
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Dec 2021 14:23:39 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4J8x961Ffyz1s6N;
	Thu,  9 Dec 2021 09:23:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1639059818;
	bh=p8qr71+vsi9TWGgaQWgHZsr7RLP7YiaNs7mVtUBq6MQ=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=UCWDEtVM+nkD51p/L2WUUNLflu6FfeAiNvPTjMLRK36QLdbG8/sICzd0LL6vJoT5c
	 iQan6ftbiuVmimQkzvWhMOFXUUW8qEcqfI7NjjNiRszloVqVHLPK0Tfm34dL/ZsXO5
	 8t4haNyq57Dvb9FbObPGIIOucKWGQ/8v6ehpO+0T9nVW+XT1nar7mDIp1LUKkWPlG0
	 Y8hctUIhRUTc1OETuhj+x7oLWaLxAd0c1UPK2kAwDLfvlaJURnEtxoPC5lkCFPEm42
	 tek3A/xRpemRcLpuEWUxDBZjZ1bNOef8xmkFaDBH+2H+4uzMEDxMgkarfbWf1VcuFj
	 uKY0lV3jmmfhg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4J8x941Wdvz1s1f
 for <lttng-dev@lists.lttng.org>; Thu,  9 Dec 2021 09:23:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B16D735BA9F
 for <lttng-dev@lists.lttng.org>; Thu,  9 Dec 2021 09:23:29 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Z4FuUbOTGlHy; Thu,  9 Dec 2021 09:23:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2E94D35BA9B;
 Thu,  9 Dec 2021 09:23:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2E94D35BA9B
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 3F93CnWaAaLa; Thu,  9 Dec 2021 09:23:29 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 238EA35BA63;
 Thu,  9 Dec 2021 09:23:29 -0500 (EST)
Date: Thu, 9 Dec 2021 09:23:29 -0500 (EST)
To: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, 
 tracecompass-dev <tracecompass-dev@eclipse.org>
Message-ID: <130357451.24324.1639059809107.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4173 (ZimbraWebClient - GC95 (Linux)/8.8.15_GA_4177)
Thread-Index: VT1cP9wV5LG2unxLTbL6j5jXbE9/JQ==
Thread-Topic: CTF2-SPECRC-2.0: Common Trace Format version 2 release candidate
Subject: [lttng-dev] CTF2-SPECRC-2.0: Common Trace Format version 2 release
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
v1.0 to v2.0.

This document, named CTF2-SPECRC-2.0, is available here:

    <https://diamon.org/ctf/files/CTF2-SPECRC-2.0.html>

Although it's a major bump because there are breaking changes, there
aren't a lot of changes since CTF2-SPECRC-1.0. See the first section,
"Revision history", to learn what changed.

As always, please feel free to provide feedback.

Philippe Proulx
EfficiOS Inc.
https://efficios.com/
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
