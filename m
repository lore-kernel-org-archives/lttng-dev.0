From: Alexander Monakov <amonakov@ispras.ru>
Subject: Re: [RFC PATCH lttng-ust] Implement register_done
 waiting via LD_AUDIT
Date: Tue, 1 Jul 2014 21:14:16 +0400 (MSK)
Message-ID: <alpine.LNX.2.00.1407012102010.15415__34568.6334804215$1404234967$gmane$org@monopod.intra.ispras.ru>
References: <1404226029-9092-1-git-send-email-paul_woegerer@mentor.com>
 <alpine.LNX.2.00.1407011902580.15415@monopod.intra.ispras.ru>
 <53B2DDDB.3090102@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ispras.ru ([83.149.199.79])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <amonakov@ispras.ru>) id 1X21eK-0006nA-TN
 for lttng-dev@lists.lttng.org; Tue, 01 Jul 2014 13:15:24 -0400
In-Reply-To: <53B2DDDB.3090102@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Tue, 1 Jul 2014, Woegerer, Paul wrote:
> Unfortunately the current approach of delaying execution of main until
> lttng-ust is available has several drawbacks. E.g. the dynamic linker
> lock is taken during the execution the static ctor. Using glibc
> functions that also require the same lock as part of the lttng-ust
> initialization easily gets us into a deadlock situation.

That's surprising; in my experience dlopen/dlsym from a static DSO ctor work,
so I wonder what functions are causing a deadlock for you.

> This patch is trying to delay execution of main with a different
> technique (using a named semaphore in la_preinit to wait for lttng-ust
> initialization).

Frankly I don't think LD_AUDIT is the right tool for the job in this case,
even ignoring its flakiness in glibc; better to fix your current approach if
possible.

> Having a stable LD_AUDIT interface would be extremely valuable in the
> context of tracing.

Oh, but the interface is extremely stable, it was unchanging for a long time
now; it's just the implementation... ;)  (sorry, could not resist)

Also note that LD_AUDIT on Linux is glibc-specific, not available on other
libcs that are otherwise quite useful, such as Bionic.

Alexander
