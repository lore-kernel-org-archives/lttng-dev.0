Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEDBC433EF
	for <lttng-dev@archiver.kernel.org>; Wed,  2 Mar 2022 15:54:31 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4K7zFf0szVz5dV;
	Wed,  2 Mar 2022 10:54:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1646236470;
	bh=UA41qYKzknXfX9nkn5EJpCKIoEq3QLf1qaHodBZV9FM=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=PEOZ43DUkXsFcxbtsHtvHBB9Uk9tOV4CUnmHTh0z2jsbStmxykDLgEyDKzOKUOG6R
	 U30beCRkYLcAqS6uJg/FzXhal4T5awjp6diCXixC2Go7QxOtvIY9ezVfvKgOs+bwh6
	 tD5uUXSqUwU9ZbtVpA7S8wwG4ztFkdBVAcJBuoQEy3u/87zJtAVLnaYEQtbfsTNczf
	 1yQgUwVaod8ta+x9Mt63HE1GrLvjqXAsBu4aoAarGu43ZyCY2LcSXXKcOrJxOnW2MI
	 xT5w0yfKupGK4V47PyxKr58/144KIVomCbhLUrg87wQuWWaqOpZeHWU6eV8Pj87itq
	 nb2Y20Fbxo4vg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4K7zFc4KX7z61g
 for <lttng-dev@lists.lttng.org>; Wed,  2 Mar 2022 10:54:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3B86D2AC37A
 for <lttng-dev@lists.lttng.org>; Wed,  2 Mar 2022 10:54:22 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ATGncwutdR6C; Wed,  2 Mar 2022 10:54:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D521A2AC5E0;
 Wed,  2 Mar 2022 10:54:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D521A2AC5E0
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id eIJttZFTFHfa; Wed,  2 Mar 2022 10:54:21 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id BF2CF2AC75A;
 Wed,  2 Mar 2022 10:54:21 -0500 (EST)
Date: Wed, 2 Mar 2022 10:54:21 -0500 (EST)
To: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, 
 tracecompass-dev <tracecompass-dev@eclipse.org>
Message-ID: <2040140140.117193.1646236461745.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - GC97 (Linux)/8.8.15_GA_4232)
Thread-Index: qiw89w3TbibMvcPC/VwUBZnbwrSMXg==
Thread-Topic: CTF2-SPECRC-4.0: Common Trace Format version 2 release candidate
Subject: [lttng-dev] CTF2-SPECRC-4.0: Common Trace Format version 2 release
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
v3.0 to v4.0.

This document, named CTF2-SPECRC-4.0, is available here:

    <https://diamon.org/ctf/files/CTF2-SPECRC-4.0.html>

See the first section, "Revision history", to learn what changed.

As always, please feel free to provide feedback.

Philippe Proulx
EfficiOS Inc.
https://efficios.com/
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
