Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC07C54EBE
	for <lttng-dev@archiver.kernel.org>; Tue, 10 Jan 2023 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1673348473;
	bh=Bx/m3YDNEPlen9X1m2JHmBOUu6RnHuFG73D6uN25VxI=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=v9AMiGl0CkpEBmpDKcfiieCqYMQMxvHVoWzYRy6Tl3GR1+G2hF7xOGsPyDbfgCeeJ
	 DAaTy6CVH1DyRsJPQzTWSGs6VOeKT8+0LmUu337LfP9C5C3DaIuyuI5X8yWmFdt3z3
	 mtD91li0xtCtu5AcETeAKNDKzXCJH7dcZSVLg5nrLQnBSlY8q/EfeNSGaASoewtnZy
	 HC9S6shM/gxYbJKLPdcaI6/Wmu7VECWNtpCYFcn9EiPYSucWvesXH38sF6Bf569OWV
	 lr7aMpTYvuP4CrvwTlFLd1gkWWy6IDSdSU0mlYJHDB/rypZqLQYsnpdJ7C4eqX+C1H
	 8jWYto6OQoZhQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4NrntK18pzz1Pjg;
	Tue, 10 Jan 2023 06:01:13 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4NrntH5LSNz1PJZ
 for <lttng-dev@lists.lttng.org>; Tue, 10 Jan 2023 06:01:10 -0500 (EST)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-BjhxAYraMMK0BpVLmR6wFQ-1; Tue, 10 Jan 2023 05:54:24 -0500
X-MC-Unique: BjhxAYraMMK0BpVLmR6wFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99DB438041CF
 for <lttng-dev@lists.lttng.org>; Tue, 10 Jan 2023 10:54:24 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B0851121314
 for <lttng-dev@lists.lttng.org>; Tue, 10 Jan 2023 10:54:24 +0000 (UTC)
To: lttng-dev@lists.lttng.org
Date: Tue, 10 Jan 2023 11:54:22 +0100
Message-ID: <87h6wyhd7l.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Subject: [lttng-dev] [PATCH] lttv: C99 compatibility fix
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

While rebuilding Fedora with a C99 compiler, we noticed that we need
this patch to avoid a compilation error:

diff --git a/lttv/lttv/state.c b/lttv/lttv/state.c
index 513c1bf3bb03ec7a..a1a31df2cbe6be30 100644
--- a/lttv/lttv/state.c
+++ b/lttv/lttv/state.c
@@ -271,7 +271,7 @@ gboolean rettrue(gpointer key, gpointer value, gpointer user_data)
 	return TRUE;
 }
 
-static guint check_expand(nb, id)
+static guint check_expand(int nb, int id)
 {
 	if(likely(nb > id))
 		return nb;

Related to:

  <https://fedoraproject.org/wiki/Changes/PortingToModernC>
  <https://fedoraproject.org/wiki/Toolchain/PortingToModernC>

Thanks,
Florian

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
