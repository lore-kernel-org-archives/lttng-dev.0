From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [urcu][GIT PULL] Add support for Solaris 10 and 11
Date: Tue, 6 Oct 2015 18:48:13 +0000 (UTC)
Message-ID: <1010471047.21545.1444157293799.JavaMail.zimbra__17012.7927129672$1444157371$gmane$org@efficios.com>
References: <5613EB0E.1010209@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZjXHm-00029w-VL
 for lttng-dev@lists.lttng.org; Tue, 06 Oct 2015 14:48:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 91A203403CB
 for <lttng-dev@lists.lttng.org>; Tue,  6 Oct 2015 18:48:22 +0000 (UTC)
In-Reply-To: <5613EB0E.1010209@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged with small modifications, thanks!

Mathieu

----- On Oct 6, 2015, at 11:38 AM, Michael Jeanson mjeanson@efficios.com wrote:

> Hi,
> 
> This pull request adds support for Solaris 10 and 11, on Solaris 10 it
> requires the OpenCSW open source software distribution for build and
> runtime dependencies.
> 
> https://github.com/urcu/userspace-rcu/pull/5
> 
>	Port: make bootstrap script work on most shell 		c8d0f0f
>	Port: replace bzero() by memset()			6e8a583
>	Port: Add Solaris support to urcu/syscall-compat.h 	da639cf
>	Port: Add Solaris support to tests/common/thread-id.h 	61b8a58
>	Port: Add Solaris getcpu support 			03190dc
>	Port: Fixes to build system for portability 		114b504
>	Port: Detect nproc bin name in benchmark scripts 	fb4b0fc
>	Fix: regtest outputs valid TAP protocol 		65fcf96
> 
> 
> Feedback is welcome.
> 
> Thanks,
> 
> Michael
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
