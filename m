From: Liu Yuan <namei.unix@gmail.com>
Subject: Query on the rculist
Date: Mon, 21 Jan 2013 10:01:39 +0800
Message-ID: <50FCA183.8030201__9908.53724438257$1358733748$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <namei.unix@gmail.com>) id 1Tx6ho-0004vu-Ij
	for lttng-dev@lists.lttng.org; Sun, 20 Jan 2013 21:01:48 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so3067514pad.38
	for <lttng-dev@lists.lttng.org>; Sun, 20 Jan 2013 18:01:42 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Hi List,

   I noticed that there are just few functions suffixed with rcu for
rculist. And from the source of Linux kernel rculist, I came up with
some comments saying that list_empty_rcu() can be simply achieved by
calling list_empty(). Is this true to urcu too? My questions is, are
following equivalents true?

  list_empty_rcu -> list_empty
  list_del_init_rcu -> list_del_init

If there are more equivalents, please show light on it.

Thanks,
Yuan
