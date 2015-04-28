From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: [PATCH lttng-tools 1/2] Fix: append_list_to_probes():
	increment index
Date: Tue, 28 Apr 2015 17:08:58 -0400
Message-ID: <1430255338-6461-1-git-send-email-eeppeliteloop__22512.2400712737$1430255330$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1YnCiw-00046I-TX
 for lttng-dev@lists.lttng.org; Tue, 28 Apr 2015 17:07:32 -0400
Received: by qcpm10 with SMTP id m10so4129642qcp.3
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2015 14:07:17 -0700 (PDT)
Received: from archeepp.internal.efficios.com
 (cable-192.222.194.238.electronicbox.net. [192.222.194.238])
 by mx.google.com with ESMTPSA id j93sm13477134qkh.29.2015.04.28.14.07.16
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 28 Apr 2015 14:07:16 -0700 (PDT)
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
 src/bin/lttng-sessiond/modprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index a9035da..d730a1d 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -395,7 +395,7 @@ static int append_list_to_probes(const char *list)
 		/* Length 13 is "lttng-probe-" + \0 */
 		name_len = strlen(next) + 13;
 
-		cur_mod = &probes[index];
+		cur_mod = &probes[index++];
 		cur_mod->name = zmalloc(name_len);
 		if (!cur_mod->name) {
 			PERROR("malloc probe list");
-- 
2.3.0
