From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PULL REQUEST lttng-tools] please pull for compudj-pull
Date: Thu, 24 Jan 2013 18:47:32 -0500
Message-ID: <20130124234731.GA16402__38457.0378730588$1359071302$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TyWW7-0001NG-66
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 18:47:35 -0500
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi David,

Please pull from my pull branch at:

git://git.dorsal.polymtl.ca/~compudj/lttng-tools
branch: compudj-pull

It contains the following useful commits:

commit 9d623b7096efbd378f566c39e4c9ab91e21fb656
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Jan 24 18:43:48 2013 -0500

    symbol prefixing: in-house copy of hash table
    
    Will ensure we don't clash with the real version in liburcu cds. It's
    especially important since those symbols are exported globally by
    liblttng-ctl.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit ec1406acb4af789da299b4e81b3b7f5cc0057714
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Jan 24 18:34:44 2013 -0500

    Fix: add missing unistd.h include for fdatasync in compat-fcntl.c
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 73f94c074aa293f09e526c01ed262a1751e10523
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Jan 24 18:33:41 2013 -0500

    namespace lttngctl filter flex/bison symbols
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
