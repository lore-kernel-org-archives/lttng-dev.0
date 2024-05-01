Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDF1C4345F
	for <lttng-dev@archiver.kernel.org>; Wed,  1 May 2024 23:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1714607103;
	bh=1aET3UPl+3xKWwn9rKOb90Zq7z2+e7CLuTUWMCrOfqg=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=zCHLhWg6F3w9/Cc6QS46IzF4bf03BLWhsIpqa0ldB8zdvSSuxL4q7ZlB3LzSvYHaG
	 k3axdmTiH3Mya3TvCy87F6yXp2UbEPa9udfVf9BsblUK3KQ+Dy8esF19CBSOSAoMdi
	 h1OGYYogsvaXQb9L0y2qcFxhjqxqzO2bVeR2eo6SlMYwno829HWJhTa1FXuwsor3Z2
	 WV3dChm2G3PYLGNzdRv+9xaE5zLx+67PH7gKx3VlkvZkr8hcNcJea5MTbWEjwoB6Go
	 f01+QaD4bEXfMiskGk0mpznwQplhXJS/oqhJTzjvPhTtb7vDxGjZrinR7zRtxvUdtl
	 uxGuoJXHS+6Iw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VVDFV4YPvz2kQk;
	Wed,  1 May 2024 19:45:02 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4VVDFS34Jhz2kr8
 for <lttng-dev@lists.lttng.org>; Wed,  1 May 2024 19:45:00 -0400 (EDT)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-S15XGB99Pku64ldgCkWoAQ-1; Wed,
 01 May 2024 19:42:42 -0400
X-MC-Unique: S15XGB99Pku64ldgCkWoAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 478EB3C0009D
 for <lttng-dev@lists.lttng.org>; Wed,  1 May 2024 23:42:42 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com
 (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42252AC6B
 for <lttng-dev@lists.lttng.org>; Wed,  1 May 2024 23:42:42 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
 by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.1/8.17.1) with
 ESMTPS id 441Nggr62395668
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Wed, 1 May 2024 19:42:42 -0400
Received: (from bmarzins@localhost)
 by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.1/8.17.1/Submit) id
 441Ngghp2395667
 for lttng-dev@lists.lttng.org; Wed, 1 May 2024 19:42:42 -0400
To: lttng-dev@lists.lttng.org
Date: Wed,  1 May 2024 19:42:41 -0400
Message-ID: <20240501234242.2395659-1-bmarzins@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Subject: [lttng-dev] [PATCH urcu] fix: handle EINTR correctly in
 get_cpu_mask_from_sysfs
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
From: Benjamin Marzinski via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Benjamin Marzinski <bmarzins@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

If the read() in get_cpu_mask_from_sysfs() fails with EINTR, the code is
supposed to retry, but the while loop condition has (bytes_read > 0),
which is false when read() fails with EINTR. The result is that the code
exits the loop, having only read part of the string.

Use (bytes_read != 0) in the while loop condition instead, since the
(bytes_read < 0) case is already handled in the loop.

Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 src/compat-smp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/compat-smp.h b/src/compat-smp.h
index 31fa979..075a332 100644
--- a/src/compat-smp.h
+++ b/src/compat-smp.h
@@ -164,7 +164,7 @@ static inline int get_cpu_mask_from_sysfs(char *buf, size_t max_bytes, const cha
 
 		total_bytes_read += bytes_read;
 		assert(total_bytes_read <= max_bytes);
-	} while (max_bytes > total_bytes_read && bytes_read > 0);
+	} while (max_bytes > total_bytes_read && bytes_read != 0);
 
 	/*
 	 * Make sure the mask read is a null terminated string.
-- 
2.44.0

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
