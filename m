From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: lttng-tools test_high_throughput_limits is fixed
Date: Wed, 19 Nov 2014 01:01:50 +0000 (UTC)
Message-ID: <1037403849.16042.1416358910194.JavaMail.zimbra__22955.7929364548$1416358966$gmane$org@efficios.com>
References: <1924724171.16029.1416358488378.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Xqted-0003lE-5d
 for lttng-dev@lists.lttng.org; Tue, 18 Nov 2014 20:01:58 -0500
In-Reply-To: <1924724171.16029.1416358488378.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeremie Galarneau <jgalar@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Yesterday's fix to http://bugs.lttng.org/issues/861
fixed this test in root long regression:
regression/tools/streaming/test_high_throughput_limits

So this long regression test (not run by our CI currently
because it requires root access) was already reporting the
issue. We knew this test failed, but did not know why (we
mistakenly thought it was an issue in the way babeltrace
computed discarded events).

Now that I see the kind of issue it was, it's possible that
a git bisect would probably have found it all by itself.

Good news is: it's fixed now. And it's planned that Jonathan
Rajotte adds these regression tests requiring root to our CI
in early 2015.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
