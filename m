From: <maxin.john@enea.com>
Subject: [PATCH] lttng-abi.c: fix the error check
Date: Fri, 22 Mar 2013 19:07:02 +0100
Message-ID: <1363975622-37401-1-git-send-email-maxin.john__37629.4068330482$1363976101$gmane$org@enea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <Maxin.John@enea.com>) id 1UJ6Mw-0000Yi-AQ
	for lttng-dev@lists.lttng.org; Fri, 22 Mar 2013 14:07:10 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, "Maxin B. John" <maxin.john@enea.com>
List-Id: lttng-dev@lists.lttng.org

From: "Maxin B. John" <maxin.john@enea.com>

lttng_syscalls_register() may return -ENOMEM or -EINVAL. So fix
the error path to check for negative values in lttng_abi_create_event()
and lttng_channel_ioctl().

Signed-off-by: Maxin B. John <maxin.john@enea.com>
---
 lttng-abi.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/lttng-abi.c b/lttng-abi.c
index 25a350a..5613b75 100644
--- a/lttng-abi.c
+++ b/lttng-abi.c
@@ -648,7 +648,7 @@ int lttng_abi_create_event(struct file *channel_file,
 		if (event_param->name[0] != '\0')
 			return -EINVAL;
 		ret = lttng_syscalls_register(channel, NULL);
-		if (ret)
+		if (ret < 0)
 			goto fd_error;
 		event_fd = 0;
 		break;
@@ -753,6 +753,8 @@ long lttng_channel_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			break;
 		}
 		ret = lttng_abi_create_event(file, uevent_param);
+		if (ret < 0)
+			return -ENOMEM;
 
 old_event_error_free_old_param:
 		kfree(old_uevent_param);
-- 
1.7.5.4
