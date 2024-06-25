Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D25C2BBCA
	for <lttng-dev@archiver.kernel.org>; Tue, 25 Jun 2024 21:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1719352378;
	bh=QUTd1ZSKOjRGJ6EP+/zStMx4pmYFWNY3B43JPrRPPYU=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=uASpI8hq3SGWt3g8DiJppBaaZf9tEBkmjbLCa/A69YbVJas4J/pZoAJiXphzKKbUM
	 NKlgA6dmSke24Tv/mfZOEKD5VGce4SCBh0RKHHVLO92e0b2xZ0rztrhYu9owHCO6tk
	 XV/s4VtQFfOCBTO8xYnUNdzC/X28ssM3+K4vDgrOxF0jH2Jipb1uKc6PpuAK4+siEH
	 thIWea2QhdXTW4Wgidy7nsrbtTsp3pNcOKoktW8B67hv8rU3pLHKvIaLfLzDspjcLD
	 6AIxE+LG2IIiQgpsU0yJpAXtkVB4zozKITDI8JHBWnvZfoCda/GWxtNKQjQFeAtkvv
	 Bb0+sqyJHB86g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4W7z8n4GZ5z6mt;
	Tue, 25 Jun 2024 17:52:57 -0400 (EDT)
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4W7z8m0pL1z6mr
 for <lttng-dev@lists.lttng.org>; Tue, 25 Jun 2024 17:52:55 -0400 (EDT)
Received: from zimbra-s2.polymtl.ca (zimbra-s2.polymtl.ca [132.207.23.204])
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id 45PLqru0085924;
 Tue, 25 Jun 2024 17:52:54 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca 45PLqru0085924
Date: Tue, 25 Jun 2024 17:52:53 -0400 (EDT)
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <1926119361.1187923.1719352373355.JavaMail.zimbra@polymtl.ca>
In-Reply-To: <ff7f120d-8d44-427b-9c46-1809378c9203@efficios.com>
References: <364622686.75839325.1718811716721.JavaMail.zimbra@polymtl.ca>
 <ff7f120d-8d44-427b-9c46-1809378c9203@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [132.207.169.227]
X-Mailer: Zimbra 9.0.0_GA_4583 (ZimbraWebClient - GC126 (Win)/9.0.0_GA_4583)
Thread-Topic: Compile modules on Centos Stream 9
Thread-Index: zmjsR3XzysvnYJXn4ajOyyGeBhizXQ==
X-Poly-FromMTA: (zimbra-s2.polymtl.ca [132.207.23.204]) at Tue,
 25 Jun 2024 21:52:53 +0000
