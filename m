From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 05/24] Fix : Do not use gLibc
	specific macros
Date: Mon, 27 Oct 2014 20:49:28 +0000
Message-ID: <1414442926-14381-6-git-send-email-c.briere__12117.2078572728$1414443093$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]
 helo=usmailout1.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEO-0007nk-N2
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:39 -0400
Received: from uscpsbgex1.samsung.com
 (u122.gpu85.samsung.co.kr [203.254.195.122]) by mailout1.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE400FZWF6I0930@mailout1.w2.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:30 -0400 (EDT)
In-reply-to: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Content-language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "jeremie.galarneau@efficios.com" <jeremie.galarneau@efficios.com>, "dgoulet@efficios.com" <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "karim.yaghmour@opersys.com" <karim.yaghmour@opersys.com>
List-Id: lttng-dev@lists.lttng.org

From: Charles Briere <c.briere@samsung.com>

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 src/common/compat/poll.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
index f892c83..64ff618 100644
--- a/src/common/compat/poll.h
+++ b/src/common/compat/poll.h
@@ -73,7 +73,7 @@ enum {
 	LPOLLNVAL = EPOLLHUP,
 	LPOLLRDHUP = EPOLLRDHUP,
 	/* Close on exec feature of epoll */
-#if __GLIBC_PREREQ(2, 9)
+#ifdef EPOLL_CLOEXEC
 	LTTNG_CLOEXEC = EPOLL_CLOEXEC,
 #else
 	/*
@@ -127,7 +127,7 @@ extern int compat_epoll_create(struct lttng_poll_event *events,
 #define lttng_poll_create(events, size, flags) \
 	compat_epoll_create(events, size, flags)
 
-#if __GLIBC_PREREQ(2, 9)
+#ifdef EPOLL_CLOEXEC
 static inline int compat_glibc_epoll_create(int size __attribute__((unused)),
 		int flags)
 {
-- 
2.1.2
