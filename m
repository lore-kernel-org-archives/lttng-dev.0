From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix: Use ipv6 loopback adress in
	test_uri
Date: Thu, 18 Feb 2016 12:45:13 -0500
Message-ID: <1455817513-432-1-git-send-email-mjeanson__5114.52455907619$1455817582$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aWSdp-0007Kf-O8
 for lttng-dev@lists.lttng.org; Thu, 18 Feb 2016 12:45:26 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Some older version of Debian/Ubuntu and maybe other distros won't set
localhost to point on ::1 in the system hosts file and use instead a
custom name like ip6-localhost or ipv6-locahost which is not
standardized across distros.

To work around this, use the ipv6 loopback address instead of localhost.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 tests/unit/test_uri.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test_uri.c b/tests/unit/test_uri.c
index 432e2b3..cd95753 100644
--- a/tests/unit/test_uri.c
+++ b/tests/unit/test_uri.c
@@ -108,7 +108,7 @@ void test_uri_parsing(void)
 		uri = NULL;
 	}
 
-	s_uri1 = "net6://localhost:8989";
+	s_uri1 = "net6://[::1]:8989";
 
 	size = uri_parse(s_uri1, &uri);
 
@@ -125,7 +125,7 @@ void test_uri_parsing(void)
 	   uri[1].port == 0 &&
 	   strlen(uri[1].subdir) == 0 &&
 	   strcmp(uri[0].dst.ipv6, "::1") == 0,
-	   "URI set to net6://localhost:8989");
+	   "URI set to net6://[::1]:8989");
 
 	if (uri) {
 		uri_free(uri);
-- 
2.7.0
