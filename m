Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEB8C77B7D
	for <lttng-dev@archiver.kernel.org>; Thu, 18 May 2023 19:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684437432;
	bh=AZpIv7DawULSDWeW//ktltTGXptYrfsd3p+hEYa6iRw=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=XS5hnD+g0Q2Mh6BxAnW/f7VuFNyxVdbDGd7kA7VWauUU5GC7X1kito3ha5UBx8l+t
	 l/jPfCbAK1CPZRcaRWzNCYTqAWvHgofGVcpx+C2CIaiXhXK5XyV2mwEfJlT23dGvD/
	 1Bl4U6dDTVGGd4le/XJHaB0ykAUh9LL2HT46sOHGNc7Qm52wTFFKfR6yvuD0qwdo4i
	 2JIZfYcEJ8tWio9RVNEcK8V84ixQZv0IFbsT60DEWRv+Sj5+Vn9S31++6HtPQJrJXf
	 i7JL8KZhyiV1ATsXFZiNk6A+oVV2lzouKTLhFA+Nk14cOyt6zxMAJXSI9IVyHFbvQ8
	 8wnM1s4kGKvbg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QMfqW2xFdz1G8W;
	Thu, 18 May 2023 15:17:11 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QMfqT5Wbqz1Fyp
 for <lttng-dev@lists.lttng.org>; Thu, 18 May 2023 15:17:09 -0400 (EDT)
Received: from [172.16.0.117] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QMfpt6ggwz134x;
 Thu, 18 May 2023 15:16:38 -0400 (EDT)
Message-ID: <ce391c2f-4aae-413f-bcf3-4f3356499f34@efficios.com>
Date: Thu, 18 May 2023 15:16:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Brian Hutchinson <b.hutchman@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <CAFZh4h8C5ZVHGWsBW2iaVYi56t=SsmuiSGZPLf0KpQO9LwfeMQ@mail.gmail.com>
 <2d953bd2-6544-3357-1424-fa44731e2bf5@efficios.com>
 <CAFZh4h95d=U6wj6RxR-z3kDMwJD58cC+DLC5O6UNSsKcschr3w@mail.gmail.com>
 <CAFZh4h9_aAqHngnaErOmvM8c+iBdSSfMnMgeYHbV_N=vEzEYmw@mail.gmail.com>
 <2f8ea79e-9515-854b-d3b0-707baba60b92@efficios.com>
 <CAFZh4h8rZU7Nd-6FptvsibgMXURu0EHKXeouRzNg0mLbTr9t+Q@mail.gmail.com>
 <CAFZh4h_Z6ZrYLV+F7rD_yvr70L_Ryp9GS0Sv12bj0k5QASTXHA@mail.gmail.com>
 <c6d06421-366d-2464-abd3-06cb43dfddeb@efficios.com>
 <CAFZh4h-aD==niaWF9Y=Z=bNm7vsUCWfaxkTBXAewyFXWVndCTg@mail.gmail.com>
In-Reply-To: <CAFZh4h-aD==niaWF9Y=Z=bNm7vsUCWfaxkTBXAewyFXWVndCTg@mail.gmail.com>
Subject: Re: [lttng-dev] Trying to understand use of lttng enable-event
 --kernel --userspace-probe=
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2023-05-18 15:07, Brian Hutchinson wrote:

[...]

>>
>> If you attach to an ELF symbol (function), then there is no USDT in
>> play, so it should not be related to the issue you have.
> 
> That is what I was thinking which is why I wanted to try it.
> 
>>
>> But if your functions happen to be inlined, then there will be nothing
>> to attach to. Perhaps this is what happens there ?
> 
> I don't see any evidence of anything being inlined in this module.  I
> grepped the code to verify.
> 
> Back to being stumped/stuck.

Make sure to check the resulting assembler and ELF symbol tables.

The compiler is free to inline various functions unless they are 
explicitly marked as __attribute__((noinline)). Also, if LTO is enabled, 
further optimization can be done at link-time.

One purpose of the UST tracepoints is to be less fragile with respect to 
specific optimizations done by the compiler and linker, thus 
guaranteeing that whatever is instrumented with a tracepoint is indeed 
available for tracing.

Also, double-check that the path you pass to --userspace-probe really 
targets your executable or .so binary file, and is not just a symbolic link.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
