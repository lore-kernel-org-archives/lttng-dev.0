From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.5.2
Date: Wed, 5 Nov 2014 20:35:41 -0500
Message-ID: <CA+jJMxvphqKxboAqNOaHDfuSpVyC+HQZzscAoHaYif0xRNbCKA__44388.6902452961$1415237787$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1XmBzH-0000v1-GF
 for lttng-dev@lists.lttng.org; Wed, 05 Nov 2014 20:35:50 -0500
Received: by mail-lb0-f181.google.com with SMTP id l4so97017lbv.12
 for <lttng-dev@lists.lttng.org>; Wed, 05 Nov 2014 17:35:41 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: maxime.hadjinlian@gmail.com
List-Id: lttng-dev@lists.lttng.org

SGkgYWxsLAoKVGhlIGx0dG5nLXRvb2xzIHByb2plY3QgcHJvdmlkZXMgYSBzZXNzaW9uIGRhZW1v
biAobHR0bmctc2Vzc2lvbmQpIHRoYXQKYWN0cyBhcyBhIHRyYWNpbmcgcmVnaXN0cnksIHRoZSAi
bHR0bmciIGNvbW1hbmQgbGluZSBmb3IgdHJhY2luZwpjb250cm9sLCBhbiBsdHRuZy1jdGwgbGli
cmFyeSBmb3IgdHJhY2luZyBjb250cm9sIGFuZCBhbiBsdHRuZy1yZWxheSBkYWVtb24KdG8gcHJv
dmlkZSBuZXR3b3JrIHN0cmVhbWluZyBhbmQgbGl2ZSByZWFkaW5nIGNhcGFiaWxpdGllcy4KClRo
aXMgaXMgdmVyc2lvbiAyLjUuMiB3aGljaCBpbmNsdWRlcyBhbiBpbXBvcnRhbnQgZml4IHRvIGVu
c3VyZSB0aGF0CnRoZSBsaXZlIHRyYWNpbmcgZmVhdHVyZSB3b3JrcyB3aGVuIGFwcGxpY2F0aW9u
cyBydW4gYnkgbXVsdGlwbGUgdXNlcnMKYXJlIGJlaW5nIHRyYWNlZC4KCk5vdGUgdGhhdCB3ZSBo
YXZlIGRlY2lkZWQgdG8gcmVtb3ZlIGx0dG5nLXRvb2xzIDIuNS4xIGZyb20gdGhlIHdlYnNpdGUK
c2luY2UgdGhlIHRhcmJhbGwgd2FzIHBhY2thZ2VkIGZyb20gdGhlIHdyb25nIHRhZy4gU3BlY2lh
bCB0aGFua3MgdG8KTWF4aW1lIEhhZGppbmxpYW4gZm9yIHJlcG9ydGluZyB0aGUgaXNzdWUhIFsx
XQoKMjAxNC0xMS0wNSBsdHRuZy10b29scyAyLjUuMgogICAgICAgICogVXBkYXRlIG1haW50YWlu
ZXIgc2VjdGlvbiBvZiB0aGUgbWFuIHBhZ2VzCiAgICAgICAgKiBVcGRhdGUgbWFpbnRhaW5lciBz
ZWN0aW9uIG9mIFJFQURNRQogICAgICAgICogRml4OiBhZGQgUkVBRE1FIHRvIGRvY3VtZW50YXRp
b24gZmlsZXMKICAgICAgICAqIEZpeDogVVNUIGNvbnN1bWVyIHN5bmMgYWxsIGF2YWlsYWJsZSBt
ZXRhZGF0YQoKQXMgYWx3YXlzLCBwbGVhc2UgcmVwb3J0IGFueSBpc3N1ZSB0byBidWdzLmx0dG5n
Lm9yZyBvciBvbiB0aGlzIG1haWxpbmcgbGlzdC4KClByb2plY3Qgd2Vic2l0ZTogaHR0cHM6Ly9s
dHRuZy5vcmcKCkRvd25sb2FkIGxpbmtzOgpodHRwczovL2x0dG5nLm9yZy9maWxlcy9sdHRuZy10
b29scy9sdHRuZy10b29scy0yLjUuMi50YXIuYnoyCkdQRyBzaWc6IGh0dHBzOi8vbHR0bmcub3Jn
L2ZpbGVzL2x0dG5nLXRvb2xzL2x0dG5nLXRvb2xzLTIuNS4yLnRhci5iejIuYXNjCgpSZWdhcmRz
LApKw6lyw6ltaWUKClsxXSBodHRwOi8vYnVncy5sdHRuZy5vcmcvaXNzdWVzLzg1NAoKLS0gCkrD
qXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
