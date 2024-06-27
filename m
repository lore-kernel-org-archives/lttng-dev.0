Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BF6C2BD09
	for <lttng-dev@archiver.kernel.org>; Thu, 27 Jun 2024 19:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1719517001;
	bh=K526LL7GDDYboBoToEMWJJEfdH9+QYIDcUWrqRPK1gg=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=RjgzAUO5OlAD1fq4UvGSl6Nttg2rCKt5Q2aef6YdgO8B4rgR3IeHbuHXzDD9yUXmN
	 GLK69wZRnEOC2EW4+zw0kVu1fSvu3v2rkBdMswVVdYpplyIhT+YZ2nwizLK+Va5o2s
	 b71CSSn/GqGruXqpaajJWo628TDgtKK3we8MT5IXuQs/2OP1hNq5n8MYFygf8WF/5a
	 uee7TYmcDMwVi3RAYxwAsYnaqB8hrrOxGmQEU9Jm5PBJ238zRWIg5F+bQGl6hH72ke
	 20FDrwZEW9tJRH/Losl0puUUL1OdnfumQKQx9dwweZpKL2DP0RtkvsPEFh0ElvWPN+
	 HYri/GqFdsKvw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4W982c6Zd4z6s8;
	Thu, 27 Jun 2024 15:36:40 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4W982Y27RWz7Dr
 for <lttng-dev@lists.lttng.org>; Thu, 27 Jun 2024 15:36:37 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4W982X1wtpz180c;
 Thu, 27 Jun 2024 15:36:36 -0400 (EDT)
Message-ID: <13eebb98-ddec-404d-81e6-452915b1b819@efficios.com>
Date: Thu, 27 Jun 2024 15:37:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Beau Belgrave <beaub@linux.microsoft.com>
Subject: [lttng-dev] Common Trace Format 2 (CTF2) specification and sub-specs
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
Cc: linux-trace-users <linux-trace-users@vger.kernel.org>,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 lttng-dev <lttng-dev@lists.lttng.org>, Philippe Proulx <pproulx@efficios.com>,
 tracecompass-dev@eclipse.org, Doug Cook <dcook@linux.microsoft.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGksCgpIZXJlIGlzIHRoZSBzdGF0dXMgb2YgdGhlIHNwZWNpZmljYXRpb24gYW5kIHN1Yi1zcGVj
