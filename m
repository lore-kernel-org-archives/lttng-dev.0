From: David Goulet <dgoulet@efficios.com>
Subject: Per UID buffers in UST
Date: Thu, 21 Mar 2013 12:33:02 -0400
Message-ID: <514B363E.6080305__23082.8729378574$1363883633$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UIiQL-00052O-RW
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 12:33:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 95D55187493
	for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2013 12:38:54 -0400 (EDT)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id o5jxJv07msXU for <lttng-dev@lists.lttng.org>;
	Thu, 21 Mar 2013 12:38:54 -0400 (EDT)
Received: from 127.0.0.1 (unknown [96.127.207.22])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id E9C0A1873C7
	for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2013 12:38:53 -0400 (EDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi everyone,

Just a quick heads up that the support for per UID buffers for UST has
been pushed into the master branch of tools and can be used like so:

$ lttng create
$ lttng enable-channel -u --buffers-uid chan1
$ lttng enable-event -a -u -c chan1
$ lttng start

Of course, you'll need the master HEAD of lttng-ust as well.

Please, I encourage anyone of you to test it! and of course report bugs
or anything weird or not working :).

commit 7972aab22f74b18faa168c0482216a3dd711a075

Cheers!
David
