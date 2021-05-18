Return-Path: <SRS0=5zNP=KN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26036C433B4
	for <lttng-dev@archiver.kernel.org>; Tue, 18 May 2021 23:46:37 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911BD61074
	for <lttng-dev@archiver.kernel.org>; Tue, 18 May 2021 23:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911BD61074
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FlCMH1kX3z1qmM;
	Tue, 18 May 2021 19:46:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621381595;
	bh=x1hoYvZNZuFVld5S2DA96TF5UX8GXfpIVfd7qK8BFCg=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=EFB5xK0NLNZjUnwQPKxP5iZBMzuYbIERsRkQ00sG9jofv1kHAepCDYvb0YgyfIel0
	 mzOcVBtfJRNBkivkRsxsPaajMfId4bMD33dPE28SD5WIGbCsUDRlBEYfUW+Gih9xqB
	 fExtN1QAU7rh96+GXVYHhjqhJzLHoI+YhgMXSPSuE3gjTIxwtAMQ5mChL/XOzJntUa
	 CmHzh/nwQZfXqmL4WAODZMVAzP8Jv0KC3sLDeMu9JmAkUD1nBnnxPDZfAiBlbgM/9P
	 Ee1dxz5SLIy6KiEMYem44RxI2Rs17r4BGkLN9RNK2K4TsU2w/toZCBaGaodT7a1kSm
	 RY/Y9k55d/hKA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FlCMF4jlJz1qSN
 for <lttng-dev@lists.lttng.org>; Tue, 18 May 2021 19:46:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6A2FF345B1D
 for <lttng-dev@lists.lttng.org>; Tue, 18 May 2021 19:46:27 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id cf0kTN6j3BR4; Tue, 18 May 2021 19:46:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 60E85345D23;
 Tue, 18 May 2021 19:46:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 60E85345D23
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Y3REbysghQWp; Tue, 18 May 2021 19:46:26 -0400 (EDT)
Received: from Mercury (unknown [107.159.88.171])
 by mail.efficios.com (Postfix) with ESMTPSA id 3BC69345C8F;
 Tue, 18 May 2021 19:46:26 -0400 (EDT)
Date: Tue, 18 May 2021 19:46:26 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <YKRR0mmKIGxjag6Y@Mercury>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [RELEASE] LTTng 2.12.4 - (Ta) Meilleure
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

Hi all,

The fourth bug-fix release of LTTng-tools 2.12 - (Ta) Meilleure has just been
released. This release addresses a number of issues listed below.

2021-05-18 lttng-tools 2.12.4 (No Dirty Dishes Day)
	* Fix: snapshot path have domain subdir duplicate "ust/ust" or "kernel/kernel"
	* Fix: relayd: failure to read index entry or stream packet after clear
	* Fix: sessiond: leak of config_path on duplicate --config option
	* Fix: relayd: live: data is missing between viewer attach and retry
	* Fix: lttng-ctl: erroneous check if user is part of the tracing group
	* Fix: kernel consumer: get next subbuffer EAGAIN handling
	* Fix: kernel consumer: signal metadata ready condition variable
	* Fix: consumerd: unbalanced subbuffer 'get' when checking operation availability
	* Fix: tests: gen-ust-events-ns: Uninitialized argument value
	* Fix: consumerd: strlen called on uninitialized path
	* Fix: tests: health thread stall: only stop consumerd when required
	* Fix: tests: quote variable in case it's not set
	* Fix: sessiond: session destroy hang in per-uid when context cannot be added
	* Fix: backward relayd: path contains a leading "ust" folder
	* Fix: lttng_destroy_session_no_wait: return 0 on success
	* config: fix typo in error message
	* Tests: array expressions without contant index are invalid
	* Fix: validate that array expression contains constant
	* Fix: test: base-path tests are not run
	* Fix: filter: memory leak in filter_parser_ctx
	* Fix: sessiond: fix -Wshadow error in save.c
	* Fix: utils: avoid strncpy overlap in utils_partial_realpath
	* Clean-up: utils: make utils_partial_realpath static
	* Fix: added missing test_channel and removed double defined test_syscall
	* Fix: sessiond: kernel: invalid error code check
	* Tests: fix: unchecked sscanf return value
	* compiler warning cleanup: is_signed_type: compare -1 to 1

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.4.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.4.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
