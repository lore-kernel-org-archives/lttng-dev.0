Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BF8C30653
	for <lttng-dev@archiver.kernel.org>; Thu,  4 Jul 2024 17:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1720114871;
	bh=D0SNLBq+kY/M5jYr1quCQG+6FBkBasXUikNirW2q3RU=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=0eus0QzOi2UApdJ+hdkffHZ0zj3AnjyoV3arikbZJ23LI8JdbUsJGNsKrJmiaPKnF
	 NXZ3JSvI+BMRCmBOX4fGNBgoXBRoVqzFSPACywCkY/pwLNL3fJO5wY+zQ2rMbt3eLg
	 Me8dbdqyNKpna5AgJ79SBCyaFFhmh+JA1GeGGVzN/KFbwMkuHc+1PZPWGfMsMNuoXO
	 pjA9HXVKs/s0wxu1kfLKZW7qtnu15Was9Wx47I0miaToBde4LXxk8ZXjyKomPE2I35
	 HhtgWIwLetnixKZBAr4z43/tvdTaeYEP4khydQRi/UxwLJLxHW2zLVcyf/My/Vv1qa
	 ULSKpikM8uhGQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WFP864frwz8gN;
	Thu,  4 Jul 2024 13:41:10 -0400 (EDT)
Received: from fhigh6-smtp.messagingengine.com
 (fhigh6-smtp.messagingengine.com [103.168.172.157])
 by lists.lttng.org (Postfix) with ESMTPS id 4WFP856Cb9z8gM
 for <lttng-dev@lists.lttng.org>; Thu,  4 Jul 2024 13:41:09 -0400 (EDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 1DA57114025E
 for <lttng-dev@lists.lttng.org>; Thu,  4 Jul 2024 13:33:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 04 Jul 2024 13:33:16 -0400
X-ME-Sender: <xms:29yGZiQcbfj3_E5FEZKFsbPGJFJ4u6BBUVoIvq1Gk15Sh0TTiuH5ng>
 <xme:29yGZnxv4z7rLA0fxTbOkfPT7EYoXDr_nJRbpoGR_ErWyapcpJvLY1OxhHGZXvs22
 KXcUdU8p5X5AmznNxU>
X-ME-Received: <xmr:29yGZv03sGKugwBDMmiDcDekRRQB6Z0FLD_Fz_Wo7CcnukoVs_a3sS-vLygTBUGxX5h1rGo_bfNR79aXfm3LVsGrwEC0tTaKgVL1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelgdduuddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhtggguffkfffvofesmhdtmherhh
 dtvdenucfhrhhomhepqfhnughrvghjucfuuhhrupcuoehonhgurhgvjhesshhurhihrdho
 rhhgqeenucggtffrrghtthgvrhhnpeeivdekvdffleejhfelfeekueegteevfeehleejke
 ejfefhvefgfeetieejkeeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
 mhgrihhlfhhrohhmpehonhgurhgvjhesshhurhihrdhorhhg
X-ME-Proxy: <xmx:29yGZuCQdJ_F7CpFmBWoOKOaivb2jVa5WinGIM_jKKeTYaKIfYO2XQ>
 <xmx:29yGZrizjqnNhAde-W3460D3jzpOGpZz7B2aC4mZ1CnntOrV6jhKlw>
 <xmx:29yGZqpxwCUoEjbjKVr2PBC54cLrHxc5FiS6xYH6kbGKNuLZFDSExg>
 <xmx:29yGZuiyZKBEkVmT13aBvoyzDcKL0RkIngqZ8zsTxpCn1PoNNWKCPA>
 <xmx:3NyGZjbYuB9x4j8t9wquScFdl3EeoOc74f23_ZgybwlnGM3lY_txMbdp>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <lttng-dev@lists.lttng.org>; Thu, 4 Jul 2024 13:33:15 -0400 (EDT)
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_84EA9637-C10B-4DEE-B130-B94602B593A2"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Message-Id: <1944AC84-89A1-4C32-807C-335461C796C1@sury.org>
Date: Thu, 4 Jul 2024 19:33:00 +0200
To: lttng-dev <lttng-dev@lists.lttng.org>
X-Mailer: Apple Mail (2.3774.600.62)
Subject: [lttng-dev] rcu_cmpxchg_pointer() documentation patch
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
From: =?utf-8?q?Ond=C5=99ej_Sur=C3=BD_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


--Apple-Mail=_84EA9637-C10B-4DEE-B130-B94602B593A2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

looks like my git-send-email configuration is not correct and my =
mailserver ate the patch,
so here's one created by git-format-patch...

Nothing important, but it bite me today...


--Apple-Mail=_84EA9637-C10B-4DEE-B130-B94602B593A2
Content-Disposition: attachment;
	filename=0001-pointer.h-Fix-the-rcu_cmpxchg_pointer-documentation.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-pointer.h-Fix-the-rcu_cmpxchg_pointer-documentation.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20062021e4540888a2095966393c48c55b7ddd441f=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20=3D?UTF-8?q?Ond=3DC5=3D99ej=3D20Sur=3DC3=3DBD?=3D=
=20<ondrej@sury.org>=0ADate:=20Thu,=204=20Jul=202024=2010:29:10=20+0200=0A=
Subject:=20[PATCH]=20pointer.h:=20Fix=20the=20rcu_cmpxchg_pointer=20=
documentation=0AMIME-Version:=201.0=0AContent-Type:=20text/plain;=20=
charset=3DUTF-8=0AContent-Transfer-Encoding:=208bit=0A=0AFix=20the=20=
description=20of=20rcu_cmpxchg_pointer()=20function=20that=20had=20=
switched=0Anew=20and=20old=20pointers.=0A=0ASigned-off-by:=20Ond=C5=99ej=20=
Sur=C3=BD=20<ondrej@sury.org>=0A---=0A=20include/urcu/pointer.h=20|=202=20=
+-=0A=201=20file=20changed,=201=20insertion(+),=201=20deletion(-)=0A=0A=
diff=20--git=20a/include/urcu/pointer.h=20b/include/urcu/pointer.h=0A=
index=20cc9aeae..7a673d6=20100644=0A---=20a/include/urcu/pointer.h=0A+++=20=
b/include/urcu/pointer.h=0A@@=20-33,7=20+33,7=20@@=20extern=20"C"=20{=0A=20=
#define=20rcu_dereference=09=09_rcu_dereference=0A=20=0A=20/*=0A-=20*=20=
type=20*rcu_cmpxchg_pointer(type=20**ptr,=20type=20*new,=20type=20*old)=0A=
+=20*=20type=20*rcu_cmpxchg_pointer(type=20**ptr,=20type=20*old,=20type=20=
*new)=0A=20=20*=20type=20*rcu_xchg_pointer(type=20**ptr,=20type=20*new)=0A=
=20=20*=20void=20rcu_set_pointer(type=20**ptr,=20type=20*new)=0A=20=20*=0A=
--=20=0A2.39.2=0A=0A=

--Apple-Mail=_84EA9637-C10B-4DEE-B130-B94602B593A2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



Ondrej
--
Ond=C5=99ej Sur=C3=BD (He/Him)
ondrej@sury.org


--Apple-Mail=_84EA9637-C10B-4DEE-B130-B94602B593A2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--Apple-Mail=_84EA9637-C10B-4DEE-B130-B94602B593A2--
