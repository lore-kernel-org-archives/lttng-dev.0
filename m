From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC] Fixing lttng-ust/modules unreadable traces
 generated from racy string input
Date: Mon, 14 Apr 2014 19:23:17 +0000 (UTC)
Message-ID: <1906740254.1543.1397503397448.JavaMail.zimbra__37351.4726212763$1397503469$gmane$org@efficios.com>
References: <62052742.1529.1397503373907.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WZmTU-0003Qi-FQ
 for lttng-dev@lists.lttng.org; Mon, 14 Apr 2014 15:23:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4156C340189
 for <lttng-dev@lists.lttng.org>; Mon, 14 Apr 2014 19:23:20 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id RVuv-CCRfwMO for <lttng-dev@lists.lttng.org>;
 Mon, 14 Apr 2014 19:23:18 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DFA16340242
 for <lttng-dev@lists.lttng.org>; Mon, 14 Apr 2014 19:23:17 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id jb-bGRWA7tkW for <lttng-dev@lists.lttng.org>;
 Mon, 14 Apr 2014 19:23:17 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id B7A62340189
 for <lttng-dev@lists.lttng.org>; Mon, 14 Apr 2014 19:23:17 +0000 (UTC)
In-Reply-To: <62052742.1529.1397503373907.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

There scenarios where strings are concurrently changed while
lttng-ust and lttng-modules are writing them to tracing buffers
can lead to unreadable traces. The following bugtracker entries
explain the issue and provide patches for the problem. I will
post those patches into the ML. Feeedback is welcome!

http://bugs.lttng.org/issues/734
http://bugs.lttng.org/issues/781

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
