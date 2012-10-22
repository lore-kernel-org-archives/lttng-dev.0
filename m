From: "McDermott, Andrew" <Andrew.McDermott@windriver.com>
Subject: Re: status of lttng top
Date: Mon, 22 Oct 2012 11:00:03 +0000
Message-ID: <7F632A9222059A42AF70FCB7965774AA20854D6F__14149.5454627604$1350903649$gmane$org@ALA-MBB.corp.ad.wrs.com>
References: <7F632A9222059A42AF70FCB7965774AA20627EAB@ALA-MBB.corp.ad.wrs.com>
	<507389DE.4000204@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.windriver.com ([147.11.146.13])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew.McDermott@windriver.com>) id 1TQFjv-00020z-Mv
	for lttng-dev@lists.lttng.org; Mon, 22 Oct 2012 07:00:11 -0400
In-Reply-To: <507389DE.4000204@efficios.com> (Julien Desfossez's message of
	"Mon, 8 Oct 2012 22:20:14 -0400")
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

> LTTngTop is still work in progress and will remain that way for a long
> time, but the version in the PPA (or in the master branch in git) is
> perfectly usable for offline traces (traces recorded and replayed
> through LTTngTop).
>
> The "live" branch is more experimental and requires patches in both
> Babeltrace and Lttng-tools (all documented in the README-LIVE file), but
> it worked at the time of Plumbers, I didn't have much time since then to
> rebase the branches.
>
> I am waiting for the release of Lttng-tools 2.1 (currently in RC) before
> merging those patches. After these patches are integrated, LTTngTop will
> be able to work live without any modifications, so directly reading
> traces in memory shared with the tracer.

Thanks for this info.

Right now my interest is with the live streaming; we have a use case
where the live streaming is really the only practical solution.

Very roughly, would you expect the RC series to conclude this year, or
(early) next year?

> In the meantime we are working on replacing the "home made" state system
> in LTTngTop with a more generic one (which will be used also in LTTV),
> this will cleanup this part of the code and allow to store the state on
> disk. So in a near future we will be able to only read the state instead
> of the trace (once it has been generated), which will compress
> significantly the amount of data we need to keep in order to access the
> kind of statistics provided by LTTngTop.
>
> If you want to try LTTngTop, you can just install the package and follow
> the man page to record a trace with the right contexts, it should work
> as is.
>
> If you have any questions and/or feedback, please don't hesitate to ask.
>
> Thanks,
>
> Julien
>
>
> On 08/10/12 05:57 PM, McDermott, Andrew wrote:
>> I was wondering what the status of lttng top was.  I'm happy to add the
>> daily Ubuntu PPA and try it that way, or equally building from source.
>>  But, before I tread that route, are there any gotchas to be aware of.
>> Is it still considered work-in-progress, etc.
>> 
>> Thanks.
>> 
>> 
>> 
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
