Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5473C6FD1D
	for <lttng-dev@archiver.kernel.org>; Fri, 17 Mar 2023 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679069481;
	bh=/hkEuFy2GceHfdaD/JR5uXNvET+UlbC7m5A136ctmRI=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MLW+T5ofGUjCOLLADIZy3ykNBCOK4Vc/1Vya89928g17Kgz5l3szz2bSreUsmfjTT
	 oXhdIrEvhkzCniSdTfle0kVSaYxiNuPEoCXIeKYHQyCYZ/2aSrw052U3F2T2wV5Net
	 DjDtLGRZn5HF2aNT+7ZGMW2eu3Ll8KPIoH4EaL/kpl1ifPYViUfzhdNBw6byaTER5L
	 GvCDs9u9lCPvAMOfSCDB/tf3dF5JR85naZpxnkRCiunlA8pMTxUQfjwDHh5ldERcs/
	 IOnPoM/spTVU2hdcUN8M4RVVkqhImbUKzeh191Wws6OsIQ/mzFhbv4puK1dzSECNRG
	 lRIcl0shbyg8Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PdTdj08TBz2CVb;
	Fri, 17 Mar 2023 12:11:20 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PdTdh0rx0z2CpJ
 for <lttng-dev@lists.lttng.org>; Fri, 17 Mar 2023 12:11:20 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PdTd53WqTzqfm;
 Fri, 17 Mar 2023 12:10:49 -0400 (EDT)
Message-ID: <040c466f-f14a-913b-fb0f-eeaf60c4374f@efficios.com>
Date: Fri, 17 Mar 2023 12:10:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Cc: lttng-dev@lists.lttng.org, paulmck <paulmck@kernel.org>
References: <9C7806BF-FD55-45EE-B234-A8274145E19F@sury.org>
 <3b41f7b2-401f-6455-e6e2-a9bfeeabe93d@efficios.com>
 <3778B038-5A99-4498-9BDE-D205BC1281DF@sury.org>
In-Reply-To: <3778B038-5A99-4498-9BDE-D205BC1281DF@sury.org>
Subject: Re: [lttng-dev] userspace-rcu and ThreadSanitizer
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

T24gMjAyMy0wMy0xNyAxMTo1MCwgT25kxZllaiBTdXLDvSB3cm90ZToKPj4gT24gMTcuIDMuIDIw
MjMsIGF0IDE0OjQ0LCBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNp
b3MuY29tPiB3cm90ZToKPj4KPj4gU3VyZSwgY2FuIHlvdSBwbGVhc2Ugc3VibWl0IHRoZSBwYXRj
aCBhcyBhIHNlcGFyYXRlIGVtYWlsIHdpdGggc3ViamVjdC9jb21taXQgbWVzc2FnZS9zaWduZWQt
b2ZmLWJ5IHRhZyA/Cj4gCj4gCj4gaHR0cHM6Ly9naXRsYWIuaXNjLm9yZy9pc2MtcHJvamVjdHMv
dXNlcnNwYWNlLXJjdS8tL21lcmdlX3JlcXVlc3RzLzEucGF0Y2gKPiAKPiBXb3VsZCB0aGlzIHdv
cmsgZm9yIHlvdT8KPiAKPiBPciBkbyB5b3UgbmVlZCB0byBoYXZlIHRoZSBwYXRjaCBhdHRhY2hl
ZD8KCkhhdmluZyB0aGUgcGF0Y2ggYXR0YWNoZWQgKGUuZy4gdXNpbmcgZ2l0IHNlbmQtZW1haWwp
IHdvdWxkIGJlIGJldHRlciwgCmJ1dCBJIGRvbid0IG1pbmQgZG93bmxvYWRpbmcgdGhlIGZpbGUg
Zm9yIHRoaXMgdGltZS4gTWVyZ2VkIGludG8gbGlidXJjdSAKbWFzdGVyIGJyYW5jaCwgdGhhbmtz
IQoKTWF0aGlldQoKPiAKPiBPbmRyZWoKPiAtLQo+IE9uZMWZZWogU3Vyw70gKEhlL0hpbSkKPiBv
bmRyZWpAc3VyeS5vcmcKPiAKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0
dHBzOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYK
