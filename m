Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A49C433EF
	for <lttng-dev@archiver.kernel.org>; Tue,  5 Apr 2022 19:33:52 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KXyW25PPXz24S;
	Tue,  5 Apr 2022 15:33:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1649187231;
	bh=NIs8HIEIuOpBStkd5nsi6WEtamc17NyKorCHEB3jGU4=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Z1OGDgu4ZdlOlCF31S8OnTUR8qDYZaQYpryBcge1M2IFFsb06YeGq8w7op08M7/KH
	 jw9I+tp5I6pkMQUvYUTzgtCacrwDQBEQjZ9qkLpzQw8f7/VUQgQ9ZB9daioQtlmPmQ
	 WHWTwKafE3p9kkj0LzqgEzEoZZehne6uCg5cfeLJfE2jzchiuhZ6lUdXQ3CnIMfCFz
	 Q8ZCzcwN+D4XRuZ8gerbnkFMOFt95WdUgQjRrpupXRe5vboGN6rnJ+PSQ16DiGb5ZS
	 e55c5PBjGiH41tFN0jAxK8ZXDZr29/zVwO70028B9dOUE/xQiKytJJ6yvKo+bHV0pY
	 xcWfchMJQhZQw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KXyW043Btz2CD
 for <lttng-dev@lists.lttng.org>; Tue,  5 Apr 2022 15:33:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 652193BB970
 for <lttng-dev@lists.lttng.org>; Tue,  5 Apr 2022 15:33:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id gqxCoFK4tvOt; Tue,  5 Apr 2022 15:33:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B4B433BBB2F;
 Tue,  5 Apr 2022 15:33:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B4B433BBB2F
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id ipd0z9fZ0iIR; Tue,  5 Apr 2022 15:33:47 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 98E763BB878;
 Tue,  5 Apr 2022 15:33:47 -0400 (EDT)
Date: Tue, 5 Apr 2022 15:33:47 -0400 (EDT)
To: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, 
 tracecompass-dev <tracecompass-dev@eclipse.org>
Message-ID: <1481555190.3990.1649187227493.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4257 (ZimbraWebClient - GC97 (Linux)/8.8.15_GA_4257)
Thread-Index: nMgR3zVo89XTXbOJAaCfWCEdSjUhvA==
Thread-Topic: CTF2-SPECRC-5.0
Subject: [lttng-dev] CTF2-SPECRC-5.0
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
v4.0 to v5.0.

This document, named CTF2-SPECRC-5.0, is available here:

    <https://diamon.org/ctf/files/CTF2-SPECRC-5.0.html>

See the first section, "Revision history", to learn what changed.

As always, please feel free to provide feedback.

Philippe Proulx
EfficiOS Inc.
https://efficios.com/
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
