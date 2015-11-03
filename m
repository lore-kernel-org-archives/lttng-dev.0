From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2 stable-2.6] Fix: rculfhash
 should not include specific rcu flavor
Date: Tue, 3 Nov 2015 10:52:03 -0500
Message-ID: <CA+jJMxvp2t=5tFS61zzyYJBANzwYTNSrL9_dvDUaNb+KC_PmmQ__7085.86729965663$1446566004$gmane$org@mail.gmail.com>
References: <1446062158-1807-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZtdsW-0006bb-SF
 for lttng-dev@lists.lttng.org; Tue, 03 Nov 2015 10:52:11 -0500
Received: by ykdr3 with SMTP id r3so22422666ykd.1
 for <lttng-dev@lists.lttng.org>; Tue, 03 Nov 2015 07:52:03 -0800 (PST)
In-Reply-To: <1446062158-1807-1-git-send-email-mathieu.desnoyers@efficios.com>
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

Qm90aCBwYXRjaGVzIG1lcmdlZCBpbiBzdGFibGUtMi42LCB0aGFua3MhCgpKw6lyw6ltaWUKCk9u
IFdlZCwgT2N0IDI4LCAyMDE1IGF0IDM6NTUgUE0sIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1
LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IE1hdGhpZXUg
RGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9j
b21tb24vaGFzaHRhYmxlL3JjdWxmaGFzaC5jIHwgMyArKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9jb21tb24v
aGFzaHRhYmxlL3JjdWxmaGFzaC5jIGIvc3JjL2NvbW1vbi9oYXNodGFibGUvcmN1bGZoYXNoLmMK
PiBpbmRleCBmZjdlNjgxLi5lMTFjNjU0IDEwMDY0NAo+IC0tLSBhL3NyYy9jb21tb24vaGFzaHRh
YmxlL3JjdWxmaGFzaC5jCj4gKysrIGIvc3JjL2NvbW1vbi9oYXNodGFibGUvcmN1bGZoYXNoLmMK
PiBAQCAtMjY0LDkgKzI2NCwxMCBAQAo+ICAjaW5jbHVkZSA8c3RkaW50Lmg+Cj4gICNpbmNsdWRl
IDxzdHJpbmcuaD4KPiAgI2luY2x1ZGUgPHNjaGVkLmg+Cj4gKyNpbmNsdWRlIDx1bmlzdGQuaD4K
Pgo+ICAjaW5jbHVkZSAiY29uZmlnLmgiCj4gLSNpbmNsdWRlIDx1cmN1Lmg+Cj4gKyNpbmNsdWRl
IDx1cmN1LXBvaW50ZXIuaD4KPiAgI2luY2x1ZGUgPHVyY3UtY2FsbC1yY3UuaD4KPiAgI2luY2x1
ZGUgPHVyY3UvYXJjaC5oPgo+ICAjaW5jbHVkZSA8dXJjdS91YXRvbWljLmg+Cj4gLS0KPiAyLjEu
NAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5l
ZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