aWZpY2F0aW9uczoKCi0gIkNURjLigJFTUEVD4oCRMi4wOiBDb21tb24gVHJhY2UgRm9ybWF0IHZl
cnNpb24gMiIKICAgaHR0cHM6Ly9kaWFtb24ub3JnL2N0Zi9maWxlcy9DVEYyLVNQRUMtMi4wLmh0
bWwKClRoaXMgaXMgdGhlIG9mZmljaWFsIENURiAyLjAgc3BlYy4gVGhlIFVSTCBodHRwczovL2Rp
YW1vbi5vcmcvY3RmCnBvaW50cyB0byB0aGUgbGF0ZXN0IHZlcnNpb24gb2YgdGhlIENvbW1vbiBU
cmFjZSBGb3JtYXQgc3BlYy4KCi0gIkNURjLigJFET0NJROKAkTIuMDogQ1RGIDIgZG9jdW1lbnQg
aWRlbnRpZmllciBmb3JtYXQiCiAgIGh0dHBzOi8vZGlhbW9uLm9yZy9jdGYvZmlsZXMvQ1RGMi1E
T0NJRC0yLjAuaHRtbAoKVGhlIENURiAyIHNwZWNpZmljYXRpb24gcmVmZXJzIHRvIGl0LgoKLSAi
Q1RGMi1GUy0xLjA6IExheW91dCBvZiBhIENURiAyIHRyYWNlIHN0b3JlZCBvbiBhIGZpbGUgc3lz
dGVtIgogICBodHRwczovL2RpYW1vbi5vcmcvY3RmL2ZpbGVzL0NURjItRlMtMS4wLmh0bWwKClRo
aXMgZG9jdW1lbnQgY292ZXJzIGhvdyBCYWJlbHRyYWNlIGFuZCBUcmFjZSBDb21wYXNzCndpbGwg
ZXhwZWN0IHRoZSBDVEYyIGZpbGVzIG9uIHRoZSBmaWxlc3lzdGVtLCBhbmQgaG93CkJhYmVsdHJh
Y2UgYW5kIExUVG5nIHBsYW4gdG8gcHJvZHVjZSB0aGVtLiBUaGlzIGlzIGJ5CmFsbCBtZWFucyBh
biAib3B0aW9uYWwiIHNwZWNpZmljYXRpb24sIHdoaWNoIG1lYW5zIGl0CmlzIHVwIHRvIHRoZSBp
bXBsZW1lbnRhdGlvbiB0byBkZWNpZGUgd2hldGhlciB0aGV5IHdhbnQKdG8gYWJpZGUgYnkgaXQg
b3Igbm90LgoKUGhpbGlwcGUgcGxhbnMgdG8gc29vbiByZWxlYXNlIGEgQ1RGMi1GUy0yLjAgZG9j
dW1lbnQgd2l0aApwcmV0dHkgbXVjaCB0aGUgc2FtZSBjb250ZW50IGFzIHZlcnNpb24gMS4wLCBi
dXQgZm9ybWF0dGVkCmZvbGxvd2luZyB0aGUgQ1RGMuKAkURPQ0lE4oCRMi4wIHNwZWNpZmljYXRp
b24uCgpXZSBhcmUgcGxhbm5pbmcgdG8gYWRkIGFuIGluZGV4IG9mIHRob3NlIHJlbGV2YW50ICJv
cHRpb25hbCIKc3BlY2lmaWNhdGlvbnMgd2l0aGluIHRoZSBDVEYyIHNwZWNpZmljYXRpb24gc28g
dGhleSBjYW4gZWFzaWx5CmJlIGZvdW5kLgoKSWYgd2UgZW5kIHVwIGhhdmluZyBhIG5ldyBzdG9y
YWdlIHBhdHRlcm4gdGhhdCBlbmQgdXAgYmVpbmcKY29tbW9ubHkgdXNlZCBieSBpbXBsZW1lbnRh
dGlvbnMsIGUuZy4gc3RvcmluZyBhIENURjIgdHJhY2UKd2l0aGluIGEgYmluYXJ5IGJsb2IgaW4g
T3BlblRlbGVtZXRyeSBbMV0sIHdlIGNhbiBhbHdheXMgY3JlYXRlCmEgbmV3IHN1Yi1zcGVjaWZp
Y2F0aW9uIHNpbWlsYXIgdG8gQ1RGMi1GUyB0byBjb3ZlciB0aGlzLgoKVGhlIGZvbGxvd2luZyBz
cGVjaWZpY2F0aW9uIGZpbGVzIHdlcmUgZGVwcmVjYXRlZCBieSB0aGUKdGltZSB0aGUgQ1RGMiBz
cGVjaWZpY2F0aW9uIHdhcyBmaW5hbGl6ZWQ6CgotIGh0dHBzOi8vZGlhbW9uLm9yZy9jdGYvZmls
ZXMvQ1RGMi1CQVNJQ0FUVFJTLTEuMC5odG1sCi0gaHR0cHM6Ly9kaWFtb24ub3JnL2N0Zi9maWxl
cy9DVEYyLVBNRVRBLTEuMC5odG1sCgpBcyBhbHdheXMsIGZlZWRiYWNrIGlzIHdlbGNvbWUhCgpU
aGFua3MsCgpNYXRoaWV1CgpbMV0gaHR0cHM6Ly9naXRodWIuY29tL29wZW4tdGVsZW1ldHJ5L29w
ZW50ZWxlbWV0cnktc3BlY2lmaWNhdGlvbi9pc3N1ZXMvMzk3OQoKLS0gCk1hdGhpZXUgRGVzbm95
ZXJzCkVmZmljaU9TIEluYy4KaHR0cHM6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
