From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: relayd: unbalanced RCU
	read-side lock/unlock
Date: Thu, 27 Nov 2014 17:31:03 -0500
Message-ID: <CA+jJMxt_gShcg55V0eKb0dkpzwt_f82Sta=vEG2rZxw+fjgPuQ__42955.425536684$1417127497$gmane$org@mail.gmail.com>
References: <1416591517-7953-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Xu7ae-0002jt-Ph
 for lttng-dev@lists.lttng.org; Thu, 27 Nov 2014 17:31:09 -0500
Received: by mail-qc0-f171.google.com with SMTP id r5so4175396qcx.30
 for <lttng-dev@lists.lttng.org>; Thu, 27 Nov 2014 14:31:03 -0800 (PST)
In-Reply-To: <1416591517-7953-1-git-send-email-mathieu.desnoyers@efficios.com>
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
diAyMSwgMjAxNCBhdCAxMjozOCBQTSwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhpZXUuZGVzbm95
ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3ll
cnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2Jpbi9sdHRu
Zy1yZWxheWQvbGl2ZS5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nLXJlbGF5ZC9saXZl
LmMgYi9zcmMvYmluL2x0dG5nLXJlbGF5ZC9saXZlLmMKPiBpbmRleCBhNzZmNTMwLi45M2Q0NThi
IDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUuYwo+ICsrKyBiL3NyYy9i
aW4vbHR0bmctcmVsYXlkL2xpdmUuYwo+IEBAIC0xMzE4LDcgKzEzMTgsNyBAQCBpbnQgdmlld2Vy
X2dldF9uZXh0X2luZGV4KHN0cnVjdCByZWxheV9jb25uZWN0aW9uICpjb25uKQo+ICAgICAgICAg
cmV0ID0gY2hlY2tfaW5kZXhfc3RhdHVzKHZzdHJlYW0sIHJzdHJlYW0sIGN0Zl90cmFjZSwgJnZp
ZXdlcl9pbmRleCk7Cj4gICAgICAgICBwdGhyZWFkX211dGV4X3VubG9jaygmcnN0cmVhbS0+dmll
d2VyX3N0cmVhbV9yb3RhdGlvbl9sb2NrKTsKPiAgICAgICAgIGlmIChyZXQgPCAwKSB7Cj4gLSAg
ICAgICAgICAgICAgIGdvdG8gZW5kOwo+ICsgICAgICAgICAgICAgICBnb3RvIGVuZF91bmxvY2s7
Cj4gICAgICAgICB9IGVsc2UgaWYgKHJldCA9PSAxKSB7Cj4gICAgICAgICAgICAgICAgIC8qCj4g
ICAgICAgICAgICAgICAgICAqIFRoaXMgbWVhbnMgdGhlIHZpZXdlciBpbmRleCBkYXRhIHN0cnVj
dHVyZSBoYXMgYmVlbiBwb3B1bGF0ZWQgYnkgdGhlCj4gLS0KPiAyLjEuMQo+CgoKCi0tIApKw6ly
w6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
