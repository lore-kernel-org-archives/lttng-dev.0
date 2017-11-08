From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules 2.9,
	7 and 2.10.4 (Linux kernel tracer)
Date: Wed, 8 Nov 2017 19:20:23 +0000 (UTC)
Message-ID: <1209041349.11541.1510168823101.JavaMail.zimbra__46411.595613654$1510168812$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3yXGMf0tLMz16yj
 for <lttng-dev@lists.lttng.org>; Wed,  8 Nov 2017 19:19:57 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org
List-Id: lttng-dev@lists.lttng.org

SGksCgpWZXJzaW9ucyAyLjkuNyBhbmQgMi4xMC40IGZpeCBhIE9PUFMgb24gYnVmZmVyIGNyZWF0
aW9uLCB3aGljaApvbmx5IHRyaWdnZXJzIGFmdGVyIG1lbW9yeSBmcmFnbWVudGF0aW9uIGluIHRo
ZSBrZXJuZWwgaXMKc3VmZmljaWVudCB0byBjYXVzZSBhIGxhcmdlIGttYWxsb2MgdG8gZmFpbC4g
VGhpcyBvbmx5IHJlcHJvZHVjZXMKd2hlbiBzdGFydGluZyBrZXJuZWwgdHJhY2luZyBhZnRlciBh
IG1hY2hpbmUgcnVucyBmb3IgYSBmZXcgZGF5cwoodG8gZ2VuZXJhdGUgZW5vdWdoIG1lbW9yeSBm
cmFnbWVudGF0aW9uIGluIHRoZSBrZXJuZWwpLCB3aXRoCmEgc3VmZmljaWVudGx5IGxhcmdlIG51
bWJlciBvZiBzdWItYnVmZmVycywgd2hpY2ggbWFkZSBpdCB0YWtlCmEgd2hpbGUgdG8gc2hvdyB1
cC4KCldlIHBsYW4gdG8gaW1wcm92ZSBvdXIgQ0kgdGVzdGluZyBpbmZyYXN0cnVjdHVyZSB0byBl
eHBsaWNpdGx5CmNvdmVyIGhpZ2ggbWVtb3J5IGZyYWdtZW50YXRpb24gc2NlbmFyaW8sIGluIG9y
ZGVyIHRvIG1ha2Ugc3VyZQp3ZSBjYW4gY2F0Y2ggdGhvc2UgY2FzZXMgYXV0b21hdGljYWxseSBp
biB0aGUgZnV0dXJlLgoKSXQgd291bGQgYmUgcHJlZmVyYWJsZSB0byB1cGdyYWRlIHlvdXIgbHR0
bmctbW9kdWxlcyB0byBhIHZlcnNpb24KY29udGFpbmluZyB0aGlzIGZpeC4KClRoYW5rcywKCk1h
dGhpZXUKClByb2plY3Qgd2Vic2l0ZTogaHR0cDovL2x0dG5nLm9yZwpEb2N1bWVudGF0aW9uOiBo
dHRwOi8vbHR0bmcub3JnL2RvY3MKRG93bmxvYWQgbGluazogaHR0cDovL2x0dG5nLm9yZy9kb3du
bG9hZAoKQ2hhbmdlbG9nOgoKMjAxNy0xMS0wOCAoTmF0aW9uYWwgQ2FwcHVjY2lubyBEYXkpIExU
VG5nIG1vZHVsZXMgMi4xMC40CiAgICAgICAgKiBGaXg6IGx0dG5nX2t2bWFsbG9jIGhlbHBlciBO
VUxMIHBvaW50ZXIgT09QUwoKMjAxNy0xMS0wOCAoTmF0aW9uYWwgQ2FwcHVjY2lubyBEYXkpIExU
VG5nIG1vZHVsZXMgMi45LjcKICAgICAgICAqIEZpeDogbHR0bmdfa3ZtYWxsb2MgaGVscGVyIE5V
TEwgcG9pbnRlciBPT1BTCgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRw
Oi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=
