Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7E3C433F5
	for <lttng-dev@archiver.kernel.org>; Fri, 17 Dec 2021 19:03:16 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JFz033TH3z1w4d;
	Fri, 17 Dec 2021 14:03:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1639767796;
	bh=R3/FquWE/jRAOsglpV9L2p4rLvqJ9RKEcd/7IsaWcVs=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=KbeRgKsyNcTy9uqQJQm/unfe85Xhs7Ads/4bogrkMlawW+I0bllrcdZtlf53Ep88F
	 MuRCJ+paxniQiehyY9sSYD8lavrRrpgnpZmAnRPQhUIooIiTXDobkWta+vHidu0Cfp
	 KCmWF2B38fVrsD7XZnFhzyXTA0VctpM37TbN0NRqu4JB4Bir/lTUQn8wYf44KvuyFs
	 gJ/QPuDe2YRvi3lL+RTnE3YOccvA8ddJ0VdpY07X5Rrb2zTQsCTwKqc24l13pxZVVB
	 NgKqc+vL3hjgjYoBtxgzyOmynevh10UDW1TdkcDlZR0N/PtpjKWhwQIOmD7uBbWM9y
	 TcFeJcUEcUZgA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JFz010GFZz1vtY
 for <lttng-dev@lists.lttng.org>; Fri, 17 Dec 2021 14:03:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CD8EE3C2605
 for <lttng-dev@lists.lttng.org>; Fri, 17 Dec 2021 14:03:06 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id UWG1UnloVw-Z; Fri, 17 Dec 2021 14:03:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 617563C2339;
 Fri, 17 Dec 2021 14:03:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 617563C2339
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id fffHH_yVda8l; Fri, 17 Dec 2021 14:03:06 -0500 (EST)
Received: from carbonara (unknown [107.159.88.171])
 by mail.efficios.com (Postfix) with ESMTPSA id 345423C2433;
 Fri, 17 Dec 2021 14:03:06 -0500 (EST)
Date: Fri, 17 Dec 2021 14:03:05 -0500
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Message-ID: <Ybze6ZpA95wGqjUv@carbonara>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [RELEASE] LTTng-tools 2.12.7 - (Ta) Meilleure
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released the seventh bug-fix release of LTTng-tools 2.12 - (Ta)
Meilleure. This release addresses a number of issues listed below.

2021-12-17 lttng-tools 2.12.7 (National Ugly Christmas Sweater Day)
	* Validate channel context mismatch across UST applications
	* Fix: relayd: compare viewer chunks by ID rather than address
	* Fix: relayd: live: erroneous message timestamp observed from live viewer
	* Fix: relayd comm: improperly packed rotate streams command header
	* test: snapshot after regenerate metadata
	* Fix: ust-consumer: segfault on snapshot after regenerate metadata
	* Tests: live kernel: no plan printed when non-root
	* Fix: sessiond: snapshot: leak of trace chunk
	* Fix: test: use BABELTRACE_BIN instead of babeltrace
	* Fix: relayd: `!vsession->current_trace_chunk` assertion failed
	* Fix: tests: fix unused-but-set warning in test_fd_tracker.c
	* Fix: sessiond: fix possible buffer overflow warning
	* Fix: lttng-ctl: tracing_group memory leaks
	* Fix: Tests: unchecked `close()` return value
	* Fix: relayd: live: mishandled initial null trace chunk
	* Fix: configure.ac: reporting SDT uprobe as a UST feature
	* Fix: Tests: leaking epoll fd

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.7.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.7.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
