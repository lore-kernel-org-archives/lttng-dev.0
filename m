From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.7.4 and lttng-modules 2.7.4
 (Linux user-space and kernel tracers)
Date: Fri, 20 May 2016 21:07:17 +0000 (UTC)
Message-ID: <1210027049.15150.1463778437928.JavaMail.zimbra__27141.0107183785$1463778465$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 3DD2CA3626
 for <lttng-dev@lists.lttng.org>; Fri, 20 May 2016 21:07:24 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0ADD9340305
 for <lttng-dev@lists.lttng.org>; Fri, 20 May 2016 21:07:24 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 7VuPoXUD-MEH for <lttng-dev@lists.lttng.org>;
 Fri, 20 May 2016 21:07:18 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3F3723403AF
 for <lttng-dev@lists.lttng.org>; Fri, 20 May 2016 21:07:18 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id XzKekW5pRDMH for <lttng-dev@lists.lttng.org>;
 Fri, 20 May 2016 21:07:18 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 215C6340305
 for <lttng-dev@lists.lttng.org>; Fri, 20 May 2016 21:07:18 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGksCgpIZXJlIGlzIGEgcmVsZWFzZSBhbm5vdW5jZW1lbnQgb2YgYnVnZml4IHJlbGVhc2VzIGZv
ciBsdHRuZyB1c3QgYW5kCmx0dG5nIG1vZHVsZXMuCgpMVFRuZy1VU1QsIHRoZSBMaW51eCBUcmFj
ZSBUb29sa2l0IE5leHQgR2VuZXJhdGlvbiBVc2Vyc3BhY2UgVHJhY2VyLAppcyBhIGxvdy1vdmVy
aGVhZCBhcHBsaWNhdGlvbiB0cmFjZXIuIFRoZSBsaWJyYXJ5ICJsaWJsdHRuZy11c3QiIGVuYWJs
ZXMKdHJhY2luZyBvZiBhcHBsaWNhdGlvbnMgYW5kIGxpYnJhcmllcy4KClRoZSBMVFRuZyBtb2R1
bGVzIHByb3ZpZGUgTGludXgga2VybmVsIHRyYWNpbmcgY2FwYWJpbGl0eSB0byB0aGUgTFRUbmcK
Mi54IHRyYWNlciB0b29sc2V0LgoKUHJvamVjdCB3ZWJzaXRlOiBodHRwOi8vbHR0bmcub3JnCkRv
Y3VtZW50YXRpb246IGh0dHA6Ly9sdHRuZy5vcmcvZG9jcwpEb3dubG9hZCBsaW5rOiBodHRwOi8v
bHR0bmcub3JnL2Rvd25sb2FkCgpDaGFuZ2Vsb2cgTFRUbmctVVNUOgoKMjAxNi0wNS0yMCAoQmlr
ZS10by1Xb3JrIERheSkgbHR0bmctdXN0IDIuNy40CiAgICAgICAgKiBQcmludCBEQkcoKSBtZXNz
YWdlIGFib3V0IGNvbXBpbGVyIHdlYWsgaGlkZGVuIHN5bWJvbCBiZWhhdmlvcgogICAgICAgICog
RG9jdW1lbnRhdGlvbjogcmluZyBidWZmZXI6IFNXSVRDSF9GTFVTSCBjYW4gYmUgdXNlZCB3aGVu
IGFjdGl2ZQogICAgICAgICogRml4OiB1bmNoZWNrZWQgcmV0dXJuIHZhbHVlIGluIHRyYWNlX2Ns
b2NrX3JlYWQ2NF9tb25vdG9uaWMKICAgICAgICAqIEZpeDogSmF2YSBhZ2VudCBzaG91bGQgdXNl
IExUVE5HX0hPTUUKICAgICAgICAqIEZpeDogZXhhbXBsZXMgbWFrZSBkaXN0Y2hlY2sgZmFpbHVy
ZQogICAgICAgICogRml4OiBlbmRpYW5uZXNzIG9mIGludGVnZXJzIHJlY2VpdmVkIGJ5IGZpbHRl
cgoKQ2hhbmdlbG9nIExUVG5nIG1vZHVsZXM6CgoyMDE2LTA1LTIwIChCaWtlLXRvLVdvcmsgRGF5
KSBMVFRuZyBtb2R1bGVzIDIuNy40CiAgICAgICAgKiBGaXg6IHJpbmcgYnVmZmVyOiBob25vciBz
d2l0Y2ggcGFyYW1ldGVyIHR5cGUgaW4gcmVtb3RlIHN3aXRjaAogICAgICAgICogRml4OiBvbmx5
IGZsdXNoIG5vbi1tZXRhZGF0YSBjaGFubmVscwogICAgICAgICogRml4OiBkb24ndCBwZXJmb3Jt
IGV4dHJhIGZsdXNoIG9uIG1ldGFkYXRhIGNoYW5uZWwKICAgICAgICAqIEZpeDogZmx1c2ggZW1w
dHkgcGFja2V0cyBvbiBzbmFwc2hvdCBjaGFubmVsCiAgICAgICAgKiBGaXg6IGRvIG5vdCBnZW5l
cmF0ZSBwYWNrZXQgYXQgZGVzdHJveSBhZnRlciBzdG9wCiAgICAgICAgKiBGaXg6IGNvbXBhdCBp
b2N0bCBmb3IgZmx1c2gvZ2V0IG1ldGFkYXRhIHZlcnNpb24KICAgICAgICAqIEZpeDogY3RmX3N0
cmluZygpIHNob3VsZCBoYW5kbGUgTlVMTCBwb2ludGVycwogICAgICAgICogRml4OiBhZGQgbW9k
dWxlcyB0YXJnZXQgdG8gYmFzZSBNYWtlZmlsZQogICAgICAgICogRml4OiBtYWtlIGNsZWFuIGRv
ZXMgbm90IGluY2x1ZGUgZG90LWNvbmZpZwogICAgICAgICogRml4OiB0cmlnZ2VyIGJ1aWxkIGVy
cm9yIGlmIENPTkZJR19UUkFDRVBPSU5UUyBpcyBub3Qgc2V0CiAgICAgICAgKiBGaXg6IG1tX3Bh
Z2VfYWxsb2NfZXh0ZnJhZyBpbnN0cnVtZW50YXRpb24gZm9yIGtlcm5lbCAzLjE2LjM1CiAgICAg
ICAgKiBGaXg6IGludGVnZXIgZW5kaWFubmVzcyBtZXRhZGF0YSBnZW5lcmF0aW9uCiAgICAgICAg
KiBGaXg6IGVuZGlhbm5lc3Mgb2YgaW50ZWdlcnMgcmVjZWl2ZWQgYnkgZmlsdGVyCgotLSAKTWF0
aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
