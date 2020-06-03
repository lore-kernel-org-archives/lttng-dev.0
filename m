From: Dmitry Antipov via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Userspace RCU data alignment
Date: Wed, 3 Jun 2020 15:36:13 +0300
Message-ID: <5352eebd-dbb7-70f9-a354-91522170efdf@yandex.ru>
Reply-To: Dmitry Antipov <dmantipov@yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------E91DBDDFA8A509741168F3D8"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from forward106p.mail.yandex.net (forward106p.mail.yandex.net
 [IPv6:2a02:6b8:0:1472:2741:0:8b7:109])
 by lists.lttng.org (Postfix) with ESMTPS id 49cT142dMDz1MP7
 for <lttng-dev@lists.lttng.org>; Wed,  3 Jun 2020 08:36:24 -0400 (EDT)
Received: from mxback15g.mail.yandex.net (mxback15g.mail.yandex.net
 [IPv6:2a02:6b8:0:1472:2741:0:8b7:94])
 by forward106p.mail.yandex.net (Yandex) with ESMTP id C42621C831EC
 for <lttng-dev@lists.lttng.org>; Wed,  3 Jun 2020 15:36:13 +0300 (MSK)
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--------------E91DBDDFA8A509741168F3D8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I've compiled userspace-rcu with:

CC=gcc CFLAGS='-O0 -g3 -fsanitize=undefined' LIBS='-lubsan' ./configure [xxx]

and see a lot of 'misaligned address' runtime errors like:

  ./doc/examples/urcu-flavors/bp ==>

../include/urcu/static/urcu-bp.h:185:6: runtime error: member access within misaligned address 0x7fcac376a020 for type 'struct urcu_bp_reader', which requires 128 byte alignment
0x7fcac376a020: note: pointer points here
  ca 7f 00 00  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00
               ^
     #0 0x7fcac372a880 in _urcu_bp_read_unlock ../include/urcu/static/urcu-bp.h:185
     #1 0x7fcac372b0d9 in urcu_bp_read_unlock /home/antipov/userspace-rcu/src/urcu-bp.c:363
     #2 0x4017d5 in main /home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp.c:92
     #3 0x7fcac2bc2041 in __libc_start_main ../csu/libc-start.c:308
     #4 0x40111d in _start (/home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp+0x40111d)

../include/urcu/static/urcu-bp.h:189:2: runtime error: member access within misaligned address 0x7fcac376a020 for type 'struct urcu_bp_reader', which requires 128 byte alignment
0x7fcac376a020: note: pointer points here
  ca 7f 00 00  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00
               ^
     #0 0x7fcac372a8c1 in _urcu_bp_read_unlock ../include/urcu/static/urcu-bp.h:189
     #1 0x7fcac372b0d9 in urcu_bp_read_unlock /home/antipov/userspace-rcu/src/urcu-bp.c:363
     #2 0x4017d5 in main /home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp.c:92
     #3 0x7fcac2bc2041 in __libc_start_main ../csu/libc-start.c:308
     #4 0x40111d in _start (/home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp+0x40111d)

Is it critical for correctness, or speed, or whatever else?

To whom it may be interesting, some of (probably not all) alignment issues may be fixed
with attached patch.

Dmitry

--------------E91DBDDFA8A509741168F3D8
Content-Type: text/x-patch; charset=UTF-8;
 name="urcu_bp_reader_alignment.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="urcu_bp_reader_alignment.patch"

diff --git a/include/urcu/list.h b/include/urcu/list.h
index 4aaf869..d5f28fe 100644
--- a/include/urcu/list.h
+++ b/include/urcu/list.h
@@ -40,6 +40,11 @@ struct cds_list_head {
 #define CDS_LIST_HEAD(name) \
 	struct cds_list_head name = { &(name), &(name) }
 
+/* Likewise but aligned to ALIGN bytes. */
+#define CDS_LIST_HEAD_ALIGNED(name, align) \
+	struct cds_list_head name __attribute__((aligned (align))) \
+	= { &(name), &(name) }
+
 /* Initialize a new list head. */
 #define CDS_INIT_LIST_HEAD(ptr) \
 	(ptr)->next = (ptr)->prev = (ptr)
diff --git a/src/urcu-bp.c b/src/urcu-bp.c
index 05efd97..4e31147 100644
--- a/src/urcu-bp.c
+++ b/src/urcu-bp.c
@@ -154,12 +154,15 @@ URCU_ATTR_ALIAS("urcu_bp_gp") extern struct urcu_bp_gp rcu_gp_bp;
 DEFINE_URCU_TLS(struct urcu_bp_reader *, urcu_bp_reader);
 DEFINE_URCU_TLS_ALIAS(struct urcu_bp_reader *, urcu_bp_reader, rcu_reader_bp);
 
-static CDS_LIST_HEAD(registry);
+static CDS_LIST_HEAD_ALIGNED(registry, CAA_CACHE_LINE_SIZE);
 
 struct registry_chunk {
 	size_t data_len;		/* data length */
 	size_t used;			/* amount of data used */
 	struct cds_list_head node;	/* chunk_list node */
+	char pad[CAA_CACHE_LINE_SIZE -  /* pad to ensure expected alignment */
+		 sizeof(size_t) * 2 -
+		 sizeof(struct cds_list_head)];
 	char data[];
 };
 
@@ -270,8 +273,8 @@ static void wait_for_readers(struct cds_list_head *input_readers,
 
 void urcu_bp_synchronize_rcu(void)
 {
-	CDS_LIST_HEAD(cur_snap_readers);
-	CDS_LIST_HEAD(qsreaders);
+	CDS_LIST_HEAD_ALIGNED(cur_snap_readers, CAA_CACHE_LINE_SIZE);
+	CDS_LIST_HEAD_ALIGNED(qsreaders, CAA_CACHE_LINE_SIZE);
 	sigset_t newmask, oldmask;
 	int ret;
 

--------------E91DBDDFA8A509741168F3D8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------E91DBDDFA8A509741168F3D8--
