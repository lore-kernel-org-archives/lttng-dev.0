From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: Use lttng for my own module which already has trace
 events
Date: Tue, 8 Oct 2013 13:25:28 +0200
Message-ID: <5253EBA8.2050205__6944.88053345612$1381231580$gmane$org@mentor.com>
References: <6B3AC2788014DD49B43AF9611365BBAA21CACCA460@mary.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VTVQ2-0006Qe-0L
	for lttng-dev@lists.lttng.org; Tue, 08 Oct 2013 07:25:40 -0400
In-Reply-To: <6B3AC2788014DD49B43AF9611365BBAA21CACCA460@mary.at.omicron.at>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Lausch <michael.lausch@omicron.at>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 10/08/2013 01:03 PM, Michael Lausch wrote:
> Hi,
>
> I've developed a kernel module which defines TRACE_EVENTS. These events
> are shown in /sys/kernel/debug/tracing/events and i can read them
> from /sys/kernel/debug/tracing/trace if they are enabled.
>
> But i want to use these events in lttng. 
> # lttng list -k 
> does not show them. 

You need to add an lttng probe in lttng-modules to expose your ftrace
events as lttng kernel events.
See: http://git.lttng.org/?p=lttng-modules.git;a=tree;f=probes;hb=HEAD

1) Add e.g. "obj-m += lttng-probe-mycustomevents.o" in
http://git.lttng.org/?p=lttng-modules.git;a=blob_plain;f=probes/Makefile;hb=HEAD
2) Create the probe source file based on some existing probe source
file, e.g.
http://git.lttng.org/?p=lttng-modules.git;a=blob;f=probes/lttng-probe-vmscan.c;hb=HEAD
3) Add a header file that describes your events as lttng events in:
../instrumentation/events/lttng-module/mycustomevents.h
use e.g.
http://git.lttng.org/?p=lttng-modules.git;a=blob;f=instrumentation/events/lttng-module/udp.h;hb=HEAD
as a template.

HTH,
Paul

-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
