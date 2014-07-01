From: Alexander Monakov <amonakov@ispras.ru>
Subject: Re: [RFC PATCH lttng-ust] Implement register_done
 waiting via LD_AUDIT
Date: Tue, 1 Jul 2014 19:19:57 +0400 (MSK)
Message-ID: <alpine.LNX.2.00.1407011902580.15415__49010.2083109834$1404228119$gmane$org@monopod.intra.ispras.ru>
References: <1404226029-9092-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ispras.ru ([83.149.199.79])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <amonakov@ispras.ru>) id 1X1zrj-00062U-FH
 for lttng-dev@lists.lttng.org; Tue, 01 Jul 2014 11:21:07 -0400
In-Reply-To: <1404226029-9092-1-git-send-email-paul_woegerer@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Woegerer <paul_woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hello,

I'm not aware of the context of this patch, but please note that the amount of
overhead from non-empty LD_AUDIT is currently extremely high in all released
Glibc versions.  The forced high overhead is, as I understand, misaligned with
LTTng's aim to provide low-overhead tracing.

Non-empty LD_AUDIT behaves as if one of auditing libraries provided PLT hooks.
This causes the dynamic linker to install register save-restore helpers for
each PLT call, even if they are not needed (if no PLT hooks were in fact
provided).

Here's the Glibc bug that shows a ~19x slowdown on a microbenchmark that
repeatedly calls sqrt() from libm.so.  The proposed patch was not accepted,
with the review suggesting a different approach.

https://sourceware.org/bugzilla/show_bug.cgi?id=15533

Could you explain the problem your patch aims to solve?  Sorry if it was
already explained elsewhere; please point me to the discussion in that case.

Alexander
