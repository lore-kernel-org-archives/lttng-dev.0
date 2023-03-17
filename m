Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3481C6FD1D
	for <lttng-dev@archiver.kernel.org>; Fri, 17 Mar 2023 18:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679079415;
	bh=Z/J2AJmfJrOmtCIsfDLrkNfZtbG9FnlFsl+vUnzprFY=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IA3FNg4VTjjuO2CZi/UoRp7XpbYGAYUMXDRu2r39ue799IqpmSKYhtuqZRIOdBwSn
	 SpuEptFSEA3qL8oLUGiK5NsD+LAkdQcauLXlrVWpQe/2CjKQRwGH6nbUWfg6E/wMWE
	 vd57hnoNFQlxjOEr59ZvV/TQIo6Lw+0G8oQpfSQSjS3K17tlepnihk2ltHvhQ/OWPa
	 Mzb3HI4AHTV6Z2rOTBVZz0xlpaMTj60lSGNABJvdVTNfTXn4v7WT08gQCAEeAHf5DH
	 j3X8VY2IFNnRPa+CkaqqbOmcWPPVJpj6gdrn9Lq6fNoVsuFwKXtfXRyXkGlSyWHqZv
	 uvyPOA6ti9mng==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PdYJk5dTkz2CvX;
	Fri, 17 Mar 2023 14:56:54 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PdYJh6Zwqz2Cxm
 for <lttng-dev@lists.lttng.org>; Fri, 17 Mar 2023 14:56:52 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PdYJ52GWWzqhb;
 Fri, 17 Mar 2023 14:56:21 -0400 (EDT)
Message-ID: <f8cd9b07-6be0-c148-6c77-f6f4375a4b2f@efficios.com>
Date: Fri, 17 Mar 2023 14:56:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Cc: lttng-dev@lists.lttng.org, paulmck <paulmck@kernel.org>
References: <9C7806BF-FD55-45EE-B234-A8274145E19F@sury.org>
 <3b41f7b2-401f-6455-e6e2-a9bfeeabe93d@efficios.com>
 <F524C7BA-80C2-42C0-A5EA-697833761DA3@sury.org>
In-Reply-To: <F524C7BA-80C2-42C0-A5EA-697833761DA3@sury.org>
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

