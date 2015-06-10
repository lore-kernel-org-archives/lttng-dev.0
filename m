From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Fixes about UST wrapper ip context
Date: Wed, 10 Jun 2015 11:56:34 +0000 (UTC)
Message-ID: <1932694960.493.1433937394561.JavaMail.zimbra__3196.03993925757$1433937462$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Z2ece-0004S6-6t
 for lttng-dev@lists.lttng.org; Wed, 10 Jun 2015 07:56:46 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Olivier Delbeke <olivier.delbeke@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I pushed fixes into lttng-ust master, stable-2.6 and stable-2.5
branches which ensure that the "ip" context for malloc, mutex,
cyg_profile, dl instrumentation are the instruction pointer of
the application calling into the "trampolines" rather than the
address within the trampolines per se.

In the master branch, I removed the recently added "caller" fields
from the malloc events, since it now duplicates the "ip" context.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
