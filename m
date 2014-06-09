From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: babeltrace test failures on some architectures
Date: Mon, 9 Jun 2014 10:16:40 -0400
Message-ID: <CA+jJMxtn8XiLjT5NVURv5K8kECPPoPs1WF-0zTakJmRW=CO3mg__10000.5983179019$1402323476$gmane$org@mail.gmail.com>
References: <20140604184126.GA26877@helmut>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Wu0NR-0000Tq-Ql
 for lttng-dev@lists.lttng.org; Mon, 09 Jun 2014 10:16:52 -0400
Received: by mail-qa0-f50.google.com with SMTP id j15so7795762qaq.37
 for <lttng-dev@lists.lttng.org>; Mon, 09 Jun 2014 07:16:40 -0700 (PDT)
In-Reply-To: <20140604184126.GA26877@helmut>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jon Bernard <jbernard@debian.org>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgSm9uLAoKV291bGQgaXQgYmUgcG9zc2libGUgdG8gcnVuIHRoZSB0ZXN0cyBvbiB0aGVzZSBt
YWNoaW5lcyBhbmQgcHJvdmlkZQp0aGUgVEFQIG91dHB1dD8KClRoYW5rcywKSsOpcsOpbWllCgpP
biBXZWQsIEp1biA0LCAyMDE0IGF0IDI6NDEgUE0sIEpvbiBCZXJuYXJkIDxqYmVybmFyZEBkZWJp
YW4ub3JnPiB3cm90ZToKPiBJIG5vdGljZWQgYmFiZWx0cmFjZSBpcyBoYXZpbmcgdGVzdCBmYWls
dXJlcyBvbiBhcm1lbCwgaHVyZC1pMzg2LAo+IGtmcmVlYnNkLXthbWQ2NCxpMzg2fSwgYW5kIHNw
YXJjLiAgVGhlc2Ugd2VyZSBwYXNzaW5nIGluIHZlcnNpb24gMS4xIGFuZAo+IHRoZSBmYWlsdXJl
cyBhcHBlYXJlZCBpbiAxLjIuICBIZXJlIGFyZSBsaW5rcyB0byB0aGUgYnVpbGQgbG9nczoKPgo+
ICAgICBhcm1lbDogICAgICAgICAgaHR0cHM6Ly9idWlsZGQuZGViaWFuLm9yZy9zdGF0dXMvZmV0
Y2gucGhwP3BrZz1iYWJlbHRyYWNlJmFyY2g9YXJtZWwmdmVyPTEuMi4xLTImc3RhbXA9MTM5NTg0
NjkxMwo+ICAgICBodXJkLWkzODY6ICAgICAgaHR0cHM6Ly9idWlsZGQuZGViaWFuLm9yZy9zdGF0
dXMvZmV0Y2gucGhwP3BrZz1iYWJlbHRyYWNlJmFyY2g9aHVyZC1pMzg2JnZlcj0xLjIuMS0yJnN0
YW1wPTEzOTgxNTgzOTQKPiAgICAga2ZyZWVic2QtYW1kNjQ6IGh0dHBzOi8vYnVpbGRkLmRlYmlh
bi5vcmcvc3RhdHVzL2FyY2hpdGVjdHVyZS5waHA/YT1rZnJlZWJzZC1hbWQ2NCZzdWl0ZT1zaWQK
PiAgICAga2ZyZWVic2QtaTM4NjogIGh0dHBzOi8vYnVpbGRkLmRlYmlhbi5vcmcvc3RhdHVzL2Zl
dGNoLnBocD9wa2c9YmFiZWx0cmFjZSZhcmNoPWtmcmVlYnNkLWkzODYmdmVyPTEuMi4xLTImc3Rh
bXA9MTM5NTg0MjUxOAo+ICAgICBzcGFyYzogICAgICAgICAgaHR0cHM6Ly9idWlsZGQuZGViaWFu
Lm9yZy9zdGF0dXMvZmV0Y2gucGhwP3BrZz1iYWJlbHRyYWNlJmFyY2g9c3BhcmMmdmVyPTEuMi4x
LTImc3RhbXA9MTM5NTg1OTU0Ngo+Cj4gICAgIGJ1aWxkZCBwYWdlOiAgICBodHRwczovL2J1aWxk
ZC5kZWJpYW4ub3JnL3N0YXR1cy9wYWNrYWdlLnBocD9wPWJhYmVsdHJhY2UKPgo+IENoZWVycywK
Pgo+IC0tCj4gSm9uCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCj4gaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3
dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpo
dHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
