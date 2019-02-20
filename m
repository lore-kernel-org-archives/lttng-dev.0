From: Trent Piepho via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Tracepoints firing without being enabled in LTTng
Date: Wed, 20 Feb 2019 19:08:22 +0000
Message-ID: <1550689701.3075.142.camel__37519.1227694572$1550717106$gmane$org@impinj.com>
References: <CAJyWpKEMbN8RHuGbODZYFiOff_pN08Zn4A=6dMEEe7C7h3nn1g@mail.gmail.com>
 <CAJyWpKH2TWmCXhvtSaE-h+jKfmt8aKQ0MaYOr_TqQ0q+M1f_gw@mail.gmail.com>
 <CADcCL0hnLNyzOvfpBRW=TzDR9Ekckei5NGOqpAQ=rMUpGnRLEQ@mail.gmail.com>
 <CAJyWpKEgHDa2gPte2eTVg9UCo6RBOBKfPLg9XFUyVcVxMoj8tA@mail.gmail.com>
 <CADcCL0gt=kQop0miSLD3edcKLNERgg+XEjmgkvzdX=A4t_MzuQ@mail.gmail.com>
 <CAJyWpKGEC5dXZXWTupdJA6BVUQhzp5dT-jDX6iX_EE=JrvU4KA@mail.gmail.com>
 <CADcCL0ieGaTA4_=rxaLT2=LAuhQdJGfjM7HYg34eTo-Oo_JDYg@mail.gmail.com>
 <CAJyWpKG2mJJ-DnHLr1gRhrPw5Qsj=TT0j_5FCaQKv7t0qkqcdA@mail.gmail.com>
 <1429830431.1895.1550674017298.JavaMail.zimbra@efficios.com>
 <CAJyWpKHVzmnJp5Mjc9ddQncHM54=b5Ecr2GcpdLLx_8hXojdEw@mail.gmail.com>
 <20190220185310.GC4583@joraj-alpa>
Reply-To: Trent Piepho <tpiepho@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770110.outbound.protection.outlook.com [40.107.77.110])
 by lists.lttng.org (Postfix) with ESMTPS id 444f2W37gWzh4Z
 for <lttng-dev@lists.lttng.org>; Wed, 20 Feb 2019 21:44:50 -0500 (EST)
In-Reply-To: <20190220185310.GC4583@joraj-alpa>
Content-Language: en-US
Content-ID: <83EAB0F380AC6F4892553A81C74045F4@namprd06.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "jonathan.rajotte-julien@efficios.com" <jonathan.rajotte-julien@efficios.com>, "mosleh1235@gmail.com" <mosleh1235@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, 2019-02-20 at 13:53 -0500, Jonathan Rajotte-Julien wrote:
> On Wed, Feb 20, 2019 at 01:43:00PM -0500, Mosleh Uddin wrote:
> > Hello,
> > 
> > I see, I was loading the liblttng-ust-fd but not fork. Once loading
> > both of
> > these with LD_PRELOAD everything seems to be working great. Thank
> > you for
> > all your assistance.
> > 
> > I was also wondering, it may be impractical to always load these
> > shared
> > objects because the systems starts the app service on boot. Is
> > there an
> 
> How is it not practical? I fail to see the problem with launching the
> application with LD_PRELOAD set inside the service.

One should be able to add LD_PRELOAD to an Environment line in a
systemd unit file.  But beware, from ld.so docs:

In secure-execution mode, preload pathnames containing slashes are
ignored.  Furthermore, shared objects are preloaded only from the
standard search directories and only if they have set-user-ID mode bit
enabled (which is not typical).

Another way that setting ld_preload can be hard is when the program
that needs it is started by another process that does not need it. 
Like say "mount" will fork and exec "losetup".  How do you set
LD_PRELOAD for just losetup without getting mount too?  Modify the code
of mount to inject an environment variable?  Make a wrapper script
named losetup that sets LD_PRELOAD and runs the real losetup binary?
