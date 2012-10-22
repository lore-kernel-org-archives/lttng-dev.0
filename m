From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: status of lttng top
Date: Mon, 22 Oct 2012 14:10:01 -0400
Message-ID: <50858BF9.705__26451.1202964515$1350929447$gmane$org@efficios.com>
References: <7F632A9222059A42AF70FCB7965774AA20627EAB@ALA-MBB.corp.ad.wrs.com>
	<507389DE.4000204@efficios.com>
	<7F632A9222059A42AF70FCB7965774AA20854D6F@ALA-MBB.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([93.20.26.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TQMS3-0005V5-4B
	for lttng-dev@lists.lttng.org; Mon, 22 Oct 2012 14:10:11 -0400
In-Reply-To: <7F632A9222059A42AF70FCB7965774AA20854D6F@ALA-MBB.corp.ad.wrs.com>
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

Hi Andrew,

On 22/10/12 07:00 AM, McDermott, Andrew wrote:
> 
> Hi,
> 
>> LTTngTop is still work in progress and will remain that way for a long
>> time, but the version in the PPA (or in the master branch in git) is
>> perfectly usable for offline traces (traces recorded and replayed
>> through LTTngTop).
>>
>> The "live" branch is more experimental and requires patches in both
>> Babeltrace and Lttng-tools (all documented in the README-LIVE file), but
>> it worked at the time of Plumbers, I didn't have much time since then to
>> rebase the branches.
>>
>> I am waiting for the release of Lttng-tools 2.1 (currently in RC) before
>> merging those patches. After these patches are integrated, LTTngTop will
>> be able to work live without any modifications, so directly reading
>> traces in memory shared with the tracer.
> 
> Thanks for this info.
> 
> Right now my interest is with the live streaming; we have a use case
> where the live streaming is really the only practical solution.
> 
> Very roughly, would you expect the RC series to conclude this year, or
> (early) next year?

Just to clarify, are you interested in live network trace reading or
live in-memory reading ?
The patches I was talking about are for in-memory trace reading.

Thanks,

Julien
