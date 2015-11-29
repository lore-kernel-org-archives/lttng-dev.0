From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng on aarch64 platform
Date: Sun, 29 Nov 2015 14:58:43 +0000 (UTC)
Message-ID: <1656873418.171234.1448809123603.JavaMail.zimbra__25433.1593787812$1448809185$gmane$org@efficios.com>
References: <5658933A.4060408@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1a33RK-0007zl-Pm
 for lttng-dev@lists.lttng.org; Sun, 29 Nov 2015 09:59:02 -0500
In-Reply-To: <5658933A.4060408@parrot.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Ronan CHAUVIN <ronan.chauvin@parrot.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Nov 27, 2015, at 6:30 PM, Ronan CHAUVIN ronan.chauvin@parrot.com wrote:

> Hello all,
> 
> I am trying to use lttng 2.7.0 on an aarch64 platform. When I create my
> session a trap is triggered which indicated that a unknow syscall (389)
> is called.
> 
> / # lttng -vvv create mysession
> DEBUG1 - 02:36:22.271714 [850/850]: Session daemon binary path:
> /usr/bin/lttng-sessiond (in launch_sessiond() at commands/create.c:668)
> Spawning a session daemon
> DEBUG1 - 02:36:24.275751 [850/850]: Session daemon terminated normally
> (exit status: 1) (in spawn_sessiond() at commands/create.c:606)
> Error: Session daemon terminated with an error (exit status: 1)
> Error: Problem occurred while launching session daemon
> (/usr/bin/lttng-sessiond)
> Error: Command error
> DEBUG1 - 02:36:24.275899 [850/850]: Clean exit (in clean_exit() at
> lttng.c:193)
> 
> It seems that lttng-sessiond deamon is directly exited. Has anyone
> already tried on a 3.10 kernel and aarch64 platform?

Hi Ronan,

That's because your liburcu calls the new membarrier system call, which was
introduced later than your kernel. The way it works is that if the membarrier
system call returns -1, errno=ENOSYS, it falls-back to a liburcu implementation
which does not need the membarrier system call. This question here is: why
does your kernel trap when an unknown system call is invoked ?

Thanks,

Mathieu

> 
> Thanks in advance,
> 
> --
> Ronan CHAUVIN
> Embedded Software Engineer
> ASIC & Video team
> --------------------------------
> Parrot SA
> 174, quai de Jemmapes
> 75010 Paris, France
> --------------------------------
> www.parrot.com
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
