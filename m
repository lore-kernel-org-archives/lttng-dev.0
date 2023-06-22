Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2A6EB64D8
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Jun 2023 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687442679;
	bh=kVlA/q9PhJMWWL39Gilev1/Gcw9i53Z5FogMlWVGRRQ=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=JDwQN+yUyafj9rgPkBFIXxgyn+WjFv4uJqV5nU66qOm+69FA8JpXNudjtjYF2r+LI
	 cE7AOBcMGFDodz76dzlXlhIMmVLb82DpLOt5kXwT1OHfWq46dL1RLJuJ5WdPXV0Zdh
	 qAkYAcxSdZPQPYrjakwB1yfIeipzBuvdtGOVRdZQ2mdeP6F06rulAwLf4Ffv3casF7
	 omp4vJQ4KSP60I+zB/B0O79nRS5rziNSTOz9pdLXmaVpdzXWQ2eqIP+ADv3teUaSdY
	 ui87opw0g2Z28u8o4DdbM4GcYMZ2h+fqu7N4rcc9IiiqqtPKMtcew/NiuaGpTfuY6p
	 FmJOxCKz1JdPg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qn2Dl2nQgz20H4;
	Thu, 22 Jun 2023 10:04:39 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qn2Dh5ZWfz2057
 for <lttng-dev@lists.lttng.org>; Thu, 22 Jun 2023 10:04:31 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qn2DT0sfdz18vr;
 Thu, 22 Jun 2023 10:04:25 -0400 (EDT)
Message-ID: <f4fd2fa5-41d4-be0b-ff7a-f797c341cea9@efficios.com>
Date: Thu, 22 Jun 2023 10:04:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>,
 lttng-dev@lists.lttng.org
References: <20230622102626.569224-1-ondrej@sury.org>
 <20230622104531.1132312-1-ondrej@sury.org>
In-Reply-To: <20230622104531.1132312-1-ondrej@sury.org>
Subject: Re: [lttng-dev] [PATCH] Avoid calling caa_container_of on NULL
 pointer in cds_lfhash macros
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

