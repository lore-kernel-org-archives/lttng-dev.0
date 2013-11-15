From: Jon Bernard <jbernard@tuxion.com>
Subject: [PATCH 2/2] Escape minus signs in lttng-ust-cyg-profile
	manpage
Date: Fri, 15 Nov 2013 09:12:47 -0500
Message-ID: <20131115141247.GA1634__5001.95876597918$1384524920$gmane$org@shaniqua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@tuxion.com>) id 1VhK8m-0002lY-Cz
	for lttng-dev@lists.lttng.org; Fri, 15 Nov 2013 09:13:03 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 544BE2102C
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 09:12:50 -0500 (EST)
Received: from localhost (unknown [108.15.195.199])
	by mail.messagingengine.com (Postfix) with ESMTPA id AD6ED6800F8
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 09:12:49 -0500 (EST)
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

By default, "-" chars are interpreted as hyphens (U+2010) by groff, not
as minus signs (U+002D). Since options to programs use minus signs
(U+002D), this means for example in UTF-8 locales that you cannot cut
and paste options, nor search for them easily.

Source: http://lintian.debian.org/tags/hyphen-used-as-minus-sign.html

Signed-off-by: Jon Bernard <jbernard@tuxion.com>
---
 doc/man/lttng-ust-cyg-profile.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/man/lttng-ust-cyg-profile.3 b/doc/man/lttng-ust-cyg-profile.3
index fa8cf4f..341d3ae 100644
--- a/doc/man/lttng-ust-cyg-profile.3
+++ b/doc/man/lttng-ust-cyg-profile.3
@@ -43,7 +43,7 @@ call site address are recorded as lttng_ust_cyg_profile:func_entry and
 lttng_ust_cyg_profile:func_exit.
 .SH "USAGE"
 To use function tracing you need to make sure the sources of your application
-are compiled with -finstrument-functions. It might be necessary to limit
+are compiled with \-finstrument\-functions. It might be necessary to limit
 the number of source files where this option is used to prevent excessive
 amount of trace data to be generated during run time. Usually there are
 additional compiler flags that allow you to specify more fine grained selection
-- 
1.8.4.rc3


-- 
Jon
