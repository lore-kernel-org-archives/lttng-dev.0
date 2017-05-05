From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: remove
 CONFIG_KALLSYMS_ALL warning on clean
Date: Fri, 5 May 2017 17:33:11 +0000 (UTC)
Message-ID: <73734197.29168.1494005591515.JavaMail.zimbra__11226.3770578013$1494005487$gmane$org@efficios.com>
References: <1494000487-27369-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wKJqW37rDzC3y
 for <lttng-dev@lists.lttng.org>; Fri,  5 May 2017 17:32:07 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5F93934034E
 for <lttng-dev@lists.lttng.org>; Fri,  5 May 2017 17:33:16 +0000 (UTC)
In-Reply-To: <1494000487-27369-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkIGludG8gbWFzdGVyLCAyLjksIDIuOCwgdGhhbmtzIQoKTWF0aGlldQoKLS0tLS0gT24g
TWF5IDUsIDIwMTcsIGF0IDEyOjA4IFBNLCBNaWNoYWVsIEplYW5zb24gbWplYW5zb25AZWZmaWNp
b3MuY29tIHdyb3RlOgoKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29u
QGVmZmljaW9zLmNvbT4KPiAtLS0KPiBwcm9iZXMvS2J1aWxkIHwgNCArKystCj4gMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9w
cm9iZXMvS2J1aWxkIGIvcHJvYmVzL0tidWlsZAo+IGluZGV4IGJmMTRjNzUuLmE0ZjZiMzIgMTAw
NjQ0Cj4gLS0tIGEvcHJvYmVzL0tidWlsZAo+ICsrKyBiL3Byb2Jlcy9LYnVpbGQKPiBAQCAtMjQz
LDcgKzI0Myw5IEBAIGlmbmVxICgkKENPTkZJR19LQUxMU1lNU19BTEwpLCkKPiAgICAgICAtbyBc
KCAkKFZFUlNJT04pIC1lcSAyIC1hICQoUEFUQ0hMRVZFTCkgLWVxIDYgLWEgJChTVUJMRVZFTCkg
LWdlIDM2IFwpIF0gOyB0aGVuCj4gICAgICAgXAo+ICAgICAgIGVjaG8gImx0dG5nLXByb2JlLXdy
aXRlYmFjay5vIiA7IGZpOykKPiBlbHNlCj4gLSAgJCh3YXJuaW5nIENPTkZJR19LQUxMU1lNU19B
TEwgaXMgZGlzYWJsZWQsIHRoZXJlZm9yZSBwcm9iZSAid3JpdGViYWNrIiBpcwo+IGRpc2FibGVk
LiBSZWJ1aWxkIHlvdXIga2VybmVsIHdpdGggdGhpcyBjb25maWd1cmF0aW9uIG9wdGlvbiBlbmFi
bGVkIGluIG9yZGVyCj4gdG8gdHJhY2UgdGhpcyBzdWJzeXN0ZW0uKQo+ICsgIGlmZGVmIENPTkZJ
R19MT0NBTFZFUlNJT04gIyBDaGVjayBpZiBkb3QtY29uZmlnIGlzIGluY2x1ZGVkLgo+ICsgICAg
JCh3YXJuaW5nIENPTkZJR19LQUxMU1lNU19BTEwgaXMgZGlzYWJsZWQsIHRoZXJlZm9yZSBwcm9i
ZSAid3JpdGViYWNrIiBpcwo+IGRpc2FibGVkLiBSZWJ1aWxkIHlvdXIga2VybmVsIHdpdGggdGhp
cyBjb25maWd1cmF0aW9uIG9wdGlvbiBlbmFibGVkIGluIG9yZGVyCj4gdG8gdHJhY2UgdGhpcyBz
dWJzeXN0ZW0uKQo+ICsgIGVuZGlmCj4gZW5kaWYgIyBDT05GSUdfS0FMTFNZTVNfQUxMCj4gCj4g
aWZuZXEgKCQoQ09ORklHX0tQUk9CRVMpLCkKPiAtLQo+IDIuNy40CgotLSAKTWF0aGlldSBEZXNu
b3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
