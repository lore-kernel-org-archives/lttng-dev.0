From: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] uatomic: Specify complete types for atomic
	function calls
Date: Sat, 22 Aug 2015 21:38:30 -0700
Message-ID: <1440304710-5312-1-git-send-email-raj.khem__12337.4129565947$1440395306$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f174.google.com ([209.85.223.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <raj.khem@gmail.com>) id 1ZTN3J-0006WB-Cx
 for lttng-dev@lists.lttng.org; Sun, 23 Aug 2015 00:38:46 -0400
Received: by iodv127 with SMTP id v127so118088318iod.3
 for <lttng-dev@lists.lttng.org>; Sat, 22 Aug 2015 21:38:36 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Khem Raj <raj.khem@gmail.com>
List-Id: lttng-dev@lists.lttng.org

This was unearthed by clang compiler where it complained about parameter
mismatch, gcc doesnt notice this

urcu/uatomic/generic.h:190:10: error: address argument to atomic builtin
must be a pointer to integer or pointer ('void *' invalid)
                return __sync_add_and_fetch_4(addr, val);

Fixed all instances thusly

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 urcu/uatomic/generic.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/urcu/uatomic/generic.h b/urcu/uatomic/generic.h
index 37f59cc..0046ffd 100644
--- a/urcu/uatomic/generic.h
+++ b/urcu/uatomic/generic.h
@@ -65,17 +65,17 @@ unsigned long _uatomic_cmpxchg(void *addr, unsigned long old,
 	switch (len) {
 #ifdef UATOMIC_HAS_ATOMIC_BYTE
 	case 1:
-		return __sync_val_compare_and_swap_1(addr, old, _new);
+		return __sync_val_compare_and_swap_1((unsigned char *)addr, old, _new);
 #endif
 #ifdef UATOMIC_HAS_ATOMIC_SHORT
 	case 2:
-		return __sync_val_compare_and_swap_2(addr, old, _new);
+		return __sync_val_compare_and_swap_2((unsigned short int *)addr, old, _new);
 #endif
 	case 4:
-		return __sync_val_compare_and_swap_4(addr, old, _new);
+		return __sync_val_compare_and_swap_4((unsigned int *)addr, old, _new);
 #if (CAA_BITS_PER_LONG == 64)
 	case 8:
-		return __sync_val_compare_and_swap_8(addr, old, _new);
+		return __sync_val_compare_and_swap_8((unsigned long *)addr, old, _new);
 #endif
 	}
 	_uatomic_link_error();
@@ -100,20 +100,20 @@ void _uatomic_and(void *addr, unsigned long val,
 	switch (len) {
 #ifdef UATOMIC_HAS_ATOMIC_BYTE
 	case 1:
-		__sync_and_and_fetch_1(addr, val);
+		__sync_and_and_fetch_1((unsigned char *)addr, val);
 		return;
 #endif
 #ifdef UATOMIC_HAS_ATOMIC_SHORT
 	case 2:
-		__sync_and_and_fetch_2(addr, val);
+		__sync_and_and_fetch_2((unsigned short int *)addr, val);
 		return;
 #endif
 	case 4:
-		__sync_and_and_fetch_4(addr, val);
+		__sync_and_and_fetch_4((unsigned int *)addr, val);
 		return;
 #if (CAA_BITS_PER_LONG == 64)
 	case 8:
-		__sync_and_and_fetch_8(addr, val);
+		__sync_and_and_fetch_8((unsigned long *)addr, val);
 		return;
 #endif
 	}
@@ -139,20 +139,20 @@ void _uatomic_or(void *addr, unsigned long val,
 	switch (len) {
 #ifdef UATOMIC_HAS_ATOMIC_BYTE
 	case 1:
-		__sync_or_and_fetch_1(addr, val);
+		__sync_or_and_fetch_1((unsigned char *)addr, val);
 		return;
 #endif
 #ifdef UATOMIC_HAS_ATOMIC_SHORT
 	case 2:
-		__sync_or_and_fetch_2(addr, val);
+		__sync_or_and_fetch_2((unsigned short int *)addr, val);
 		return;
 #endif
 	case 4:
-		__sync_or_and_fetch_4(addr, val);
+		__sync_or_and_fetch_4((unsigned int *)addr, val);
 		return;
 #if (CAA_BITS_PER_LONG == 64)
 	case 8:
-		__sync_or_and_fetch_8(addr, val);
+		__sync_or_and_fetch_8((unsigned long *)addr, val);
 		return;
 #endif
 	}
@@ -180,17 +180,17 @@ unsigned long _uatomic_add_return(void *addr, unsigned long val,
 	switch (len) {
 #ifdef UATOMIC_HAS_ATOMIC_BYTE
 	case 1:
-		return __sync_add_and_fetch_1(addr, val);
+		return __sync_add_and_fetch_1((unsigned char *)addr, val);
 #endif
 #ifdef UATOMIC_HAS_ATOMIC_SHORT
 	case 2:
-		return __sync_add_and_fetch_2(addr, val);
+		return __sync_add_and_fetch_2((unsigned short int *)addr, val);
 #endif
 	case 4:
-		return __sync_add_and_fetch_4(addr, val);
+		return __sync_add_and_fetch_4((unsigned int *)addr, val);
 #if (CAA_BITS_PER_LONG == 64)
 	case 8:
-		return __sync_add_and_fetch_8(addr, val);
+		return __sync_add_and_fetch_8((unsigned long *)addr, val);
 #endif
 	}
 	_uatomic_link_error();
@@ -218,7 +218,7 @@ unsigned long _uatomic_exchange(void *addr, unsigned long val, int len)
 
 		do {
 			old = uatomic_read((unsigned char *)addr);
-		} while (!__sync_bool_compare_and_swap_1(addr, old, val));
+		} while (!__sync_bool_compare_and_swap_1((unsigned char *)addr, old, val));
 
 		return old;
 	}
@@ -230,7 +230,7 @@ unsigned long _uatomic_exchange(void *addr, unsigned long val, int len)
 
 		do {
 			old = uatomic_read((unsigned short *)addr);
-		} while (!__sync_bool_compare_and_swap_2(addr, old, val));
+		} while (!__sync_bool_compare_and_swap_2((unsigned short int *)addr, old, val));
 
 		return old;
 	}
@@ -241,7 +241,7 @@ unsigned long _uatomic_exchange(void *addr, unsigned long val, int len)
 
 		do {
 			old = uatomic_read((unsigned int *)addr);
-		} while (!__sync_bool_compare_and_swap_4(addr, old, val));
+		} while (!__sync_bool_compare_and_swap_4((unsigned int *)addr, old, val));
 
 		return old;
 	}
@@ -252,7 +252,7 @@ unsigned long _uatomic_exchange(void *addr, unsigned long val, int len)
 
 		do {
 			old = uatomic_read((unsigned long *)addr);
-		} while (!__sync_bool_compare_and_swap_8(addr, old, val));
+		} while (!__sync_bool_compare_and_swap_8((unsigned long *)addr, old, val));
 
 		return old;
 	}
-- 
2.1.4
