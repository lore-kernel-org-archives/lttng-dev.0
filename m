Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2737C6FA82
	for <lttng-dev@archiver.kernel.org>; Tue, 27 Sep 2022 16:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1664297575;
	bh=UdMYpsM6ZQlYUly/HVA28qKeKGkqlrAxvX3p+Uiohyk=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=f5Dl/Lhc55Qo3dEyqnuc7GkuQ2D5ckUl5YQKB3lb4LcWElSHmcfMQFstnHaiLj1xb
	 DQWCWDAqUBcyKjmiHwKXMfk7inM8uv6NbdzV39iloSty4lwRqMPDooxEzLV2N3WhwW
	 HshKwMVhU4xZyu4nbV1yrFBHcr3iR6tugm0JRoscWKDcRPrmO4k66SfOLfps1cTIEU
	 0PTDbjCCRp22c6oXxHdN9tgUk6ecRA3YQJqEz1QFkt2U5VuRT9mJLBf92rtZvLU3pO
	 thIL3Fca+uKTc5q3hrpeNi2X/UKRNpkDyK6/UQ/77jYBX0P+8Muj+ti/4ZWhxW3ynE
	 pzUBXwu+FhXiQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4McQfb0XVvz25xw;
	Tue, 27 Sep 2022 12:52:55 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:5aae::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4McQfY707nz25xv
 for <lttng-dev@lists.lttng.org>; Tue, 27 Sep 2022 12:52:53 -0400 (EDT)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4McQfR2GTXzNy5;
 Tue, 27 Sep 2022 12:52:47 -0400 (EDT)
To: jgalar@efficios.com
Date: Tue, 27 Sep 2022 12:52:42 -0400
Message-Id: <20220927165242.644594-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH lttng-tools 1/1] Fix: Handle empty string in
 lttng_event_field_value_string_create_with_size
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

When using the event notification capture API, empty strings are
represented by a NULL pointer with a size=0 in the msgpack object.
The NULL pointer is unexpected, which triggers an assertion in
lttng_event_field_value_string_create_with_size.

Fix this by duplicating an empty string ("") when a size=0 is
encountered. This ensures that users of the API don't end up with an
unexpected NULL pointer. Indeed, the sample program notif-app.c in the
LTTng website documentation does not expect a NULL pointer.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Change-Id: I7c3a839dbbeeb95a1b3bf6ddc3205a2f6b4538e3
---
 src/common/event-field-value.cpp | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/common/event-field-value.cpp b/src/common/event-field-value.cpp
index 8017fd081..fa9e97018 100644
--- a/src/common/event-field-value.cpp
+++ b/src/common/event-field-value.cpp
@@ -183,8 +183,17 @@ struct lttng_event_field_value *lttng_event_field_value_string_create_with_size(
 		goto error;
 	}
 
-	LTTNG_ASSERT(val);
-	field_val->val = strndup(val, size);
+	if (size) {
+		LTTNG_ASSERT(val);
+		field_val->val = strndup(val, size);
+	} else {
+		/*
+		 * User code (e.g. notif-app.c on lttng.org/docs) do not expect
+		 * a NULL string pointer. Populate with an empty string when
+		 * length is 0.
+		 */
+		field_val->val = strdup("");
+	}
 	if (!field_val->val) {
 		goto error;
 	}
-- 
2.25.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