Subject: Re: [lttng-dev] Compile modules on Centos Stream 9
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
From: Jean-Marc Chevalier via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jean-Marc Chevalier <jean-marc.chevalier@polymtl.ca>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgS2llbmFuLAoKVGhhbmsgeW91LCBpdCB3b3JrZWQuCgpJIGRpZCBub3Qga25vdyBleGFjdGx5
IHdoYXQgSSB3YXMgZG9pbmcsIGJ1dCBJIGNsaWNrZWQgIk9wZW4gZG93bmxvYWQgb3ZlcmxheSIg
YW5kIGdvdCB0aGUgcGF0Y2hlZCB2ZXJzaW9uIGluICJjNDY5ZWQ3LnRhci5neiIuCgpUaGUgbW9k
dWxlcyBhcmUgbG9hZGVkLiBUaGUgdGVhY2hlcnMgd2lsbCBiZSBhYmxlIHRvIHRvIHRlc3QgaXQg
YXMgSSBkb250IGtub3cgbXlzZWxmIGhvdyB0byBldmFsdWF0ZSBpZiBpdCB3b3Jrcy4KCi0gSk0K
Ci0tIAotIEplYW4tTWFyYyBDaGV2YWxpZXIKICBUZWNobmljaWVuCiAgR8OpbmllIGluZm9ybWF0
aXF1ZSBHw6luaWUgbG9naWNpZWwKICBMb2NhbDogICAgIE0tNDAwMgkKICBUw6lsw6lwaG9uZTog
NTE0LTM0MC00NzExIHg0MjY2CgotLS0tLSBNYWlsIG9yaWdpbmFsIC0tLS0tCkRlOiAiS2llbmFu
IFN0ZXdhcnQiIDxrc3Rld2FydEBlZmZpY2lvcy5jb20+CsOAOiAiSmVhbi1NYXJjIENoZXZhbGll
ciIgPGplYW4tbWFyYy5jaGV2YWxpZXJAcG9seW10bC5jYT4sIGx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKRW52b3nDqTogSmV1ZGkgMjAgSnVpbiAyMDI0IDExOjI2OjI1Ck9iamV0OiBSZTogW2x0
dG5nLWRldl0gQ29tcGlsZSBtb2R1bGVzIG9uIENlbnRvcyBTdHJlYW0gOQoKSGkgSmVhbi1NYXJj
LAoKZm9yIHRoZSBidWlsZCBlcnJvcnMgY291bGQgeW91IHRyeSB0aGUgZm9sbG93aW5nIHBhdGNo
OiAKaHR0cHM6Ly9yZXZpZXcubHR0bmcub3JnL2MvbHR0bmctbW9kdWxlcy8rLzEyODg1ID8KCnRo
YW5rcywKa2llbmFuCgpPbiA2LzE5LzI0IDExOjQxIEFNLCBKZWFuLU1hcmMgQ2hldmFsaWVyIHZp
YSBsdHRuZy1kZXYgd3JvdGU6Cj4gSGksCj4gCj4gSXMgaXQgcG9zc2libGUgdG8gYnVpbGQgdGhl
IGx0dG5nIG1vZHVsZXMgYWdhaW50IENlbnRvcyBTdHJlYW0gOSAKPiBrZXJuZWxzPyBJIHNlZSB0
aGVzZSB3YXJuaW5ncyBhdCB0aGUgdG9wIHdoZW4gYXR0ZW1wdGluZyB0byBjb21waWxlOgo+IAo+
IG1ha2VbMV06IEVudGVyaW5nIGRpcmVjdG9yeSAnL3Vzci9zcmMva2VybmVscy81LjE0LjAtNDUy
LmVsOS54ODZfNjQnCj4gL2hvbWUvdG1wL2dpdC9sdHRuZy1tb2R1bGVzL3NyYy9wcm9iZXMvS2J1
aWxkOjI4OiBGaWxlIC4vbW0vc2xhYi5oIG5vdCAKPiBmb3VuZC4gUHJvYmUgImttZW0iIGlzIGRp
c2FibGVkLiBVc2UgZnVsbCBrZXJuZWwgc291cmNlIHRyZWUgdG8gZW5hYmxlIGl0Lgo+IC9ob21l
L3RtcC9naXQvbHR0bmctbW9kdWxlcy9zcmMvcHJvYmVzL0tidWlsZDo3OTogRmlsZSAKPiAuL2Fy
Y2gveDg2L2t2bS9sYXBpYy5oIG5vdCBmb3VuZC4gUHJvYmUgImt2bSIgeDg2LXNwZWNpZmljIGlz
IGRpc2FibGVkLiAKPiBVc2UgZnVsbCBrZXJuZWwgc291cmNlIHRyZWUgdG8gZW5hYmxlIGl0Lgo+
IC9ob21lL3RtcC9naXQvbHR0bmctbW9kdWxlcy9zcmMvcHJvYmVzL0tidWlsZDoxODE6IEZpbGVz
IC4vbW0vaW50ZXJuYWwuaCAKPiBub3QgZm91bmQuIFByb2JlICJjb21wYWN0aW9uIiBpcyBkaXNh
YmxlZC4gVXNlIGZ1bGwga2VybmVsIHNvdXJjZSB0cmVlIAo+IHRvIGVuYWJsZSBpdC4KPiAvaG9t
ZS90bXAvZ2l0L2x0dG5nLW1vZHVsZXMvc3JjL3Byb2Jlcy9LYnVpbGQ6MTkwOiBGaWxlcyAuL2Zz
L2V4dDQvKi5oIAo+IG5vdCBmb3VuZC4gUHJvYmUgImV4dDQiIGlzIGRpc2FibGVkLiBVc2UgZnVs
bCBrZXJuZWwgc291cmNlIHRyZWUgdG8gCj4gZW5hYmxlIGl0Lgo+IC9ob21lL3RtcC9naXQvbHR0
bmctbW9kdWxlcy9zcmMvcHJvYmVzL0tidWlsZDoyMTM6IEZpbGUgCj4gLi9kcml2ZXJzL2Jhc2Uv
cmVnbWFwL3RyYWNlLmggbm90IGZvdW5kLiBQcm9iZSAicmVnbWFwIiBpcyBkaXNhYmxlZC4gVXNl
IAo+IGZ1bGwga2VybmVsIHNvdXJjZSB0cmVlIHRvIGVuYWJsZSBpdC4KPiAKPiBJIHRyaWVkIHdp
dGggbW9kdWxlIHZlcnNpb25zIDIuMTIuMTcgYW5kIDIuMTMuMTMgYWdhaW5zdCB0aGUga2VybmVs
IAo+IDUuMTQuMC00NTIuZWw5Lng4Nl82NCBhbmQgSSBvYnRhaW4gdGhpcyBlcnJvcjoKPiAKPiAv
aG9tZS90bXAvZ2l0L2x0dG5nLW1vZHVsZXMvc3JjL3Byb2Jlcy8uLi8uLi9pbmNsdWRlL2x0dG5n
L3RyYWNlcG9pbnQtZXZlbnQtaW1wbC5oOjEzMzo2OiBlcnJvcjogY29uZmxpY3RpbmcgdHlwZXMg
Zm9yICd0cmFjZV9zY2hlZF9zdGF0X3J1bnRpbWUnOyBoYXZlICd2b2lkKHN0cnVjdCB0YXNrX3N0
cnVjdCAqLCB1NjQswqAgdTY0KScge2FrYSAndm9pZChzdHJ1Y3QgdGFza19zdHJ1Y3QgKiwgbG9u
ZyBsb25nIHVuc2lnbmVkIGludCzCoCBsb25nIGxvbmcgdW5zaWduZWQgaW50KSd9Cj4gCj4gQW55
IGhlbHAgd291bGQgYmUgZ3JlYXRseSBhcHByZWNpYXRlZC4KPiAKPiAtIEpNCj4gCj4gLS0gCj4g
LSBKZWFuLU1hcmMgQ2hldmFsaWVyCj4gIMKgwqBUZWNobmljaWVuCj4gIMKgwqBHw6luaWUgaW5m
b3JtYXRpcXVlIEfDqW5pZSBsb2dpY2llbAo+ICDCoMKgTG9jYWw6IMKgIMKgIE0tNDAwMgo+ICDC
oMKgVMOpbMOpcGhvbmU6IDUxNC0zNDAtNDcxMSB4NDI2Ngo+IAo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+
IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
