Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3AEC4707B
	for <lttng-dev@archiver.kernel.org>; Sat, 13 Jan 2024 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705150224;
	bh=YAJgSeRLcyqwXM6C1maBCFefGRD/TN+yd+TvIyaNX20=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=njBX9brsQxrimTlPeDXWNq2DdV0c838pWca8u4pSBK8UYA9TJDxPqPtIbQS+JrSrx
	 KLfiAd/kMBdDIcA3NnYVJu8QtvKTds2uo8TW+YMauhccZUKLNSz/OW3KBUSRxU7Y12
	 UM4rsk4MbPxtSWmjG46D+RoGrqkUEA9dGEQE74MQddxLqX62TSywmfpE/zA9V89dfB
	 AGSrCm7dXlzWYi47b1OT3CWPQeUVBY9Qo3qJQ/acg5rh2dFWQv7KHDx+29fGqIHc+/
	 c3lbkz36tEDvQvituOp2eNSz3F+qvAIFPrZd+eZY5IhzEy66fOeHVc0f4ahwxBrdHf
	 t9G6VFR0L7E7g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TBytR6RVNz1MQc;
	Sat, 13 Jan 2024 07:50:23 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4TBytQ5R1pz1MW3
 for <lttng-dev@lists.lttng.org>; Sat, 13 Jan 2024 07:50:22 -0500 (EST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-W-dsHOidPMeHYoXYVbNQ_g-1; Sat, 13 Jan 2024 07:49:10 -0500
X-MC-Unique: W-dsHOidPMeHYoXYVbNQ_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 274F485A588;
 Sat, 13 Jan 2024 12:49:10 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E91991C0652C;
 Sat, 13 Jan 2024 12:49:07 +0000 (UTC)
To: gcc@gcc.gnu.org, libc-alpha@sourceware.org
Cc: Iain Sandoe <iain@sandoe.co.uk>, aburgess@redhat.com,
 lttng-dev@lists.lttng.org, Szabolcs Nagy <szabolcs.nagy@arm.com>
Date: Sat, 13 Jan 2024 13:49:05 +0100
Message-ID: <8734v1ieke.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Subject: [lttng-dev] New TLS usage in libgcc_s.so.1, compatibility impact
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Florian Weimer via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

This commit

commit 8abddb187b33480d8827f44ec655f45734a1749d
Author: Andrew Burgess <andrew.burgess@embecosm.com>
Date:   Sat Aug 5 14:31:06 2023 +0200

    libgcc: support heap-based trampolines
    
    Add support for heap-based trampolines on x86_64-linux, aarch64-linux,
    and x86_64-darwin. Implement the __builtin_nested_func_ptr_created and
    __builtin_nested_func_ptr_deleted functions for these targets.
    
    Co-Authored-By: Maxim Blinov <maxim.blinov@embecosm.com>
    Co-Authored-By: Iain Sandoe <iain@sandoe.co.uk>
    Co-Authored-By: Francois-Xavier Coudert <fxcoudert@gcc.gnu.org>

added TLS usage to libgcc_s.so.1.  The way that libgcc_s is currently
built, it ends up using a dynamic TLS variant on the Linux targets.
This means that there is no up-front TLS allocation with glibc (but
there would be one with musl).

There is still a compatibility impact because glibc assigns a TLS module
ID upfront.  This seems to be what causes the
ust/libc-wrapper/test_libc-wrapper test in lttng-tools to fail.  We end
up with an infinite regress during process termination because
libgcc_s.so.1 has been loaded, resulting in a DTV update.  When this
happens, the bottom of the stack looks like this:

#4447 0x00007ffff7f288f0 in free () from /lib64/liblttng-ust-libc-wrapper.so.1
#4448 0x00007ffff7fdb142 in free (ptr=<optimized out>)
    at ../include/rtld-malloc.h:50
#4449 _dl_update_slotinfo (req_modid=3, new_gen=2) at ../elf/dl-tls.c:822
#4450 0x00007ffff7fdb214 in update_get_addr (ti=0x7ffff7f2bfc0, 
    gen=<optimized out>) at ../elf/dl-tls.c:916
