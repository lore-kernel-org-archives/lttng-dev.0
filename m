From: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tool] mi: add machine interface
	description to man page
Date: Tue, 29 Jul 2014 10:25:52 -0400
Message-ID: <1406643952-30673-1-git-send-email-jonathan.r.julien__1942.16864551908$1406644020$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1XC8Lu-0004BQ-GM
 for lttng-dev@lists.lttng.org; Tue, 29 Jul 2014 10:26:11 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
---
 doc/man/lttng.1 | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
index 12ca33d..de13b76 100644
--- a/doc/man/lttng.1
+++ b/doc/man/lttng.1
@@ -77,6 +77,26 @@ Simple listing of lttng options.
 .TP
 .BR "\-\-list\-commands"
 Simple listing of lttng commands.
+.TP
+.BR "\-m, \-\-mi TYPE
+Machine interface
+
+TYPE supported: XML
+
+Machine interface (MI) mode convert the traditional pretty printing to a more
+machine friendly output syntax. Mi mode provide a format change-resistant way to
+access information generated via lttng-cli.
+
+When using MI mode, the generated document is outputted on STDOUT.
+Errors and warning are outputted as normal on STDERR and in normal format.
+
+If any errors occurs during the execution of a command, the return value
+of the command will be different than zero as normal. In this event, lttng does
+no guarantees the syntax and data validity of the generated document.
+
+For XML output type, lttng provide an xml schema definitioni (XSD) file for validation. It
+can be found under: lttng-tools/src/common/mi_lttng.xsd.
+
 .SH "COMMANDS"
 
 .PP
-- 
2.0.0
