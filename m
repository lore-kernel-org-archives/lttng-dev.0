From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: Error using add-context for perf counters
Date: Wed, 3 Apr 2013 14:06:10 -0400
Message-ID: <515C6F92.5060803__17557.3809691288$1365012455$gmane$org@ericsson.com>
References: <5148B66A.6080007@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1UNS53-0002HS-NH
	for lttng-dev@lists.lttng.org; Wed, 03 Apr 2013 14:06:41 -0400
In-Reply-To: <5148B66A.6080007@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi, I can confirm this bug, Has anyone else tried it?

On 13-03-19 03:03 PM, Bernd Hufmann wrote:
> Hello
>
> I cannot add contexts for perf counters using lttng-tools v2.1.1 and I
> get an error (see below). When using lttng-tools 2.0.5 (on a different
> computer) it works. Could somebody from lttng development team look
> into that?
>
> Thanks
> Bernd
>
> ----------------------------------------------------------------------
> > lttng create mySession
> Session mySession created.
> Traces will be written in
> /home/bernd/lttng-traces/mySession-20130319-145021
>
> > lttng enable-event -a -k
> All kernel events are enabled in channel channel0
>
> > lttng add-context -k -t perf:branch-misses -t perf:cache-misses
> PERROR: add context ioctl: Invalid argument [in
> kernel_add_channel_context() at kernel.c:47]
> Error: perf:cache-misses: Add kernel context failed
> PERROR: add context ioctl: Invalid argument [in
> kernel_add_channel_context() at kernel.c:47]
> Error: perf:branch-misses: Add kernel context failed
> Warning: Some command(s) went wrong
>
> -----------------------------------------------------------------------
> My setup is:
> Ubuntu 12.04 with kernel 3.2.0-38
> lttng-modules v2.1.1
> lttng-tools v2.1.1
>
>
>
