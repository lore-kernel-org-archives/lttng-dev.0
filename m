Return-Path: <SRS0=91P6=I5=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CFEC433B4
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 19:25:20 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4F360230
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 19:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4F360230
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F9bqx3hbVzS9m;
	Wed, 31 Mar 2021 15:25:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617218718;
	bh=aBOHwWilF5C2QBc1PBMZQ/PS3yKFLPFrfnP3efQ/mdM=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=sH03dBMG6DQG8gVWrzQb1D9oQYrdrlJH34GwpOL6fuZaHclsZDODNEeTRCqXuEN5U
	 WYZI4fDzArRiLcywVXphNBOYDvjdjsqoz4gdPbdOqzCJzOm4lJFVTTDaykojodVXjN
	 +KGk4X1DvOhrcn36YdQUwKHbGOUIQcY7v5uW7ljJqFxXd0UkUVRKeZkaIDubt/QY9A
	 48qSw3ZkMr+zIhEygU06PIYLTyKkVZcvYRr8nCDrV9A8yteOKxYrEmRF14DRZoflSr
	 4ur4eMppOFSpNwYj5EtvA2w+2S5O8CFmMEfUxsnVxzrOlaWbiSCNzIJ11zu6Uq8qd8
	 VzIJVNwwLD0og==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4F9bqw1CqLzS9l
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 15:25:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BC8042F9225
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 15:25:09 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id jEEKciAXKItv; Wed, 31 Mar 2021 15:25:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5EC5A2F9224;
 Wed, 31 Mar 2021 15:25:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5EC5A2F9224
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id q89vdVgjKM8x; Wed, 31 Mar 2021 15:25:09 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 56D062F9221;
 Wed, 31 Mar 2021 15:25:09 -0400 (EDT)
Date: Wed, 31 Mar 2021 15:25:09 -0400 (EDT)
To: Anders Wallin <wallinux@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <592114658.48857.1617218709305.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210331185624.406960-1-wallinux@gmail.com>
References: <20210331185624.406960-1-wallinux@gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - GC88 (Linux)/8.8.15_GA_4007)
Thread-Topic: test code assumes that child process is schedule to run before
 parent
Thread-Index: spuxQjDmJT+MtLON4NHXbqnjWToiIA==
Subject: Re: [lttng-dev] [PATCH lttng-tools] Fix: test code assumes that
 child process is schedule to run before parent
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

> #
> # SPDX-License-Identifier: GPL-2.0-only
> 
> -TEST_DESC="LTTng - Event traker test"
> +TEST_DESC="LTTng - Event tracker test"
> 
> CURDIR=$(dirname "$0")/
> TESTDIR="$CURDIR/../../.."
> @@ -42,6 +42,8 @@ function prepare_ust_app
> 
> 	$TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a "$AFTER_FIRST_PATH" -b
> 	"$BEFORE_LAST_PATH" &
> 	CHILD_PID=$!
> +	# voluntary context switch to start $TESTAPP_BIN
> +	sleep 0.1

A wait on the $AFTER_FIRST_PATH file would be probably more deterministic than a sleep here.

  while [ ! -f "${AFTER_FIRST_PATH}" ]; do
          sleep 0.1
  done

I would also expect something similar for the `prepare_kernel_app` function considering the same race is most probably present and simply not triggered by a chance of luck.
Seems like gen-kernel-test-events does not expose the same sync capabilities here, please use gen-ust-events as an example of how it is done.

Let us know how your testing goes.

Thanks
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
