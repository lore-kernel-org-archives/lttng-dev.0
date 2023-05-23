Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC11C7EE26
	for <lttng-dev@archiver.kernel.org>; Tue, 23 May 2023 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684857923;
	bh=hhOb8f7H1tPn5OXc1e8IwrN+HHQfEX0uvBMQsaJvfyQ=;
	h=To:In-Reply-To:References:Date:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=byI7bAMrvZvIKhhGoshuF9BIH9XEPF+/wcBvUO/W/AQbYob8r2wqzMATzbYTkrId/
	 GI4CmaNY7FF7dgZEkjBIRZEUvGHwYSVcBapS2lA/mI4NwuOtoSFJviydXad1r/Cx1v
	 GRJWjDmpSVGg5snaQ4vP4WqZeyNzlOyli4tqO1Ew9CUKvrvQGDaS/Lt+p7TEMx3FLu
	 dV6RrhzO+EzAAbalo4GPxIIJ+Mzn2909a4eRPwtm9Kh/N10AnUXv3yOoPu8safCyrQ
	 0Bgf9h/xx2WYR2UFB0XMJkw+r1VCnb1gK2IHMFSN8sQQW/z2OwKYl0uijB30sZgGzU
	 84VMNh/ZUlEZA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QQfKt3N7Qz1HX4;
	Tue, 23 May 2023 12:05:22 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QQfKr5RYvz1HLV
 for <lttng-dev@lists.lttng.org>; Tue, 23 May 2023 12:05:20 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QQfKb5x72z13WX;
 Tue, 23 May 2023 12:05:07 -0400 (EDT)
To: Dmitry Vyukov <dvyukov@google.com>
In-Reply-To: <87ttwbj9uz.fsf@laura>
Organization: EfficiOS
References: <20230515201718.9809-1-odion@efficios.com>
 <CACT4Y+b-THcfzGiXxu8Wc79GwiMsQREPnykffj52+sDLcDqHvw@mail.gmail.com>
 <874jocl1lf.fsf@laura>
 <CACT4Y+YFNRKTgA=s8+ntiwEsRVq9WAR2pBF3toyiGe08mUQ4Gg@mail.gmail.com>
 <CACT4Y+Z8c30QQ3KFTaMq1Zgm-5fFCXEpNN3Kc9KWC+xzRkTzRQ@mail.gmail.com>
 <87ttwbj9uz.fsf@laura>
Date: Tue, 23 May 2023 12:05:07 -0400
Message-ID: <87v8gj11ak.fsf@laura>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Subject: Re: [lttng-dev] [PATCH 00/11] Add support for TSAN to liburcu
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@kernel.org>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--=-=-=
Content-Type: text/plain

Hi Dmitry,

We do have a new issue and we think it might be a limitation from TSAN.

