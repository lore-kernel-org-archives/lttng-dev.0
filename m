Return-Path: <SRS0=8KW7=PH=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAC8C433F5
	for <lttng-dev@archiver.kernel.org>; Tue, 19 Oct 2021 21:13:41 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1E160F8F
	for <lttng-dev@archiver.kernel.org>; Tue, 19 Oct 2021 21:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC1E160F8F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4HYmgk6XRCz1SNJ;
	Tue, 19 Oct 2021 17:13:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1634678019;
	bh=99h3f+EE1EIZC0ahq7Am841T1I0ZM9/DtZpWJOfHAfs=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=niA5q9NwO6gW+G0pk6K7JMCfjRi0XGiX18Mb8u/fFzM8Ix/P356sZI0ZvnrdBmkEc
	 8ZZuDP0/zGowOJIShis4m5kyq/MlRFaXmI/6LdmJueLQ9ANM1ABN8JWXKmyMnhJG77
	 gUUQoARGmWkfsXOTgrqtU1/AoolIB2TJqDiwvuVXnZ6wfNOBenuRvC40Iwr3S1KTGE
	 gt/OV3eHCigSYMe0ryCdwgt1sfLma2bXUu3dPXuWXgCzxi32IiwniDswFCQoUTsTyo
	 u3/yX+Spp5GLQ+f+7I79Yk9JGYVESWpkEEQr9DIHbP/8285ZI4rVI0yKMrQyqFptp3
	 YE3lVp/oZ5LYw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4HYmgh3Fysz1RpV
 for <lttng-dev@lists.lttng.org>; Tue, 19 Oct 2021 17:13:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1CEB338E21B
 for <lttng-dev@lists.lttng.org>; Tue, 19 Oct 2021 17:13:30 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id sZWRxeE9KGUC; Tue, 19 Oct 2021 17:13:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 869E238E502;
 Tue, 19 Oct 2021 17:13:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 869E238E502
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id RXrMGJkFp8Qv; Tue, 19 Oct 2021 17:13:29 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 7B1EE38E501;
 Tue, 19 Oct 2021 17:13:29 -0400 (EDT)
Date: Tue, 19 Oct 2021 17:13:29 -0400 (EDT)
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>, 
 linux-trace-users <linux-trace-users@vger.kernel.org>
Message-ID: <1790858757.21395.1634678009452.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4156 (ZimbraWebClient - GC95 (Linux)/8.8.15_GA_4156)
Thread-Index: gHgpWheTuGaoeqqfOAFvu91eb/lhiA==
Thread-Topic: LTTng-tools 2.11.8 - Lafontaine
Subject: [lttng-dev] [RELEASE] LTTng-tools 2.11.8 - Lafontaine
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all, 

We have just released the eighth and final bug-fix release of LTTng-tools 2.11 - 
Lafontaine. This release addresses the issues listed below. 

2021-10-18 lttng-tools 2.11.8 (National Chocolate Cupcake Day) 
* Fix: sessiond: previously created channel cannot be enabled 
* Fix: ust: app stuck on recv message during UST comm timeout scenario 
* Fix: ust: UST communication can return -EAGAIN 
* Fix: ust: segfault on lttng start on filter bytecode copy 
* Build fix: Missing message in LTTNG_DEPRECATED invocation 
* include: remove spurious spaces in condition/session-rotation.h 
* fix: wrong define used for GCC version check 
* Fix: userspace-probe: unreported error on string copy error 
* Fix: userspace-probe: truncating binary path for SDT 
* Fix: sessiond: ust session is inactive during ust_app_global_update 
* Fix: man: lttng-rotate: trace file count/size limitation does not apply 
* Fix: rotation client example: leak of handle on error 
* Fix: use of uninitialised bytes valgrind warning 
* Fix: bump minimal urcu dependency to 0.11 
* Fix: list_lttng_agent_events: unbalanced RCU read-side lock on error 
* Fix: consumer: unbalanced RCU read-side lock on error 

As always, please report any issue you may encounter to bugs.lttng.org 
or on this mailing list. 

Project website: https://lttng.org 

Download link: 
https://lttng.org/files/lttng-tools/lttng-tools-2.11.8.tar.bz2 

GPG signature: 
https://lttng.org/files/lttng-tools/lttng-tools-2.11.8.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
