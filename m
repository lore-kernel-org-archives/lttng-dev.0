From: Alexander Monakov <amonakov@ispras.ru>
Subject: Re: [RFC PATCH lttng-ust] Implement register_done
 waiting via LD_AUDIT
Date: Wed, 2 Jul 2014 19:02:09 +0400 (MSK)
Message-ID: <alpine.LNX.2.00.1407021834120.15415__8559.4741198749$1404313469$gmane$org@monopod.intra.ispras.ru>
References: <1404226029-9092-1-git-send-email-paul_woegerer@mentor.com>
 <alpine.LNX.2.00.1407011902580.15415@monopod.intra.ispras.ru>
 <53B2DDDB.3090102@mentor.com>
 <alpine.LNX.2.00.1407012102010.15415@monopod.intra.ispras.ru>
 <155121331.7082.1404310847950.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ispras.ru ([83.149.199.79])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <amonakov@ispras.ru>) id 1X2M43-0006AD-RA
 for lttng-dev@lists.lttng.org; Wed, 02 Jul 2014 11:03:21 -0400
In-Reply-To: <155121331.7082.1404310847950.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Thanks Mathieu for such detailed response.  I did not understand the nature of
the deadlock until your explanation.

My suggestion for the immediate problem is: can you restructure the code so
that all preliminary work (connecting to the daemon etc.) is done directly
from the constructor before spawning the secondary thread?  So that you don't
have to suspend after launching the listener thread?  From your explanation it
looks like there's no particular reason to do that work in the listener
thread, except perhaps the convenience of programming (not needing to pass
around the socket, etc).

Admittedly the above is written from general principles, so I do apologize if
I'm not seeing some real LTTng-specific issues there and sound like an
armchair code analyst.

Apropos, and you might already know that: Glibc runs static constructors from
LD_PRELOAD'ed DSOs _after_ the ctors from libs loaded as dependencies.

Alexander
