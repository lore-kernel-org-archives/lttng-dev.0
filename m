Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B467C433EF
	for <lttng-dev@archiver.kernel.org>; Mon, 28 Mar 2022 21:01:27 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KS4qn5Fk5zKys;
	Mon, 28 Mar 2022 17:01:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1648501286;
	bh=Y5MeOOnCuxioLfDtuAXgaFYNuddqmgu8d89xgfG+bWI=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=s0uy6daqzDcT1WA7IOfAqmRz27GoLyhIwkQRSS5xLZxkrsHGf/3zImVXM9jmMbMSv
	 TiYByBboIFPzduWO+aqMANngqu3sUwVibrs7ymVodWCA5Ul+mfTzm3v2yc8xE/3/vB
	 8eif1r0d4Lv+814EGQ0OZxoX7t5+LjSEY6P8hOQZKkt34TdI1tm1Kdys0Ll8y2f5w4
	 lmZ6HVKmDJc+ViqcDf5kYk/eI0MFir+NeJOks7xzMLzGi/jg02NBWghptDEjHdT4Qq
	 ZOaI77FV1xhMHrQfJHXrIfRn2uU/4xLG40/LA9gdPgV2G8Ngwv2eloC2g6dI6TN0tR
	 moe8sQtc+AxLg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KS4ql5wydzL3V
 for <lttng-dev@lists.lttng.org>; Mon, 28 Mar 2022 17:01:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 809723FC1D0
 for <lttng-dev@lists.lttng.org>; Mon, 28 Mar 2022 17:01:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id LbaEtfqidB-T; Mon, 28 Mar 2022 17:01:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C0B9E3FC1CE;
 Mon, 28 Mar 2022 17:01:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C0B9E3FC1CE
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Z712gemk5JzE; Mon, 28 Mar 2022 17:01:16 -0400 (EDT)
Received: from carbonara (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
 by mail.efficios.com (Postfix) with ESMTPSA id 91FF73FC288;
 Mon, 28 Mar 2022 17:01:16 -0400 (EDT)
Date: Mon, 28 Mar 2022 17:01:16 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Message-ID: <YkIiHKpC1VqCb0Ru@carbonara>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [RELEASE] LTTng-tools 2.12.10 - (Ta) Meilleure
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released the tenth bug-fix release of LTTng-tools 2.12 - (Ta)
Meilleure. This release addresses a number of issues listed below.

2022-03-28 lttng-tools 2.12.10 (National Hot Tub Day)
	* Fix: Remove liblttng-ctl.so dependency on liburcu-cds.so and liburcu-common.so

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.10.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.10.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
