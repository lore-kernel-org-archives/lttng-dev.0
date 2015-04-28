From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: [PATCH lttng-tools 2/2] Fix: modprobe.c: fix tmp_list
	memory leak
Date: Tue, 28 Apr 2015 17:09:16 -0400
Message-ID: <1430255356-6566-1-git-send-email-eeppeliteloop__32472.7843319581$1430255487$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1YnCj8-00046K-83
 for lttng-dev@lists.lttng.org; Tue, 28 Apr 2015 17:07:42 -0400
Received: by qkhg7 with SMTP id g7so4908681qkh.2
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2015 14:07:28 -0700 (PDT)
Received: from archeepp.internal.efficios.com
 (cable-192.222.194.238.electronicbox.net. [192.222.194.238])
 by mx.google.com with ESMTPSA id c8sm13664102qgf.6.2015.04.28.14.07.27
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 28 Apr 2015 14:07:28 -0700 (PDT)
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

Reported-by: Hannes Weisbach <hannes.weisbach@mailbox.tu-dresden.de>
Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
---
 src/bin/lttng-sessiond/modprobe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index d730a1d..32c4210 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -360,11 +360,11 @@ static int append_list_to_probes(const char *list)
 {
 	char *next;
 	int index = nr_probes, ret;
-	char *tmp_list;
+	char *tmp_list, *cur_list;
 
 	assert(list);
 
-	tmp_list = strdup(list);
+	cur_list = tmp_list = strdup(list);
 	if (!tmp_list) {
 		PERROR("strdup temp list");
 		return -ENOMEM;
@@ -374,11 +374,11 @@ static int append_list_to_probes(const char *list)
 		size_t name_len;
 		struct kern_modules_param *cur_mod;
 
-		next = strtok(tmp_list, ",");
+		next = strtok(cur_list, ",");
 		if (!next) {
 			break;
 		}
-		tmp_list = NULL;
+		cur_list = NULL;
 
 		/* filter leading spaces */
 		while (*next == ' ') {
-- 
2.3.0
