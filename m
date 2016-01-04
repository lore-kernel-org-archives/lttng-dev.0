From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Is lttng similar to tools in Wind River Workbench?
Date: Mon, 4 Jan 2016 10:20:40 -0500
Message-ID: <568A8DC8.3020002__30527.9642729603$1451920898$gmane$org@efficios.com>
References: <41302A7145AC054FA7A96CFD03835A0A0BA4D5C2@EX10MBX02.EU.NEC.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1aG6wE-0006Lj-3M
 for lttng-dev@lists.lttng.org; Mon, 04 Jan 2016 10:20:51 -0500
In-Reply-To: <41302A7145AC054FA7A96CFD03835A0A0BA4D5C2@EX10MBX02.EU.NEC.COM>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Aldrich <david.aldrich@emea.nec.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi David,

Well LTTng alone is not really a * graphical trace/profiling tools *. 
You might want to check on Trace Compass [1] for the graphical 
representation of tracing. LTTng is mostly responsible for the trace 
generation/collecting.

LTTng and Trace Compass together is probably what you want. If you are 
more interested in monitoring data and metrics you might also be 
interested by a new project from EfficiOS under the LTTng umbrella: 
lttng-analyses [2].

Cheers!

[1] http://www.tracecompass.org/
[2] https://github.com/lttng/lttng-analyses

On 2016-01-04 09:23 AM, David Aldrich wrote:
> Hi
>
> I am fairly new to Embedded Linux and am looking at the open source tools available for it.
>
> Is lttng similar to the graphical trace/profiling tools supplied with Wind River Workbench?
>
> Are there any other open source graphical profiling/trace tools available for Linux?
>
> Best regards
>
> David
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan R. Julien
Efficios
