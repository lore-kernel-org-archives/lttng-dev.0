From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Question about lttng daemons
Date: Thu, 26 Jul 2012 10:41:18 -0400
Message-ID: <5011570E.3060200__32520.7695518204$1343313759$gmane$org@voxpopuli.im>
References: <5010FFA8.9000706@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1SuPG2-0003xv-Bi
	for lttng-dev@lists.lttng.org; Thu, 26 Jul 2012 10:41:42 -0400
In-Reply-To: <5010FFA8.9000706@emc.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: changz <zheng.chang@emc.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

I can answer your first question ;)


On 12-07-26 04:28 AM, changz wrote:
> Hi all,
>
> Is that possible to launch lttng daemons as a system service? i.e. we
> can start/stop/restart it like the services under /etc/init.d.

Absolutely. Note that you only need to auto-start the lttng-sessiond.
The consumerd daemons get started automatically by the sessiond when
trace sessions are created. This is a nice way to start a root session
daemon at boot time, which then allows users in the "tracing" group to
use the kernel tracer without being root themselves.

We don't ship an example in the source tree, since this is usually
distro-specific, but for reference you can look at the Upstart script
that is available in the Ubuntu package:
http://bazaar.launchpad.net/~ubuntu-branches/ubuntu/quantal/lttng-tools/quantal/view/head:/debian/lttng-tools.lttng-sessiond.upstart


Alex

> Another concern is if here is a way to recover or continue the
> dataflow once the daemons get crashed.
> I hope some vital trace info can be still kept even if daemon crashes.
>
> BR
> zheng
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