T24gMjAyMy0wMy0xNyAxMzowMiwgT25kxZllaiBTdXLDvSB3cm90ZToKPj4gT24gMTcuIDMuIDIw
MjMsIGF0IDE0OjQ0LCBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNp
b3MuY29tPiB3cm90ZToKPj4KPj4gSSB3b3VsZCBpbmRlZWQgbGlrZSB0byByZW1vdmUgYWxsIHRo
ZSBjdXN0b20gYXRvbWljcyBhc3NlbWJseSBjb2RlIGZyb20gbGlidXJjdSBub3cgdGhhdCB0aGVy
ZSBhcmUgZ29vZCBhdG9taWNzIHN1cHBvcnQgaW4gdGhlIG1ham9yIGNvbXBpbGVycyAoZ2NjIGFu
ZCBjbGFuZykuCj4gCj4gSGVyZSdzIHZlcnkgcHJlbGltaW5hcnkgaW1wbGVtZW50YXRpb246Cj4g
Cj4gaHR0cHM6Ly9naXRsYWIuaXNjLm9yZy9pc2MtcHJvamVjdHMvdXNlcnNwYWNlLXJjdS8tL21l
cmdlX3JlcXVlc3RzLzIKPiAKPiBJIGp1c3QgZGlkIHNvbWV0aGluZyB3cm9uZyBzb21ld2hlcmUg
YWxvbmcgdGhlIHBhdGggYW5kIGl0IGRvZXNuJ3QgY29tcGlsZSBub3csCj4gYnV0IGl0IGRpZCBm
b3IgbWUgbG9jYWxseS4KPiAKPiBJIGFtIHN1Ym1pdHRpbmcgdGhpcyBub3cgYXMgaXQncyAxODow
MCBGcmlkYXkgZXZlbmluZyBhbmQgbXkga2lkcyBhcmUgc3RhcnRpbmcgdG8KPiBiZSBhbmdyeSBh
dCBtZSA6KS4KPiAKPiBUaGlzIHdpbGwgbmVlZCBzb21lIG1vcmUgd29yayAtIEkgdGhpbmsgc29t
ZSBvZiB0aGUgY21tXyBtYWNyb3MgbWlnaHQgYmUgZHJvcHBlZAo+IG5vdywgYW5kIHNvbWVib2R5
IHdobyBkb2VzIHRoYXQgbW9yZSBvZnRlbiB0aGFuIEkgc2hvdWxkIHRha2UgYSBsb29rIGF0IHRo
ZSBtZW1vcnkKPiBvcmRlcmluZ3MuCgpBIGZldyBjb21tZW50czoKCmNtbV9iYXJyaWVyKCkgc2hv
dWxkIHJhdGhlciBiZSBfX2F0b21pY19zaWduYWxfZmVuY2UoKS4KCkFsc28gSSBub3RpY2UgdGhp
cyBtYWNybyBwYXR0ZXJuIChjb2Rpbmcgc3R5bGUpOgoKI2RlZmluZSB1YXRvbWljX3NldChhZGRy
LCB2KSBfX2F0b21pY19zdG9yZV9uKChhZGRyKSwgKHYpLCBfX0FUT01JQ19SRUxFQVNFKQoKVGhl
IGV4dHJhIHBhcmVudGhlc2VzIGZvciBwYXJhbWV0ZXJzIGFyZSBub3QgbmVlZGVkLCBiZWNhdXNl
IHRoZSBjb21tYSBpcyBwcmV0dHkKbXVjaCB0aGUgbGFzdCBvcGVyYXRvciBpbiB0ZXJtcyBvZiBw
cmlvcml0eS4gVGhlIGZvbGxvd2luZyB3b3VsZCBiZSBwcmVmZXJyZWQKc3BlY2lmaWNhbGx5IGJl
Y2F1c2UgdGhvc2UgYXJlIHNlcGFyYXRlZCBieSBjb21tYToKCiNkZWZpbmUgdWF0b21pY19zZXQo
YWRkciwgdikgX19hdG9taWNfc3RvcmVfbihhZGRyLCB2LCBfX0FUT01JQ19SRUxFQVNFKQoKT3Vy
IG1lbW9yeSBiYXJyaWVyIHNlbWFudGljIGFyZSBzaW1pbGFyIHRvIHRoZSBMaW51eCBrZXJuZWws
IHdoZXJlIHRoZSBmb2xsb3dpbmcKaW1wbHkgQUNRX1JFTCBiZWNhdXNlIHRoZXkgcmV0dXJuIHNv
bWV0aGluZzogY21weGNoZywgYWRkX3JldHVybiwgc3ViX3JldHVybiwgeGNoZy4KClRoZSByZXN0
IChhZGQsIHN1YiwgYW5kLCBvciwgaW5jLCBkZWMpIGFyZSBfX0FUT01JQ19SRUxBWEVELiBOb3Rl
IHRoYXQKY21tX3NtcF9tYl9fYmVmb3JlL2FmdGVyX3VhdG9taWNfKigpIG5lZWQgdG8gYmUgaW1w
bGVtZW50ZWQgYXMKX19hdG9taWNfdGhyZWFkX2ZlbmNlKF9fQVRPTUlDX0FDUV9SRUwpLgoKVGhl
cmUgYXJlIHNvbWUgYXJjaGl0ZWN0dXJlcyB3aGVyZSB3ZSB3aWxsIHdhbnQgdG8ga2VlcCBhIHNw
ZWNpYWxpemVkIHZlcnNpb24Kb2YgdGhvc2UgYWRkLCBzdWIsIGFuZCwgb3IsIGluYywgZGVjIG9w
ZXJhdGlvbnMgd2hpY2ggaW5jbHVkZSB0aGUgQUNRX1JFTCBzZW1hbnRpYywKZS5nLiB4ODYsIHdo
ZXJlIHRoaXMgaXMgaW1wbGllZCBieSB0aGUgTE9DSyBwcmVmaXguIEZvciB0aG9zZSB0aGUgY21t
X3NtcF9tYl9fYmVmb3JlL2FmdGVyX3VhdG9taWNfKigpCndpbGwgYmUgbm8tb3BzLgoKVGhlIENN
TV9TVE9SRV9TSEFSRUQgaXMgbm90IG1lYW50IHRvIGhhdmUgYSBSRUxFQVNFIHNlbWFudGljLiBJ
dCBpcyBtZWFudCB0bwp1cGRhdGUgdmFyaWFibGVzIHRoYXQgZG9uJ3QgbmVlZCB0aGUgcmVsZWFz
ZSBvcmRlcmluZy4gVGhlIEFUT01JQ19DT05TVU1FIHdhcwpub3QgdGhlIGludGVudCBhdCB0aGUg
Q01NX0xPQURfU0hBUkVEIGxldmVsIG5laXRoZXIuCgoodGhpcyBpcyBqdXN0IGZyb20gbG9va2lu
ZyBhcm91bmQgYXQgdGhlIHBhdGNoZXMsIGl0IHdvdWxkIGJlIGJldHRlciBpZiB3ZSBjYW4gaGF2
ZSB0aGUKcGF0Y2hlcyBwb3N0ZWQgdG8gdGhlIG1haWxpbmcgbGlzdCBmb3IgZnVydGhlciBkaXNj
dXNzaW9uKQoKVGhhbmtzIQoKTWF0aGlldQoKCj4gCj4gT25kcmVqCj4gLS0KPiBPbmTFmWVqIFN1
csO9IChIZS9IaW0pCj4gb25kcmVqQHN1cnkub3JnCj4gCgotLSAKTWF0aGlldSBEZXNub3llcnMK
RWZmaWNpT1MgSW5jLgpodHRwczovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
