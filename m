From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Remove duplicate include of
 unistd in test_ctf_writer
Date: Fri, 7 Nov 2014 11:44:26 -0500
Message-ID: <CA+jJMxvJwfUgVMUjJ_y5MSukdAOui8R_3m4fhTUpy4SRBdM_PQ__42379.0888199166$1415378736$gmane$org@mail.gmail.com>
References: <1415373628-32259-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1XmmeG-0004m0-Q7
 for lttng-dev@lists.lttng.org; Fri, 07 Nov 2014 11:44:36 -0500
Received: by mail-lb0-f182.google.com with SMTP id f15so3211071lbj.41
 for <lttng-dev@lists.lttng.org>; Fri, 07 Nov 2014 08:44:27 -0800 (PST)
In-Reply-To: <1415373628-32259-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIEZyaSwgTm92IDcsIDIwMTQgYXQgMTA6MjAg
QU0sIENocmlzdGlhbiBCYWJldXgKPGNocmlzdGlhbi5iYWJldXhAZWZmaWNpb3MuY29tPiB3cm90
ZToKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gQmFiZXV4IDxjaHJpc3RpYW4uYmFiZXV4QGVm
ZmljaW9zLmNvbT4KPiAtLS0KPiAgdGVzdHMvbGliL3Rlc3RfY3RmX3dyaXRlci5jIHwgMSAtCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvbGli
L3Rlc3RfY3RmX3dyaXRlci5jIGIvdGVzdHMvbGliL3Rlc3RfY3RmX3dyaXRlci5jCj4gaW5kZXgg
YmQzM2FiNy4uOWQ0MjhjMiAxMDA2NDQKPiAtLS0gYS90ZXN0cy9saWIvdGVzdF9jdGZfd3JpdGVy
LmMKPiArKysgYi90ZXN0cy9saWIvdGVzdF9jdGZfd3JpdGVyLmMKPiBAQCAtMzQsNyArMzQsNiBA
QAo+ICAjaW5jbHVkZSA8YmFiZWx0cmFjZS9jb21wYXQvbGltaXRzLmg+Cj4gICNpbmNsdWRlIDxz
dHJpbmcuaD4KPiAgI2luY2x1ZGUgPGFzc2VydC5oPgo+IC0jaW5jbHVkZSA8dW5pc3RkLmg+Cj4g
ICNpbmNsdWRlIDxzeXMvd2FpdC5oPgo+ICAjaW5jbHVkZSA8ZmNudGwuaD4KPiAgI2luY2x1ZGUg
PGRpcmVudC5oPgo+IC0tCj4gMi4xLjEKPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJ
bmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
