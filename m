From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Add rcu_read_ongoing()
	assertions around process_client_msg
Date: Tue, 8 Sep 2015 08:24:47 -0400
Message-ID: <CA+jJMxt-VS0vVECg2P8VOmw9bhPsgByvrG8fWAZMjPJ165H4HA__26653.1276553453$1441715157$gmane$org@mail.gmail.com>
References: <1441636569-3488-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZZHxF-0006Yp-63
 for lttng-dev@lists.lttng.org; Tue, 08 Sep 2015 08:24:56 -0400
Received: by ykdg206 with SMTP id g206so115241027ykd.1
 for <lttng-dev@lists.lttng.org>; Tue, 08 Sep 2015 05:24:47 -0700 (PDT)
In-Reply-To: <1441636569-3488-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIE1vbiwgU2VwIDcsIDIwMTUgYXQgMTA6MzYg
QU0sIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdy
b3RlOgo+IHByb2Nlc3NfY2xpZW50X21zZyBlbnN1cmVzIHRoYXQgUkNVIHJlYWQtc2lkZSBsb2Nr
IHNob3VsZCBub3QgYmUgaGVsZAo+IHdoZW4gY2FsbGluZyBpdC4gVmFsaWRhdGUgdGhpcyB1c2lu
ZyByY3VfcmVhZF9vbmdvaW5nKCkgYXQgdGhlIGVudHJ5IGFuZAo+IGV4aXQgcG9pbnRzIG9mIHRo
aXMgZnVuY3Rpb24uIFRoaXMgYWxsb3dzIHVzIHRvIGNhdGNoIHVuYmFsYW5jZWQgUkNVCj4gcmVh
ZC1zaWRlIGxvY2sgd2l0aGluIGNvbW1hbmRzIHF1aWNrbHkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBN
YXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+
ICBzcmMvYmluL2x0dG5nLXNlc3Npb25kL21haW4uYyB8IDMgKysrCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nLXNlc3Npb25k
L21haW4uYyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5jCj4gaW5kZXggN2M0OGU0ZC4u
MGU3ZGU2ZSAxMDA2NDQKPiAtLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21haW4uYwo+ICsr
KyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5jCj4gQEAgLTI5NzIsNiArMjk3Miw4IEBA
IHN0YXRpYyBpbnQgcHJvY2Vzc19jbGllbnRfbXNnKHN0cnVjdCBjb21tYW5kX2N0eCAqY21kX2N0
eCwgaW50IHNvY2ssCj4KPiAgICAgICAgIERCRygiUHJvY2Vzc2luZyBjbGllbnQgY29tbWFuZCAl
ZCIsIGNtZF9jdHgtPmxzbS0+Y21kX3R5cGUpOwo+Cj4gKyAgICAgICBhc3NlcnQoIXJjdV9yZWFk
X29uZ29pbmcoKSk7Cj4gKwo+ICAgICAgICAgKnNvY2tfZXJyb3IgPSAwOwo+Cj4gICAgICAgICBz
d2l0Y2ggKGNtZF9jdHgtPmxzbS0+Y21kX3R5cGUpIHsKPiBAQCAtNDA1OSw2ICs0MDYxLDcgQEAg
c2V0dXBfZXJyb3I6Cj4gICAgICAgICAgICAgICAgIHNlc3Npb25fdW5sb2NrX2xpc3QoKTsKPiAg
ICAgICAgIH0KPiAgaW5pdF9zZXR1cF9lcnJvcjoKPiArICAgICAgIGFzc2VydCghcmN1X3JlYWRf
b25nb2luZygpKTsKPiAgICAgICAgIHJldHVybiByZXQ7Cj4gIH0KPgo+IC0tCj4gMi4xLjQKPgoK
CgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNp
b3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
