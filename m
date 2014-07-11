From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 1/1] check if set_schedaffinity works in
 configure.ac
Date: Fri, 11 Jul 2014 15:55:34 +0000 (UTC)
Message-ID: <1676153325.12166.1405094134846.JavaMail.zimbra__39272.4220677794$1405094208$gmane$org@efficios.com>
References: <5394C476.2050707@gmail.com> <5394C521.4040001@gmail.com>
 <5394C810.1000801@gmail.com> <5396042C.2010708@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1X5dAf-0007cu-Gp
 for lttng-dev@lists.lttng.org; Fri, 11 Jul 2014 11:55:42 -0400
In-Reply-To: <5396042C.2010708@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Nathan Lynch <Nathan_Lynch@mentor.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Nathan Lynch" <Nathan_Lynch@mentor.com>
> To: "Pranith Kumar" <bobby.prani@gmail.com>
> Cc: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>, lttng-dev@lists.lttng.org
> Sent: Monday, June 9, 2014 2:59:56 PM
> Subject: Re: [lttng-dev] [RFC PATCH 1/1] check if set_schedaffinity works in configure.ac
> 
> On 06/08/2014 03:31 PM, Pranith Kumar wrote:
> > +    AS_IF([test "x$sched_set_affinity_args" = "x3"], [
> > +        # test if sched_setaffinity works
> > +        AC_MSG_CHECKING([if sched_setaffinity works])
> > +        AC_RUN_IFELSE([AC_LANG_SOURCE([[
> > +                #include <sched.h>
> > +                int main()
> > +                {
> > +                    cpu_set_t foo;
> > +                    return sched_setaffinity(0, sizeof (foo), &foo);
> 
> This passes uninitialized stack memory to the system call; the return
> value is unpredictable.
> 
> If it turns out that such a test is necessary, it should probably call
> sched_getaffinity first and pass the result to sched_setaffinity.
> 

It looks like a respin of the patch taking care
of Nathan's comments is needed here. It might be
a good thing to open a bug report against Userspace
RCU on http://bugs.lttng.org to keep track of this
issue.

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
