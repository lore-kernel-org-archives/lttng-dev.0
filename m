From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: linking C++ modules against lttng-ust libraries
Date: Mon, 12 May 2014 16:53:54 +0200
Message-ID: <5370E082.2060104__17720.0793209069$1399906505$gmane$org@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=0209817850=gerlando.falauto@keymile.com>)
 id 1WjrcD-0004Qk-Qm
 for lttng-dev@lists.lttng.org; Mon, 12 May 2014 10:54:11 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I am trying to link a C++ application against lttng-ust, with a simple 
test case, and I get the following error message upon linking:

main.cpp:109: undefined reference to `_lttng_ust_tracef(char const*, ...)'

where main.cpp reads:
...
13: #include <lttng/tracef.h>
...
109: tracef("my message, this integer %d", 1234);
...

The following seems to fix my problem:

diff --git a/include/lttng/tracef.h b/include/lttng/tracef.h
index 16a984b..98338d8 100644
--- a/include/lttng/tracef.h
+++ b/include/lttng/tracef.h
@@ -23,6 +23,10 @@
   * SOFTWARE.
   */

+#ifdef __cplusplus
+extern "C" {
+#endif
+
  #include <lttng/lttng-ust-tracef.h>

  extern
@@ -35,4 +39,8 @@ void _lttng_ust_tracef(const char *fmt, ...);
                         _lttng_ust_tracef(fmt, ## __VA_ARGS__);         \
         } while (0)

+#ifdef __cplusplus
+}
+#endif
+
  #endif /* _LTTNG_UST_TRACEF_H */

But since I've noticed in the history that this whole C guard has been 
reworked several times lately, I have no idea whether this is a good 
idea or not.
Don't know if this has any relevance or anything, but both lttng-ust 
(along with its dependencies) and my test application are being 
cross-compiled.

Hints?

Thank you,
Gerlando
