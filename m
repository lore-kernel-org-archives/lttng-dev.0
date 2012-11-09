From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [urcu commit] Fix TLS detection: test with linker,
	add	--disable-compiler-tls
Date: Thu, 8 Nov 2012 21:54:18 -0500
Message-ID: <20121109025418.GA26014__42883.7590305649$1352429698$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TWejb-00017q-Mu
	for lttng-dev@lists.lttng.org; Thu, 08 Nov 2012 21:54:19 -0500
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Marek =?utf-8?Q?Vavru=C5=A1a?= <marek.vavrusa@nic.cz>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Jim Reid <jim@rfc1035.com>
List-Id: lttng-dev@lists.lttng.org

The following commit is now in the userspace RCU master branch
(backported to stable-0.7 branch too). It should fix TLS detection on
both NetBSD <= 5.1, and on Darwin, and adds a --disable-compiler-tls
flag to force using the pthread_getspecific fallback.


commit 75478b32ffe53b0d8b5e687d9cf7ebdd77a085de
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Nov 8 21:45:04 2012 -0500

    Fix TLS detection: test with linker, add --disable-compiler-tls
    
    NetBSD 5.1 and older, as well as Darwin, succeed to compile code
    containing TLS, but cannot link it. Test with linker in addition to
    compiler for TLS support.
    
    Also add a --disable-compiler-tls configure option to allow users to
    force using the pthread getspecific fall back.
    
    Fixes #288
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Feedback is welcome!

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
