From: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>
Subject: Re: error in generation of trace files
Date: Thu, 27 Feb 2014 15:44:23 -0500
Message-ID: <1393533863.530fa3a7d01c8__5694.47158272869$1393533931$gmane$org@www.imp.polymtl.ca>
References: <CAB7sTjgY9OpaQG-Cs2gnHA6s3+hHuutkP=6wPPVq5TkfdY-hng@mail.gmail.com>
	<20140227134247.GA7407@thessa>
	<CAB7sTjjHMizJVJOYCpqED=rzt=+KJB_2Nxjf7X2C2y2+G=E_sA@mail.gmail.com>
	<20140227135748.GB7407@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <suchakrapani.sharma@polymtl.ca>) id 1WJ7oi-0001XF-5b
	for lttng-dev@lists.lttng.org; Thu, 27 Feb 2014 15:44:33 -0500
In-Reply-To: <20140227135748.GB7407@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Mariya Rampurawala <mariya.r26@gmail.com>
List-Id: lttng-dev@lists.lttng.org

Aah..someone is already replying. I should look at my inbox more carefully then
:-/

Ignore my previous message.

Quoting David Goulet <dgoulet@efficios.com>:

<SNIP>

> CCing back lttng-dev ML. If you have this problem, others have! :)
>
> Ok so this means that you enable all user space event for that session
> so you need to have an application that is instrumented with LTTng
> userspace tracer (lttng-ust) in order to collect data from that app.
> There are multiple examples in the git repository.
>
> For the kernel (-a -k), you need to install lttng-modules and start
> lttng-sessiond as root (or set yourself in the "tracing" group).
>
> Hope this help!

<SNIP>

--
Suchakra
