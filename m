From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: state tracking and missing statedump end
Date: Thu, 14 May 2015 22:35:54 +0000 (UTC)
Message-ID: <1361850761.1447.1431642954186.JavaMail.zimbra__23862.755802884$1431643007$gmane$org@efficios.com>
References: <1265315316.1445.1431642898336.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Yt1jP-0001JN-8p
 for lttng-dev@lists.lttng.org; Thu, 14 May 2015 18:35:56 -0400
In-Reply-To: <1265315316.1445.1431642898336.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@efficios.com>, Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Alexandre, Hi Matthew,

You will certainly be interested in this commit in
lttng-modules:

commit 84c7055e17f9bf7628fe1004db732d932ed2a77b
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu May 14 18:29:58 2015 -0400

    Fix: missing statedump end event when block device listing available
    
    Incorrect handling of lttng_enumerate_block_devices() return value of 0
    (which means "ok"), causing do_lttng_statedump() to return early.
    
    To causes missing "lttng_statedump_end" in traces where block device
    enumeration is available (CONFIG_KALLSYMS=y).
    
    Reported-by: Antoine Busque <abusque@efficios.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
