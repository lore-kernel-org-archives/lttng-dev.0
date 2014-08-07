From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH urcu] wfcqueue: Implement mutex-free
 wfcqueue head with transparent union
Date: Thu, 7 Aug 2014 12:25:51 +0000 (UTC)
Message-ID: <1276574182.2252.1407414351409.JavaMail.zimbra__43912.18243768$1407414260$gmane$org@efficios.com>
References: <1406855243-17124-1-git-send-email-mathieu.desnoyers@efficios.com>
 <20140802091036.GA9107@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XFMjD-0008NW-SE
 for lttng-dev@lists.lttng.org; Thu, 07 Aug 2014 08:23:32 -0400
In-Reply-To: <20140802091036.GA9107@dcvr.yhbt.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Eric Wong <normalperson@yhbt.net>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Eric Wong" <normalperson@yhbt.net>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Lai Jiangshan"
> <laijs@cn.fujitsu.com>
> Sent: Saturday, August 2, 2014 5:10:36 AM
> Subject: Re: [RFC PATCH urcu] wfcqueue: Implement mutex-free wfcqueue head with transparent union
> 
> Thanks,
> 
> Tested-by: Eric Wong <normalperson@yhbt.net>

Merged into master, thanks!

Mathieu

> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
