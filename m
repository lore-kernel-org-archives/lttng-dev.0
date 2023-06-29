Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C471EB64D9
	for <lttng-dev@archiver.kernel.org>; Thu, 29 Jun 2023 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1688059330;
	bh=E+On8u1jMLIo8/UsWBIVdfD/lO2TSNij4XzTac2GtDI=;
	h=To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=V9W60BujHnsdSpGfj1aOdTkqxVG1hu+7f17W/mUzaJbMMob/qS6EaNYBV/sGGRAzQ
	 zSXAUFEJwPldk3e36vEbNwTfiIsyPjW68Pnm9l++y8WmtfCHynVPZIyeyE9c6OjQAe
	 30QYwsZ/hNzNvzElxkCNylDsmtsQEZQtKsYRcA/x4O/l0FjOcsgk823MO9LncIg4yG
	 YVPmP5jnHjjk9mG2/x8xXFQGBJWEemBLCilIMy+GscGUXX1r+3TxicadDWL+uPJvB1
	 CZ7tFtPz0rLqDpI2+YoTPM+0/4laap1hmUfKMHKEoSnYO8eQA2yqhDHUZkxfcEpNAA
	 BHTGXCovrtSfQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QsQHP4K4pz22CR;
	Thu, 29 Jun 2023 13:22:09 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QsQHN0k1gz22MX
 for <lttng-dev@lists.lttng.org>; Thu, 29 Jun 2023 13:22:02 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QsQHD6nMlz19bj;
 Thu, 29 Jun 2023 13:22:00 -0400 (EDT)
To: paulmck@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
In-Reply-To: <105bad2a-9fed-4353-a434-a571ce9da7ac@paulmck-laptop>
Organization: EfficiOS
References: <20230515201718.9809-1-odion@efficios.com>
 <20230515201718.9809-3-odion@efficios.com>
 <c7834f41-c033-4c53-96e8-0ad728c2a285@paulmck-laptop>
 <ffec193e-7060-3fe2-6526-c54e89e992e6@efficios.com>
 <105bad2a-9fed-4353-a434-a571ce9da7ac@paulmck-laptop>
Date: Thu, 29 Jun 2023 13:22:00 -0400
Message-ID: <878rc2ji9z.fsf@laura>
MIME-Version: 1.0
Subject: Re: [lttng-dev] [PATCH 02/11] urcu/uatomic: Use atomic builtins if
 configured
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Thu, 22 Jun 2023, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> On Thu, Jun 22, 2023 at 11:55:55AM -0400, Mathieu Desnoyers wrote:
>> On 6/21/23 19:19, Paul E. McKenney wrote:
> I suggest C11 volatile atomic load/store.  Load/store fusing is permitted
> for non-volatile atomic loads and stores, and such fusing can ruin your
> code's entire day.  ;-)

After some testing, I got a wall of warnings:

  -Wignored-qualifiers:

    Warn if the return type of a function has a type qualifier such as
    "const".  For ISO C such a type qualifier has no effect, since the
    value returned by a function is not an lvalue.  For C++, the warning
    is only emitted for scalar types or "void".  ISO C prohibits
    qualified "void" return types on function definitions, so such
    return types always receive a warning even without this option.

Since we are using atomic builtins, for example load:

  type __atomic_load_n (type *ptr, int memorder)

If we put the qualifier volatile to TYPE, we end up with the same
qualifier on the return value, triggering a warning for each atomic
operation.

This seems to be only a problem when compiling in C++ [0] while in C it
seems the compiler is more relaxed on this [1].

Ideas to make the toolchains happy? :-)

  [0] https://godbolt.org/z/3nW14M3v1
  [1] https://godbolt.org/z/TcTeMeKbW

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
