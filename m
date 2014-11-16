From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Stress tests added to ctf testsuite
Date: Sun, 16 Nov 2014 15:39:44 -0500
Message-ID: <54690B90.308__4228.34850983254$1416170449$gmane$org@voxpopuli.im>
References: <1259876374.14213.1416156117524.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1Xq6c2-00043R-74
 for lttng-dev@lists.lttng.org; Sun, 16 Nov 2014 15:40:02 -0500
In-Reply-To: <1259876374.14213.1416156117524.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Trace Compass Developer Discussions <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

Looks great! Preliminary testing shows that Trace Compass also blows up 
in many different ways, but hey that's expected ;)

If I may suggest, having a script, either shell or Python, to just 
generate/clean the test traces would be very useful.
We don't use the run.sh scripts in CI (we're within JUnit tests, there 
is no executable at that point), we just look at the trace directories 
and try to run everything in there. If there was a simple way to "create 
everything" and then "clean everything" it would make it easier to 
integrate in our (and I guess others') build system.

Cheers,
Alexandre


On 2014-11-16 11:41 AM, Mathieu Desnoyers wrote:
> Hi!
>
> If you look at
> https://github.com/efficios/ctf-testsuite
>
> I just pushed various CTF stress-tests, and did some
> general cleanup in the tree (e.g. renaming tests to
> meaningful names).
>
> Have fun!
>
> Thanks,
>
> Mathieu
>
