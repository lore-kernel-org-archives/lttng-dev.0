From: Jon Bernard <jbernard@debian.org>
Subject: Fwd: Bug#705827: babeltrace: FTBFS on GNU/kFreeBSD
Date: Mon, 22 Apr 2013 11:24:17 -0400
Message-ID: <20130422152417.GA13418__31906.5233612948$1366644289$gmane$org@quintessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@debian.org>) id 1UUIbP-000813-Ls
	for lttng-dev@lists.lttng.org; Mon, 22 Apr 2013 11:24:24 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 538E620B76
	for <lttng-dev@lists.lttng.org>; Mon, 22 Apr 2013 11:24:18 -0400 (EDT)
Received: from localhost (unknown [216.252.204.142])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1DF97200060
	for <lttng-dev@lists.lttng.org>; Mon, 22 Apr 2013 11:24:18 -0400 (EDT)
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hello all, I received this request over the weekend and wanted to pass it on.

----- Forwarded message from Petr Salinger <Petr.Salinger@seznam.cz> -----

Date: Sat, 20 Apr 2013 19:19:11 +0200 (CEST)
From: Petr Salinger <Petr.Salinger@seznam.cz>
To: submit@bugs.debian.org
Subject: Bug#705827: babeltrace: FTBFS on GNU/kFreeBSD

Package: babeltrace
Version: 1.1.0-1
Severity: serious
Tags: patch
User: debian-bsd@lists.debian.org
Usertags: kfreebsd

Hi,

the current version fails to build on GNU/kFreeBSD.

The value ENODATA is linux specific,
please use some general error number, like shown bellow.

It would also be nice if you can inform upstream about this.

Thanks
	Petr

--- formats/ctf/ctf.c
+++ formats/ctf/ctf.c
@@ -1032,7 +1032,7 @@
        buflen = strlen(*buf);
        if (!buflen) {
                *fp = NULL;
-               return -ENODATA;
+               return -ENOENT;
        }
        *fp = babeltrace_fmemopen(*buf, buflen, "rb");
        if (!*fp) {

----- End forwarded message -----

-- 
Jon
