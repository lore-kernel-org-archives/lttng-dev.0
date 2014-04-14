From: Keir Fraser <keir@cohodata.com>
Subject: [PATCH liburcu] Fix pthread_atfork() behaviour
Date: Mon, 14 Apr 2014 14:31:57 +0100
Message-ID: <534BE34D.6040304__42638.7824853466$1397488843$gmane$org@cohodata.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070001000304040202010108"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <keir@cohodata.com>) id 1WZgzX-00013b-OW
 for lttng-dev@lists.lttng.org; Mon, 14 Apr 2014 09:32:13 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so4021863wiv.3
 for <lttng-dev@lists.lttng.org>; Mon, 14 Apr 2014 06:32:01 -0700 (PDT)
Received: from unknown-a8:20:66:16:48:c7.home
 (host86-149-186-214.range86-149.btcentralplus.com. [86.149.186.214])
 by mx.google.com with ESMTPSA id ft8sm6392500wib.13.2014.04.14.06.31.59
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 14 Apr 2014 06:31:59 -0700 (PDT)
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

This is a multi-part message in MIME format.
--------------070001000304040202010108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In the process of integrating liburcu into a multi-threaded codebase 
with fork()s I found a couple of problems with liburcu that I could not 
work around without fixing the library. Hence I present the two required 
fixes here (as attachments, sorry!) with some background info about them.

After fork() the child process has no pthreads but the one that called 
fork(). Unfortunately call_rcu_after_fork_child() does not update URCU's 
thread registry to reflect this -- if fork() is called with any threads 
registered with URCU then the child process will inherit a corrupted 
registry containing a linked list through per-thread TLS state which is 
no longer valid allocated memory. Crash or hang soon after is the 
result. Patch 1 therefore simply clears the registry list in the child 
process. Caveats here are that (a) the calling thread cannot be 
registered (it must unregister/re-register itself in the atfork 
handlers); and (b) some flavours of URCU may have more complex 
registries than a simple linked list and so this patch may not be 
sufficient for those. I only tested the memb/mb flavour myself.

A second problem is that although call_rcu threads are paused across 
fork(), the handshaking PAUSED flag is not cleared when their execution 
resumes. Hence a second fork() invocation in the original parent process 
will not spin-wait for call_rcu threads to quiesce (as the atfork 
handler will observe all PAUSED flags already set). Patch 2 fixes this 
with the appropriate clearing handshake on resume, post-fork.

Please feel free to modify or rewrite these patches, or solve the 
described problems in a different way, as you see fit! Cc me on replies 
as I am not a subscriber to this list.

  Regards,
  Keir Fraser

--------------070001000304040202010108
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="1-zap-thread-registry.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="1-zap-thread-registry.patch"

From 3044b160c9e5614787db5891fb0ded8a4a1ed108 Mon Sep 17 00:00:00 2001
From: Keir Fraser <keir@cohodata.com>
Date: Mon, 7 Apr 2014 14:20:33 +0100
Subject: [PATCH 1/2] Clean the thread registry in the child of a fork.
 No threads are registered there, and the registry is a linked list through
 non-existent per-thread state.

The caller of the pthread_atfork() handlers must not be an RCU-registered thread.

Signed-off-by: Keir Fraser <keir@cohodata.com>
---
 urcu-call-rcu-impl.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
index 10c4f3e..a050d41 100644
--- a/urcu-call-rcu-impl.h
+++ b/urcu-call-rcu-impl.h
@@ -887,6 +887,9 @@ void call_rcu_after_fork_child(void)
 	/* Release the mutex. */
 	call_rcu_unlock(&call_rcu_mutex);
 
+	/* No RCU-registered threads at this point. Clean the registry. */
+	CDS_INIT_LIST_HEAD(&registry);
+
 	/* Do nothing when call_rcu() has not been used */
 	if (cds_list_empty(&call_rcu_data_list))
 		return;
-- 
1.8.3.2


--------------070001000304040202010108
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="2-clear-paused-flag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="2-clear-paused-flag.patch"

From 7722952d181132856d71c929f5395e62a05f5c0c Mon Sep 17 00:00:00 2001
From: Keir <keir@cohodata.com>
Date: Mon, 7 Apr 2014 14:28:52 +0100
Subject: [PATCH 2/2] call_rcu threads should clear their PAUSED flag
 when they unpause.

And call_rcu_after_fork_parent should spin-wait on this.

Otherwise a second fork in the parent will see the PAUSED flags
already set and call_rcu_before_fork will not correctly wait for the
call_rcu threads to quiesce on this second occasion.

Signed-off-by: Keir Fraser <keir@cohodata.com>
---
 urcu-call-rcu-impl.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
index a050d41..5c25a75 100644
--- a/urcu-call-rcu-impl.h
+++ b/urcu-call-rcu-impl.h
@@ -308,6 +308,8 @@ static void *call_rcu_thread(void *arg)
 			uatomic_or(&crdp->flags, URCU_CALL_RCU_PAUSED);
 			while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_PAUSE) != 0)
 				poll(NULL, 0, 1);
+			uatomic_and(&crdp->flags, ~URCU_CALL_RCU_PAUSED);
+			cmm_smp_mb__after_uatomic_and();
 			rcu_register_thread();
 		}
 
@@ -872,6 +874,10 @@ void call_rcu_after_fork_parent(void)
 
 	cds_list_for_each_entry(crdp, &call_rcu_data_list, list)
 		uatomic_and(&crdp->flags, ~URCU_CALL_RCU_PAUSE);
+	cds_list_for_each_entry(crdp, &call_rcu_data_list, list) {
+		while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_PAUSED) != 0)
+			poll(NULL, 0, 1);
+	}
 	call_rcu_unlock(&call_rcu_mutex);
 }
 
-- 
1.8.3.2


--------------070001000304040202010108
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------070001000304040202010108--
