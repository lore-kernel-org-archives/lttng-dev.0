From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.8.1 (Linux kernel tracer)
Date: Mon, 3 Oct 2016 16:12:27 +0000 (UTC)
Message-ID: <745214500.43785.1475511147478.JavaMail.zimbra__26856.0015982532$1475511106$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id E31C3A1DC1
 for <lttng-dev@lists.lttng.org>; Mon,  3 Oct 2016 16:12:57 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EEFCD3401FB
 for <lttng-dev@lists.lttng.org>; Mon,  3 Oct 2016 16:12:28 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id sSF6g4wpzk-n for <lttng-dev@lists.lttng.org>;
 Mon,  3 Oct 2016 16:12:27 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9177E34022D
 for <lttng-dev@lists.lttng.org>; Mon,  3 Oct 2016 16:12:27 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id nBkEe3NGHNFo for <lttng-dev@lists.lttng.org>;
 Mon,  3 Oct 2016 16:12:27 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com
 [167.114.142.141])
 by mail.efficios.com (Postfix) with ESMTP id 814253401FB
 for <lttng-dev@lists.lttng.org>; Mon,  3 Oct 2016 16:12:27 +0000 (UTC)
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

VGhlIExUVG5nIG1vZHVsZXMgcHJvdmlkZSBMaW51eCBrZXJuZWwgdHJhY2luZyBjYXBhYmlsaXR5
IHRvIHRoZSBMVFRuZwoyLnggdHJhY2VyIHRvb2xzZXQuCgpUaGlzIGlzIGEgYnVnZml4IHJlbGVh
c2UuCgpQcm9qZWN0IHdlYnNpdGU6IGh0dHA6Ly9sdHRuZy5vcmcKRG9jdW1lbnRhdGlvbjogaHR0
cDovL2x0dG5nLm9yZy9kb2NzCkRvd25sb2FkIGxpbms6IGh0dHA6Ly9sdHRuZy5vcmcvZG93bmxv
YWQKCkNoYW5nZWxvZzoKMjAxNi0xMC0wMyAoTmF0aW9uYWwgVGVjaGllcyBEYXkpIExUVG5nIG1v
ZHVsZXMgMi44LjEKICAgICAgICAqIEZpeDogaGFuZGxlIGxhcmdlIG51bWJlciBvZiBwYWdlcyBv
ciBzdWJidWZmZXJzIHBlciBidWZmZXIKICAgICAgICAqIEZpeDogdW5yZWdpc3RlciBjcHUgaG90
cGx1ZyBub3RpZmllciBvbiBidWZmZXIgYWxsb2MgZXJyb3IKICAgICAgICAqIEZpeDogc2FfZmFt
aWx5IGlzIG9mIHR5cGUgdW5zaWduZWQgc2hvcnQKICAgICAgICAqIEZpeDogY2hlY2sgZm9yIHNp
emVvZiBzYV9mYW1pbHkgdG8gc2F2ZSBzYV9mYW1pbHkgaW4gYWNjZXB0IGFuZCBjb25uZWN0CiAg
ICAgICAgKiBDbGVhbnVwOiByZXVzZSBjb2RlIGluIGFjY2VwdCgpIGFuZCBhY2NlcHQ0KCkgaW5z
dHJ1bWVudGF0aW9uCiAgICAgICAgKiBBZGQgeDg2LTY0IG92ZXJyaWRlIGZvciBhY2NlcHQ0IHN5
c2NhbGwKICAgICAgICAqIEZpeDogdXNlIHByaW50a19vbmNlKCkgZm9yIHdyYXBwZXIgd2Fybmlu
ZyBtZXNzYWdlcwogICAgICAgICogRml4OiBidHJmcyBpbnN0cnVtZW50YXRpb24gZm9yIDQuOCBr
ZXJuZWwKICAgICAgICAqIEZpeDogdXBkYXRlIG1tX3Ztc2NhbiBpbnN0cnVtZW50YXRpb24gZm9y
IGtlcm5lbCA0LjgKICAgICAgICAqIEZpeDogbmFwaSBpbnN0cnVtZW50YXRpb24gZm9yIDQuOCBr
ZXJuZWxzCiAgICAgICAgKiBGaXg6IHVwZGF0ZSBibG9jayBpbnN0cnVtZW50YXRpb24gdG8gY29t
cGlsZSBvbiA0Ljgga2VybmVscwogICAgICAgICogRml4OiB0aW1lciB3cmFwcGVyOiBzdXBwb3J0
IGtlcm5lbHMgPj0gNC44CiAgICAgICAgKiBGaXg6IHg4Ni02NCBhY2NlcHQgaW5zdHJ1bWVudGF0
aW9uCiAgICAgICAgKiBGaXg6IEFkZCBzdXBwb3J0IGZvciA0LjYuNC1ydDgga2VybmVsCiAgICAg
ICAgKiBGaXg6IHVwZGF0ZSBzY3NpIGluc3RydW1lbnRhdGlvbiBmb3IgNC43KyBrZXJuZWxzCiAg
ICAgICAgKiBGaXg6IFVzZSBmc19pbml0Y2FsbCBpbnN0ZWFkIG9mIHJvb3Rmc19pbml0Y2FsbAog
ICAgICAgICogRml4OiBBZGQga2VybmVsIGNvbmZpZ3VyYXRpb24gZm9yIGx0dG5nIGNsb2NrIHBs
dWdpbgogICAgICAgICogRml4OiB0aGUgY2xvY2sgcGx1Z2luIG11c3QgYmUgaW5pdGlhdGVkIGJl
Zm9yZSBmaXJzdCB1c2Ugb2YgdGhlIGNsb2NrCiAgICAgICAgKiBGaXg6IHRlc3RzL0tidWlsZCBm
b3Igb2xkZXIga2VybmVscwogICAgICAgICogRml4OiBhbm5vdGF0ZSBieXRlY29kZSBpbnRlcnBy
ZXRlciBmb3Iga2VybmVsIHN0YWNrIHZhbGlkYXRvcgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZm
aWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
