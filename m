From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust 0/2] Bugfix for
 http://bugs.lttng.org/issues/745 (now using mutex)
Date: Wed, 16 Jul 2014 14:39:48 +0000 (UTC)
Message-ID: <511477741.15193.1405521588370.JavaMail.zimbra__40506.2849088155$1405521662$gmane$org@efficios.com>
References: <1879691854.11749.1404998687774.JavaMail.zimbra@efficios.com>
 <1405327105-20507-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1X7QN4-0005Py-BT
 for lttng-dev@lists.lttng.org; Wed, 16 Jul 2014 10:39:55 -0400
In-Reply-To: <1405327105-20507-1-git-send-email-paul_woegerer@mentor.com>
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

Both patches merged into master and will be part of
the 2.5 release. No backport to stable-2.4 planned
though, as this is fixing what was an experimental
feature in 2.4.

Thanks,

Mathieu

----- Original Message -----
> From: "Paul Woegerer" <paul_woegerer@mentor.com>
> To: lttng-dev@lists.lttng.org, "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "Paul Woegerer" <paul_woegerer@mentor.com>
> Sent: Monday, July 14, 2014 4:38:23 AM
> Subject: [PATCH lttng-ust 0/2] Bugfix for http://bugs.lttng.org/issues/745 (now using mutex)
> 
> As discussed previously I replaced the semaphore with a mutex and retested on
> all three platforms (x86_x64, ARM and PPC). Turns out using a mutex is as
> good
> as the original implementation with the semaphore.
> 
> Paul Woegerer (2):
>   Bugfix for #745 deadlock with baddr statedump+fork
>   Revert "Turn base address dump into experimental feature"
> 
>  doc/man/lttng-ust.3            | 10 +++-------
>  liblttng-ust/lttng-ust-baddr.c |  2 +-
>  liblttng-ust/lttng-ust-comm.c  | 16 ++++++++++++++++
>  3 files changed, 20 insertions(+), 8 deletions(-)
> 
> --
> 2.0.1
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
