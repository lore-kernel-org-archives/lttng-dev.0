From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC PATCH urcu] lfstack: Implement mutex-free
 stack head with transparent union
Date: Fri, 1 Aug 2014 01:44:01 +0000
Message-ID: <20140801014401.GA26369__7867.63821165568$1406857485$gmane$org@dcvr.yhbt.net>
References: <1406851531-31109-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dcvr.yhbt.net ([64.71.152.64] ident=normalperson)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <normalperson@yhbt.net>) id 1XD1t4-00084X-Dz
 for lttng-dev@lists.lttng.org; Thu, 31 Jul 2014 21:44:03 -0400
Content-Disposition: inline
In-Reply-To: <1406851531-31109-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Thanks, seems to work for me.

I tested push + pop_all with a non-yet-public project dynamically-linked
to liburcu-cds.  The same binary continued working without ABI breakage
when swapping shared libs.

Tested-by: Eric Wong <normalperson@yhbt.net>

I'll test the wfcqueue change tomorrow.
