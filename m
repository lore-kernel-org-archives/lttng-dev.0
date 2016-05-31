From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace 2/2] Fix: strerror_r behavior is
	glibc specific
Date: Tue, 31 May 2016 01:53:09 -0400
Message-ID: <CA+jJMxuFS=K5COp8zPKgnoV=jusja8ifekPWkTXy74yO7u9cdg__929.936607326631$1464674010$gmane$org@mail.gmail.com>
References: <1464640742-24658-1-git-send-email-mjeanson@efficios.com>
 <1464640742-24658-2-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f66.google.com (mail-qg0-f66.google.com
 [209.85.192.66])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 6C807A3728
 for <lttng-dev@lists.lttng.org>; Tue, 31 May 2016 05:53:10 +0000 (UTC)
Received: by mail-qg0-f66.google.com with SMTP id p34so3036720qgp.0
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2016 22:53:10 -0700 (PDT)
In-Reply-To: <1464640742-24658-2-git-send-email-mjeanson@efficios.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTEuNC4gVGhhbmtzIQoKSsOpcsOpbWllCgpPbiBN
b24sIE1heSAzMCwgMjAxNiBhdCA0OjM5IFBNLCBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVm
ZmljaW9zLmNvbT4gd3JvdGU6Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVh
bnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIGluY2x1ZGUvYmFiZWx0cmFjZS9jb21wYXQvc3Ry
aW5nLmggfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYmFiZWx0cmFjZS9jb21wYXQvc3RyaW5nLmgg
Yi9pbmNsdWRlL2JhYmVsdHJhY2UvY29tcGF0L3N0cmluZy5oCj4gaW5kZXggN2E1NzRlNi4uNjA5
MjYxNiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2JhYmVsdHJhY2UvY29tcGF0L3N0cmluZy5oCj4g
KysrIGIvaW5jbHVkZS9iYWJlbHRyYWNlL2NvbXBhdC9zdHJpbmcuaAo+IEBAIC0yNiw3ICsyNiw3
IEBACj4gICNpbmNsdWRlIDxzdHJpbmcuaD4KPiAgI2luY2x1ZGUgPHN0ZGxpYi5oPgo+Cj4gLSNp
ZiAhZGVmaW5lZChfX2xpbnV4X18pIHx8ICgoX1BPU0lYX0NfU09VUkNFID49IDIwMDExMkwgfHwg
X1hPUEVOX1NPVVJDRSA+PSA2MDApICYmICFkZWZpbmVkKF9HTlVfU09VUkNFKSkKPiArI2lmICFk
ZWZpbmVkKF9fR0xJQkNfXykgfHwgKChfUE9TSVhfQ19TT1VSQ0UgPj0gMjAwMTEyTCB8fCBfWE9Q
RU5fU09VUkNFID49IDYwMCkgJiYgIWRlZmluZWQoX0dOVV9TT1VSQ0UpKQo+Cj4gIC8qIFhTSS1j
b21wbGlhbnQgc3RyZXJyb3JfciAqLwo+ICBzdGF0aWMgaW5saW5lCj4gLS0KPiAyLjcuNAo+CgoK
Ci0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lv
cy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0
bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlz
dHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
