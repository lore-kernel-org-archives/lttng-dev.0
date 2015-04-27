From: Zifei Tong <zifeitong@gmail.com>
Subject: [PATCH] Fix: multiple definition error with gcc 5.1
Date: Mon, 27 Apr 2015 23:31:45 +0200
Message-ID: <1430170305-26566-1-git-send-email-zifeitong__4055.73802204362$1430170382$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from miyuki.olf.sgsnet.se ([46.239.124.10]
 helo=Zifeis-MacBook-Pro.local)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <zifei@Zifeis-MacBook-Pro.local>) id 1YmqdJ-0005CN-Oy
 for lttng-dev@lists.lttng.org; Mon, 27 Apr 2015 17:32:09 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jeremie.galarneau@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

When building lttng-tools with gcc 5.1, I saw the following error:
  ../../../src/common/.libs/libcommon.a(mi-lttng.o):(.data.rel.ro.local+0x0):
      multiple definition of `mi_lttng_element_snapshots'
  commands/enable_events.o:(.bss+0x30): first defined here
  collect2: error: ld returned 1 exit status

The output of `nm enable_events.o` shows that the mi_lttng_element_snapshots
was put in the uninitialized data section (BSS), but not a common symbol
which it should be. This causes the multiple definition error.

This issue was also found by others [1], who fixes by declaring
`mi_lttng_element_snapshots' and friends as 'extern'.

However, the root cause I believe is an undefined behavior of accessing
uninitialized variable 'opt_function_entry_symbol' in enable_events.c.
The UB causes Identical Code Folding (ICF) added in gcc 5.x generates
wrong output (fipa-icf is default in -O2, and compiing with -fno-ipa-icf
works just fine).

This patch comments out the accessing of `opt_function_entry_symbol`
which is not used anymore.

[1]: http://permalink.gmane.org/gmane.comp.handhelds.openembedded.core/62798

Signed-off-by: Zifei Tong <zifeitong@gmail.com>
---
 src/bin/lttng/commands/enable_events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index ab32994..4b86a30 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -52,7 +52,6 @@ static int opt_python;
 static int opt_enable_all;
 static char *opt_probe;
 static char *opt_function;
-static char *opt_function_entry_symbol;
 static char *opt_channel_name;
 static char *opt_filter;
 static char *opt_exclude;
@@ -1053,11 +1052,13 @@ static int enable_events(char *session_name)
 					goto error;
 				}
 				break;
+#if 0
 			case LTTNG_EVENT_FUNCTION_ENTRY:
 				strncpy(ev.attr.ftrace.symbol_name, opt_function_entry_symbol,
 						LTTNG_SYMBOL_NAME_LEN);
 				ev.attr.ftrace.symbol_name[LTTNG_SYMBOL_NAME_LEN - 1] = '\0';
 				break;
+#endif
 			case LTTNG_EVENT_SYSCALL:
 				ev.type = LTTNG_EVENT_SYSCALL;
 				break;
-- 
2.3.5
