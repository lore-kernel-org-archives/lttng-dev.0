Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ACAC77B7A
	for <lttng-dev@archiver.kernel.org>; Tue, 16 May 2023 15:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684252666;
	bh=IE2H38xufavJ6VAjS66pByqD7/lIWGjsKVu7r+Kdh9w=;
	h=To:In-Reply-To:References:Date:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=dkOu6QElCJ1qRHuEjyn2TSL0QISXmG9/3g8ZVnkKbc7mhrp2yVBAlaXPqhdLEkOl5
	 TRh7cDlbHkUkp3yGg8iB9VIu5TUstBeDU0B11slme8cAdESkVt9b+ddwacjq5tKjMH
	 l3CL16KwwajRB7bke070xWrZoefuGr+NZSXEGKQbFc527pvVfqpcFSaiMcoiz2bjx6
	 /wnvEYV1EPF1mq2Gne/geJKd5QwNBw3ZvAQX0l9w9JEzAiGAiq4skHE6c88+I4ciMu
	 fm0jJ6rhW+qtFFkQpAwZchZfxh5wSIN8VqvtsKL2rod7xi3KfX5mOb8ThKJBbX5zEP
	 0+iW2+JebEoRg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QLLVL4FJvz1F8H;
	Tue, 16 May 2023 11:57:46 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QLLVG5Hkbz1FXs
 for <lttng-dev@lists.lttng.org>; Tue, 16 May 2023 11:57:42 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QLLTh0vtZz12W3;
 Tue, 16 May 2023 11:57:12 -0400 (EDT)
To: lttng-dev@lists.lttng.org
In-Reply-To: <20230515201718.9809-12-odion@efficios.com>
Organization: EfficiOS
References: <25be655a-d6d4-069d-742b-de80abe69f96@dotat.at>
Date: Tue, 16 May 2023 11:57:11 -0400
Message-ID: <87zg64jmlk.fsf@laura>
MIME-Version: 1.0
Subject: Re: [lttng-dev] [PATCH 11/11] urcu/annotate: Add CMM annotation
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
Cc: Tony Finch <dot@dotat.at>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Tue, 16 May 2023, Tony Finch <dot@dotat.at> wrote:
> The __has_feature pseudo-macro interacts in fun ways with preprocessor
> expression evaluation, because when it is undefined and you write
>
> 	#if defined(__has_feature) && __has_feature(thread_sanitizer)
>
> macro expansion gives you a syntax error
>
> 	#if 0 && 0(thread_sanitizer)
>
> so it must be split into two #if expressions, thus:

TIL.  Thank you for that!

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
