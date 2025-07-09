Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7D8C83F0A
	for <lttng-dev@archiver.kernel.org>; Wed,  9 Jul 2025 18:57:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bcnKn5KyRz2R6p
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1752087471;
	b=Fp1AS3GH0PM4qK1v0wqDlQ/X36x+TisPRAwn+kzXyZ09hOETVpm0kWKUJkX72IUAZpY5
	 Ms9ohqoqXs1gj3N7dhj2WYm1DczYusqJ6PfirvPxA4CF7CaL2krsLO83gosxIzbzu8Ma/
	 6vuj4g932uDAarrs3gxXiCruUGiIFaO429vXJ1hP5957z/oPn6aEhOqKVAwYIdwLFT/VQ
	 oJw+Zcby66zCmwFvidF4QIVAwFe4+mgSEUzL8Ue6QUASjJxpU42Ie9rtH6FGgMl8OhS12
	 iy46n3AdOqJYKTgN9OknXM4Pydh8qqYXnljH0H1R/8NjSXxzfdN38SnBglAP/PvkC7A==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1752087471;
	h=DKIM-Signature:Mime-Version:Subject:Message-Id:Date:To:From:From;
	bh=6ipdHbiYIDOWBfevQFo99DAjrA2xMLjgX5dCITSVejk=;
	b=elBI0MX54wpOawy0jMkn+m1GjZhS543ZTxFbl6L1+rhv8F4awLN1G2QOEj0pmjofWyEI
	 +aebKGguR9llL2hG4YbEjrsO66ZRkCcGHVjU+6tN7nrona5Ah2MB8m4Iwj9BcYuwRW+iz
	 NhNsA+pQPvbJvvcdxAHh2q1t8pPutF3AEymyBHs7+UgECXK6Fc7p6yXV1MTLRq/h7YFrP
	 xjJAHfpKNwS4vutFC61X1IHmCBO8oBqu5cPGd55Zqaq9RA7RF/jyjURMI0JmkFfM3VxFK
	 8FI9aO9lcDnEUwFvZJGQJ+DXjPbeSnHLHw/H3cnNNitNilN5CwBNhXHmIqCtB8cLwPA==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bcnKn5KyRz2R6p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1752087471;
	bh=6ipdHbiYIDOWBfevQFo99DAjrA2xMLjgX5dCITSVejk=;
	h=Subject:Date:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=RaoD47Ro10a8PnP3odPy0IWMu3quA74B9V+Ji6d2DrTdbHlrbIY6FE2Jzlr8S2ZN/
	 mi6jQ4j3xoKVpPr+delip7bHQT+JY9oKbe4wypWjAoObKCjMTvp3+c9qt6Bdeuplf4
	 dq4K22eYl65zCl7BoBOoYtnpHMZ6mvQTPYJgFN063pLwcNqN8LO7hwJKO7S9Ei5d6+
	 5dAf5Otyo10kLTl/30kJ9905qK/7qbJG3ma/7d+55B5y3aVJNI52ADqC5g4QO6iWrv
	 E47HurBZ9NoQcAIBqkYoY/fr1Q0xGJ8gK3cIArdfL369HVBZ3+XROFcVG6Bxb0dNYJ
	 szV7KgolP5fow==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bcnKn5KyRz2R6p;
	Wed,  9 Jul 2025 14:57:49 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bcnKk5XnSz2Qy7
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bcnKk5XnSz2Qy7
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by lists.lttng.org (Postfix) with ESMTPS id 4bcnKk5XnSz2Qy7
 for <lttng-dev@lists.lttng.org>; Wed,  9 Jul 2025 14:57:46 -0400 (EDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A1D8314003C2
 for <lttng-dev@lists.lttng.org>; Wed,  9 Jul 2025 14:57:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 14:57:44 -0400
X-ME-Sender: <xms:qLtuaIyILhl-iJaixoimDPhTNq-HM84jmIxUWoxUbPE5gAkid6bxpQ>
 <xme:qLtuaORWsEydh2r1D6YmlaeDeWniqexsotRinNckw2n2U_PNq69lZH_hDttaAERzA
 otzgYQIC8PiZoVY1kc>
X-ME-Received: <xmr:qLtuaDtYy0_Lqz9xy0wD7konZx2gg8QhZ4y5OxUQPYCibWALJhyxCD-BYuvCxXiRSO2RjYTGXha8PI4aggIcD3ghtBOjwOhla0s0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkeefgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephfgtgfgguffkfffvofesthhqmhdthhdtje
 enucfhrhhomhepqfhnughrvghjucfuuhhrupcuoehonhgurhgvjhesshhurhihrdhorhhg
 qeenucggtffrrghtthgvrhhnpeekieekgffhhedvteelfeefleeiiefhtdfhtdeuleffff
 dtveeujeetuedvkeevjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
 ihhlfhhrohhmpehonhgurhgvjhesshhurhihrdhorhhgpdhnsggprhgtphhtthhopedupd
 hmohguvgepshhmthhpohhuthdprhgtphhtthhopehlthhtnhhgqdguvghvsehlihhsthhs
 rdhlthhtnhhgrdhorhhg
X-ME-Proxy: <xmx:qLtuaIuIYszoq21ZmPiV6gUBf60ONonIUjAVnV_IMZmSl20AyWHzFw>
 <xmx:qLtuaBzyb7gHSX6q4cit5xWNZZBMd5tu0saDtVRReM9T-lPfjX7yFw>
 <xmx:qLtuaGhH_qNPphwWYzALQx1gC2Ap_ijLUhAu6ugxydJnNztaDfiJOA>
 <xmx:qLtuaNB23yNsUNTUeDCduRnnSw23VOz5XlQK3lcPbB3gcXTAbZTcrw>
 <xmx:qLtuaAlaUbfk4TGouF6tOrQPS4qzmObjPbGMU6NE4Xg64AYKLihNDsIk>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <lttng-dev@lists.lttng.org>; Wed, 9 Jul 2025 14:57:44 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: cds_lfht_new() clarification - init vs min
Message-Id: <0178CA60-19CE-4E0A-AEEB-5E9DEAAB460E@sury.org>
Date: Wed, 9 Jul 2025 20:57:31 +0200
To: lttng-dev <lttng-dev@lists.lttng.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
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

Hi,

as the answer to this might be useful to more people, I am asking here:

The cds_lfht_new documentation specifies 3 sizes.

 * cds_lfht_new - allocate a hash table.
 * @init_size: number of buckets to allocate initially. Must be power of =
two.
 * @min_nr_alloc_buckets: the minimum number of allocated buckets.
 *                        (must be power of two)
 * @max_nr_buckets: the maximum number of hash table buckets allowed.
 *                  (must be power of two, 0 is accepted, means
 *                  "infinite")

The max number of buckets is obvious, but the interaction between init
and min is confusing.

If I am reading the code right, then init_size < min_nr_alloc_buckets =
have no
effect, the buckets table will be at least 1 << min_nr_alloc_buckets.

But what happens if init_size > min_nr_alloc_buckets? It feels like it =
will work
as expected if you pre-populate the table, but if you use it "normally", =
e.g. there
could be single add / del, the table will shrink immediately.

Do I understand the code correctly?

Ondrej
--
Ond=C5=99ej Sur=C3=BD (He/Him)
ondrej@sury.org