T24gNi8yMi8yMyAwNjo0NSwgT25kxZllaiBTdXLDvSB2aWEgbHR0bmctZGV2IHdyb3RlOgo+IChT
b3JyeSwgSSBtaXNzZWQgY2xvc2luZyBicmFja2V0cyBpbiBib3RoIG1hY3Jvcywgc28gcmVzZW5k
aW5nIGZpeGVkIHBhdGNoLi4uKQo+IAo+IFRoZSBjZHNfbGZodF9mb3JfZWFjaF9lbnRyeSBhbmQg
Y2RzX2xmaHRfZm9yX2VhY2hfZW50cnlfZHVwbGljYXRlIG1hY3Jvcwo+IHdvdWxkIGNhbGwgY2Fh
X2NvbnRhaW5lcl9vZigpIG1hY3JvIG9uIE5VTEwgcG9pbnRlci4gIFRoaXMgaXMgbm90IGEKPiBw
cm9ibGVtIHVuZGVyIG5vcm1hbCBjaXJjdW1zdGFuY2VzIGFzIHRoZSBjaGVjayBpbiB0aGUgZm9y
IGxvb3AgZmFpbHMKPiBhbmQgdGhlIGxvb3Atc3RhdGVtZW50IGlzIG5vdCBjYWxsZWQgd2l0aCBp
bnZhbGlkIChwb3MpIHZhbHVlLgo+IAo+IEhvd2V2ZXIgQWRkcmVzc1Nhbml0aXplciBkb2Vzbid0
IGxpa2UgdGhhdCBhbmQgY29tcGxhaW5zIGFib3V0IHRoaXM6Cj4gCj4gICAgICBydW50aW1lIGVy
cm9yOiBhcHBseWluZyBub24temVybyBvZmZzZXQgMTg0NDY3NDQwNzM3MDk1NTEwNTYgdG8gbnVs
bCBwb2ludGVyCj4gCj4gTW92ZSB0aGUgY2RzX2xmaHRfaXRlcl9nZXRfbm9kZShpdGVyKSAhPSBO
VUxMIGZyb20gdGhlIGNvbmQtZXhwcmVzc2lvbgo+IG9mIHRoZSBmb3IgbG9vcCBpbnRvIGJvdGgg
aW5pdC1jbGF1c2UgYW5kIGl0ZXJhdGlvbi1leHByZXNzaW9uIGFzCj4gY29uZGl0aW9uYWwgb3Bl
cmF0b3IgYW5kIGNoZWNrIGZvciAocG9zKSB2YWx1ZSBpbiB0aGUgY29uZC1leHByZXNzaW9uCj4g
aW5zdGVhZC4KCkkndmUgdGFrZW4gdGhlIGxpYmVydHkgdG8gcmVpbXBsZW1lbnQgdGhpcyB3aXRo
IGEgbmV3IGhlbHBlciAiY2RzX2xmaHRfZW50cnkiLgoKQ2FuIHlvdSByZXZpZXcgYW5kIHRyeSB0
aGUgZm9sbG93aW5nIGNvbW1pdHMgcGxlYXNlID8KCmh0dHBzOi8vcmV2aWV3Lmx0dG5nLm9yZy9j
L3VzZXJzcGFjZS1yY3UvKy8xMDQ0NSBjb21waWxlci5oOiBJbnRyb2R1Y2UgY2FhX3VucXVhbF9z
Y2FsYXJfdHlwZW9mCmh0dHBzOi8vcmV2aWV3Lmx0dG5nLm9yZy9jL3VzZXJzcGFjZS1yY3UvKy8x
MDQ0NiBBdm9pZCBjYWxsaW5nIGNhYV9jb250YWluZXJfb2Ygb24gTlVMTCBwb2ludGVyIGluIGNk
c19sZmh0IG1hY3JvcwoKVGhhbmtzIQoKTWF0aGlldQoKPiAKPiBTaWduZWQtb2ZmLWJ5OiBPbmTF
mWVqIFN1csO9IDxvbmRyZWpAc3VyeS5vcmc+Cj4gLS0tCj4gICBpbmNsdWRlL3VyY3UvcmN1bGZo
YXNoLmggfCAyMCArKysrKysrKysrLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3Vy
Y3UvcmN1bGZoYXNoLmggYi9pbmNsdWRlL3VyY3UvcmN1bGZoYXNoLmgKPiBpbmRleCBmYmQzM2Nj
Li42NGNjMThmIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdXJjdS9yY3VsZmhhc2guaAo+ICsrKyBi
L2luY2x1ZGUvdXJjdS9yY3VsZmhhc2guaAo+IEBAIC01NDYsMjIgKzU0NiwyMiBAQCB2b2lkIGNk
c19sZmh0X3Jlc2l6ZShzdHJ1Y3QgY2RzX2xmaHQgKmh0LCB1bnNpZ25lZCBsb25nIG5ld19zaXpl
KTsKPiAgIAo+ICAgI2RlZmluZSBjZHNfbGZodF9mb3JfZWFjaF9lbnRyeShodCwgaXRlciwgcG9z
LCBtZW1iZXIpCQkJXAo+ICAgCWZvciAoY2RzX2xmaHRfZmlyc3QoaHQsIGl0ZXIpLAkJCQkJXAo+
IC0JCQlwb3MgPSBjYWFfY29udGFpbmVyX29mKGNkc19sZmh0X2l0ZXJfZ2V0X25vZGUoaXRlciks
IFwKPiAtCQkJCQlfX3R5cGVvZl9fKCoocG9zKSksIG1lbWJlcik7CVwKPiAtCQljZHNfbGZodF9p
dGVyX2dldF9ub2RlKGl0ZXIpICE9IE5VTEw7CQkJXAo+ICsJCQlwb3MgPSAoY2RzX2xmaHRfaXRl
cl9nZXRfbm9kZShpdGVyKSAhPSBOVUxMID8gY2FhX2NvbnRhaW5lcl9vZihjZHNfbGZodF9pdGVy
X2dldF9ub2RlKGl0ZXIpLCBcCj4gKwkJCQkJX190eXBlb2ZfXygqKHBvcykpLCBtZW1iZXIpIDog
TlVMTCk7CVwKPiArCQlwb3MgIT0gTlVMTDsJCQlcCj4gICAJCWNkc19sZmh0X25leHQoaHQsIGl0
ZXIpLAkJCQlcCj4gLQkJCXBvcyA9IGNhYV9jb250YWluZXJfb2YoY2RzX2xmaHRfaXRlcl9nZXRf
bm9kZShpdGVyKSwgXAo+IC0JCQkJCV9fdHlwZW9mX18oKihwb3MpKSwgbWVtYmVyKSkKPiArCQkJ
cG9zID0gKGNkc19sZmh0X2l0ZXJfZ2V0X25vZGUoaXRlcikgIT0gTlVMTCA/IGNhYV9jb250YWlu
ZXJfb2YoY2RzX2xmaHRfaXRlcl9nZXRfbm9kZShpdGVyKSwgXAo+ICsJCQkJCV9fdHlwZW9mX18o
Kihwb3MpKSwgbWVtYmVyKSA6IE5VTEwpKQo+ICAgCj4gICAjZGVmaW5lIGNkc19sZmh0X2Zvcl9l
YWNoX2VudHJ5X2R1cGxpY2F0ZShodCwgaGFzaCwgbWF0Y2gsIGtleSwJCVwKPiAgIAkJCQlpdGVy
LCBwb3MsIG1lbWJlcikJCQlcCj4gICAJZm9yIChjZHNfbGZodF9sb29rdXAoaHQsIGhhc2gsIG1h
dGNoLCBrZXksIGl0ZXIpLAkJXAo+IC0JCQlwb3MgPSBjYWFfY29udGFpbmVyX29mKGNkc19sZmh0
X2l0ZXJfZ2V0X25vZGUoaXRlciksIFwKPiAtCQkJCQlfX3R5cGVvZl9fKCoocG9zKSksIG1lbWJl
cik7CVwKPiAtCQljZHNfbGZodF9pdGVyX2dldF9ub2RlKGl0ZXIpICE9IE5VTEw7CQkJXAo+ICsJ
CQlwb3MgPSAoY2RzX2xmaHRfaXRlcl9nZXRfbm9kZShpdGVyKSAhPSBOVUxMID8gY2FhX2NvbnRh
aW5lcl9vZihjZHNfbGZodF9pdGVyX2dldF9ub2RlKGl0ZXIpLCBcCj4gKwkJCQkJX190eXBlb2Zf
XygqKHBvcykpLCBtZW1iZXIpIDogTlVMTCk7CVwKPiArCQlwb3MgIT0gTlVMTDsJCQlcCj4gICAJ
CWNkc19sZmh0X25leHRfZHVwbGljYXRlKGh0LCBtYXRjaCwga2V5LCBpdGVyKSwJCVwKPiAtCQkJ
cG9zID0gY2FhX2NvbnRhaW5lcl9vZihjZHNfbGZodF9pdGVyX2dldF9ub2RlKGl0ZXIpLCBcCj4g
LQkJCQkJX190eXBlb2ZfXygqKHBvcykpLCBtZW1iZXIpKQo+ICsJCQlwb3MgPSAoY2RzX2xmaHRf
aXRlcl9nZXRfbm9kZShpdGVyKSAhPSBOVUxMID8gY2FhX2NvbnRhaW5lcl9vZihjZHNfbGZodF9p
dGVyX2dldF9ub2RlKGl0ZXIpLCBcCj4gKwkJCQkJX190eXBlb2ZfXygqKHBvcykpLCBtZW1iZXIp
IDogTlVMTCkpCj4gICAKPiAgICNpZmRlZiBfX2NwbHVzcGx1cwo+ICAgfQoKLS0gCk1hdGhpZXUg
RGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cHM6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGlu
ZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
