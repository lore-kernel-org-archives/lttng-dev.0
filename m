Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31929C433EF
	for <lttng-dev@archiver.kernel.org>; Fri, 17 Dec 2021 19:01:22 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JFyxr3ydhz1wJf;
	Fri, 17 Dec 2021 14:01:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1639767681;
	bh=IPZl0XLyEhlWfwU2Ezbm72sc0uF6xrKmDE4ndWhB7UM=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=gTAyohu7yNpq/XMRWreM7xJAIXhZN4eqhyxU/4JNDfszLMomoCMrE+f2fgUnEqUYE
	 trcigBOFUe5zKN3HRKEHl7i3GCUNaaHhwdtb8jimz+wa18KLov8RSZxN/tOM6UzFHP
	 AeI6/XYcjEsA4m0nRBD9KdgtNZqD9puie0Xnc9gyPO1OL6m+8IBNN3tItea1mK2ayJ
	 5Z4F9isTqCV7Wk+tYI0DayVNr5fCrVOK6EViHQmdGtRD9CSxgfRlTuTXFsZ0fnwBJv
	 5hfCPpZNVWNOiyjBNKFVNxbIRMqwEY5ePijSyZ5j/3Xf+i2UNzadwB5ArjLaMo7p9y
	 F+O1r3pPwRSNw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JFyxq40xNz1wJc
 for <lttng-dev@lists.lttng.org>; Fri, 17 Dec 2021 14:01:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 006CE3C25A6
 for <lttng-dev@lists.lttng.org>; Fri, 17 Dec 2021 14:01:13 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 7R8K8EQ8VgxH; Fri, 17 Dec 2021 14:01:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DBAEC3C2165;
 Fri, 17 Dec 2021 14:01:11 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DBAEC3C2165
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id hmRjV0ChLmLr; Fri, 17 Dec 2021 14:01:11 -0500 (EST)
Received: from carbonara (unknown [107.159.88.171])
 by mail.efficios.com (Postfix) with ESMTPSA id AE51D3C2263;
 Fri, 17 Dec 2021 14:01:11 -0500 (EST)
Date: Fri, 17 Dec 2021 14:01:11 -0500
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Message-ID: <Ybzed+wMHvpvQ3Pz@carbonara>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] =?iso-8859-1?q?=5BRELEASE=5D_LTTng-tools_2=2E13=2E2_?=
 =?iso-8859-1?q?-_Nordicit=E9?=
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released the second bug-fix release of LTTng-tools 2.13 - Nord=
icit=E9.
This release addresses a number of issues listed below.

2021-12-17 lttng-tools 2.13.2 (National Ugly Christmas Sweater Day)
	* Validate channel context mismatch across UST applications
	* Fix: relayd: compare viewer chunks by ID rather than address
	* Fix: relayd: live: erroneous message timestamp observed from live viewer
	* Fix: relayd comm: improperly packed rotate streams command header
	* Test: snapshot after regenerate metadata
	* Fix: ust-consumer: segfault on snapshot after regenerate metadata
	* lttng: list valid condition / action names if missing or unknown
	* lttng: mention argument number on unknown action / condition name
	* lttng: fix argument numbers in add-trigger error messages
	* argpar-utils: tweak unknown option error message
	* argpar: sync with upstream - adjust to iterator API
	* common: move append_str to string-utils
	* lttng-create(1): specify that `--shm-path` only applies to UST channels
	* Fix: sessiond: action-executor: misquoted strings in logging
	* Tests: live kernel: no plan printed when non-root
	* Fix: sessiond: assert on lttng_ht_add_unique_str on ltt_sessions_ht_by_n=
ame
	* Fix: sessiond: snapshot: leak of trace chunk
	* Fix: test: use BABELTRACE_BIN instead of babeltrace
	* Fix: action executor: ref count imbalance for session object
	* Fix: relayd: `!vsession->current_trace_chunk` assertion failed
	* Fix: tests: fix unused-but-set warning in test_fd_tracker.c
	* Fix: sessiond: fix possible buffer overflow warning
	* Fix: tests: app unregistering is not guaranteed by app lifetime
	* Fix: lttng-ctl: tracing_group memory leaks
	* Fix: use <unistd.h> instead of <sys/unistd.h>
	* Fix: Tests: unchecked `close()` return value
	* Fix: relayd: live: mishandled initial null trace chunk
	* Fix: configure.ac: reporting SDT uprobe as a UST feature
	* Fix: Tests: leaking epoll fd
	* Typo: occurences -> occurrences

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.2.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.2.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
