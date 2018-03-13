From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Cleanup: comment about
 CONFIG_HOTPLUG_CPU ifdef
Date: Tue, 13 Mar 2018 12:19:28 -0400 (EDT)
Message-ID: <1328641673.8936.1520957968742.JavaMail.zimbra__16931.4245730222$1520957856$gmane$org@efficios.com>
References: <1520957683-18969-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 4010Rj6TZbzvV
 for <lttng-dev@lists.lttng.org>; Tue, 13 Mar 2018 12:19:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5A84A41D4F7
 for <lttng-dev@lists.lttng.org>; Tue, 13 Mar 2018 12:19:29 -0400 (EDT)
In-Reply-To: <1520957683-18969-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGludG8gbWFzdGVyLCAyLjksIDIuMTAsCgpUaGFua3MhCgpNYXRoaWV1CgotLS0tLSBP
biBNYXIgMTMsIDIwMTgsIGF0IDEyOjE0IFBNLCBNaWNoYWVsIEplYW5zb24gbWplYW5zb25AZWZm
aWNpb3MuY29tIHdyb3RlOgoKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFu
c29uQGVmZmljaW9zLmNvbT4KPiAtLS0KPiBsdHRuZy1ldmVudHMuYyB8IDQgKystLQo+IDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL2x0dG5nLWV2ZW50cy5jIGIvbHR0bmctZXZlbnRzLmMKPiBpbmRleCAyY2Q2NTBmLi42MDk4
Y2U0IDEwMDY0NAo+IC0tLSBhL2x0dG5nLWV2ZW50cy5jCj4gKysrIGIvbHR0bmctZXZlbnRzLmMK
PiBAQCAtMjc2MCw3ICsyNzYwLDcgQEAgc3RhdGljIHZvaWQgX19leGl0IGx0dG5nX2V4aXRfY3B1
X2hvdHBsdWcodm9pZCkKPiAJY3B1aHBfcmVtb3ZlX211bHRpX3N0YXRlKGx0dG5nX2hwX3ByZXBh
cmUpOwo+IH0KPiAKPiAtI2Vsc2UgLyogI2lmIChDT05GSUdfSE9UUExVR19DUFUgJiYgKExJTlVY
X1ZFUlNJT05fQ09ERSA+PQo+IEtFUk5FTF9WRVJTSU9OKDQsMTAsMCkpKSAqLwo+ICsjZWxzZSAv
KiAjaWYgKExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig0LDEwLDApKSAqLwo+
IHN0YXRpYyBpbnQgbHR0bmdfaW5pdF9jcHVfaG90cGx1Zyh2b2lkKQo+IHsKPiAJcmV0dXJuIDA7
Cj4gQEAgLTI3NjgsNyArMjc2OCw3IEBAIHN0YXRpYyBpbnQgbHR0bmdfaW5pdF9jcHVfaG90cGx1
Zyh2b2lkKQo+IHN0YXRpYyB2b2lkIGx0dG5nX2V4aXRfY3B1X2hvdHBsdWcodm9pZCkKPiB7Cj4g
fQo+IC0jZW5kaWYgLyogI2Vsc2UgI2lmIChDT05GSUdfSE9UUExVR19DUFUgJiYgKExJTlVYX1ZF
UlNJT05fQ09ERSA+PQo+IEtFUk5FTF9WRVJTSU9OKDQsMTAsMCkpKSAqLwo+ICsjZW5kaWYgLyog
I2Vsc2UgI2lmIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNCwxMCwwKSkg
Ki8KPiAKPiAKPiBzdGF0aWMgaW50IF9faW5pdCBsdHRuZ19ldmVudHNfaW5pdCh2b2lkKQo+IC0t
Cj4gMi43LjQKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cu
ZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
