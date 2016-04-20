From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 0/4] Allow discard buffers in
	snapshot sessions
Date: Wed, 20 Apr 2016 11:19:56 -0400
Message-ID: <1461165600-17288-1-git-send-email-mathieu.desnoyers__14866.725941147$1461165629$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id ED9A2A062A
 for <lttng-dev@lists.lttng.org>; Wed, 20 Apr 2016 15:20:04 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

VGhpcyBwYXRjaHNldCBhbGxvd3MgdXNlcnMgdG8gb3ZlcnJpZGUgdGhlIGNoYW5uZWwgbW9kZQoo
ZGlzY2FyZC9vdmVyd3JpdGUpIGZvciBzbmFwc2hvdCBzZXNzaW9ucyBmb3IgYm90aCBsdHRuZy11
c3QgYW5kIGx0dG5nCmtlcm5lbCB0cmFjaW5nLiBQcmV2aW91c2x5LCBzbmFwc2hvdCBzZXNzaW9u
cyB3ZXJlIGVuZm9yY2luZyBvdmVyd3JpdGUKYnVmZmVyIHR5cGVzLgoKVGhhbmtzLAoKTWF0aGll
dQoKTWF0aGlldSBEZXNub3llcnMgKDQpOgogIEZpeDogdmFsaWRhdGUgbnVtYmVyIG9mIHN1YmJ1
ZmZlcnMgYWZ0ZXIgdHdlYWtpbmcgcHJvcGVydGllcwogIEFsbG93IGNoYW5uZWwgbW9kZSBvdmVy
cmlkZSBpbiBzbmFwc2hvdCBzZXNzaW9ucwogIHRlc3RzOiB0ZXN0IGtlcm5lbCBzbmFwc2hvdCB3
aXRoIGRpc2NhcmQgYnVmZmVycwogIHRlc3RzOiB0ZXN0IHVzdCBzbmFwc2hvdCB3aXRoIGRpc2Nh
cmQgYnVmZmVycwoKIGluY2x1ZGUvbHR0bmcvY2hhbm5lbC5oICAgICAgICAgICAgICAgICAgICAg
IHwgICAyICstCiBzcmMvYmluL2x0dG5nLXNlc3Npb25kL2NoYW5uZWwuYyAgICAgICAgICAgICB8
ICA1NSArKysrKysrKystCiBzcmMvYmluL2x0dG5nLXNlc3Npb25kL2NtZC5jICAgICAgICAgICAg
ICAgICB8ICAxMCAtLQogc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9jcmVhdGUuYyAgICAgICAgICAg
ICAgfCAgIDIgKy0KIHNyYy9jb21tb24vZGVmYXVsdHMuaCAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAyICstCiB0ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL3NuYXBzaG90cy90ZXN0X2tlcm5lbCB8
ICA5NCArKysrKysrKysrKysrKysrLQogdGVzdHMvcmVncmVzc2lvbi90b29scy9zbmFwc2hvdHMv
dXN0X3Rlc3QgICAgfCAxNTAgKysrKysrKysrKysrKysrKysrKysrKysrKystCiB0ZXN0cy91dGls
cy91dGlscy5zaCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzMCArKysrKysKIDggZmlsZXMg
Y2hhbmdlZCwgMzIxIGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQoKLS0gCjIuMS40Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYg
bWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
