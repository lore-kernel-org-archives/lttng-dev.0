Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C707C25B0E
	for <lttng-dev@archiver.kernel.org>; Tue,  9 Aug 2022 18:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660069725;
	bh=tdNYeCv/N0B3FgdZvYUMpro7u2Wj/JHlpxRG9FEhX40=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=taD9A2n15QNMjENY90W8D7+vmQenN9N4FHk1swzJOY7mr6dlqDMWpIj6dckae35Di
	 oRDvU6ZEEkqLYstLg2KXZLvid7vS/8m0/GhU+q727bSYmJdQBN+Rv0GfgM5Kckatgj
	 0FBBR6rz9IXOeRVVxLreHpCTk3XeRXGUoo1ZEN6sp9kK+6wTd2CF9zciiwehHbMI1m
	 JAUMmwf4XS01xZBHoWgKdWhsvf8DoD9b83YIkx/5fVbREHIvTFUArZBHyEJsNfj3EH
	 OlUuouHnxaipXyY58P+22qjQ2S5oZMCUAUfa+BRDbHywdr5ZsDA5q7I5Z67HHyUW2+
	 YV4pbjHB5lleg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M2M5m3czmz148W;
	Tue,  9 Aug 2022 14:28:44 -0400 (EDT)
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
 by lists.lttng.org (Postfix) with ESMTPS id 4M2M5l2SJRz13fH
 for <lttng-dev@lists.lttng.org>; Tue,  9 Aug 2022 14:28:43 -0400 (EDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
 by dcvr.yhbt.net (Postfix) with ESMTP id 5A64A1F54E;
 Tue,  9 Aug 2022 18:19:27 +0000 (UTC)
Date: Tue, 9 Aug 2022 18:19:27 +0000
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: Sam Saffron <sam.saffron@gmail.com>,
 Simon Marchi <simon.marchi@efficios.com>
Message-ID: <20220809181927.GA3718@dcvr>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] urcu 7ca7fe9c03 + _LGPL_SOURCE regression?
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
From: Eric Wong via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Eric Wong <normalperson@yhbt.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGVsbG8sIEkndmUgbm90aWNlZCBsaWJ1cmN1IHYwLjExLjQrIGFuZCBsYXRlciBmYWlscyB3aXRo
IHRoZQoibXdyYXAiIExEX1BSRUxPQUQgbWFsbG9jIHdyYXBwZXIgd2hpY2ggaW5pdGlhbGl6ZXMg
YW4gcmN1bGZoYXNoCmluIGEgY29uc3RydWN0b3IuCgpUaGUgcHJvYmxlbSBoYXBwZW5zIHdoZW4g
dXNpbmcgX0xHUExfU09VUkNFICsgcmN1X2RlcmVmZXJlbmNlIG9uCmEgY2RzX2xmaHQgcG9pbnRl
cjoKCiAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvYi9pbmNsdWRlL3VyY3UvcG9pbnRlci5o
OjM5LAogICAgICAgICAgICAgICAgICAgZnJvbSAvdG1wL2IvaW5jbHVkZS91cmN1L3VyY3UtYnAu
aDo1OCwKICAgICAgICAgICAgICAgICAgIGZyb20gL3RtcC9iL2luY2x1ZGUvdXJjdS1icC5oOjIs
CiAgICAgICAgICAgICAgICAgICBmcm9tIC4uLzdjYTdmZTljX3JlZ3Jlc3Npb24uYzoxMDoKICAu
Li83Y2E3ZmU5Y19yZWdyZXNzaW9uLmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6CiAgL3RtcC9i
L2luY2x1ZGUvdXJjdS9zdGF0aWMvcG9pbnRlci5oOjEwMToxODogZXJyb3I6IGludmFsaWQgdXNl
IG9mIHVuZGVmaW5lZCB0eXBlIOKAmHN0cnVjdCBjZHNfbGZodOKAmQogICAgMTAxIHwgICAgIF9f
dHlwZW9mX18ocCArIDApIF9fX19fX19fX3AxOyAgICBcCiAgICAgICAgfCAgICAgICAgICAgICAg
ICAgIF4KICAvdG1wL2IvaW5jbHVkZS91cmN1L3BvaW50ZXIuaDo0NzoyNjogbm90ZTogaW4gZXhw
YW5zaW9uIG9mIG1hY3JvIOKAmF9yY3VfZGVyZWZlcmVuY2XigJkKICAgICA0NyB8ICNkZWZpbmUg
cmN1X2RlcmVmZXJlbmNlICBfcmN1X2RlcmVmZXJlbmNlCiAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fgogIC4uLzdjYTdmZTljX3JlZ3Jlc3Npb24uYzoy
NjoyMzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmHJjdV9kZXJlZmVyZW5jZeKAmQog
ICAgIDI2IHwgIHN0cnVjdCBjZHNfbGZodCAqdCA9IHJjdV9kZXJlZmVyZW5jZSh0b3RhbHMpOwog
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fgoKUmVtb3Zpbmcg
X0xHUExfU09VUkNFIGF2b2lkcyB0aGUgcHJvYmxlbSwgYnV0IEknZCByYXRoZXIgbm90CmludHJv
ZHVjZSBwZXJmb3JtYW5jZSByZWdyZXNzaW9ucy4KCkluIHJldHJvc3BlY3QsIG15IHVzZSBvZiBy
Y3VfZGVyZWZlcmVuY2Ugc2VlbXMgdW5uZWNlc3Nhcnkgc2luY2UKY29uc3RydWN0b3IgZnVuY3Rp
b25zIHNob3VsZCBhbHdheXMgZmlyZSBiZWZvcmUgYW55IHRocmVhZHMgYXJlCmNyZWF0ZWQuCgpU
aGF0IG1lYW5zIEkgY2FuIHNhZmVseSByZXBsYWNlIHRoZSBhc3NpZ25tZW50IHcvIENNTV9TVE9S
RV9TSEFSRUQsCmFuZCByY3VfZGVyZWZlcmVuY2Ugd2l0aCBDTU1fTE9BRF9TSEFSRUQsIGNvcnJl
Y3Q/CgpTYW1wbGUgY29kZToKLyoKICogc2hvd3MgYSByZWdyZXNzaW9uIHdpdGggX0xHUExfU09V
UkNFICsgdXJjdSB2MC4xMS40LCBjb21taXQ6CiAqIDdjYTdmZTljMDMyMTc4MTMgKE1ha2UgdGVt
cG9yYXJ5IHZhcmlhYmxlIGluIF9yY3VfZGVyZWZlcmVuY2Ugbm9uLWNvbnN0LCAyMDIxLTA3LTI5
KQogKiAkKENDKSAtbyB4IC1JL3BhdGgvdG8vaW5jbHVkZS8gLUwvcGF0aC90by9saWIvIF9fRklM
RV9fIC1sdXJjdS1icCAtbHVyY3UtY2RzCiAqCiAqIE9yaWdpbmFsbHkgbm90aWNlZCBpbiBhbiBM
RF9QUkVMT0FEIG1hbGxvYyB3cmFwcGVyOgogKiBodHRwczovLzgweDI0Lm9yZy9td3JhcC5naXQg
KFJ1YnkgMi42KykKICogaHR0cHM6Ly84MHgyNC5vcmcvbXdyYXAtcGVybC5naXQgKFBlcmw1KQog
Ki8KI2RlZmluZSBfTEdQTF9TT1VSQ0UKI2luY2x1ZGUgPHVyY3UtYnAuaD4KI2luY2x1ZGUgPHVy
Y3UvcmN1bGZoYXNoLmg+CnN0YXRpYyBzdHJ1Y3QgY2RzX2xmaHQgKnRvdGFsczsgLyogaW1tb3J0
YWwgKi8KCl9fYXR0cmlidXRlX18oKGNvbnN0cnVjdG9yKSkgc3RhdGljIHZvaWQgaW5pdF9sZmh0
KHZvaWQpCnsKCS8qIFhYWCByZXBsYWNlIHdpdGggQ01NX1NUT1JFX1NIQVJFRD8gKi8KCXRvdGFs
cyA9IGNkc19sZmh0X25ldygxNjM4NCwgMSwgMCwgQ0RTX0xGSFRfQVVUT19SRVNJWkUsIDApOwp9
CgppbnQgbWFpbih2b2lkKSAvKiB0aGlzIGlzIG1lYW50IHRvIGJlIGEgbWFsbG9jLWZhbWlseSBm
dW5jdGlvbiBpbiBtd3JhcCAqLwp7CgkvKiBYWFggcmVwbGFjZSByY3VfZGVyZWZlcmVuY2Ugd2l0
aCBDTU1fTE9BRF9TSEFSRUQ/ICovCglzdHJ1Y3QgY2RzX2xmaHQgKnQgPSByY3VfZGVyZWZlcmVu
Y2UodG90YWxzKTsKCXJldHVybiB0ID8gMCA6IDE7Cn0KLS0tClRoYW5rcyBmb3IgbWFueSB5ZWFy
cyBvZiB1cmN1ICsgY2RzIQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
