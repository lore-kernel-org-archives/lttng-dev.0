From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace stable-1.5] Fix: timegm compat on
	Solaris
Date: Mon, 13 Nov 2017 18:43:58 -0500
Message-ID: <CA+jJMxuDc4Pd6KRoepiEiYTtt8N0HHA5-bvHV+Emcj2couG=wA__45522.4379351877$1510616647$gmane$org@mail.gmail.com>
References: <1510603589-9901-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3ybS00621Wz161N
 for <lttng-dev@lists.lttng.org>; Mon, 13 Nov 2017 23:44:00 +0000 (UTC)
Received: by mail-wr0-x242.google.com with SMTP id 4so15962009wrt.0
 for <lttng-dev@lists.lttng.org>; Mon, 13 Nov 2017 15:44:00 -0800 (PST)
In-Reply-To: <1510603589-9901-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIDEzIE5vdmVtYmVyIDIwMTcgYXQgMTU6MDYs
IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPiB3cm90ZToKPiBPbiBTb2xh
cmlzIDExIHNldHRpbmcgVFogdG8gYW4gZW1wdHkgc3RyaW5nIGJlZm9yZSBjYWxsaW5nIG1rdGlt
ZSB3aWxsCj4gaW4gc29tZSBjaXJjdW1zdGFuY2VzIGRvIHRoZSBjb252ZXJzaW9uIGluIGxvY2Fs
dGltZSBpbnN0ZWFkIG9mIFVUQyBhcwo+IGV4cGVjdGVkLgo+Cj4gUmVwbGFjZSB0aGUgZW1wdHkg
c3RyaW5nIGJ5ICJVVEMiLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVh
bnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIGluY2x1ZGUvYmFiZWx0cmFjZS9jb21wYXQvdXRj
LmggfCA0ICsrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2JhYmVsdHJhY2UvY29tcGF0L3V0Yy5oIGIv
aW5jbHVkZS9iYWJlbHRyYWNlL2NvbXBhdC91dGMuaAo+IGluZGV4IGQ1OWQ4NTYuLmFiMDgwZjIg
MTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9iYWJlbHRyYWNlL2NvbXBhdC91dGMuaAo+ICsrKyBiL2lu
Y2x1ZGUvYmFiZWx0cmFjZS9jb21wYXQvdXRjLmgKPiBAQCAtNjcsOCArNjcsOCBAQCB0aW1lX3Qg
YmFiZWx0cmFjZV90aW1lZ20oc3RydWN0IHRtICp0bSkKPiAgICAgICAgICAgICAgICAgfQo+ICAg
ICAgICAgfQo+Cj4gLSAgICAgICAvKiBUZW1wb3JhcmlseSBzZXR0aW5nIFRaIHRvIDEgZm9yIFVU
QyAqLwo+IC0gICAgICAgc2V0ZW52KCJUWiIsICIiLCAxKTsKPiArICAgICAgIC8qIFRlbXBvcmFy
aWx5IHNldHRpbmcgVFogdG8gVVRDICovCj4gKyAgICAgICBzZXRlbnYoIlRaIiwgIlVUQyIsIDEp
Owo+ICAgICAgICAgdHpzZXQoKTsKPiAgICAgICAgIHJldCA9IG1rdGltZSh0bSk7Cj4gICAgICAg
ICBpZiAodHopIHsKPiAtLQo+IDIuNy40Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZm
aWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
