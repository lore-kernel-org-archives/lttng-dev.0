From: David Goulet <dgoulet@efficios.com>
Subject: Re: Issue faced in logging the traces
Date: Fri, 15 Feb 2013 09:29:19 -0500
Message-ID: <511E463F.2080605__21927.4427312941$1360938608$gmane$org@efficios.com>
References: <CAG15VGA_O+6P9cLT8h3U-_W=YUVHEVFiBN5Zrm6Gj4i1qBV6BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1U6MHy-0002Xx-Hw
	for lttng-dev@lists.lttng.org; Fri, 15 Feb 2013 09:29:22 -0500
In-Reply-To: <CAG15VGA_O+6P9cLT8h3U-_W=YUVHEVFiBN5Zrm6Gj4i1qBV6BQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Vivek Kumar <vivekkumar.p@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Vivek,

In order to collect a trace you need to instrument your application with
LTTng-UST tracepoints.

If you like to gather the syscalls for instance, you need to install the
LTTng modules and start your session daemon as root.

If you are still experiencing problem, please provide the commands you
use and setup.

Thanks!
David

Vivek Kumar:
> Hi,
>  
> I am trying to port LTTng to my arm based board.
> For userspace tracing, I have been able to successfully port followings:
> LTTng-tools,
> LTT-ust Library
> Userspace-rcu
> libpopt
>  
> Now I can see that lttng-sessiond is running, and am able to create
> sessions, enable-event and start and stop tracing.
> But, I don't see traces be logged in the home directory (indeed nothing
> happens, i.e, not even the creation of the base directory -> lttng-traces).
> Am I missing anything because of that LTTng is failing to log traces?
> Please help.
>  
> Regards, Vivek
> 
> 
> -- 
> Best, Vivek
> 
> 
> This body part will be downloaded on demand.
