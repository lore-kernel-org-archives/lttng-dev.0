From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Tracepoints firing without being enabled in LTTng
Date: Wed, 20 Feb 2019 15:05:58 -0500
Message-ID: <20190220200558.GD4583__47364.766783879$1550693178$gmane$org@joraj-alpa>
References: <CADcCL0hnLNyzOvfpBRW=TzDR9Ekckei5NGOqpAQ=rMUpGnRLEQ@mail.gmail.com>
 <CAJyWpKEgHDa2gPte2eTVg9UCo6RBOBKfPLg9XFUyVcVxMoj8tA@mail.gmail.com>
 <CADcCL0gt=kQop0miSLD3edcKLNERgg+XEjmgkvzdX=A4t_MzuQ@mail.gmail.com>
 <CAJyWpKGEC5dXZXWTupdJA6BVUQhzp5dT-jDX6iX_EE=JrvU4KA@mail.gmail.com>
 <CADcCL0ieGaTA4_=rxaLT2=LAuhQdJGfjM7HYg34eTo-Oo_JDYg@mail.gmail.com>
 <CAJyWpKG2mJJ-DnHLr1gRhrPw5Qsj=TT0j_5FCaQKv7t0qkqcdA@mail.gmail.com>
 <1429830431.1895.1550674017298.JavaMail.zimbra@efficios.com>
 <CAJyWpKHVzmnJp5Mjc9ddQncHM54=b5Ecr2GcpdLLx_8hXojdEw@mail.gmail.com>
 <20190220185310.GC4583@joraj-alpa>
 <1550689701.3075.142.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 444TBJ4G99zgg0
 for <lttng-dev@lists.lttng.org>; Wed, 20 Feb 2019 15:06:00 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1550689701.3075.142.camel@impinj.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Trent Piepho <tpiepho@impinj.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> One should be able to add LD_PRELOAD to an Environment line in a
> systemd unit file.  But beware, from ld.so docs:
> 
> In secure-execution mode, preload pathnames containing slashes are
> ignored.  Furthermore, shared objects are preloaded only from the
> standard search directories and only if they have set-user-ID mode bit
> enabled (which is not typical).

Those are all valid constraints and if I'm not mistaken can be controlled by a
system administrator. Thanks for bringing it up.

> 
> Another way that setting ld_preload can be hard is when the program
> that needs it is started by another process that does not need it. 
> Like say "mount" will fork and exec "losetup".  How do you set
> LD_PRELOAD for just losetup without getting mount too?  Modify the code
> of mount to inject an environment variable?

Unfortunately, for now, yes, if you know that the application that you exec is
instrumented with lttng and will perform either a fork call not followed by an
exec (family) call and/or close all FDs.

> Make a wrapper script
> named losetup that sets LD_PRELOAD and runs the real losetup binary?

This is valid option.

We do have a potential solution to eliminate the need of preloading the fork
wrapper but we did not yet have time to work on it.

As for the FD lib utility (liblttng-ust-fd) we are open to opinion on how to
solve the problem and make liblttng-ust-fd obsolete.

Cheers
-- 
Jonathan Rajotte-Julien
EfficiOS
