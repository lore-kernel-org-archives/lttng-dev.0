From: Jon Bernard <jbernard@tuxion.com>
Subject: [PATCH 1/2] Fix spelling mistake in lttng-ust manpage
Date: Fri, 15 Nov 2013 09:12:33 -0500
Message-ID: <20131115141233.GA32470__42162.2731759728$1384524823$gmane$org@shaniqua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@tuxion.com>) id 1VhK8Z-0002hi-Fl
	for lttng-dev@lists.lttng.org; Fri, 15 Nov 2013 09:12:49 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3E99020C73
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 09:12:36 -0500 (EST)
Received: from localhost (unknown [108.15.195.199])
	by mail.messagingengine.com (Postfix) with ESMTPA id A09436800B5
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 09:12:35 -0500 (EST)
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Jon Bernard <jbernard@tuxion.com>
---
 doc/man/lttng-ust.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3
index de4271c..26841d0 100644
--- a/doc/man/lttng-ust.3
+++ b/doc/man/lttng-ust.3
@@ -383,7 +383,7 @@ lttng-sessiond(8)
 
 .PP
 Older lttng-ust libraries reject more recent, and incompatible, probe
-providers. Newer lttng-ust librairies accept older probe providers, even
+providers. Newer lttng-ust libraries accept older probe providers, even
 though some newer features might not be available with those providers.
 .PP
 
-- 
1.8.4.rc3


-- 
Jon
