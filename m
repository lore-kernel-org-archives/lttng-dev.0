Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812DFEB64D9
	for <lttng-dev@archiver.kernel.org>; Thu, 29 Jun 2023 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1688059666;
	bh=iJA2MAvQScX/nzJMgjl8K0cchoxSXzI+Q3QUzVC+KNs=;
	h=To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hUwPdOHW2qEHeewixFu3Hz2wa739K5QnZtLM2Bl75LZ7/J4jArPyqq/DdYkcvBo3b
	 jfickqaAiGQaFBTxzB2ECTQpvZtEbOhb3sPCMtTADjV+p7U5eXoMWCVmSgtA7MWz4V
	 0nC6dNfe6HIUzykTGQcouU8zbHc8+s+EMox/xcFj6QPGl0YSzGAY+jQDweRuJ8YnFj
	 qQQH1FjFT9+QgnboYjaQlbRAr6FGzk5Hc33o1Yzwf2N5hTey5UREabE3usyYitjMXO
	 YF/LIIJIIa3eu4St4osujZScE7E7+q9YPYFdZbPja4bv55Ndyv4v7dmsruG/5c0wPN
	 4dcYWaPdCuFbw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QsQPs6qQMz2210;
	Thu, 29 Jun 2023 13:27:45 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QsQPr2W3dz220x
 for <lttng-dev@lists.lttng.org>; Thu, 29 Jun 2023 13:27:44 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QsQPq53ryz19f5;
 Thu, 29 Jun 2023 13:27:43 -0400 (EDT)
To: paulmck@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
In-Reply-To: <878rc2ji9z.fsf@laura>
Organization: EfficiOS
References: <20230515201718.9809-1-odion@efficios.com>
 <20230515201718.9809-3-odion@efficios.com>
 <c7834f41-c033-4c53-96e8-0ad728c2a285@paulmck-laptop>
 <ffec193e-7060-3fe2-6526-c54e89e992e6@efficios.com>
 <105bad2a-9fed-4353-a434-a571ce9da7ac@paulmck-laptop>
 <878rc2ji9z.fsf@laura>
Date: Thu, 29 Jun 2023 13:27:43 -0400
Message-ID: <875y76ji0g.fsf@laura>
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

On Thu, 29 Jun 2023, Olivier Dion <odion@efficios.com> wrote:

>   [0] https://godbolt.org/z/3nW14M3v1
>   [1] https://godbolt.org/z/TcTeMeKbW

Sorry.  That was:

    [0] https://godbolt.org/z/ETcxnz4TW
    [1] https://godbolt.org/z/jMjh8YoM4

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
