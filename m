From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Stress tests added to ctf testsuite
Date: Sun, 16 Nov 2014 20:49:33 +0000 (UTC)
Message-ID: <1931444595.14255.1416170973715.JavaMail.zimbra__40489.9665191353$1416171015$gmane$org@efficios.com>
References: <1259876374.14213.1416156117524.JavaMail.zimbra@efficios.com>
 <54690B90.308@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Xq6lQ-00047q-8G
 for lttng-dev@lists.lttng.org; Sun, 16 Nov 2014 15:49:41 -0500
In-Reply-To: <54690B90.308@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Trace Compass Developer Discussions <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

Can you modify Junit, or use a different test system,
to allow calling scripts instead ? I expect we will end up having
much more automatically generated test-cases over time, and the more
we will have, the less sense it will make to generate them all at
test start.

Thanks!

Mathieu

----- Original Message -----
> From: "Alexandre Montplaisir" <alexmonthy@voxpopuli.im>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Matthew Khouzam" <matthew.khouzam@ericsson.com>
> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>, "Trace Compass Developer Discussions" <tracecompass-dev@eclipse.org>
> Sent: Sunday, November 16, 2014 9:39:44 PM
> Subject: Re: Stress tests added to ctf testsuite
> 
> Hi Mathieu,
> 
> Looks great! Preliminary testing shows that Trace Compass also blows up
> in many different ways, but hey that's expected ;)
> 
> If I may suggest, having a script, either shell or Python, to just
> generate/clean the test traces would be very useful.
> We don't use the run.sh scripts in CI (we're within JUnit tests, there
> is no executable at that point), we just look at the trace directories
> and try to run everything in there. If there was a simple way to "create
> everything" and then "clean everything" it would make it easier to
> integrate in our (and I guess others') build system.
> 
> Cheers,
> Alexandre
> 
> 
> On 2014-11-16 11:41 AM, Mathieu Desnoyers wrote:
> > Hi!
> >
> > If you look at
> > https://github.com/efficios/ctf-testsuite
> >
> > I just pushed various CTF stress-tests, and did some
> > general cleanup in the tree (e.g. renaming tests to
> > meaningful names).
> >
> > Have fun!
> >
> > Thanks,
> >
> > Mathieu
> >
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
