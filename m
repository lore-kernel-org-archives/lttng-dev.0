Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053AFCA1005
	for <lttng-dev@archiver.kernel.org>; Tue,  2 Sep 2025 21:34:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGfBm4p1cz1BhD
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1756848849;
	b=HT/KAlToZD/rsYCsHE28Nmjnj7xs4F8h9ngzRkiGevN6mnGedsH34ox4Cm8yuEmKxK9n
	 NUSQIy07PfpF7DT+ihLtQkOBLtyXdau9eh06MBNAlSNZkg6M/AiQPgGvteGPBLpTPZUW+
	 25uGSk5HeWqoDybyJLDGFB77mn+ea7KCN4msr8jenBH2C9UkIMTzl/SmmXvc2q5COJCB2
	 mKoEJcbgVZN42U/fN1GzwFOJnMqkOklKxYlxxTXcr/JY9FnlceyPIyDwMXflhWlw2s/DV
	 GLruxGpYo+taRhgT0FpQW6ufAQcZv7bNOUpIykhXchk6T6Esk2P80BnpNr1T2W4o26A==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1756848849;
	h=DKIM-Signature:Mime-Version:Subject:Date:Message-Id:To:From:From;
	bh=HVTesPcG/F+BpHlmTPVWJ/RXvS+AEdGLRjGmjUBugdI=;
	b=TBx07+ibujFCxjPl+8q++ei7dOc38mYCgIIUj1t5GeIlbBLrUspuXgGALRM7Hc59MQSk
	 JuDHfddz++stysBbl8/aLI9rv2vi7U+W18W9JvMIEs6GnWb7XzSE08MjZJiUBEWY26qwr
	 phcoOMAvYrmDtdy2oywsPMGGcNJ0TkwcDJgJCwqa/xLKX5Tn6YI4iOZxJv6dX8LpVGrlV
	 yXUNCz8IcIwLTDxDnK8DNMs03oiuj2TfAgGXL27LFLgaQnK2JmLRMqFkspsmvP2suWpTb
	 E7oyQNnz/bzyr0IzCApZCG7mjbo+kDklDB9aF8x2vTvUim9Qsab1K+B0EAKgLjutyaQ==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGfBm4p1cz1BhD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1756848849;
	bh=HVTesPcG/F+BpHlmTPVWJ/RXvS+AEdGLRjGmjUBugdI=;
	h=Subject:In-Reply-To:Date:Cc:References:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KwKp0I5Uiwljpyy/n8QQyOCdcf8qqVk5i+fpQ5WzDttaxOtz5h6xVQASGaNwpw2zn
	 SSJosY6gDj0l2RhxqPr553t33cZ/v1W9Ex+6HhIW8dLPzU/Q73dZYBb4yBmpbnpdst
	 oa7wyB/N2Cvnnxx3wyeXJ65gk3SCzGCQ0qILiyOk7Sxioi2fUITkCI7R1SvVyBF9ut
	 ru1OBb1K2v/mjVuIPd2AIEemhtu91B0pFdzGAxTxjrnYUXArsx0U70klkqARWW2Qce
	 3/OYTMYE2n/aVU/D1xtvqnyzNuZgoiYi0hay7oOlHM71MrY/2YXJDGX9ihK7uJioY2
	 L+nqMVRbJZFAA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cGfBm4p1cz1BhD;
	Tue,  2 Sep 2025 17:34:08 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGfBl2Bjjz1CTy
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGfBl2Bjjz1CTy
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by lists.lttng.org (Postfix) with ESMTPS id 4cGfBl2Bjjz1CTy
 for <lttng-dev@lists.lttng.org>; Tue,  2 Sep 2025 17:34:07 -0400 (EDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E435A1400114;
 Tue,  2 Sep 2025 17:34:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 02 Sep 2025 17:34:04 -0400
X-ME-Sender: <xms:zGK3aFPMOFS47DAh7cO-sw7tONXQ4arImjGMhMmbzMW3i3TStnTW5g>
 <xme:zGK3aIKHjm40edQHGxJle7QzvFCqiXuLbL16ILYbEQvRaRUq-fY_nt99OI6DJZxbO
 oAWIKt544aWc1ODYPw>
X-ME-Received: <xmr:zGK3aGHHIPBMkN3lTT5kBd1elbI2BCv-j2q5dgnoLF8uZ5j3Dj5d-cR4bumpESlTphTbkriNWMAFXe6eAfcTA4YAN4Z5xZt_sIP9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 eptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpefqnhgurhgvjhcu
 ufhurhpuuceoohhnughrvghjsehsuhhrhidrohhrgheqnecuggftrfgrthhtvghrnhepje
 dvtddvledufeetueevjeeuheeukeduudfhkeethfeitdefudffkeeffeevkeevnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohhnughrvghjse
 hsuhhrhidrohhrghdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
 tghpthhtohepthhhohgskhhnuhesghhmrghilhdrtghomhdprhgtphhtthhopehlthhtnh
 hgqdguvghvsehlihhsthhsrdhlthhtnhhgrdhorhhg
X-ME-Proxy: <xmx:zGK3aASISIbByyfokhxvqdfoYAvj5Mpg_6yyUnkKcYLA_M_eNdwxbQ>
 <xmx:zGK3aCFtXdCKtX27XSmsWw4rk7zBoavwiHYRxP6V6C_LRGtb33W3_Q>
 <xmx:zGK3aM_P07sHrXHo_ojBidkcDk6T4KvGoI7iMRW9DSGhPtnKHBsS4w>
 <xmx:zGK3aMJsiQzirSFZF29D6joT91K_pB4e_D4pzpMJfcuRqhbzShYSMA>
 <xmx:zGK3aGxCiLLeGRRBgmY7bVCvciJBacc6ipIiU2I2UyVZ_Ac37f45Eqs7>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 17:34:04 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: URCU feature request?
In-Reply-To: <CAKGpciq+ixOVGN7TXYaF336ZEL_mOejzic5BvaKbexwwn_aqOQ@mail.gmail.com>
Date: Tue, 2 Sep 2025 23:33:50 +0200
Cc: lttng-dev@lists.lttng.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD1A29BD-2AD2-4092-B1A2-DFEFAE77AAEE@sury.org>
References: <CAKGpciq6Cb6+hqsfn+_zPk+MqCg+b0M_Gc3jVxVvnEGcE8rdLw@mail.gmail.com>
 <CAKGpciqHpGqGJChLa8p4P4Xv7EyUPMxULHxeknOTyie8kHH6hg@mail.gmail.com>
 <3c49eadb-f310-46b2-984d-58a0c193cde9@efficios.com>
 <CAKGpcipt=fWJi9Y497C3vq03CXmPY6rXQqs8ZP9nDoTGdRKnAA@mail.gmail.com>
 <CAKGpcipfyp3Ds4J0OH96Mu4zVhCLJg8g6tqEnfcRscZ1T8EmVA@mail.gmail.com>
 <2f0dc1b4-3fcb-453c-aa42-4a1f85623300@paulmck-laptop>
 <CAKGpciq+ixOVGN7TXYaF336ZEL_mOejzic5BvaKbexwwn_aqOQ@mail.gmail.com>
To: Thobias Knudsen <thobknu@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
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

If I understand you correctly, you can do something like this:

#undef rcu_read_lock
#define rcu_read_lock() urcu_memb_read_lock(); {

#undef rcu_read_unlock
#define rcu_read_lock() } urcu_memb_read_unlock();

(replace memb with your RCU variant of course)

and make your code declare all the RCU protected pointers inside the RCU =
critical section, e.g.

rcu_read_lock();
my_pointer *foo =3D rcu_dereference(...);

use(foo); /* valid */

rcu_read_unlock();


use(foo); /* invalid and caught by the compiler */

Ondrej
--
Ond=C5=99ej Sur=C3=BD (He/Him)
ondrej@sury.org

> On 2. 9. 2025, at 23:06, Thobias Knudsen via lttng-dev =
<lttng-dev@lists.lttng.org> wrote:
>=20
> Yes, that is what I'm worried about. For my case when using URCU that =
is my biggest concern, as the debug macro "library" I made checks =
everything else, if I haven't overlooked anything.
>=20

