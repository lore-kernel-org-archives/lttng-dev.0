From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Limited event types displayed.
Date: Thu, 19 Feb 2015 13:52:51 -0500
Message-ID: <54E63103.2060207__47041.6763484993$1424372054$gmane$org@voxpopuli.im>
References: <8369DAE2C5B8814998E89CE414A915381F6B7DFB@IT-Mailbox3.TTPGroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1YOWDZ-0004Xc-OW
 for lttng-dev@lists.lttng.org; Thu, 19 Feb 2015 13:53:02 -0500
In-Reply-To: <8369DAE2C5B8814998E89CE414A915381F6B7DFB@IT-Mailbox3.TTPGroup.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Neil Bryan <Neil.Bryan@ttp.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

On 02/19/2015 06:31 AM, Neil Bryan wrote:
> Hello Forum,
>
> Now that I have got LTTng built, I have tried some preliminary tests. Unfortunately the results are not quite as I expect.
> I have used LTTng previously, although I did not perform the kernel integration. Using Eclipse TFM I could see various processes in the Control Flow tab.
> With low-level kernel events (interrupts, sched_wakeup etc) causing threads to run or remain blocked. On my system I only see event data in the Histogram view and in the Statistics tab.
> Something has not been enabled in my build (tracepoints?) and I only have a limited amount of instrumentation. My Control Flow tab is blank and I don't see any driver threads or stuff
> that I am interested. Any clues as to what is missing?

If you import a kernel trace as a "Generic CTF Trace", the viewer will 
only use information common to all CTF traces, which is not much. To get 
the kernel-specific views and anlaysis working, it needs to be imported 
as a "LTTng kernel trace". But then you said this was not working:

> I imported this into eclipse as a Generic CTF Trace. Using LTTng kernel trace gave me a Validation Failed error.

Which version of LTTng are you using? As mentioned in the other thread, 
you should make sure to use a recent version. To validate kernel traces, 
we verify that the trace's metadata (in the "metadata" file) contains 
"domain = kernel" in its environment. I don't remember in which version 
exactly this was added, and I'm not sure it was present in LTTng 2.0.

> I have checked the plug-ins and features on eclipse (Version: Kepler Service Release 2
> Build id: 20140224-0627) and all looks sensible.

This is also quite old ;) The LTTng integration plugins for Eclipse have 
recently moved to the Trace Compass project [1]. You can find the latest 
versions on the Downloads page [2], both for the stand-alone program, 
and the plugins to add to an existing Eclipse installation.


Cheers,
Alexandre


[1] http://www.eclipse.org/tracecompass
[2] http://projects.eclipse.org/projects/tools.tracecompass/downloads
