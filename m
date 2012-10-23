From: "McDermott, Andrew" <Andrew.McDermott@windriver.com>
Subject: Re: status of lttng top
Date: Tue, 23 Oct 2012 13:11:16 +0000
Message-ID: <7F632A9222059A42AF70FCB7965774AA20860D77__20806.8652231761$1350997916$gmane$org@ALA-MBB.corp.ad.wrs.com>
References: <7F632A9222059A42AF70FCB7965774AA20627EAB@ALA-MBB.corp.ad.wrs.com>
	<507389DE.4000204@efficios.com>
	<7F632A9222059A42AF70FCB7965774AA20854D6F@ALA-MBB.corp.ad.wrs.com>
	<50858BF9.705@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.windriver.com ([147.11.146.13])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew.McDermott@windriver.com>) id 1TQeGS-0005y7-MX
	for lttng-dev@lists.lttng.org; Tue, 23 Oct 2012 09:11:24 -0400
In-Reply-To: <50858BF9.705@efficios.com> (Julien Desfossez's message of
	"Mon,	22 Oct 2012 14:10:01 -0400")
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


Hi,

> On 22/10/12 07:00 AM, McDermott, Andrew wrote:
>> 
>> Hi,
>> 
>>> LTTngTop is still work in progress and will remain that way for a long
>>> time, but the version in the PPA (or in the master branch in git) is
>>> perfectly usable for offline traces (traces recorded and replayed
>>> through LTTngTop).
>>>
>>> The "live" branch is more experimental and requires patches in both
>>> Babeltrace and Lttng-tools (all documented in the README-LIVE file), but
>>> it worked at the time of Plumbers, I didn't have much time since then to
>>> rebase the branches.
>>>
>>> I am waiting for the release of Lttng-tools 2.1 (currently in RC) before
>>> merging those patches. After these patches are integrated, LTTngTop will
>>> be able to work live without any modifications, so directly reading
>>> traces in memory shared with the tracer.
>> 
>> Thanks for this info.
>> 
>> Right now my interest is with the live streaming; we have a use case
>> where the live streaming is really the only practical solution.
>> 
>> Very roughly, would you expect the RC series to conclude this year, or
>> (early) next year?
>
> Just to clarify, are you interested in live network trace reading or
> live in-memory reading ?
> The patches I was talking about are for in-memory trace reading.

So I guess I don't understand enough of the low-level detail here.  What
I was interested in was being able to consume events, maybe periodically
(1 /s), from a trace written by another process on the same machine.  I
guess that would fall under in-memory trace reading.

-- 
andy