Find attached a test program that we believe is correct.  You can
compile it with `gcc -fsanitize=thread test.c -pthread'.


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=test.c
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CgojaW5jbHVkZSA8cHRocmVh
ZC5oPgoKI2RlZmluZSBMT09QIDEwMDAKCnN0cnVjdCBub2RlIHsKCXN0cnVjdCBub2RlICpuZXh0
Owp9OwoKc3RhdGljIHB0aHJlYWRfYmFycmllcl90IGJhcnJpZXI7CnN0YXRpYyBzdHJ1Y3Qgbm9k
ZSB0aGVfdGVybWluYWxfbm9kZSA9IHsgLm5leHQgPSAmdGhlX3Rlcm1pbmFsX25vZGUgfTsKc3Rh
dGljIHN0cnVjdCBub2RlIHBlbmRpbmdfc3RhY2sgPSB7ICZ0aGVfdGVybWluYWxfbm9kZSB9OwoK
ZXh0ZXJuIHZvaWQgX190c2FuX2FjcXVpcmUodm9pZCopOwpleHRlcm4gdm9pZCBfX3RzYW5fcmVs
ZWFzZSh2b2lkKik7CgpleHRlcm4gdm9pZCBfX3RzYW5faWdub3JlX3RocmVhZF9iZWdpbigpOwpl
eHRlcm4gdm9pZCBfX3RzYW5faWdub3JlX3RocmVhZF9lbmQoKTsKCnN0YXRpYyB2b2lkICpwdXNo
X3dvcmtlcih2b2lkICpuaWwpCnsKCSh2b2lkKSBuaWw7CgoJcHRocmVhZF9iYXJyaWVyX3dhaXQo
JmJhcnJpZXIpOwoKCWZvciAoc2l6ZV90IGs9MDsgazxMT09QOyArK2spewoJCXN0cnVjdCBub2Rl
ICpuZXdfbm9kZSwgKm9sZF9ub2RlOwoKCQluZXdfbm9kZSA9IGNhbGxvYygxLCBzaXplb2Yoc3Ry
dWN0IG5vZGUpKTsKCQlvbGRfbm9kZSA9IF9fYXRvbWljX2V4Y2hhbmdlX24oJnBlbmRpbmdfc3Rh
Y2submV4dCwKCQkJCQkgICAgICAgbmV3X25vZGUsCgkJCQkJICAgICAgIF9fQVRPTUlDX1NFUV9D
U1QpOwoJCS8qIFdvcmtzIGlmIFJFTEVBU0UuICovCgkJX19hdG9taWNfc3RvcmVfbigmbmV3X25v
ZGUtPm5leHQsIG9sZF9ub2RlLCBfX0FUT01JQ19SRUxBWEVEKTsKCgkJLyogQWxzbyB3b3JrcyBp
ZjogKi8KI2lmIDAKCQlfX3RzYW5faWdub3JlX3RocmVhZF9iZWdpbigpOwoJCV9fYXRvbWljX3N0
b3JlX24oJm5ld19ub2RlLT5uZXh0LCBvbGRfbm9kZSwgX19BVE9NSUNfUkVMQVhFRCk7CgkJX190
c2FuX2lnbm9yZV90aHJlYWRfZW5kKCk7CiNlbmRpZgoJCS8qIFdoeSBpcyB0aGlzIG5vdCB3b3Jr
aW5nPyAqLwojaWYgMAoJCV9fdHNhbl9yZWxlYXNlKCZuZXdfbm9kZS0+bmV4dCk7CgkJX19hdG9t
aWNfc3RvcmVfbigmbmV3X25vZGUtPm5leHQsIG9sZF9ub2RlLCBfX0FUT01JQ19SRUxBWEVEKTsK
I2VuZGlmCgoJfQoKCXJldHVybiBOVUxMOwp9CgpzdGF0aWMgdm9pZCAqcG9wX3dvcmtlcih2b2lk
ICpuaWwpCnsKCSh2b2lkKSBuaWw7CgoJc2l6ZV90IGsgPSAwOwoKCXB0aHJlYWRfYmFycmllcl93
YWl0KCZiYXJyaWVyKTsKCgl3aGlsZSAoayA8IExPT1ApIHsKCQlzdHJ1Y3Qgbm9kZSAqY3VycmVu
dF9zdGFjazsKCQlzdHJ1Y3Qgbm9kZSAqbmV4dF9ub2RlOwoKCQljdXJyZW50X3N0YWNrID0gX19h
dG9taWNfZXhjaGFuZ2VfbigmcGVuZGluZ19zdGFjay5uZXh0LAoJCQkJCQkgICAgJnRoZV90ZXJt
aW5hbF9ub2RlLAoJCQkJCQkgICAgX19BVE9NSUNfU0VRX0NTVCk7CgoJCXdoaWxlIChjdXJyZW50
X3N0YWNrICE9ICZ0aGVfdGVybWluYWxfbm9kZSkgewoKCQlyZXRyeV9sb2FkOgoJCQluZXh0X25v
ZGUgPSBfX2F0b21pY19sb2FkX24oJmN1cnJlbnRfc3RhY2stPm5leHQsCgkJCQkJCSAgICBfX0FU
T01JQ19DT05TVU1FKTsKCgkJCWlmICghbmV4dF9ub2RlKSB7CgkJCQlnb3RvIHJldHJ5X2xvYWQ7
CgkJCX0KCgkJCWZyZWUoY3VycmVudF9zdGFjayk7CgkJCWN1cnJlbnRfc3RhY2sgPSBuZXh0X25v
ZGU7CgkJCSsrazsKCQl9Cgl9CgoJcmV0dXJuIE5VTEw7Cn0KCmludCBtYWluKHZvaWQpCnsKCXB0
aHJlYWRfdCB0aHNbMl07CgoJcHRocmVhZF9iYXJyaWVyX2luaXQoJmJhcnJpZXIsIE5VTEwsIDMp
OwoKCXB0aHJlYWRfY3JlYXRlKCZ0aHNbMF0sIE5VTEwsIHB1c2hfd29ya2VyLCBOVUxMKTsKCXB0
aHJlYWRfY3JlYXRlKCZ0aHNbMV0sIE5VTEwsIHBvcF93b3JrZXIsIE5VTEwpOwoKCXB0aHJlYWRf
YmFycmllcl93YWl0KCZiYXJyaWVyKTsKCglwdGhyZWFkX2pvaW4odGhzWzBdLCBOVUxMKTsKCXB0
aHJlYWRfam9pbih0aHNbMV0sIE5VTEwpOwoKCXJldHVybiAwOwp9Cg==
--=-=-=
Content-Type: text/plain


TSAN flags a race condition between the atomic store relaxed at line 36
and the free at line 81.

We can solve the issue by replacing the atomic store relaxed with a
atomic store release.  However, the preceding atomic exchange with
sequential consistency already acts as an implicit release (in term of
memory barrier) for the following store, making the release semantic
redundant.

We've found an alternative to fix this by ignoring the thread during the
relaxed store (line 39).  However, what we would like is to annotate the
memory stored (line 45).

My theory (I don't know the internal of TSAN much) is that TSAN thinks
for some reason that the atomic store relaxed happen at the same epoch
as the free, resulting in a false positive.  If so, m

Thought?

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=-=-=--
