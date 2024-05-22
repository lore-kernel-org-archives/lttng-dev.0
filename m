Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33DDC25B78
	for <lttng-dev@archiver.kernel.org>; Wed, 22 May 2024 20:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1716408529;
	bh=a8SsPMYXTaFCL8JFuT3ikmikO0CeXAxR9oHAW9kLyDA=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=kF+s9TF8mfYPXXnLfIC0436l1XwSGe7wPwj0Ot0nclETImPoZPdEV7JAQfrnMqtND
	 5QLaJQyfeqppRvVq262sNdAq2j9VrXSOCsjqkI+vUnPApp26IYYRfxUSAo5wKiKXyZ
	 KBgWtjF5Vk950jG73PnwXAHkbMejVVC7/qKF1mufTjUC2VBZPyNx3L3MFJ1ipa1P18
	 SUDAB6CZooHBUklhJ2tlYKShqCNFFqBG+ZUeGcWpfij03gu3Zi0xHpxI9nNCvLC2iZ
	 RX4j3VP1YicFoWkH5sjSuIOSrJiOlhVPMUXs/RdAKT0mO9zABACmqxiy2xwKg14G8g
	 zNkmcfCPplu/w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Vl2SJ3DShz2pqC;
	Wed, 22 May 2024 16:08:48 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:b2ee::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4Vl2SH1QG8z2q26
 for <lttng-dev@lists.lttng.org>; Wed, 22 May 2024 16:08:46 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Vl2SF2BStz10hJ;
 Wed, 22 May 2024 16:08:45 -0400 (EDT)
Message-ID: <4aff9f86-0c2c-430e-8749-786bc94fd750@efficios.com>
Date: Wed, 22 May 2024 16:09:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kienan Stewart <kstewart@efficios.com>,
 Martin Hicks <martin@sr-research.com>, lttng-dev@lists.lttng.org
References: <ZkdnIf/OX995MndN@t14.bork.org>
 <9e00bf4e-1059-402b-9be2-ef407dbdf039@efficios.com>
Content-Language: en-US
In-Reply-To: <9e00bf4e-1059-402b-9be2-ef407dbdf039@efficios.com>
Subject: Re: [lttng-dev] [PATCH] Fix mm_vmscan_lru_isolate tracepoint for
 RHEL 9.4 kernel
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

T24gMjAyNC0wNS0xNyAxMjowNCwgS2llbmFuIFN0ZXdhcnQgdmlhIGx0dG5nLWRldiB3cm90ZToK
PiBIaSBNYXJ0aW4sCj4gCj4gdGhhbmtzIGZvciB0aGUgcGF0Y2guCj4gCj4gSSBjaGFuZ2VkIHRo
ZSB2ZXJzaW9uIHJhbmdlIHNsaWdodGx5LiBUaGUgUkhFTCBrZXJuZWwgNS4xNC4wLTQyNy4xMy4x
IAo+IHN0aWxsIGhhcyB0aGUgYGlzb2xhdGVfbW9kZWAgcGFyYW1ldGVyIGluIHRoZSBgbW1fdm1z
Y2FuX2xydV9pc29sYXRlYCAKPiB0cmFjZXBvaW50OyBpdCB3YXMgb25seSByZW1vdmVkIGluIDUu
MTQuMC00MjcuMTYuMS4KPiAKPiBJIGFsc28gZm9yd2FyZCBwb3J0ZWQgdGhlIHBhdGNoIHRvIHRo
ZSBtYXN0ZXIgYnJhbmNoLgo+IAo+IFRoZSB1cGRhdGVkIHBhdGNoZXMgd2lsbCBiZSByZXZpZXdl
ZCBhdDogCj4gaHR0cHM6Ly9yZXZpZXcubHR0bmcub3JnL3EvdG9waWM6JTIyYnVpbGRmaXgtZWw5
LjQlMjIKCk1lcmdlZCBpbnRvIGx0dG5nLW1vZHVsZXMgbWFzdGVyIGFuZCBzdGFibGUtMi4xMywg
dGhhbmtzIQoKTWF0aGlldQoKPiAKPiB0aGFua3MsCj4ga2llbmFuCj4gCj4gT24gNS8xNy8yNCAx
MDozMCBBTSwgTWFydGluIEhpY2tzIHZpYSBsdHRuZy1kZXYgd3JvdGU6Cj4+Cj4+Cj4+IFJlZGhh
dCBoYXMgbW92ZWQgdG8gdXNpbmcgdGhlIGZvcm1hdCBmaXJzdCBmb3VuZCBpbiB0aGUgNi43IGtl
cm5lbAo+PiBmb3IgdGhlIG1tX3Ztc2Nhbl9scnVfaXNvbGF0ZSB0cmFjZXBvaW50Lgo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBNYXJ0aW4gSGlja3MgPG1hcnRpbkBzci1yZXNlYXJjaC5jb20+Cj4+IC0t
LQo+PiDCoCBpbmNsdWRlL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbW1fdm1zY2FuLmggfCA0ICsr
Ky0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+
Pgo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9pbnN0cnVtZW50YXRpb24vZXZlbnRzL21tX3Ztc2Nh
bi5oIAo+PiBiL2luY2x1ZGUvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9tbV92bXNjYW4uaAo+PiBp
bmRleCBlYTZmNGI3Li40OWE5ZWFlIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2luc3RydW1lbnRh
dGlvbi9ldmVudHMvbW1fdm1zY2FuLmgKPj4gKysrIGIvaW5jbHVkZS9pbnN0cnVtZW50YXRpb24v
ZXZlbnRzL21tX3Ztc2Nhbi5oCj4+IEBAIC0zNjksNyArMzY5LDkgQEAgTFRUTkdfVFJBQ0VQT0lO
VF9FVkVOVF9NQVAobW1fc2hyaW5rX3NsYWJfZW5kLAo+PiDCoCApCj4+IMKgICNlbmRpZgo+PiAt
I2lmIChMVFROR19MSU5VWF9WRVJTSU9OX0NPREUgPj0gTFRUTkdfS0VSTkVMX1ZFUlNJT04oNiw3
LDApKQo+PiArI2lmIChMVFROR19MSU5VWF9WRVJTSU9OX0NPREUgPj0gTFRUTkdfS0VSTkVMX1ZF
UlNJT04oNiw3LDApIHx8IFwKPj4gK8KgwqDCoMKgIExUVE5HX1JIRUxfS0VSTkVMX1JBTkdFKDUs
MTQsMCw0MjcsMCwwLCA1LDE1LDAsMCwwLDApKQo+PiArCj4+IMKgIExUVE5HX1RSQUNFUE9JTlRf
RVZFTlQobW1fdm1zY2FuX2xydV9pc29sYXRlLAo+PiDCoMKgwqDCoMKgIFRQX1BST1RPKGludCBj
bGFzc3pvbmVfaWR4LAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwczovL3d3dy5l
ZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
