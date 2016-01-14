From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: missing $ in SED variable
Date: Thu, 14 Jan 2016 11:59:26 -0500
Message-ID: <CA+jJMxv2D1X1yPYmqfsxHkm0tV-rTfM8VGsq+zhqO6aQP5MXhw__13025.7850898944$1452790959$gmane$org@mail.gmail.com>
References: <1452101502-9478-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1aJlFD-0000dc-Mf
 for lttng-dev@lists.lttng.org; Thu, 14 Jan 2016 11:59:34 -0500
Received: by mail-ig0-f194.google.com with SMTP id o2so20492971iga.3
 for <lttng-dev@lists.lttng.org>; Thu, 14 Jan 2016 08:59:31 -0800 (PST)
In-Reply-To: <1452101502-9478-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFdlZCwgSmFuIDYsIDIwMTYgYXQgMTI6MzEg
UE0sIE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPiB3cm90ZToKPiBTaWdu
ZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4KPiAtLS0K
PiAgY29uZmlndXJlLmFjIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9jb25maWd1cmUuYWMgYi9jb25maWd1cmUu
YWMKPiBpbmRleCA1NTM3YzE1Li5mODUxYmU4IDEwMDY0NAo+IC0tLSBhL2NvbmZpZ3VyZS5hYwo+
ICsrKyBiL2NvbmZpZ3VyZS5hYwo+IEBAIC05MCw3ICs5MCw3IEBAIEFTX0lGKFt0ZXN0ICJ4JGxp
YnRvb2xfZml4dXAiID0gInh5ZXMiXSwKPiAgICAgICAgICAgICBbCj4gICAgICAgICAgICAgICAg
ICAgQUNfTVNHX1JFU1VMVChbJGxpYnRvb2xfZmxhZ19wYXR0ZXJuX2NvdW50XSkKPiAgICAgICAg
ICAgICAgICAgICBBQ19NU0dfV0FSTihbdGhlIGRldGVjdGVkIGxpYnRvb2wgd2lsbCBub3QgbGlu
ayBhbGwgZGVwZW5kZW5jaWVzLCBmb3JjaW5nIGxpbmtfYWxsX2RlcGxpYnMgPSB1bmtub3duXSkK
PiAtICAgICAgICAgICAgICAgICBTRUQgLWkgInMvXCgkbGlidG9vbF9mbGFnX3BhdHRlcm5cKVxz
Kj1ccypuby9cMT11bmtub3duL2ciICRsaWJ0b29sX200Cj4gKyAgICAgICAgICAgICAgICAgJFNF
RCAtaSAicy9cKCRsaWJ0b29sX2ZsYWdfcGF0dGVyblwpXHMqPVxzKm5vL1wxPXVua25vd24vZyIg
JGxpYnRvb2xfbTQKPiAgICAgICAgICAgICAgICAgICBdLAo+ICAgICAgICAgICAgICAgICAgIFsK
PiAgICAgICAgICAgICAgICAgICBBQ19NU0dfUkVTVUxUKFtub25lXSkKPiAtLQo+IDIuNy4wLnJj
Mwo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5l
ZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
