Return-Path: <SRS0=QQXS=BN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CDEC433E0
	for <lttng-dev@archiver.kernel.org>; Mon,  3 Aug 2020 22:36:26 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D5EA2068F
	for <lttng-dev@archiver.kernel.org>; Mon,  3 Aug 2020 22:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="B/iwNw/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5EA2068F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BLCRD6JjGz1nYn;
	Mon,  3 Aug 2020 18:36:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1596494185;
	bh=KmT1+176ijQmTPi1JbYizelKHQK0t5efw60Mkpxyz40=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=B/iwNw/fZti/BflqnHOTHMh1acm0hqFTy2xBscc+pNVObOeJz8QjQ7wCYynA61lHz
	 4vOh5G+dm7pF+LykyHJwdv020bjsT3A/KBPelPF4f7lEvQuQTkEmgP3AbxFJMeIm0W
	 UjrHjU9wryfkgBkzmC/7YGNK/j5T0OKrRSbdawyFiIyGhXraSZvrdPUta3ZC93x05Q
	 Ku4g7NQyifUSQL3j+VSeH/WTBl0GYeagITzvDaxS/sh9mu0vUd6aMEwwBPX1ehy6Tu
	 8cB27ExFz3NjKrqZwxTXYK9CwrkYGZiwWplKQ0CCepC3fJlIrxSpIh41WQgXdLNwUK
	 4vh67XD2ipfdw==
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53])
 by lists.lttng.org (Postfix) with ESMTPS id 4BLCRC0jKjz1nR8
 for <lttng-dev@lists.lttng.org>; Mon,  3 Aug 2020 18:36:22 -0400 (EDT)
Received: by mail-qv1-f53.google.com with SMTP id r19so9643050qvw.11
 for <lttng-dev@lists.lttng.org>; Mon, 03 Aug 2020 15:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=Z7B91a0ismdHeVXkGUzfMhxmNZTHKKxA3STkVXpRr0o=;
 b=VPx/eQv3AP35QCq+t4ZYnFEzd2dyMlBf8039PE0WiISdbtLpTbP/uHIl8eAoLiSY4W
 l1qyovTfQS+OCybDbkpf650aNHGzM1SjM9ajRjlAivjJ/IM46jOD7ZgIir6qzLzoR4Te
 ir/vQU4A6+59Skn1LUjfnT8/dqFFhUa/PkzabUbWBDoDPQZpjwoTxK6Sq7s6Hm7icFND
 SvH02LF9VaDd1BIUsgJz62u1OQGvHFflDDLUe+EpQdmfPLZSjS76fq9i2vOR/bvPT45X
 VThBJ7MmHH1Ru+RsB0Zp8s0rxBcuiOjAIG+7niorerA62m1cxZ4NPT3NRF2qvz2JSR4H
 LW1Q==
X-Gm-Message-State: AOAM530Wi2X9rYKk6ETFAfQtyHvhYCCJYZOQ87l9+wuj6GyLKpc60Mhp
 QOTl+U9HqzyCPAM80HpB4+d0AZL9
X-Google-Smtp-Source: ABdhPJzVioUi/eyrWNO4PClKDLDpSGGBs4Ne1AcNWAkvN0JH2QG3czZfHuOz34h3E8p6WHlIzhI2Aw==
X-Received: by 2002:a0c:a81a:: with SMTP id w26mr19419406qva.52.1596494181773; 
 Mon, 03 Aug 2020 15:36:21 -0700 (PDT)
Received: from gmail.com (192-222-251-19.qc.cable.ebox.net. [192.222.251.19])
 by smtp.gmail.com with ESMTPSA id
 r18sm10684416qtc.90.2020.08.03.15.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 15:36:21 -0700 (PDT)
Date: Mon, 3 Aug 2020 18:36:19 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <20200803223619.GB2165704@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [RELEASE] LTTng 2.12.2 - (Ta) Meilleure
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
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

The second bug-fix release of LTTng-tools 2.12 - (Ta) Meilleure has
just been released. This release addresses a number of issues listed
below.

2020-08-03 lttng-tools 2.12.2 (National Watermelon Day)
	* Tests: rework tracefile_count test to meet the tracefile count limit
	* Fix: extraneous empty/inactive flush on rotation out of a trace chunk
	* Fix: relayd: double unlock on viewer stream creation error
	* Fix: relayd: live connection fails to open file during clear
	* Fix: relayd: wrong stream type used in DBG statement
	* Fix: lttng: leak of userspace probe path on listing
	* Fix: uprobe: missing error code on allocation failure
	* Fix: sessiond: don't negate error code on list error
	* Fix: send/received actual size is overwritten by 'expected' size
	* Fix: partial recv lead to client disconnect
	* tests: return the proper TAP exit code
	* Tests: live/test_{lttng_,}kernel: use lttng_test_filter_event instead of sched_switch
	* Fix: consumer: Move sanity check within `consumer_subbuffer` functions
	* Fix: sessiond: wrong variable checked for error code
	* Fix: consumerd: double unlock on rotate channel error path
	* Fix: consumerd: packet sent before channel rotation
	* Fix: relayd: wrong specifier used in DBG format string
	* Tests: add a "new metadata after clear" test
	* Fix: relayd: send_viewer_streams sends stack data in padding
	* Fix: stream intersection fails on snapshot of cleared session
	* Fix: relayd: viewer metadata is not rotated after a session clear
	* Fix: post-clear trace chunk has a late beginning packet
	* Fix: kconsumer: missing wait for metadata thread in do_sync_metadata
	* Fix: tests: interrupting get_next_notification causes test to fail
	* Fix: consumer.c: wrong order of parameter in `DBG()` statement
	* Fix: consumer: dangling chunk on buffer allocation failure
	* Fix: consumerd: uninitialized written_bytes on no-data sleep
	* Build fix: consumerd misnamed label
	* consumerd: on_sleep not called on stream when no data is available
	* Fix: invalid discarded events on start/stop without event production
	* tests: truncate metadata file for regenerate metadata test
	* Fix: consumerd: user space metadata not regenerated
	* tests: gen-ust-events-ns/tp.h: Fix build with musl libc
	* Fix: tests: output_dir contains the consumerd pipe
	* Fix: unix: don't PERROR on EAGAIN for non-blocking sockets
	* Fix: sessiond: sessiond and agent deadlock on destroy
	* Fix: incorrect specifier %lu used with size_t argument
	* Fix: consumerd: live client receives incomplete metadata
	* consumerd: refactor: split read_subbuf into sub-operations
	* consumerd: move rotation logic to domain-agnostic read path
	* sessiond: enforce mmap output type for kernel metadata channel
	* consumerd: tag metadata channel as being part of a live session
	* consumerd: pass channel instance to stream creation function
	* consumerd: cleanup: use buffer view interface for mmap read subbuf
	* consumerd: move address computation from on_read_subbuffer_mmap
	* consumerd: refactor: combine duplicated check_*_functions
	* kerner-ctl: add RING_RING_BUFFER_GET_NEXT_SUBBUF_METADATA_CHECK
	* Add lttng_dynamic_buffer_append_view util
	* Fix: lttng: Destroying session message repeated during destruction
	* Fix: liblttng-ctl: leak of tracker handle in lttng_[un]track_pid
	* Fix: common: fs_handle_seek returns negative value on success
	* Fix: common: abort on rotation after time manipulation
	* Tests: test_exclusion: exclusion after tracing active
	* Tests: `gen-ust-nevents`: add syncpoints
	* Tests: accept built-in kernel modules

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.2.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.2.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
