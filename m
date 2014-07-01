From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: [RFC PATCH lttng-ust] Implement register_done
 waiting via LD_AUDIT
Date: Tue, 1 Jul 2014 18:12:11 +0200
Message-ID: <53B2DDDB.3090102__4903.33624552495$1404231176$gmane$org@mentor.com>
References: <1404226029-9092-1-git-send-email-paul_woegerer@mentor.com>
 <alpine.LNX.2.00.1407011902580.15415@monopod.intra.ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Paul_Woegerer@mentor.com>) id 1X20fO-0006Ob-GH
 for lttng-dev@lists.lttng.org; Tue, 01 Jul 2014 12:12:23 -0400
In-Reply-To: <alpine.LNX.2.00.1407011902580.15415@monopod.intra.ispras.ru>
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

Hi Alexander,

The idea of this patch is to prevent deadlocks in the initialization
phase of lttng-ust when forks (e.g. for daemons) are happening in the
traced application.

lttng-ust uses a semaphore to block further execution of the program
until lttng-ust is fully initialized (see lttng-ust-comm.c:1496 in
lttng_ust_init() "switch (timeout_mode)"). The initialization of
lttng-ust happens in the ust_listener_thread that gets started from
lttng_ust_init(). If initialization is done the semaphore gets posted
(search for sem_post) and the static ctor lttng_ust_init() is able to
complete.

Unfortunately the current approach of delaying execution of main until
lttng-ust is available has several drawbacks. E.g. the dynamic linker
lock is taken during the execution the static ctor. Using glibc
functions that also require the same lock as part of the lttng-ust
initialization easily gets us into a deadlock situation.

This patch is trying to delay execution of main with a different
technique (using a named semaphore in la_preinit to wait for lttng-ust
initialization).


Note that this is not the only issue that prevents us from using
LD_AUDIT effectively for our own purposes:

https://sourceware.org/bugzilla/show_bug.cgi?id=11177#c8
prevents us from using my current patch e.g. to trace firefox (and other
applications that link against libicu*.so)

https://sourceware.org/bugzilla/show_bug.cgi?id=16592 prevents us from
using LD_AUDIT as a generic function enter/exit framework for public
functions (all glibc functions, glib, ....).

Having a stable LD_AUDIT interface would be extremely valuable in the
context of tracing. Unfortunately in it's current state it's just a nice
toy to play with.


HTH,
Paul


On 07/01/2014 05:19 PM, Alexander Monakov wrote:
> Hello,
> 
> I'm not aware of the context of this patch, but please note that the amount of
> overhead from non-empty LD_AUDIT is currently extremely high in all released
> Glibc versions.  The forced high overhead is, as I understand, misaligned with
> LTTng's aim to provide low-overhead tracing.
> 
> Non-empty LD_AUDIT behaves as if one of auditing libraries provided PLT hooks.
> This causes the dynamic linker to install register save-restore helpers for
> each PLT call, even if they are not needed (if no PLT hooks were in fact
> provided).
> 
> Here's the Glibc bug that shows a ~19x slowdown on a microbenchmark that
> repeatedly calls sqrt() from libm.so.  The proposed patch was not accepted,
> with the review suggesting a different approach.
> 
> https://sourceware.org/bugzilla/show_bug.cgi?id=15533
> 
> Could you explain the problem your patch aims to solve?  Sorry if it was
> already explained elsewhere; please point me to the discussion in that case.
> 
> Alexander
> 


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
