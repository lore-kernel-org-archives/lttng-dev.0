From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: LTTng-UST: Bump LTTNG_UST_ABI_MINOR_VERSION to 1
Date: Fri, 20 Dec 2019 10:55:45 -0500 (EST)
Message-ID: <1817839556.13991.1576857345582.JavaMail.zimbra__32127.7014257916$1576857381$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47fYHk65cvz1HPq
 for <lttng-dev@lists.lttng.org>; Fri, 20 Dec 2019 10:55:46 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jeremie Galarneau <jgalar@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

FYI, a similar approach should be taken for lttng-ust 2.12, as
pushed into the master branch:

commit 677423ebf26cc17916bddd0334b1a9f7614035c9
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Dec 20 10:49:20 2019 -0500

    Bump LTTNG_UST_ABI_MINOR_VERSION to 1
    
    Increment the minor version of lttng-ust ABI to 1, to take into
    account that the "clear" command was added in this release cycle.
    
    This will allow future LTTng-tools versions to check for this
    capability.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
