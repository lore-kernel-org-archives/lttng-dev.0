From: Michael Lausch <michael.lausch@omicron.at>
Subject: Re: Use lttng for my own module which already has trace
 events
Date: Tue, 8 Oct 2013 14:42:56 +0200
Message-ID: <6B3AC2788014DD49B43AF9611365BBAA21CACCA461__8817.24275318465$1381236229$gmane$org@mary.at.omicron.at>
References: <6B3AC2788014DD49B43AF9611365BBAA21CACCA460@mary.at.omicron.at>
	<5253EBA8.2050205@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ns.omicron.at ([212.183.10.25])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <michael.lausch@omicron.at>) id 1VTWcw-0001qW-Os
	for lttng-dev@lists.lttng.org; Tue, 08 Oct 2013 08:43:04 -0400
In-Reply-To: <5253EBA8.2050205@mentor.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul_Woegerer@mentor.com" <Paul_Woegerer@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, 2013-10-08 at 13:25 +0200, Woegerer, Paul wrote:
> On 10/08/2013 01:03 PM, Michael Lausch wrote:
> > Hi,
> >
> > I've developed a kernel module which defines TRACE_EVENTS. These events
> > are shown in /sys/kernel/debug/tracing/events and i can read them
> > from /sys/kernel/debug/tracing/trace if they are enabled.
> >
> > But i want to use these events in lttng. 
> > # lttng list -k 
> > does not show them. 
> 
> You need to add an lttng probe in lttng-modules to expose your ftrace
> events as lttng kernel events.

I did this, but this has some maintenance problems. I'd like not to
change or add something to the lttng-module source. I'd like to compile
the lttng tracepoints, depending on some config variable int he same
step as the kernel module.

If that's not possible, maintenannce of the module get's a little bit
harder. 

 thanks anyway.
michael
