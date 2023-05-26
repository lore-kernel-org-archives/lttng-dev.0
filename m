Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890AFC77B73
	for <lttng-dev@archiver.kernel.org>; Fri, 26 May 2023 15:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1685114156;
	bh=A+c72/o2uK8mRz8tuuWG+KoY5YgQBj06Tl3j4Xd12Ns=;
	h=To:In-Reply-To:References:Date:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Cdu4s0vDoa1dhUkxLlTKyCafADPsVhSWDtEbViacyXTRoZCP91GAU/WSPl3x2Z/QF
	 A5wN5PhuQIdS7kShXizKvvVqF8DlBOOXVb9NQIVMmatd2hO237Co293My09vju/0BH
	 GNoiRRLOrjgnrIn4gq+dnbX7Tt27JeawuqEBrcVykctOvzL12akeUkeLhretYI1xHD
	 UM91OocUI2lZh2JjivrC+Y1OYsZqzq4jQ7lB4Dl/rzxfVn888o0RRw5FD9ujm7bUuJ
	 oXqLrQDo5tDms6tthYrxbKHJMRFrayFGYWEWkL0opaLCyuOc2tMGvMv+2yDnm702PL
	 97hTUYZ3y+S6g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QST5S2v7bz1T1R;
	Fri, 26 May 2023 11:15:56 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QST5N6VhJz1T1P
 for <lttng-dev@lists.lttng.org>; Fri, 26 May 2023 11:15:52 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QST5L0L5zz15dv;
 Fri, 26 May 2023 11:15:50 -0400 (EDT)
To: Dmitry Vyukov <dvyukov@google.com>, tsan-users <tsan-users@google.com>
In-Reply-To: <CACT4Y+a22N7gvcePvBazN_=AyeigVaeH-nFX-ZqZbq49mftMPg@mail.gmail.com>
Organization: EfficiOS
References: <20230515201718.9809-1-odion@efficios.com>
 <CACT4Y+b-THcfzGiXxu8Wc79GwiMsQREPnykffj52+sDLcDqHvw@mail.gmail.com>
 <874jocl1lf.fsf@laura>
 <CACT4Y+YFNRKTgA=s8+ntiwEsRVq9WAR2pBF3toyiGe08mUQ4Gg@mail.gmail.com>
 <CACT4Y+Z8c30QQ3KFTaMq1Zgm-5fFCXEpNN3Kc9KWC+xzRkTzRQ@mail.gmail.com>
 <87ttwbj9uz.fsf@laura> <87v8gj11ak.fsf@laura>
 <CACT4Y+a22N7gvcePvBazN_=AyeigVaeH-nFX-ZqZbq49mftMPg@mail.gmail.com>
Date: Fri, 26 May 2023 11:15:49 -0400
Message-ID: <87a5xr15ui.fsf@laura>
MIME-Version: 1.0
Subject: Re: [lttng-dev] [PATCH 00/11] Add support for TSAN to liburcu
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
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, 24 May 2023, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Tue, 23 May 2023 at 18:05, Olivier Dion <odion@efficios.com> wrote:

> I don't this this is true in the C/C++ memory model:
> "the preceding atomic exchange with sequential consistency already
> acts as an implicit release (in term of memory barrier) for the
> following store".
>
> std::atomic_thread_fence does affect all preceding/subsequent
> operations, but an atomic memory operation only affects ordering on
> that variable, it doesn't also serve as a standalone memory fence.

After reading the standard, we concur with you.  We had to revisit the
memory model used by URCU to understand the conflict.  While doing so,
we had to adapt some of the algorithms that were assuming implicit full
memory barriers with operation such as CAS.

Thank for the insight!

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
