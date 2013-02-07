From: David Goulet <dgoulet@efficios.com>
Subject: Re: help on using command lttng enable-event just one
 trace point -u
Date: Thu, 07 Feb 2013 12:51:07 -0500
Message-ID: <5113E98B.9040101__40127.1124523648$1360259514$gmane$org@efficios.com>
References: <CACbTJH8R-Dj6NU9xTMR_Y_znrgaw_84ySr2SKHGZVePNfhrP7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1U3Vcs-0001PD-4R
	for lttng-dev@lists.lttng.org; Thu, 07 Feb 2013 12:51:10 -0500
In-Reply-To: <CACbTJH8R-Dj6NU9xTMR_Y_znrgaw_84ySr2SKHGZVePNfhrP7g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mohammad reza rejali <mohrez.rejali@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

You are probably missing a part of the event name.

Once your application is started, you can use "lttng list -u" to list
the available events for UST tracing. It should look something like that
(this is taken from the hello example in UST code tree).

ust_tests_hello:tptest (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)

$ lttng enable-event ust_tests_hello:tptest -u

When creating a tracepoint event in your application, you have this:

TRACEPOINT_EVENT(ust_tests_hello, tptest, ...)

You have to use both part with ":" between which are the component name
and name of the tracepoint. See lttng-ust(3) for an explanation.

Thanks!
David

mohammad reza rejali:
> Dear Sir/Madam
> 
> I am new in this area, I downloaded the examples and run the sample file
> but there is a problem.
> I used this command lttng enable-event sample_component -u
> But when i use this and lltng start and then stop when I use this
> command lttng view, Nothing show me,the only thing it shows is the
> directory that created for my session.
> On the other hand, when I use lttng enable event -a -u and run my
> code,when i use lttng view i could see the trace.
> I really appreciate your help and thank you in advance.
> 
> Best Regards,
> Mohammad
> 
> 
> This body part will be downloaded on demand.
