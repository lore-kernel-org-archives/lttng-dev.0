From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: baddr feature triggers deadlock in lttng-ust
Date: Thu, 27 Feb 2014 21:30:06 +0000 (UTC)
Message-ID: <561294755.31915.1393536606539.JavaMail.zimbra__313.125822185789$1393536675$gmane$org@efficios.com>
References: <1640835527.31912.1393536374130.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WJ8Ww-0001tM-JH
	for lttng-dev@lists.lttng.org; Thu, 27 Feb 2014 16:30:16 -0500
In-Reply-To: <1640835527.31912.1393536374130.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Woegerer <paul_woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Paul,

Please see http://bugs.lttng.org/issues/745, which explains a deadlock
we just found out.

We might have to disable the baddr dump feature, since our release is
tomorrow. We'll have to re-think our locking to protect operations
using the dynamic loader lock against fork, clone, and daemon.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
