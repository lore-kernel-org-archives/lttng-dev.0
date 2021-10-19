Return-Path: <SRS0=8KW7=PH=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E49FC433EF
	for <lttng-dev@archiver.kernel.org>; Tue, 19 Oct 2021 21:13:46 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FE960174
	for <lttng-dev@archiver.kernel.org>; Tue, 19 Oct 2021 21:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2FE960174
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4HYmgr70Yhz1S8V;
	Tue, 19 Oct 2021 17:13:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1634678025;
	bh=RsJY9+2WakP/fl2OgQrH/U0LkwVh1A/dRp42CcFasK8=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=z5ZTfeeYj06pK3EcdeU3IjbYLlSE+IjaWZb1n6cyCQBTkhJ9XbhGf6HnV3eYdQnJt
	 THvMYBbQtWHEMX11V2yZqBGBDDYFT/tGA539IaPnEWoZAB/ViGS7UGCFfPJnPRhrTE
	 GsjPgoPda7QU8z4PX3d7ZAcvDgTpA9clXZJmYDKrcM1LE2I7T7mRvfnE5+BNAYZiWE
	 n+zb7kWx6lI40qOrxF1IqXDzrx+f7pWpbMaUfBAOYiFjLM53elLrLPBjN2v4CGYU0m
	 2B+djKpIElaIhrXoqU0vuP3400GJSiFJ5wUWL1Mnivuy2UHtqOu3fe+7jPKGLXkVtH
	 IXKDimuTNJeqg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4HYmgk1bD3z1RpY
 for <lttng-dev@lists.lttng.org>; Tue, 19 Oct 2021 17:13:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0450C38DFED
 for <lttng-dev@lists.lttng.org>; Tue, 19 Oct 2021 17:13:32 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Q66ukc8qM8sP; Tue, 19 Oct 2021 17:13:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BEEFE38E3B4;
 Tue, 19 Oct 2021 17:13:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BEEFE38E3B4
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id aQr0xKhq5bZb; Tue, 19 Oct 2021 17:13:31 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id B657F38E32E;
 Tue, 19 Oct 2021 17:13:31 -0400 (EDT)
Date: Tue, 19 Oct 2021 17:13:31 -0400 (EDT)
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>, 
 linux-trace-users <linux-trace-users@vger.kernel.org>
Message-ID: <1608072864.21396.1634678011737.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4156 (ZimbraWebClient - GC95 (Linux)/8.8.15_GA_4156)
Thread-Index: qP5k52t409NrIJ6yZg8s/9nd0nGbtw==
Thread-Topic: LTTng-tools 2.12.6 - (Ta) Meilleure
Subject: [lttng-dev] [RELEASE] LTTng-tools 2.12.6 - (Ta) Meilleure
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

We have just released the sixth bug-fix release of LTTng-tools 2.12 - (Ta) 
Meilleure. This release addresses a number of issues listed below. 

2021-10-18 lttng-tools 2.12.6 (National Chocolate Cupcake Day) 
* Fix: sessiond: previously created channel cannot be enabled 
* Fix: ust: app stuck on recv message during UST comm timeout scenario 
* Fix: ust: UST communication can return -EAGAIN 
* Fix: ust: segfault on lttng start on filter bytecode copy 
* Build fix: Missing message in LTTNG_DEPRECATED invocation 
* include: remove spurious spaces in condition/session-rotation.h 
* tests: fix header of regression/ust/getcpu-override/run-getcpu-override 
* fix: wrong define used for GCC version check 
* Fix: userspace-probe: unreported error on string copy error 
* Fix: userspace-probe: truncating binary path for SDT 
* Fix: statements with side-effects in assert statements 
* Fix: lttng_trace_archive_location_serialize is called on freed memory 
* Fix: sessiond: ust session is inactive during ust_app_global_update 
* Fix: Tests: race condition in test_ns_contexts_change 
* Fix: Tests: race condition in test_event_tracker 
* Fix: man: lttng-rotate: trace file count/size limitation does not apply 

As always, please report any issue you may encounter to bugs.lttng.org 
or on this mailing list. 

Project website: https://lttng.org 

Download link: 
https://lttng.org/files/lttng-tools/lttng-tools-2.12.6.tar.bz2 

GPG signature: 
https://lttng.org/files/lttng-tools/lttng-tools-2.12.6.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
