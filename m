From: David Goulet <dgoulet@efficios.com>
Subject: Re: [GSoC 2013] projects information
Date: Mon, 15 Apr 2013 11:02:43 -0400
Message-ID: <516C1693.7020908__29882.7918283225$1366038190$gmane$org@efficios.com>
References: <1365761741.59268.YahooMailNeo@web122204.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1URkve-0003fo-O8
	for lttng-dev@lists.lttng.org; Mon, 15 Apr 2013 11:02:47 -0400
In-Reply-To: <1365761741.59268.YahooMailNeo@web122204.mail.ne1.yahoo.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Claudiu Olteanu <olteanu.claudiu@ymail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Claudiu,

I can give you more details for the strace-alike wrapper.

The lttng command line is a git alike such as "lttng create [...]" or
"lttng enable-event [...]". What we are looking to do is a "lttng trace
[...]" that behaves like strace meaning it will activate syscall
tracing, live mode and/or the application tracepoints if available.

Now, by the end of July, we are expecting to have the live feature
meaning that you can see a trace while it's being written. We'll also
need filtering in lttng-modules (available in UST) so only syscalls made
by the application are recorded. Furthermore, per-PID tracing in UST
would be awesome to complement "lttng trace" with the application's
tracepoints.

As you can see, there is a lot to do but the end result will be a very
useful tool which is "strace" type of tool that does NOT use PTRACE and
change the behavior of your application :). (with greater performance).

Kernel filtering, per-PID tracing in UST, "lttng trace" command... pick
your choice :)

Thanks!
David

Claudiu Olteanu:
> Hi there!
> 
> My name is Claudiu Olteanu, I'm from Bucharest, Romania and I study at
> the University 'Politehnica' of Bucharest, the Faculty of Automatic
> Control and Computers Science. I'm a third year student and I would like
> to participate to GSoC this summer. After I took a look at the projects
> list I decided that it would be interesting and motivating to work on
> one of these projects :
>  - Trace probe support in C++
>  - Development of an strace-alike wrapper
> 
> I will appreciate it if you give me more details about them and some
> advice that can put me on track.
> 
> You can find my CV here[1] in case you want to know more about me.
> 
> Regards,
> Claudiu
> 
> [1] -
> https://docs.google.com/file/d/0BwSntkUS-WYzVUVoZkYxdzNvNmc/edit?usp=sharing
> 
> 
> 
> This body part will be downloaded on demand.
