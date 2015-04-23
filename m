From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: DEBUG_RCU vs RCU_DEBUG
Date: Thu, 23 Apr 2015 19:44:40 +0000 (UTC)
Message-ID: <1338447584.35237.1429818280158.JavaMail.zimbra__2377.28503202579$1429818353$gmane$org@efficios.com>
References: <5534B3CA.6030306@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YlN3E-0000hv-5r
 for lttng-dev@lists.lttng.org; Thu, 23 Apr 2015 15:44:46 -0400
In-Reply-To: <5534B3CA.6030306@free.fr>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Duncan Sands <duncan.sands@deepbluecap.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> I noticed that urcu-qsbr.h checks for RCU_DEBUG being defined while the rest
> of
> userspace-rcu (0.8.6) checks DEBUG_RCU.  Is this a mistake or a cunning plan?

Good catch! Even urcu/static/urcu-qsbr.h has a ifdef based on
DEBUG_RCU.

Will rename the urcu-qsbr.[ch] RCU_DEBUG to DEBUG_RCU, and I will
define RCU_DEBUG if DEBUG_RCU is defined in qsbr (for backward compat).
Fixes pushed into master, stable-0.8 and stable-0.7.

Thanks!

Mathieu

> 
> Ciao, Duncan.
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
