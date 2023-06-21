Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8F4EB64D7
	for <lttng-dev@archiver.kernel.org>; Wed, 21 Jun 2023 13:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687355222;
	bh=s7eSws/j3xjh+8sbGxIt8ZqeXYtQiHEMJ6jeAhd8Mh4=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=RgVfhocIUC5zXf5a6ZnxcOr+IckrRojsZMm8ha8zZ7dfuQVFLsPqM790/YdPvIKJc
	 kyse7MV1ZbnbUNFXkM+lWfeZzChKNkhek0O5eQGOCdT52LnVcGOmQdXzq5/XgIHZ6+
	 aDVDPuxwoPffKWYcWlQRWBZ4WsM3pOJawRznukgL84i7qDSw40dxRjNuumps4whQRK
	 k+sndbgWlAcH7swAK7hgwPuUfz73/rWEeesK5CbHrwTkNcHYmUvP2CEdFPg/hEffGP
	 fysr4GpGxTdb2xFYyWidDzplHSonOMayl0uLiAL9iGGVTYPr5aU5vWlrRB63Xbo9UE
	 XAhQNAtPeJoSA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QmPts3QNJz1yS8;
	Wed, 21 Jun 2023 09:47:01 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QmPtq3Dm8z1yh2
 for <lttng-dev@lists.lttng.org>; Wed, 21 Jun 2023 09:46:59 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QmPtn0ySpz18jj;
 Wed, 21 Jun 2023 09:46:57 -0400 (EDT)
Message-ID: <fb397173-040c-9370-c6c7-3c7b1535becb@efficios.com>
Date: Wed, 21 Jun 2023 09:47:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: "Yitschak, Yehuda" <yehuday@amazon.com>, "Mousa, Anas"
 <anasmous@amazon.com>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>
References: <6e06b605ec9f446da5dc8948c8621518@amazon.com>
 <63288a1f-59b4-80f9-2a26-bc252ce9cd1f@efficios.com>
 <900fe19a-5642-9124-4d83-0716e0d11a22@efficios.com>
 <bb2ccac8e296450c96d0863937fc8db8@amazon.com>
In-Reply-To: <bb2ccac8e296450c96d0863937fc8db8@amazon.com>
Subject: Re: [lttng-dev] Profiling LTTng tracepoint latency on different arm
 platforms
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

On 6/21/23 01:39, Yitschak, Yehuda wrote:
>> On 6/20/23 10:20, Mathieu Desnoyers via lttng-dev wrote:
>>> On 6/20/23 06:27, Mousa, Anas via lttng-dev wrote:
>>>> Hello,
>>>
>>>>
>>>>
>> Arethereanysuggestionstorootcausethehighlatencyandpotentiallyimproveito
>> n*platform****1*?
>>>>
>>>> Thanks and best regards,
>>>>
>>>> Anas.
>>>>
>>>
>>> I recommend using "perf" when tracing with the sample program in a
>>> loop to figure out the hot spots. With that information on the "fast"
>>> and "slow" system, we might be able to figure out what differs.
>>>
>>> Also, comparing the kernel configurations of the two systems can help.
>>> Also comparing the glibc versions of the two systems would be relevant.
>>>
>>
>> Also make sure you benchmark the lttng "snapshot" mode [1] to make sure
>> you don't run into a situation where the disk/network I/O throughput cannot
>> cope with the generated event throughput, thus causing the ring buffer to
>> discard events. This would therefore "speed up" tracing from the application
>> perspective because discarding an event is faster than writing it to a ring
>> buffer.
> 
> You mean we should avoid the "discard" loss mode and use "overwrite" loss mode since discard mode can fake fast performance ?

Yes. In addition to use "overwrite-when-buffer-full" mode, the 
"snapshot" session also ensures that no consumer daemon extracts the 
trace data (unless an explicit snapshot record is performed), which 
allows comparing the ring buffer producer performance with minimal noise.

If you really want to benchmark the discard-when-buffer-full mode and 
the the consumer daemon I/O behavior, then you need to take into account 
event discarded counts and the actual trace data size that was written 
to disk.

Thanks,

Mathieu

> 
>>
>> Thanks,
>>
>> Mathieu
>>
>> [1] https://lttng.org/docs/v2.13/#doc-taking-a-snapshot
>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
