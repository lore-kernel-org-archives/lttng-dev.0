Return-Path: <SRS0=EL7T=M5=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEEDC4338F
	for <lttng-dev@archiver.kernel.org>; Fri,  6 Aug 2021 20:22:04 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8136960F35
	for <lttng-dev@archiver.kernel.org>; Fri,  6 Aug 2021 20:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8136960F35
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4GhH2K5zH6z7BC;
	Fri,  6 Aug 2021 16:22:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1628281322;
	bh=QjbKL9VaV53ODp5WF+5Fw4nzA5IqWgj51aE2U8wObvI=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=KQUsLdqNpMSH5amQbdjMT8AD03zWQ0LmdzomweEyky34KoOu9JHP0sbPXZCNMlK7g
	 pBQ81YANRkW/Iz5iC3IghG95dL1xGb8agX6/42fl/D2xEAeTWuX/cwz9kox3j1+A6r
	 nHRyc5j2AFwX7G953B9ejHfsudAC0POtMqvbkqqNtsNcUdoeRCgPVKQ5sqxin5MAyl
	 Bs1fiSCwwMf27LvGlYrUyWG6j2l0r47lxFU6u6RMWo2FRFYD+jFJ14wT4tRtLL3NCz
	 OHrq9xoTiZCTh//rNu1qNn0vQMsQp4QHdQFALe76Cu4KvAFC+Huf8eJHXFBDM4pUMT
	 hM+K2ZkNhIpjg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4GhH2J1mdzz7GW
 for <lttng-dev@lists.lttng.org>; Fri,  6 Aug 2021 16:21:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 57EF337B04D
 for <lttng-dev@lists.lttng.org>; Fri,  6 Aug 2021 16:21:53 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id THoWE6-3X7P9; Fri,  6 Aug 2021 16:21:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 59AD037B229;
 Fri,  6 Aug 2021 16:21:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 59AD037B229
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id O0P3TFKZkpOK; Fri,  6 Aug 2021 16:21:52 -0400 (EDT)
Received: from Mercury (unknown [107.159.88.171])
 by mail.efficios.com (Postfix) with ESMTPSA id 4025237B228;
 Fri,  6 Aug 2021 16:21:52 -0400 (EDT)
Date: Fri, 6 Aug 2021 16:21:51 -0400
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: diamon-discuss <diamon-discuss-bounces@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Message-ID: <YQ2Z3yAtG6QxpQ1H@Mercury>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [RELEASE] LTTng 2.12.5 - (Ta) Meilleure
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

The fifth bug-fix release of LTTng-tools 2.12 - (Ta) Meilleure has just been
released. This release addresses a number of issues listed below.

2021-08-06 lttng-tools 2.12.5 (International Beer Day)
	* Fix: runas: less-than-zero comparison of an unsigned value
	* Fix: runas: supplementary groups are ignored on lttng save
	* Fix: lttng: free sessions in cmd_destroy
	* Fix: lttng: free domains and channels in get_session_stats_str
	* Fix: rotation client example: leak of handle on error
	* .gitreview: Set default branch to 'stable-2.12'
	* tests: Move tap-driver.sh out of the autotools aux directory
	* Fix: use of uninitialised bytes valgrind warning
	* Fix: bump minimal urcu dependency to 0.11
	* Fix: consumer: unbalanced RCU read-side lock on error
	* Fix: tests: missing LOG_DRIVER and LOG_DRIVER_FLAGS
	* Fix: list_lttng_agent_events: unbalanced RCU read-side lock on error

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.5.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.5.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
