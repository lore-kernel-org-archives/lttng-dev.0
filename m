From: Shawn Bohrer <sbohrer@rgmadvisors.com>
Subject: [PATCH] lttng-gen-tp: Allow generation from templates
	in subdirectories
Date: Wed, 29 Aug 2012 15:39:59 -0500
Message-ID: <1346272799-23183-1-git-send-email-sbohrer__4621.10540033809$1346276044$gmane$org@rgmadvisors.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sbohrer@rgmadvisors.com>) id 1T6p3a-0002Ba-0T
	for lttng-dev@lists.lttng.org; Wed, 29 Aug 2012 16:40:10 -0400
Received: by obbtb18 with SMTP id tb18so2480662obb.35
	for <lttng-dev@lists.lttng.org>; Wed, 29 Aug 2012 13:40:08 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Shawn Bohrer <sbohrer@rgmadvisors.com>
List-Id: lttng-dev@lists.lttng.org

If a template is located in a subdirectory as is common in large
software projects then the include guard will contain forward slash
characters which are not allowed.  This replaces those characters with
an underscore.  Additional the include guards previously started with
an underscore and capital letter which is reserved thus this
additionally removes the leading underscore.

Fixes: #298

Signed-off-by: Shawn Bohrer <sbohrer@rgmadvisors.com>
---
 tools/lttng-gen-tp |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
index d54559a..8cd3191 100755
--- a/tools/lttng-gen-tp
+++ b/tools/lttng-gen-tp
@@ -61,7 +61,7 @@ extern "C"{{
 
     def write(self):
         outputFile = open(self.outputFilename,"w")
-        includeGuard = "_"+self.outputFilename.upper().replace(".","_")
+        includeGuard = self.outputFilename.upper().replace(".","_").replace("/","_")
 
         outputFile.write(HeaderFile.HEADER_TPL.format(providerName=self.template.domain,
                                            includeGuard = includeGuard,
-- 
1.7.7.6


-- 

---------------------------------------------------------------
This email, along with any attachments, is confidential. If you 
believe you received this message in error, please contact the 
sender immediately and delete all copies of the message.  
Thank you.
