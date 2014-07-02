From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-ust] Implement register_done
 waiting via LD_AUDIT
Date: Wed, 2 Jul 2014 14:20:47 +0000 (UTC)
Message-ID: <155121331.7082.1404310847950.JavaMail.zimbra__19032.8951961876$1404310912$gmane$org@efficios.com>
References: <1404226029-9092-1-git-send-email-paul_woegerer@mentor.com>
 <alpine.LNX.2.00.1407011902580.15415@monopod.intra.ispras.ru>
 <53B2DDDB.3090102@mentor.com>
 <alpine.LNX.2.00.1407012102010.15415@monopod.intra.ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1X2LP1-0005lX-7X
 for lttng-dev@lists.lttng.org; Wed, 02 Jul 2014 10:20:57 -0400
In-Reply-To: <alpine.LNX.2.00.1407012102010.15415@monopod.intra.ispras.ru>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexander Monakov <amonakov@ispras.ru>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Alexander Monakov" <amonakov@ispras.ru>
> To: "Paul Woegerer" <Paul_Woegerer@mentor.com>
> Cc: lttng-dev@lists.lttng.org, "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Tuesday, July 1, 2014 1:14:16 PM
> Subject: Re: [lttng-dev] [RFC PATCH lttng-ust] Implement register_done waiting via LD_AUDIT
> 
> On Tue, 1 Jul 2014, Woegerer, Paul wrote:
> > Unfortunately the current approach of delaying execution of main until
> > lttng-ust is available has several drawbacks. E.g. the dynamic linker
> > lock is taken during the execution the static ctor. Using glibc
> > functions that also require the same lock as part of the lttng-ust
> > initialization easily gets us into a deadlock situation.
> 
> That's surprising; in my experience dlopen/dlsym from a static DSO ctor work,
> so I wonder what functions are causing a deadlock for you.

It works because the glibc uses a nestable mutex internally. Unfortunately,
it does not cover our use-case. It can be summarized as this simplified list
of actions:

liblttng-ust constructor executes during application startup (or if lttng-ust is
dlopen'd):
  - spawns 2 lttng-ust listener threads (one for per-user, one for system-wide
    tracing),
  - Within each lttng-ust listener thread:
    - if we can connect to a session daemon, will await commands from the
      session daemon to setup tracing. At the end of the sequence of commands
      for application startup, the session daemon sends a "registration done"
      command.
    - When the registration done command is received, the thread posts the
      "constructor_wait" semaphore,
    - If the lttng-ust listener thread fails to connect to a session daemon,
      it posts the "constructor_wait" semaphore,
  - after having spawned the 2 lttng-ust listener threads, the liblttng-ust
    constructor waits on the "constructor_wait" semaphore, using the
    LTTNG_UST_REGISTER_TIMEOUT as a timeout (see lttng-ust(3)).

So if within the commands executed by the listener thread, we try to use
glibc functions that grab the dynamic loader lock (already being held while
calling constructors), we deadlock in this way:

  - constructor holding dl lock
    - constructor waiting on constructor_wait semaphore

  - listener thread trying to grab dl lock, which needs to be available
    before we can post the semaphore

The issue here is that nestable mutexes are good when a single thread is
trying to grab the same mutex in a nested fashion, but not when this
dependency is transitive through another lock or semaphore.

The reason why we wait on this "constructor_wait" semaphore is to ensure
that events traced at the beginning of the application are indeed traced.

> 
> > This patch is trying to delay execution of main with a different
> > technique (using a named semaphore in la_preinit to wait for lttng-ust
> > initialization).
> 
> Frankly I don't think LD_AUDIT is the right tool for the job in this case,
> even ignoring its flakiness in glibc; better to fix your current approach if
> possible.

Suggestions are very welcome. This issue is a real pain for us, and makes
it tricky to use glibc APIs related to the dynamic loader.

Thanks,

Mathieu

> 
> > Having a stable LD_AUDIT interface would be extremely valuable in the
> > context of tracing.
> 
> Oh, but the interface is extremely stable, it was unchanging for a long time
> now; it's just the implementation... ;)  (sorry, could not resist)
> 
> Also note that LD_AUDIT on Linux is glibc-specific, not available on other
> libcs that are otherwise quite useful, such as Bionic.
> 
> Alexander
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
