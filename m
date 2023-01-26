Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7595C54EAA
	for <lttng-dev@archiver.kernel.org>; Thu, 26 Jan 2023 19:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1674762452;
	bh=bEjneZvhv/tG4gl040vir4DO46sAYB5mC0iP1QwwoQM=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=gIUEKgWt6vfno9jfMUkmHn8nw3yGOq35kZCqQw4xzhI0jhy6RNbnJMSI+Zj0uAkyK
	 rfr5TLd5l/A23Ylys95kVSynO59pP441+x2bA1SuiEX3EVlmlSZbsLADR01cfyYgF3
	 repANjdUzQrAtwUuCdUdLphdt94ztIgHHEGe5dVCjhh1W3D7O7GfyT9a6IdgPWebsv
	 KToZvt3ogAlNZMmukizMlcU0ALmb9QLdASPgogGUtl2J3sDJjzaWJy5vFd5MDdT24D
	 ie397jLC5SicUxLO+nuQkHW4Uk3cyvAnKCQK+qDQv0PCBb7mCDTiGg7RqQy7JwwFfO
	 YTuTJykWlCtjw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4P2rpC6X0vz1Vj1;
	Thu, 26 Jan 2023 14:47:31 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4P2rp73z5vz1Vhy
 for <lttng-dev@lists.lttng.org>; Thu, 26 Jan 2023 14:47:27 -0500 (EST)
Received: from [10.93.0.190] (unknown [62.119.240.70])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4P2rnQ0YnHzhtv;
 Thu, 26 Jan 2023 14:46:49 -0500 (EST)
Message-ID: <cff5a787-4f4a-85b3-6cde-24fac04d07f2@efficios.com>
Date: Thu, 26 Jan 2023 20:47:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: Anders Wallin <wallinux@gmail.com>,
 Henrik Wallin B <henrik.b.wallin@ericsson.com>,
 =?UTF-8?Q?P=c3=a4r_Olsson_A?= <par.a.olsson@ericsson.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
References: <CAF2baFfZ+sxAGfxGY_or7=JJMxDngZTtfrzruUC5=RnZFD4tvA@mail.gmail.com>
 <954909194.21985.1511551181212.JavaMail.zimbra@efficios.com>
 <CAF2baFecVMCenooHSMcNChMEkevz1taF0VWUxWAyxbUq8kVXSg@mail.gmail.com>
 <1784f4f4-1c5a-5c4b-2041-2327128712d1@efficios.com>
 <CAF2baFebd9hi7GjRYrOV666THGt0nOusp1DdcitL7bn9KOf-yg@mail.gmail.com>
In-Reply-To: <CAF2baFebd9hi7GjRYrOV666THGt0nOusp1DdcitL7bn9KOf-yg@mail.gmail.com>
Subject: Re: [lttng-dev] lttng-consumerd crash on aarch64 due to x86 arch
 specific optimization
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gMjAyMy0wMS0yNiAxNDozMiwgQW5kZXJzIFdhbGxpbiB3cm90ZToKPiBIaSBNYXR0aGlldSwK
PiAKPiBJJ3ZlIHJldGlyZWQgYW5kIG5vIGxvbmdlciBoYXZlIGFjY2VzcyB0byBhbnkgYXJjaDY0
wqAgdGFyZ2V0IHRvIHRlc3QgaXQgb24uCj4gCgpUaGFua3MgZm9yIHlvdXIgcmVwbHkgQW5kZXJz
LAoKSSd2ZSB0YWxrZWQgdG8gSGVucmlrIGFuZCBQw6RyIHRvZGF5IGFuZCB0aGV5IGFyZSBhbHJl
YWR5IHRlc3RpbmcgaXQgb3V0LgoKRW5qb3kgeW91ciByZXRpcmVtZW50IDopCgpCZXN0IHJlZ2Fy
ZHMsCgpNYXRoaWV1CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwczov
L3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9y
ZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==
