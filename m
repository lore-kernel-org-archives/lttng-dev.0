Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39C3C433EF
	for <lttng-dev@archiver.kernel.org>; Tue, 29 Mar 2022 03:40:06 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KSFgm6vbWzNqm;
	Mon, 28 Mar 2022 23:40:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1648525205;
	bh=+9MdC0k1U5d+pcaiisUcPSQBR2kw79O561P91d0Bybo=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=w5xi0u2ypbspEHlj2b7ATg2S1Kw9iwMf1v7/M4vxrxznJoSPnPugvz95J4mGoLFTN
	 L45bRyAIXF+BE3Kac5uvebKVspi+HCGNBb6uznRMhTd6umPF5HfAQZE0wB+0DXCzvs
	 H/AsxFhqTiDe/k8BFK0qJEL27zdWzYzPSVNaj2whiaaBQLgbUi2FfAFLtK2wySC+ND
	 OcA1fApsGxyabzg6Txcmcx+oO/NWLdEgsf6vRqzLdyqg82prQ1wkW0Y0xKIicXFff+
	 LmZ9HJt85xijNYV9hlFHqellabqZ4NKasGUDVXiq7ZUX2FbBE38cf6K539nVyIK3RP
	 qSxy5pR+7308A==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KSFgl5CLyzNmF
 for <lttng-dev@lists.lttng.org>; Mon, 28 Mar 2022 23:40:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 989623FE8D0
 for <lttng-dev@lists.lttng.org>; Mon, 28 Mar 2022 23:39:57 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id s27XZqfeM8iZ; Mon, 28 Mar 2022 23:39:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3B6973FE1E0;
 Mon, 28 Mar 2022 23:39:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3B6973FE1E0
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id P1ODItY8KeRm; Mon, 28 Mar 2022 23:39:57 -0400 (EDT)
Received: from carbonara (unknown [107.159.88.171])
 by mail.efficios.com (Postfix) with ESMTPSA id 1CFB33FE1DD;
 Mon, 28 Mar 2022 23:39:57 -0400 (EDT)
Date: Mon, 28 Mar 2022 23:39:56 -0400
To: lttng-dev@lists.lttng.org
Cc: linux-trace-users <linux-trace-users@vger.kernel.org>,
 diamon-discuss <diamon-discuss@lists.linuxfoundation.org>
Message-ID: <YkJ/jERUzoilTmf6@carbonara>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] =?iso-8859-1?q?=5BRELEASE=5D_LTTng-tools_2=2E13=2E6_?=
 =?iso-8859-1?q?-_Nordicit=E9?=
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released the sixth bug-fix release of LTTng-tools 2.13 - Nordi=
cit=E9.
This release addresses a number of issues listed below.

2022-03-28 lttng-tools 2.13.6 (National Hot Tub Day)
	* Fix: hide symbols erroneously exported in 2.13.5

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.6.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.6.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
