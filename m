From: =?UTF-8?B?5rOw5p2l?= <tailai.ly@alibaba-inc.com>
Subject: Query on the rcu red-black tree status
Date: Sun, 20 Jan 2013 13:42:40 +0800
Message-ID: <50FB83D0.8010908__43260.1323271685$1358728950$gmane$org@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out4133-113.mail.aliyun.com ([42.120.133.113])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <tailai.ly@alibaba-inc.com>) id 1TwngE-0003r7-25
	for lttng-dev@lists.lttng.org; Sun, 20 Jan 2013 00:42:54 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Hi List

  I am developer of Sheepdog project, which is a heavy user of urcu
library. I noticed there is a branch which implement rcu red-black tree
and it seems to halt on the late 2011. Is there roadmap to merge this
into master branch?

Thanks,
Yuan
