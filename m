Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809F3EB64DA
	for <lttng-dev@archiver.kernel.org>; Tue,  4 Jul 2023 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1688482277;
	bh=ZtcPig+8hdNtpJEgxLd/Sujy14wDsuZH6NqAKLdO9hE=;
	h=To:In-Reply-To:References:Date:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=aEwab4rIQbs0VusHCocthl+gWZYOfeEAl8fekFQJ8OEh/iOu9tGOTniH+4GVyzsLW
	 MdrQlrluFR9lq3ST57j6nPqZWls805ZDFG/b/SbyQ17jkg4ZW6qN9skJ02uJdJSlnb
	 ES71LgxIU7X2f5LdCi800pOAC2a2tTgXRxBqpLTB0Z4Ca8p+wFoUHMitBkUTdTefIn
	 RButP4jpdK9rR24S5TuNMajAlA4GxklsLeWRffKfQL+nobB0OazY2KbSFeD1n8Zg97
	 6I11mPX40hm20gnOEdBuTWjUsp+vnkA6qPQjm4VIZv5Wdk7YU8r+r2q6BH+7vuZMNM
	 dd7QPVaty/eCA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QwQhz74qfz23nN;
	Tue,  4 Jul 2023 10:51:15 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QwQhw1R9hz23Br
 for <lttng-dev@lists.lttng.org>; Tue,  4 Jul 2023 10:51:12 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QwQWs2mY8z1Frk;
 Tue,  4 Jul 2023 10:43:21 -0400 (EDT)
To: paulmck@kernel.org
In-Reply-To: <81bdddb0-0a8e-4ce7-a40d-789bba0a74e2@paulmck-laptop>
Organization: EfficiOS
References: <20230515201718.9809-1-odion@efficios.com>
 <20230607185359.8125-5-odion@efficios.com>
 <81bdddb0-0a8e-4ce7-a40d-789bba0a74e2@paulmck-laptop>
Date: Tue, 04 Jul 2023 10:43:21 -0400
Message-ID: <87o7krd9fa.fsf@laura>
MIME-Version: 1.0
Subject: Re: [lttng-dev] [PATCH v2 04/12] urcu/system: Use atomic builtins
 if configured
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Cc: Tony Finch <dot@dotat.at>, lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, 21 Jun 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> On Wed, Jun 07, 2023 at 02:53:51PM -0400, Olivier Dion wrote:
>
> Same question here on loss of volatile semantics.
>

This apply to all review on volatile semantics.  I added a
cmm_cast_volatile() macro/template for C/C++ for adding the volatile
qualifier to pointers passed to every atomic builtin calls.

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
