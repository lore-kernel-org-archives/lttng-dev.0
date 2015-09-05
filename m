From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 2/3] Fix: relay:
 viewer_get_next_index handle null vstream
Date: Sat, 5 Sep 2015 12:13:53 -0400
Message-ID: <CA+jJMxsEW_o3Ztky6_ncA7MdVw=qDKTAOXiAk3ZOvv6KjqtqFw__43603.132866747$1441469679$gmane$org@mail.gmail.com>
References: <1441315050-17271-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1441315050-17271-2-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZYG6J-0002iT-1V
 for lttng-dev@lists.lttng.org; Sat, 05 Sep 2015 12:13:59 -0400
Received: by ykek143 with SMTP id k143so47160350yke.2
 for <lttng-dev@lists.lttng.org>; Sat, 05 Sep 2015 09:13:53 -0700 (PDT)
In-Reply-To: <1441315050-17271-2-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFRodSwgU2VwIDMsIDIwMTUgYXQgNToxNyBQ
TSwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4gd3Jv
dGU6Cj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJz
QGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5jIHwgOCAr
KysrKy0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUuYyBiL3NyYy9iaW4v
bHR0bmctcmVsYXlkL2xpdmUuYwo+IGluZGV4IDJkMGI2ODcuLmViNTc0MjEgMTAwNjQ0Cj4gLS0t
IGEvc3JjL2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5jCj4gKysrIGIvc3JjL2Jpbi9sdHRuZy1yZWxh
eWQvbGl2ZS5jCj4gQEAgLTE0NTQsOSArMTQ1NCwxMSBAQCBzZW5kX3JlcGx5Ogo+ICAgICAgICAg
fQo+ICAgICAgICAgaGVhbHRoX2NvZGVfdXBkYXRlKCk7Cj4KPiAtICAgICAgIERCRygiSW5kZXgg
JSIgUFJJdTY0ICIgZm9yIHN0cmVhbSAlIiBQUkl1NjQgIiBzZW50IiwKPiAtICAgICAgICAgICAg
ICAgICAgICAgICB2c3RyZWFtLT5sYXN0X3NlbnRfaW5kZXgsCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgdnN0cmVhbS0+c3RyZWFtLT5zdHJlYW1faGFuZGxlKTsKPiArICAgICAgIGlmICh2c3Ry
ZWFtKSB7Cj4gKyAgICAgICAgICAgICAgIERCRygiSW5kZXggJSIgUFJJdTY0ICIgZm9yIHN0cmVh
bSAlIiBQUkl1NjQgIiBzZW50IiwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZz
dHJlYW0tPmxhc3Rfc2VudF9pbmRleCwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHZzdHJlYW0tPnN0cmVhbS0+c3RyZWFtX2hhbmRsZSk7Cj4gKyAgICAgICB9Cj4gIGVuZDoKPiAg
ICAgICAgIGlmIChtZXRhZGF0YV92aWV3ZXJfc3RyZWFtKSB7Cj4gICAgICAgICAgICAgICAgIHZp
ZXdlcl9zdHJlYW1fcHV0KG1ldGFkYXRhX3ZpZXdlcl9zdHJlYW0pOwo+IC0tCj4gMi4xLjQKPgoK
CgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNp
b3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
