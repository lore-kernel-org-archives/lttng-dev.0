From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: double RCU unlock on
	event_agent_disable_all
Date: Wed, 9 Sep 2015 06:29:10 -0400
Message-ID: <CA+jJMxt+bMyCZDHVxh0KnRWSEwOBfnR4btQ8v-3A8Mis9_XC-A__31870.9167223007$1441794616$gmane$org@mail.gmail.com>
References: <1441751532-11628-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZZccu-0004fo-2D
 for lttng-dev@lists.lttng.org; Wed, 09 Sep 2015 06:29:19 -0400
Received: by ykcf206 with SMTP id f206so7699882ykc.3
 for <lttng-dev@lists.lttng.org>; Wed, 09 Sep 2015 03:29:10 -0700 (PDT)
In-Reply-To: <1441751532-11628-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuNywgdGhhbmtzIQoKSmVyZW1pZQoKT24gVHVl
LCBTZXAgOCwgMjAxNSBhdCA2OjMyIFBNLCBKb25hdGhhbiBSYWpvdHRlCjxqb25hdGhhbi5yYWpv
dHRlLWp1bGllbkBlZmZpY2lvcy5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFu
IFJham90dGUgPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAg
c3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9ldmVudC5jIHwgMiAtLQo+ICAxIGZpbGUgY2hhbmdlZCwg
MiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL2V2
ZW50LmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL2V2ZW50LmMKPiBpbmRleCBkYWNkNTZkLi44
Y2NhMjEzIDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvZXZlbnQuYwo+ICsr
KyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvZXZlbnQuYwo+IEBAIC02NDcsOCArNjQ3LDYgQEAg
aW50IGV2ZW50X2FnZW50X2Rpc2FibGVfYWxsKHN0cnVjdCBsdHRfdXN0X3Nlc3Npb24gKnVzZXNz
LAo+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfdW5sb2NrOwo+ICAgICAgICAg
ICAgICAgICB9Cj4gICAgICAgICB9Cj4gLSAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiAtCj4g
ICAgICAgICByZXQgPSBMVFROR19PSzsKPgo+ICBlcnJvcl91bmxvY2s6Cj4gLS0KPiAyLjEuNAo+
CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZp
Y2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8v
bGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
