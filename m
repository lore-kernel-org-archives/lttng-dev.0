Return-Path: <SRS0=QQXS=BN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121E4C433DF
	for <lttng-dev@archiver.kernel.org>; Mon,  3 Aug 2020 22:35:00 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73A620722
	for <lttng-dev@archiver.kernel.org>; Mon,  3 Aug 2020 22:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="xWzCRQfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73A620722
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BLCPY6rWmz1nT7;
	Mon,  3 Aug 2020 18:34:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1596494098;
	bh=ZAkWXP+uGIb+H9h0iPgmuL1C1pqLXQhdVLkPLt43tmU=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=xWzCRQfWjQywVxJR+aNehY3y4hIGyqMl+/MGyuRrRqWOrGw0q5EUExFseDSnF70sf
	 RSxmMi7Fbaz6XbMWQLR4lPD4JovevGuSloV9R8UPEPjGpWdRb3Q02BzCThczBkC88i
	 rKsy5rh9511NoI1FWoM4Za15lJH3aAixJhwNViN0+q1rBh3JuoT3ILxwhnEri9Eq8l
	 6ry8aMxZXgF6V/ysOyThvvp+xLWWmKeC9ZcKyUSHK8nKlyHgaTrSlAZHUhMKAiXihK
	 lIcCCjLbHs8LAsLKHtGkeFbUe8E5Z+8elHUGwK5FOAlo0N8yzihss34pdoKhFYxnO3
	 jU8x4v4YQ0D4A==
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by lists.lttng.org (Postfix) with ESMTPS id 4BLCPX107kz1nCD
 for <lttng-dev@lists.lttng.org>; Mon,  3 Aug 2020 18:34:55 -0400 (EDT)
Received: by mail-qt1-f170.google.com with SMTP id v22so23609496qtq.8
 for <lttng-dev@lists.lttng.org>; Mon, 03 Aug 2020 15:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=XXXqlxq8vYx19nlPfxnkR6X3lNfVgSLDoF5vGR+u0Wc=;
 b=hny7yvJ+Lp4sq9/m1vnte+h/13bGDcIjqIqePuGaFLWa8uX35vfRkI1Lhzk6fs6pnM
 1qKbfGl5qjghJBORSikqskvGBd/gIS0pccP8Ib8rkU4ozFUrbMyX90k3YSXS6Lf8g/80
 o0uSJW0u8L9yNbZaS2ksOnoEJJaHoRhDzegrjlt4OdsOi1uVigN6A7HUk2tgdTOEVVYp
 CTcdG93H1aOlwIxalf3+MQ1eo/5KSGAsnL5P3/OxMlzLuz0MMcY0wvJtX9YGWonDoFUX
 plaL9vfcUI8goFqEllm6Pt0Zn0iLV6sfAGezhU8PHz1YGhasq0U4bOa0LWyHt6NGTYhQ
 ghUA==
X-Gm-Message-State: AOAM530WGdOAfCkZ5Y3pozHwcznnU5dn1BgZ2lZCFMlyJBNFgmzm1fKp
 zLHjrFzBlIW1PElIGMCt1MpkQgFN
X-Google-Smtp-Source: ABdhPJzsxAqefqEhxum08zlaOI2OhW6qitcoRW/EC+Hr6NJXHIcbg99hZB0Hq/o5kltfvH5QXyIo3Q==
X-Received: by 2002:ac8:6a06:: with SMTP id t6mr18699196qtr.206.1596494094791; 
 Mon, 03 Aug 2020 15:34:54 -0700 (PDT)
Received: from gmail.com (192-222-251-19.qc.cable.ebox.net. [192.222.251.19])
 by smtp.gmail.com with ESMTPSA id
 l31sm24639967qtc.33.2020.08.03.15.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 15:34:53 -0700 (PDT)
Date: Mon, 3 Aug 2020 18:34:51 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <20200803223451.GA2165704@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [RELEASE] LTTng-tools 2.11.5 - Lafontaine
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

The fifth bug-fix release of LTTng-tools 2.11 - Lafontaine has just
been released. This release addresses a number of issues listed below.

2020-08-03 lttng-tools 2.11.5 (National Watermelon Day)
	* Fix: lttng: leak of userspace probe path on listing
	* Fix: uprobe: missing error code on allocation failure
	* Fix: sessiond: don't negate error code on list error
	* Fix: send/received actual size is overwritten by 'expected' size
	* Fix: partial recv lead to client disconnect
	* tests: return the proper TAP exit code
	* Tests: live/test_{lttng_,}kernel: use lttng_test_filter_event instead of sched_switch
	* Fix: consumer: Move sanity check within `consumer_subbuffer` functions
	* Cleanup: typo in DBG() statements
	* Fix: relayd: send_viewer_streams sends stack data in padding
	* Fix: kconsumer: missing wait for metadata thread in do_sync_metadata
	* Fix: tests: interrupting get_next_notification causes test to fail
	* Fix: consumer.c: wrong order of parameter in `DBG()` statement
	* Fix: kernel metadata file outside of kernel/ directory
	* Fix: consumer: dangling chunk on buffer allocation failure
	* Fix: consumerd: uninitialized written_bytes on no-data sleep
	* Build fix: consumerd misnamed label
	* consumerd: on_sleep not called on stream when no data is available
	* Fix: invalid discarded events on start/stop without event production
	* tests: truncate metadata file for regenerate metadata test
	* Fix: consumerd: user space metadata not regenerated
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

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.11.5.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.11.5.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
