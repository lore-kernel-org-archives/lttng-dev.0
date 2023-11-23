Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE9EC5AD4C
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Nov 2023 19:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1700767983;
	bh=xjjzfpmQFL01bAwRDswx5RhtvNks+ud8S8F6VeGkWnY=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=DJ+woy2woln1VUhLrQi3ZKcIjrSRiLxFiJ6q1yZoK4Ng6vDO0jPW9quZJOsQLSVaW
	 y+6h4D4kTjM09AZbXdohTpK1tItHlTR0A8N/4c0O9vZI1B8FgYzXUOVyG4awrjfMQm
	 T0DJHjavlBiLpunjPgJ3iOGvFBmJBAzhU71p/uWaB2M3QJIhdszR7+Plg5SGVTVl6V
	 y/h5xTiM716FUNdU9DxcWJppOhbv2rc79ElCaYO/HI56jcv6fbwCVjkR/dEP14VKPN
	 8vsz08J4gBMpdy7XkAChmQ/Py6EnqnxZfkZ461EuTQ91pnOkB52ONeN8+eI7C0Z1Xy
	 2sVL8vvD2oTww==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SbpDb2mgRzL71;
	Thu, 23 Nov 2023 14:33:03 -0500 (EST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by lists.lttng.org (Postfix) with ESMTPS id 4SbpDT3Lq0zKpw
 for <lttng-dev@lists.lttng.org>; Thu, 23 Nov 2023 14:32:57 -0500 (EST)
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-778ac9c898dso56955885a.0
 for <lttng-dev@lists.lttng.org>; Thu, 23 Nov 2023 11:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700767976; x=1701372776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qw/0Xi1Oq5WAqFrnmhhl+tFyHbm+a0ci6FljNDUHnVk=;
 b=ABlTMz2FYNxo0+Ja/Cil8VtGpSe1wBPEtLPhMG2Fay27HFxUZINVoXRh8k7u6dz8xO
 M6m+8s3L4bosXfuE3BJoLtdV8OwSLsmuZOdkQmsjuolbzhMOE8o76BDmPLyuFCNXiVwE
 nucfRO0MIRDHoIdXj06/mhSzQ+YpN9lbwNqvYxDVhoeo16XZCxrzEP/+uKiLyZ86o9Rx
 wToTk5d40WsqvS0CiCCgsksx23qipz9nK5eHhrDQclHPQoIPpke0hg0m4LuNhdk5Ki6+
 HOBp89GDV9u2wOzEzevf54APrBG84XfeufO04TsnoZvk0+cyMXbl7iJii6Lqp7pTzvnv
 6P6A==
X-Gm-Message-State: AOJu0YygrJKFvJEsyUcR5/sG2+1Ie+vNbYD7g1fqRkkMtU3S5ZqyeW/W
 +N9lMZW7iEoVbcHWNVQxWwYWPUu3a12D5Q==
X-Google-Smtp-Source: AGHT+IFOGfKMVtNgV/xWzqKoxuLX+RBb3BQ2pGzbWO895S39sqku+N+cWDap5ULbJfULCP/5WX6E+g==
X-Received: by 2002:a05:620a:8d87:b0:777:74c0:4f3b with SMTP id
 rc7-20020a05620a8d8700b0077774c04f3bmr284545qkn.76.1700767976384; 
 Thu, 23 Nov 2023 11:32:56 -0800 (PST)
Received: from localhost.localdomain ([174.112.183.231])
 by smtp.gmail.com with ESMTPSA id
 dt32-20020a05620a47a000b0077d71d46887sm662669qkb.112.2023.11.23.11.32.55
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 11:32:55 -0800 (PST)
To: lttng-dev@lists.lttng.org
Date: Thu, 23 Nov 2023 14:32:48 -0500
Message-Id: <20231123193249.3190764-2-bruce.ashfield@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123193249.3190764-1-bruce.ashfield@gmail.com>
References: <20231123193249.3190764-1-bruce.ashfield@gmail.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 2/3] wrapper/fdtable: adjust fd lookup to v6.7+
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
From: Bruce Ashfield via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: bruce.ashfield@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

From: Bruce Ashfield <bruce.ashfield@gmail.com>

commit 0ede61d8589cc2d93 [file: convert to SLAB_TYPESAFE_BY_RCU]
renames lookup_fd_rcu to lookup_fdget_rcu, so we need to
version adjust the fdtable wrapper accordingly.

Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
---

Repeating the comment from patch 1 of this series:

Someone else may or may not already have this in flight,
but I didn't see anything on the list or in the git
repo.

I ran into this failure when working on the v6.7-rc
kernel as part of yocto project kernel updates.

Tweak as necessary, as I'm no expert in the right way
to version these sort of changes.

Bruce


 include/wrapper/fdtable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/wrapper/fdtable.h b/include/wrapper/fdtable.h
index fa5f7207..aaf2b9e7 100644
--- a/include/wrapper/fdtable.h
+++ b/include/wrapper/fdtable.h
@@ -16,7 +16,11 @@
 static inline
 struct file *lttng_lookup_fd_rcu(unsigned int fd)
 {
+#if (LTTNG_LINUX_VERSION_CODE < LTTNG_KERNEL_VERSION(6,7,0))
 	return lookup_fd_rcu(fd);
+#else
+	return lookup_fdget_rcu(fd);
+#endif
 }
 #else
 static inline
-- 
2.34.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
