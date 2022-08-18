Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8920C00140
	for <lttng-dev@archiver.kernel.org>; Thu, 18 Aug 2022 19:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660852595;
	bh=yTZnsj6ospii6VYjIyI0LFM/X8McK8AGMiw/mEbgIrE=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=aIqbJ/8++kPjkOOQNLnkn1tJ5Cy84JR4DH+BzwCiQ/NbZ95z2c8o281stDRXPXRf/
	 YmI8572OQfhS+ZOBBmL76kqs+SKyPau9GdWuQzIO1HnolVDbzCD2z2CXU5CjraCCH3
	 9eMduGdAtr4itgHwCKOC1lU8UWKQqHe0VvFiW6CQlRO7epzoMdARNk1DyowKZ9//Ki
	 6vUh/M5+j5UJ3uSbUXhICYm0HYbW67o+nawSyrwNDEgEDPANqvmpp/GV9HYINwtBvt
	 DySqp65vp264YF74zesJIkh/BsaVDkQs+3Zm1qe79a/dhBJ6bQMd4EEvFPLuwz0LPc
	 UysSWYlZOT3VQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M7wcy6Xpgz1J67;
	Thu, 18 Aug 2022 15:56:34 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4M7wcx2Djqz1JnV
 for <lttng-dev@lists.lttng.org>; Thu, 18 Aug 2022 15:56:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E15E33972A3
 for <lttng-dev@lists.lttng.org>; Thu, 18 Aug 2022 15:56:32 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id L4ntQNqvmZyB; Thu, 18 Aug 2022 15:56:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 87FDB397487;
 Thu, 18 Aug 2022 15:56:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 87FDB397487
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id cs9c_tcoBo_Z; Thu, 18 Aug 2022 15:56:32 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 74A8C397043;
 Thu, 18 Aug 2022 15:56:32 -0400 (EDT)
Date: Thu, 18 Aug 2022 15:56:32 -0400 (EDT)
To: linux-kernel <linux-kernel@vger.kernel.org>, 
 lttng-dev <lttng-dev@lists.lttng.org>, rp <rp@svcs.cs.pdx.edu>
Cc: paulmck <paulmck@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, lwn <lwn@lwn.net>
Message-ID: <927024516.15730.1660852592448.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - FF103
 (Linux)/8.8.15_GA_4372)
Thread-Index: F7oOQWdMenIxdDZOhR4ztlxSiCsK7A==
Thread-Topic: Userspace RCU 0.12.4 and 0.13.2
Subject: [lttng-dev] [RELEASE] Userspace RCU 0.12.4 and 0.13.2
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
Content-Type: multipart/mixed; boundary="===============9135593134609468304=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============9135593134609468304==
Content-Type: multipart/alternative; 
	boundary="=_607ce2e3-f2e9-41a9-914c-fcad0be8df17"

--=_607ce2e3-f2e9-41a9-914c-fcad0be8df17
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 

This is stable release announcement for the Userspace RCU project. 
It covers the two currently maintained stable branches: 0.12 and 0.13, 
respectively with releases v0.12.4 and v0.13.2. 

Especially for the spurious futex wakeup fix, users of the 0.12 and 0.13 (or older) 
liburcu branches are recommended to upgrade. 

* Noteworthy in these releases: 

- Handle spurious futex wakeups in urcu-qsbr, urcu, urcu-wait, defer_rcu, call_rcu, 
and workqueue code. This has been known to cause issues where the workqueue 
worker thread spuriously takes nearly 100% of CPU time. 

- Change method used by _rcu_dereference ot strip type constness. 
Rather than using pointer arithmetic (which does not work with opaque types), 
rely on a statement expression trick. 

- Fix support for Linux systems where sysconf(_SC_NPROCESSORS_CONF) can 
return a value less than max cpu id. 

Project website: https://liburcu.org 

Feedback is welcome! 

Thanks, 

Mathieu 

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_607ce2e3-f2e9-41a9-914c-fcad0be8df17
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi,</div><div><br data-mce-bogus=3D"1"></di=
v><div>This is stable release announcement for the Userspace RCU project.<b=
r></div><div>It covers the two currently maintained stable branches: 0.12 a=
nd 0.13,</div><div>respectively with releases v0.12.4 and v0.13.2.<br data-=
mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Especially f=
or the spurious futex wakeup fix, users of the 0.12 and 0.13 (or older)</di=
v><div>liburcu branches are recommended to upgrade.<br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><div>* Noteworthy in these relea=
ses:<br></div><div><br data-mce-bogus=3D"1"></div><div><div>- Handle spurio=
us futex wakeups in urcu-qsbr, urcu, urcu-wait, defer_rcu, call_rcu,</div><=
div>&nbsp; and workqueue code. This has been known to cause issues where th=
e workqueue</div><div>&nbsp; worker thread spuriously takes nearly 100% of =
CPU time.<br></div><div><br data-mce-bogus=3D"1"></div></div><div>- Change =
method used by _rcu_dereference ot strip type constness.</div><div>&nbsp; R=
ather than using pointer arithmetic (which does not work with opaque types)=
,<br data-mce-bogus=3D"1"></div><div>&nbsp; rely on a statement expression =
trick.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><d=
iv>- Fix support for Linux systems where sysconf(_SC_NPROCESSORS_CONF) can<=
br data-mce-bogus=3D"1"></div><div>&nbsp; return a value less than max cpu =
id.<br data-mce-bogus=3D"1"></div><div><br>Project website: https://liburcu=
.org<br><br></div><div>Feedback is welcome!<br data-mce-bogus=3D"1"></div><=
div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></d=
iv><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><div data-marker=3D"__SIG_POST__=
">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effici=
os.com</div></div></body></html>
--=_607ce2e3-f2e9-41a9-914c-fcad0be8df17--

--===============9135593134609468304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============9135593134609468304==--
