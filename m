From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [LTTng-UST PATCH] lttng-gen-tp: Fix include guard name
	with file using non valid characters
Date: Mon, 17 Jun 2013 12:03:11 -0400
Message-ID: <1371484991-8578-1-git-send-email-yannick.brosseau__17192.6926509061$1371485062$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Uobu2-000293-0w
	for lttng-dev@lists.lttng.org; Mon, 17 Jun 2013 12:03:34 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so3316458obc.20
	for <lttng-dev@lists.lttng.org>; Mon, 17 Jun 2013 09:03:28 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Now, the include guard will be generated with all the non
alpha-numeric characters replace with an '_'

Fixes #511

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 tools/lttng-gen-tp |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
index 2f468cb..5937dfd 100755
--- a/tools/lttng-gen-tp
+++ b/tools/lttng-gen-tp
@@ -61,7 +61,9 @@ extern "C"{{
 
     def write(self):
         outputFile = open(self.outputFilename,"w")
-        includeGuard = self.outputFilename.upper().replace(".","_")
+        # Include guard macro will be created by uppercasing the filename and
+        # replacing all non alphanumeric characters with '_'
+        includeGuard = re.sub('[^0-9a-zA-Z]', '_', self.outputFilename.upper())
 
         outputFile.write(HeaderFile.HEADER_TPL.format(providerName=self.template.domain,
                                            includeGuard = includeGuard,
-- 
1.7.10.4
