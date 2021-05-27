Return-Path: <SRS0=hpL2=KW=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAC7C47089
	for <lttng-dev@archiver.kernel.org>; Thu, 27 May 2021 21:11:42 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF08F610A8
	for <lttng-dev@archiver.kernel.org>; Thu, 27 May 2021 21:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF08F610A8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FrgVK6F6Xz1xlp;
	Thu, 27 May 2021 17:11:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1622149898;
	bh=NcVusCFNj+R1ErTaBUrZVBkpmHUJF8smcYIMbQ20HE8=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=DtigTbYnmox490gsefpk3WtKG3YORtQaeDXMLTm8z6x+ILMJElk5l6N4nQ61XyGQG
	 vA8o6cnbIcxaTZowRj70iDgxVnC1EP3RZBMhCbly3tDg7ltEJSiVAuIf54XIaYOKQK
	 WBdqIlyZ2RGxuR4jflvFCboKr2JeZ+q+GkFCJNMOPepty7xkFX17sg0ypF6bh6YHge
	 dFVwbrwjvxCkvJZDP9u00joeV6AxAlv81JL+4yZcmj8sIrKOrHyWmjYRT5D8h41LXU
	 XT0WbZKWz1SU4DK5HNfs7+e+L1C/HWDEk72w6/6T9YOuyTw7BT1D25PZPThPQW4acZ
	 8NhifwOPX6dGA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FrgVH3wV1z3PC
 for <lttng-dev@lists.lttng.org>; Thu, 27 May 2021 17:11:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 92BE47A67;
 Thu, 27 May 2021 17:11:29 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id JxW41TNhvq3L; Thu, 27 May 2021 17:11:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9A6B47A66;
 Thu, 27 May 2021 17:11:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9A6B47A66
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id yOezSq1hu7DQ; Thu, 27 May 2021 17:11:28 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net
 [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id 6B11C7E13;
 Thu, 27 May 2021 17:11:28 -0400 (EDT)
To: jgalar@efficios.com
Date: Thu, 27 May 2021 17:11:22 -0400
Message-Id: <20210527211122.2462-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Subject: [lttng-dev] [PATCH lttng-tools stable-2.12] Fix:
 list_lttng_agent_events: unbalanced RCU read-side lock on error
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

The error label jumps to the end label which releases the RCU read-side
lock. There are many error paths in this function which goto error
without holding the RCU read-side lock, thus causing unbalanced RCU
read-side lock.

There is no point in keeping so short RCU read-side critical sections,
so cover the entire function with a single read-side critical section.

[ Applies to stable-2.12 and possibly prior versions. Does _not_ apply
  to stable-2.13+. ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Change-Id: I5b20c229a5df22d22ecfdc64dbbb87ee118649d2
---
 src/bin/lttng-sessiond/cmd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index b608df1e1..eb5da1b76 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -510,7 +510,6 @@ static int list_lttng_agent_events(struct agent *agt,
 
 	rcu_read_lock();
 	nb_event = lttng_ht_get_count(agt->events);
-	rcu_read_unlock();
 	if (nb_event == 0) {
 		ret = nb_event;
 		*total_size = 0;
@@ -524,7 +523,6 @@ static int list_lttng_agent_events(struct agent *agt,
 	 * This is only valid because the commands which add events are
 	 * processed in the same thread as the listing.
 	 */
-	rcu_read_lock();
 	cds_lfht_for_each_entry(agt->events->ht, &iter.iter, event, node.node) {
 		ret = increment_extended_len(event->filter_expression, NULL, NULL,
 				&extended_len);
@@ -534,7 +532,6 @@ static int list_lttng_agent_events(struct agent *agt,
 			goto error;
 		}
 	}
-	rcu_read_unlock();
 
 	*total_size = nb_event * sizeof(*tmp_events) + extended_len;
 	tmp_events = zmalloc(*total_size);
@@ -547,7 +544,6 @@ static int list_lttng_agent_events(struct agent *agt,
 	extended_at = ((uint8_t *) tmp_events) +
 		nb_event * sizeof(struct lttng_event);
 
-	rcu_read_lock();
 	cds_lfht_for_each_entry(agt->events->ht, &iter.iter, event, node.node) {
 		strncpy(tmp_events[i].name, event->name, sizeof(tmp_events[i].name));
 		tmp_events[i].name[sizeof(tmp_events[i].name) - 1] = '\0';
-- 
2.17.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
