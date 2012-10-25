From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: status of lttng top
Date: Thu, 25 Oct 2012 14:40:31 -0400
Message-ID: <5089879F.50701__25751.8986044035$1351190478$gmane$org@efficios.com>
References: <7F632A9222059A42AF70FCB7965774AA20627EAB@ALA-MBB.corp.ad.wrs.com>
	<507389DE.4000204@efficios.com>
	<7F632A9222059A42AF70FCB7965774AA20854D6F@ALA-MBB.corp.ad.wrs.com>
	<50858BF9.705@efficios.com>
	<7F632A9222059A42AF70FCB7965774AA20860D77@ALA-MBB.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([194.250.102.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TRSMC-0005V4-Tl
	for lttng-dev@lists.lttng.org; Thu, 25 Oct 2012 14:40:41 -0400
In-Reply-To: <7F632A9222059A42AF70FCB7965774AA20860D77@ALA-MBB.corp.ad.wrs.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "McDermott, Andrew" <Andrew.McDermott@windriver.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

>>>> LTTngTop is still work in progress and will remain that way for a long
>>>> time, but the version in the PPA (or in the master branch in git) is
>>>> perfectly usable for offline traces (traces recorded and replayed
>>>> through LTTngTop).
>>>>
>>>> The "live" branch is more experimental and requires patches in both
>>>> Babeltrace and Lttng-tools (all documented in the README-LIVE file), but
>>>> it worked at the time of Plumbers, I didn't have much time since then to
>>>> rebase the branches.
>>>>
>>>> I am waiting for the release of Lttng-tools 2.1 (currently in RC) before
>>>> merging those patches. After these patches are integrated, LTTngTop will
>>>> be able to work live without any modifications, so directly reading
>>>> traces in memory shared with the tracer.
>>>
>>> Thanks for this info.
>>>
>>> Right now my interest is with the live streaming; we have a use case
>>> where the live streaming is really the only practical solution.
>>>
>>> Very roughly, would you expect the RC series to conclude this year, or
>>> (early) next year?
>>
>> Just to clarify, are you interested in live network trace reading or
>> live in-memory reading ?
>> The patches I was talking about are for in-memory trace reading.
> 
> So I guess I don't understand enough of the low-level detail here.  What
> I was interested in was being able to consume events, maybe periodically
> (1 /s), from a trace written by another process on the same machine.  I
> guess that would fall under in-memory trace reading.
> 

Ok I will just describe this a little more, when we talk about live
reading the trace, we have two aspects :
- reading a trace while it is being written on disk (whether it is
received from the network or from a local consumer)
- reading a trace directly from memory mapped buffers between the tracer
and the consumer without writing the trace files.

So if you want to read the trace on the machine that is being traced
without ever writing the trace on disk, yes you want the in-memory trace
reading.

For 2.2, the focus is to support live trace reading from disk (local and
network).
In my development branches (referenced in previous email), I have code
that provides live trace reading from memory, I will try to merge it in
2.2 but I cannot guarantee it will be accepted since it is not the
current priority (but definitely a use-case we want to support).

I hope it clarifies the situation,

Thanks,

Julien
