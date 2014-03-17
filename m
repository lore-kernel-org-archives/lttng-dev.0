From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Trace just the my application processes
Date: Mon, 17 Mar 2014 16:04:18 -0700
Message-ID: <1395097458.6936.5.camel__12360.7581634589$1395097522$gmane$org@fylkir>
References: <9531e427eaa14e45a70927ac5e8643dd@Perses.usurf.usu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1WPga2-0002sq-95
	for lttng-dev@lists.lttng.org; Mon, 17 Mar 2014 19:04:30 -0400
In-Reply-To: <9531e427eaa14e45a70927ac5e8643dd@Perses.usurf.usu.edu>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Jon,

If you use a semi-recent version of the Eclipse viewer (like the RCP one
at http://lttng.org/eclipse ), it is possible to filter the entries in
the CFV. Look for the left-most button in the view's toolbar.

There is also the possibility to add filters at the tracer level when
you setup your tracing session. I'm not too familiar with that though,
perhaps one of the LTTng devs can give some details.

Cheers,
Alexandre


On Mon, 2014-03-17 at 22:38 +0000, Jonathan Haws wrote:
> I'm sure this question has been asked, but no amount of searching has helped so far...
> 
> I have a suite of programs that I would like to enable tracing for and be able to view the control flow, statistics, etc. in the Eclipse plugin.  How is this done?  I have instrumented my code for UST and enabled all the necessary kernel events and I get good trace data, but I would like to prefilter all the stuff not associated with my processes.  If the data is there, that is fine (I will probably want it) but is there any way to capture data on just the desired processes?  What about being able to hide things in the Control Flow view?
> 
> Thanks!
> Jon
