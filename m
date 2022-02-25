Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A46C433EF
	for <lttng-dev@archiver.kernel.org>; Fri, 25 Feb 2022 15:13:31 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4K4tZd4Bpxz3wZ;
	Fri, 25 Feb 2022 10:13:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1645802010;
	bh=rsNJ+Fm5ew9G+FF/fxPVXasfd+ie1XoxFT8aE1x50Ko=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=b/ttJpXrfFNBm3XrJktSXVMp3thpkaEj/eM8k6eEFVTgU/FNTmO3iXe3der5dz7OY
	 XefbVTzRiAbNThLJOhvRnyLrbEhAK9vg534459ol5Rn+ZDAdvBfw8FA6w0IDJvQ7f5
	 ckRIdlGrRs5xvF4W2nqmk80F6D5DFX0MTxPJetrW/gnJrDC7MIyu84hKPbXcJOfUe4
	 wJVcnFVHn9QFLst++fr8PtZEq30XSl28uUBrHfz9EAxjjILe5kZ9+WF5zYfKEe+c2M
	 vX1SN3vA2TBY4XXWolnyWHBLS2arpxJyAkbZK9LXYHJA8j2fzz+LVIMmVTnB8beCYT
	 tPOPVcVwK4lOw==
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by lists.lttng.org (Postfix) with ESMTPS id 4K4tZb5c07z3rN
 for <lttng-dev@lists.lttng.org>; Fri, 25 Feb 2022 10:13:27 -0500 (EST)
To: <lttng-dev@lists.lttng.org>
Date: Fri, 25 Feb 2022 16:12:02 +0100
Message-ID: <20220225151202.4148809-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH lttng-tools] Fix: consumer-stream:
 use-after-free of metadata bucket
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
From: Vincent Whitchurch via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: kernel@axis.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

When consumer_stream_destroy() is called from, for example, the error
path in setup_metadata(), consumer_stream_free() can end up being called
twice on the same stream.  Since the stream->metadata_bucket is not set
to NULL after being destroyed, it leads to a use-after-free:

 ERROR: AddressSanitizer: heap-use-after-free on address 0x604000000318
 READ of size 8 at 0x604000000318 thread T7
     #0 in metadata_bucket_destroy
     #1 in consumer_stream_free
     #2 in consumer_stream_destroy
     #3 in setup_metadata
     #4 in lttng_ustconsumer_recv_cmd
     #5 in lttng_consumer_recv_cmd
     #6 in consumer_thread_sessiond_poll
     #7 in start_thread nptl/pthread_create.c:481
     #8 in clone (/lib/x86_64-linux-gnu/libc.so.6+0xfcbde)

 0x604000000318 is located 8 bytes inside of 48-byte region [0x604000000310,0x604000000340)
 freed by thread T7 here:
     #0 in __interceptor_free
     #1 in metadata_bucket_destroy
     #2 in consumer_stream_free
     #3 in consumer_stream_destroy
     #4 in clean_channel_stream_list
     #5 in consumer_del_channel
     #6 in consumer_stream_destroy
     #7 in setup_metadata
     #8 in lttng_ustconsumer_recv_cmd
     #9 in lttng_consumer_recv_cmd
     #10 in consumer_thread_sessiond_poll
     #11 in start_thread nptl/pthread_create.c:481

 previously allocated by thread T7 here:
     #0 in __interceptor_calloc
     #1 in zmalloc
     #2 in metadata_bucket_create
     #3 in consumer_stream_enable_metadata_bucketization
     #4 in lttng_ustconsumer_set_stream_ops
     #5 in lttng_ustconsumer_on_recv_stream
     #6 in lttng_consumer_on_recv_stream
     #7 in create_ust_streams
     #8 in ask_channel
     #9 in lttng_ustconsumer_recv_cmd
     #10 in lttng_consumer_recv_cmd
     #11 in consumer_thread_sessiond_poll
     #12 in start_thread nptl/pthread_create.c:481

 Thread T7 created by T0 here:
     #0 in __interceptor_pthread_create
     #1 in main
     #2 in __libc_start_main ../csu/libc-start.c:332

 SUMMARY: AddressSanitizer: heap-use-after-free in metadata_bucket_destroy

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 src/common/consumer/consumer-stream.cpp | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/common/consumer/consumer-stream.cpp b/src/common/consumer/consumer-stream.cpp
index 2dc3f002b..481611c3e 100644
--- a/src/common/consumer/consumer-stream.cpp
+++ b/src/common/consumer/consumer-stream.cpp
@@ -988,6 +988,7 @@ void consumer_stream_free(struct lttng_consumer_stream *stream)
 	LTTNG_ASSERT(stream);
 
 	metadata_bucket_destroy(stream->metadata_bucket);
+	stream->metadata_bucket = NULL;
 	call_rcu(&stream->node.head, free_stream_rcu);
 }
 
-- 
2.34.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
