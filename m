From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Simple question about tracepoint defs
Date: Wed, 2 Jul 2014 14:25:20 +0000 (UTC)
Message-ID: <1881122758.7106.1404311120916.JavaMail.zimbra__19726.4059250758$1404311179$gmane$org@efficios.com>
References: <CAEEAEzX5h6FL6_cT5UJ+UyQa364jttLheQE6Br03fgZ9MRBW3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1X2LTP-0005p8-EO
 for lttng-dev@lists.lttng.org; Wed, 02 Jul 2014 10:25:28 -0400
In-Reply-To: <CAEEAEzX5h6FL6_cT5UJ+UyQa364jttLheQE6Br03fgZ9MRBW3Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Sandeep K Chaudhary" <babbusandy2006@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Wednesday, July 2, 2014 2:02:25 AM
> Subject: [lttng-dev] Simple question about tracepoint defs
> 
> Hi guys,
> 
> I have a simple question about tracepoint definitions.
> 
> Is it not possible to have two or more trace-point definitions in the
> same header file?
> 
> Reading from the manual[1] as
> 
> "There can be an arbitrary number of tracepoint providers within an
> application, but they must each have their own provider name. Duplicate
> provider names are not allowed.",
> 
> I get the idea that it is not possible since each tracepoint provider
> needs to have unique name, and therefore, should be in a different
> header file.
> 
> Please confirm if this is the case.
> 
> It would be much better for me if it is possible to have multiple
> trace-point definitions in the same header file.

Yes, it is possible. See lttng-ust

doc/examples/demo/ust_tests_demo.h

Thanks,

Mathieu

> 
> [1] https://lttng.org/files/doc/man-pages/man3/lttng-ust.3.html
> 
> Thanks and regards,
> Sandeep.
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
