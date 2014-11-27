From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: relayd: unbalanced RCU
	read lock/unlock
Date: Thu, 27 Nov 2014 17:33:15 -0500
Message-ID: <CA+jJMxug_UvZU9MC2igjT-PkG9VNN4CY=gS38iqVQ6Vb3VhCbA__34915.2225222953$1417127629$gmane$org@mail.gmail.com>
References: <1416591725-8204-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Xu7cm-0002pi-Sp
 for lttng-dev@lists.lttng.org; Thu, 27 Nov 2014 17:33:21 -0500
Received: by mail-qc0-f181.google.com with SMTP id m20so4054233qcx.26
 for <lttng-dev@lists.lttng.org>; Thu, 27 Nov 2014 14:33:15 -0800 (PST)
In-Reply-To: <1416591725-8204-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGFsbCB0aGUgd2F5IHRvIDIuNCwgdGhhbmtzIQoKSsOpcsOpbWllCgpPbiBGcmksIE5v
diAyMSwgMjAxNCBhdCAxMjo0MiBQTSwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhpZXUuZGVzbm95
ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3ll
cnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2Jpbi9sdHRu
Zy1yZWxheWQvbWFpbi5jIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+
Cj4gZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctcmVsYXlkL21haW4uYyBiL3NyYy9iaW4vbHR0
bmctcmVsYXlkL21haW4uYwo+IGluZGV4IDAzZWExMDguLmM5ZjIwMjEgMTAwNjQ0Cj4gLS0tIGEv
c3JjL2Jpbi9sdHRuZy1yZWxheWQvbWFpbi5jCj4gKysrIGIvc3JjL2Jpbi9sdHRuZy1yZWxheWQv
bWFpbi5jCj4gQEAgLTI2MTYsNiArMjYxNiw3IEBAIHJlc3RhcnQ6Cj4KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGlmIChyZXZlbnRzICYgTFBPTExJTikgewo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoY29ubi0+dHlwZSAhPSBSRUxBWV9EQVRB
KSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmN1
X3JlYWRfdW5sb2NrKCk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY29udGludWU7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIH0KPgo+IC0tCj4gMi4xLjEKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lP
UyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
