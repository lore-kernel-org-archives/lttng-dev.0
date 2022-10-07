Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E25EC433FE
	for <lttng-dev@archiver.kernel.org>; Fri,  7 Oct 2022 06:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1665124007;
	bh=iaKd8y4ee+TZ0IquP5AeVyHb8RKpC+N1IqkDMdIPJVY=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=vpT7ESwyfG+9NV8EGQF/+O4+Hd1igSDPHtBC/22w05q4hhTMyDLnLW38pXbXp8Ywq
	 MuXzycy5PSdo5pYkQ8YgHmTxR+dR8AdCB/VFI7v+Pt7+hwh9pGEUWm9wz/JpyhxmcE
	 gap4AvRIjCrtAKK0AoJS0n3DETFo2SxFRj2cnRH95coXkV0TM3jyrP3M187kjzkLfp
	 X//TG7bBeKUitOsJYEc5+MLxXt1iXmQsF+PpHt9HBuoKj30Xp7l6rtlVpl9QxxbYuE
	 qDoeVc1sj2ROdsSIt9CYoz1f2+5Tx6DEl3PhhUK4AqACOPU1fKvVWZAyxNTeiwCVQV
	 N4GoIF4kX02Hg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MkJHW0pYHz29Np;
	Fri,  7 Oct 2022 02:26:47 -0400 (EDT)
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
 by lists.lttng.org (Postfix) with ESMTPS id 4Mk8c330xYz29C1
 for <lttng-dev@lists.lttng.org>; Thu,  6 Oct 2022 20:40:35 -0400 (EDT)
X-IronPort-AV: E=Sophos;i="5.95,164,1661788800"; d="scan'208";a="211532199"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2022 08:39:25 +0800
IronPort-SDR: uaxOi3R449b8yvtO259zkgs7b1eBApY5WvB2BMwelg1GFvkhsJYF52wUo64HMcqcoe5TOpNzTo
 /9dygZJaDJVArSmXvqaNqOlOl5acwoEI1lDEn2AvkY7qradwwWMXBizvzDLYNh72kvBNkWLq3z
 n3DlbyBlYs2TL/Frex32hgi3kURy2PZam4Y/UYT59J06asFntzxGVCMpHlJLRPUbXdX59f43k9
 ND0DcaCdEuTRBVqWcoJJZP8wSYjzr6LqZtoA5VOSqIzCu/V4Zlt84/X7yV3KxlwTpOdAQ6R0NC
 duOS/vDfV2mMkyL/TEoUzr3a
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Oct 2022 16:59:10 -0700
IronPort-SDR: j6OLOosYhQzL24Q3Db0VwtAhPc6mhD0HVnPUd1WSa1MImNT5920mEe13Qbhdz8X8LX8xCsspAH
 P3P/DUh54MJiMRaV5YDAdqNc6Wxkwgw7sEv/13MJTJzAmn0YKvKOG8iZgiWJw0mLSExLmLKueu
 x4ANn6HZru7GVEF5laxkw/uubiwR3JJ8OmrKY+M2ysjpVbHCjdkd0emXC2kgfz1JajzvMBZ1uF
 zeS0krkciq5uqPCdERI/n4mubfpUdAKrn5dIUWi9DRd3Zz62tx0srYoymTvFSX7t3I1gc9VlKe
 IwI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Oct 2022 17:39:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mk8Zh6bLpz1RwqL
 for <lttng-dev@lists.lttng.org>; Thu,  6 Oct 2022 17:39:24 -0700 (PDT)
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id TZAWKfu_fcin for <lttng-dev@lists.lttng.org>;
 Thu,  6 Oct 2022 17:39:24 -0700 (PDT)
Received: from toolbox.wdc.com (unknown [10.225.167.15])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mk8Zf6ZNRz1RvLy;
 Thu,  6 Oct 2022 17:39:22 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Fri,  7 Oct 2022 10:39:17 +1000
Message-Id: <20221007003918.344922-1-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 07 Oct 2022 02:26:46 -0400
Subject: [lttng-dev] [PATCH lttng-tools 1/2] README: Update the Userspace
 RCU requirements
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
From: Alistair Francis via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Alistair Francis <alistair.francis@opensource.wdc.com>
Cc: alistair23@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

RnJvbTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQ29tbWl0
IGNjMjJkZTk4NWZiZCAiQnVtcCBVUkNVIGRlcGVuZGVuY3kgdG8gMC4xNCIgaW5jcmVhc2UgdGhl
ClVzZXJzcGFjZSBSQ1UgcmVxdWlyZW1lbnRzIGJ1dCBkaWRuJ3QgdXBkYXRlIHRoZSBSRUFETUUu
IExldCdzIGVuc3VyZQp0aGUgUkVBRE1FIGhhcyB0aGUgY29ycmVjdCBpbmZvcm1hdGlvbi4KClNp
Z25lZC1vZmYtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4K
LS0tCiBSRUFETUUuYWRvYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL1JFQURNRS5hZG9jIGIvUkVBRE1FLmFkb2MKaW5k
ZXggODMwZGQ5MzNlLi4xOTFiMGUwYTIgMTAwNjQ0Ci0tLSBhL1JFQURNRS5hZG9jCisrKyBiL1JF
QURNRS5hZG9jCkBAIC01NCw3ICs1NCw3IEBAIGNvbXBvbmVudHM6CiAKICogKipMaW51eCBrZXJu
ZWx7bmJzcH3iiaV7bmJzcH0yLjYuMzAqKgogCi0qICoqaHR0cDovL3d3dy5saWJ1cmN1Lm9yZy9b
VXNlcnNwYWNle25ic3B9UkNVXXtuYnNwfeKJpXtuYnNwfTAuMTEuMCoqLgorKiAqKmh0dHA6Ly93
d3cubGlidXJjdS5vcmcvW1VzZXJzcGFjZXtuYnNwfVJDVV17bmJzcH3iiaV7bmJzcH0wLjE0LjAq
Ki4KICsKIERlYmlhbi9VYnVudHUgcGFja2FnZTogYGxpYnVyY3V7bmJofWRldmAuCiAKLS0gCjIu
MzcuMwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0
bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlz
dHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
