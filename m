Return-Path: <SRS0=Zciu=HZ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D557C433DB
	for <lttng-dev@archiver.kernel.org>; Tue, 23 Feb 2021 23:11:46 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CCF64E7C
	for <lttng-dev@archiver.kernel.org>; Tue, 23 Feb 2021 23:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CCF64E7C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DlZYq1dmDz6yg;
	Tue, 23 Feb 2021 18:11:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1614121904;
	bh=8KIaMz//yEgwYVdfS+XVVKjyxyolTJWd4rMHGi820lE=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=bE7pqL68pMewJa6Ew9VTr8jC5zKvT9nW9F3ufJYV8tXoCN1dLEhIyaTxEtFcwXBP5
	 4CFlHs5/xobAqesmrlSbgjHPSgE8Bm/Jcjp1YiIEhtdISc5dzJfK9plt2lDeXM+vDz
	 9iVVheTz+va+RXma6+UV58oNxTFQJXko2E22/gEZ7bzH80/TtM5rYVH8OmP1rMB0mq
	 7M+FLBICFmXEU6kYclUtYH1hMrLJAkmeTUWtnsPjRsRsdmLcRzLgkpjt2QRX4Mnr5C
	 G0d+WRqC+R6Ulz45Q5b26m+9mc8x6s8td7OzfI3+4D7+YNMK76D/MRWzbJCm7q42cP
	 grg+znZ2bAx/Q==
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by lists.lttng.org (Postfix) with ESMTPS id 4DlZYn0RrWz6ng
 for <lttng-dev@lists.lttng.org>; Tue, 23 Feb 2021 18:11:40 -0500 (EST)
Received: by mail-qt1-f178.google.com with SMTP id l25so153673qtr.3
 for <lttng-dev@lists.lttng.org>; Tue, 23 Feb 2021 15:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=xCN2q4fjlYe8E/rPqtbmSY6q88/yRP0u8mm7jR64KbM=;
 b=VLlZ6cGRUQ+vEbei0hqOVXKv0sGZiwtWnKmmBTUyZ0XQjIP7X2g143z3//Zeb8mJO7
 p3KQAFsorABxfqMXiX0W1fuiaW3gBRIWvl3kgMsavi9vW8ZH8Sw/mrxY/z98js0Px/pL
 NLGBQGe3/XKsL/Po79CqWIFoItHI3JYyS2hWOLuhwnd98TrKAf+Fwv+Jmph9gid/Wf+0
 oyIU7LFTejdTZY/xRjI+VQ1T4gOgQ2zUFXFbEqSs8BUSay001iCccpjblvGlBOXe9dnz
 0LrMPp4Kz0Gi8J2+pl2LxLByGUs5MS7rrBDZgiFZgiA4C1L1ACLpmVrPJFPTeoxPDR+k
 PQ2A==
X-Gm-Message-State: AOAM5308M8E0YGqt+yZAxDH0K/n47hEG0Wp7qxe6h7AQsO/9n6jr1TBc
 LLIWlHxxntsp47usW9jyKflUoZUq/FOy5Q==
X-Google-Smtp-Source: ABdhPJyUqCGGL2d8v6Qwe90F2PxY06CFvUZ93uFJ8G3uF3jn0bSoQKwU/MxnpEG8lQkuxweQjMCjEQ==
X-Received: by 2002:a05:622a:28d:: with SMTP id
 z13mr27117272qtw.87.1614121899994; 
 Tue, 23 Feb 2021 15:11:39 -0800 (PST)
Received: from gmail.com ([107.159.88.171])
 by smtp.gmail.com with ESMTPSA id y9sm226460qkf.73.2021.02.23.15.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 15:11:39 -0800 (PST)
Date: Tue, 23 Feb 2021 18:11:37 -0500
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org
Message-ID: <YDWLqXao3e/6+Iqg@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [RELEASE Babeltrace 2.0.4 - Amqui
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
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi everyone!

Today we're releasing the fourth patch-level release of Babeltrace 2.0
"Amqui".

What's new since Babeltrace 2.0.3?
==================================

This release contains a number of plug-in fixes and changes to build the project
on FreeBSD. It also fixes the build system to accomodate some breaking changes
introduced in Autoconf 2.70.

The full change log follows.

2021-02-23 Babeltrace 2.0.4 (National Banana Bread Day)
	* Fix: macro name for "get supported mip versions method" attribute descriptor
	* Fix: configure: support Autoconf 2.70
	* port: add 'notext' keyword linker support
	* port: fix compat/endian.h on FreeBSD
	* port: tests: Add sys/wait.h include for FreeBSD
	* port: namespace align.h with BT_ prefix
	* port: Add sys/param.h include to compat/limits.h for FreeBSD
	* port: disable debug-info by default on FreeBSD
	* Fix: disable deprecation warnings for SWIG generated code
	* port: 'ls --ignore=' is a GNU extension
	* tests/lib/test_trace_ir_ref.c: rename user structure
	* Fix: sink.ctf.fs: fix logic of make_unique_stream_file_name
	* Fix: sink.ctf.fs: remove spurious directory level when using assume-single-trace
	* Fix: bt2: _trim_docstring(): docstring can have 0 or 1 line
	* Fix: `ctf` plugin: use element FC's alignment as array/seq. FC alignment
	* Fix: source.ctf.lttng-live: muxing failure on clear (unit conversion)
	* Fix: src.ctf.lttng-live: incomplete metadata packet is an error
	* Fix: source.ctf.lttng-live: muxing failure on clear
	* Fix: source.ctf.fs: 0-length packet index length causes SIGFPE
	* Update working version to Babeltrace 2.0.4

Important links
===============
Babeltrace 2.0.4 tarball:
    https://www.efficios.com/files/babeltrace/babeltrace2-2.0.4.tar.bz2

Babeltrace website:
    https://babeltrace.org

Mailing list (for support and development):
    `lttng-dev at lists.lttng.org`

IRC channel:
    `#lttng` on `irc.oftc.net`

Git repository:
    https://bugs.lttng.org/projects/babeltrace

GitHub project:
    https://github.com/efficios/babeltrace

Continuous integration:
    https://ci.lttng.org/view/Babeltrace/

Code review:
    https://review.lttng.org/q/project:babeltrace
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
