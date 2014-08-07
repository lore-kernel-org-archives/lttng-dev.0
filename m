From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH urcu] lfstack: Implement mutex-free
 stack head with transparent union
Date: Thu, 7 Aug 2014 12:25:34 +0000 (UTC)
Message-ID: <616518376.2251.1407414334270.JavaMail.zimbra__42978.5885768526$1407414253$gmane$org@efficios.com>
References: <1406851531-31109-1-git-send-email-mathieu.desnoyers@efficios.com>
 <20140801014401.GA26369@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XFMiw-0008Mk-SP
 for lttng-dev@lists.lttng.org; Thu, 07 Aug 2014 08:23:17 -0400
In-Reply-To: <20140801014401.GA26369@dcvr.yhbt.net>
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
> Sent: Thursday, July 31, 2014 9:44:01 PM
> Subject: Re: [RFC PATCH urcu] lfstack: Implement mutex-free stack head with transparent union
> 
> Thanks, seems to work for me.
> 
> I tested push + pop_all with a non-yet-public project dynamically-linked
> to liburcu-cds.  The same binary continued working without ABI breakage
> when swapping shared libs.
> 
> Tested-by: Eric Wong <normalperson@yhbt.net>

Merged with your tested-by, thanks!

Mathieu

> 
> I'll test the wfcqueue change tomorrow.
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