#4451 0x00007ffff7fddccc in __tls_get_addr ()
    at ../sysdeps/x86_64/tls_get_addr.S:55
#4452 0x00007ffff7f288f0 in free () from /lib64/liblttng-ust-libc-wrapper.so.1
#4453 0x00007ffff7fdb142 in free (ptr=<optimized out>)
    at ../include/rtld-malloc.h:50
#4454 _dl_update_slotinfo (req_modid=2, new_gen=2) at ../elf/dl-tls.c:822
#4455 0x00007ffff7fdb214 in update_get_addr (ti=0x7ffff7f39fa0, 
    gen=<optimized out>) at ../elf/dl-tls.c:916
#4456 0x00007ffff7fddccc in __tls_get_addr ()
    at ../sysdeps/x86_64/tls_get_addr.S:55
#4457 0x00007ffff7f36113 in lttng_ust_cancelstate_disable_push ()
   from /lib64/liblttng-ust-common.so.1
#4458 0x00007ffff7f4c2e8 in ust_lock_nocheck () from /lib64/liblttng-ust.so.1
#4459 0x00007ffff7f5175a in lttng_ust_cleanup () from /lib64/liblttng-ust.so.1
#4460 0x00007ffff7fca0f2 in _dl_call_fini (
    closure_map=closure_map@entry=0x7ffff7fbe000) at dl-call_fini.c:43
#4461 0x00007ffff7fce06e in _dl_fini () at dl-fini.c:114
#4462 0x00007ffff7d82fe6 in __run_exit_handlers () from /lib64/libc.so.6

Cc:ing <lttng-dev@lists.lttng.org> for awareness.

The issue also requires a recent glibc with changes to DTV management:
commit d2123d68275acc0f061e73d5f86ca504e0d5a344 ("elf: Fix slow tls
access after dlopen [BZ #19924]").  If I understand things correctly,
before this glibc change, we didn't deallocate the old DTV, so there was
no call to the free function.

On the glibc side, we should recommend that intercepting mallocs and its
dependencies use initial-exec TLS because that kind of TLS does not use
malloc.  If intercepting mallocs using dynamic TLS work at all, that's
totally by accident, and was in the past helped by glibc bug 19924.  (I
don't think there is anything special about libgcc_s.so.1 that triggers
the test failure above, it is just an object with dynamic TLS that is
implicitly loaded via dlopen at the right stage of the test.)  In this
particular case, we can also paper over the test failure in glibc by not
call free at all because the argument is a null pointer:

diff --git a/elf/dl-tls.c b/elf/dl-tls.c
index 7b3dd9ab60..14c71cbd06 100644
--- a/elf/dl-tls.c
+++ b/elf/dl-tls.c
@@ -819,7 +819,8 @@ _dl_update_slotinfo (unsigned long int req_modid, size_t new_gen)
 		 dtv entry free it.  Note: this is not AS-safe.  */
 	      /* XXX Ideally we will at some point create a memory
 		 pool.  */
-	      free (dtv[modid].pointer.to_free);
+	      if (dtv[modid].pointer.to_free != NULL)
+		free (dtv[modid].pointer.to_free);
 	      dtv[modid].pointer.val = TLS_DTV_UNALLOCATED;
 	      dtv[modid].pointer.to_free = NULL;

As the comment hints, we shouldn't be using malloc for TLS memory at all
because it is not AS-safe, but that's a long-term change.  This change
seems rather specific to this particular test case failure because it
relies on libgcc_s.so.1 never using TLS before it gets unloaded.

Regarding the libgcc_s side, I'm not sure if the TLS usage there should
be considered a real problem, although I'm a bit nervous about it.
However, the current implementation caches one page of trampolines past
the outermost nested function pointer deallocation (otherwise creating
one function pointer per thread in a loop would be really expensive).
It looks to me that is never freed, so if the thread exits even with
proper unwinding (e.g., on glibc with code compiled with -fexceptions),
there is a memory leak.  Integration with glibc could avoid this issue,
and also help with the longjmp problem, and fix setcontext/swapcontext,
too.

Thanks,
Florian

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
