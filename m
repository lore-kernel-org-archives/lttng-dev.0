Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB68C001E0
	for <lttng-dev@archiver.kernel.org>; Wed,  5 Jul 2023 19:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1688583811;
	bh=lCRenXhmkv/ZGnK/KiFfHdL4F6gyxV92d/1ctx5KrEU=;
	h=To:In-Reply-To:References:Date:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=JQQ+NhXQMP8BrmGzTsNaOz6lF16q4p/ve6wLkfHZ1eVa45a1P7yGnfuD5Y9y9gHs0
	 EvGcODM2pX6/tfcJVxqgBGQSWMtKH2p6dwDbyALFdqHfGIn9PrHKJHt6qHBUIWFpfj
	 9AgBpZZld++batDzrpJIQIDcVZZC84XdutxAK5Ri5dzCWIX3vq8Zg3d7mezD91j5DM
	 ynDmFCiN0LtM6ZFalOdXb2w9bhtjh1NnUNZUh/QOdep6CH5KlKln1rYhZ+12M/R6Pk
	 dt2caq4rqTrl5oGxwFj3s6Af7QFhUJBNFmTTe8s1I32nZ0TXv7PXjQtUa8KbyuCrIm
	 qa03U/uQwl/1g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qx8FZ5s5vz2447;
	Wed,  5 Jul 2023 15:03:30 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qx8FY0xvKz248F
 for <lttng-dev@lists.lttng.org>; Wed,  5 Jul 2023 15:03:28 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qx8FQ1nqBz1Fvp;
 Wed,  5 Jul 2023 15:03:22 -0400 (EDT)
To: paulmck@kernel.org
In-Reply-To: <116221bf-33e0-4517-bee6-0dbb9cb69f26@paulmck-laptop>
Organization: EfficiOS
References: <20230515201718.9809-1-odion@efficios.com>
 <20230607185359.8125-5-odion@efficios.com>
 <81bdddb0-0a8e-4ce7-a40d-789bba0a74e2@paulmck-laptop>
 <87o7krd9fa.fsf@laura>
 <116221bf-33e0-4517-bee6-0dbb9cb69f26@paulmck-laptop>
Date: Wed, 05 Jul 2023 15:03:21 -0400
Message-ID: <871qhmchae.fsf@laura>
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

On Wed, 05 Jul 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> On Tue, Jul 04, 2023 at 10:43:21AM -0400, Olivier Dion wrote:
>> On Wed, 21 Jun 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> > On Wed, Jun 07, 2023 at 02:53:51PM -0400, Olivier Dion wrote:
>> >
>> > Same question here on loss of volatile semantics.
>> 
>> This apply to all review on volatile semantics.  I added a
>> cmm_cast_volatile() macro/template for C/C++ for adding the volatile
>> qualifier to pointers passed to every atomic builtin calls.
>
> Sounds very good, thank you!

Maybe a case of synchronicity here, but I just stumble upon this
<https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2016/p0062r1.html>
where you seem to express the same concerns :-)

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
