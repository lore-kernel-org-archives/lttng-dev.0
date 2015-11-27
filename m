From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] Fix: close indexes when
	rotating the trace files
Date: Fri, 27 Nov 2015 15:31:45 -0500
Message-ID: <CA+jJMxt5inOqPB7=ZU_br5TJdG7Y972fezOunaAp3ykG-yTZpg__2292.08661844513$1448656366$gmane$org@mail.gmail.com>
References: <1448644364-21440-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1a2PgN-0003dL-8d
 for lttng-dev@lists.lttng.org; Fri, 27 Nov 2015 15:31:52 -0500
Received: by ykfs79 with SMTP id s79so128937023ykf.1
 for <lttng-dev@lists.lttng.org>; Fri, 27 Nov 2015 12:31:45 -0800 (PST)
In-Reply-To: <1448644364-21440-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

T24gRnJpLCBOb3YgMjcsIDIwMTUgYXQgMTI6MTIgUE0sIEp1bGllbiBEZXNmb3NzZXoKPGpkZXNm
b3NzZXpAZWZmaWNpb3MuY29tPiB3cm90ZToKPiBUaGUgY29uc3VtZXIgbmVlZHMgdG8gY2xvc2Ug
dGhlIG9sZCBpbmRleCBmaWxlIHdoZW4gZG9pbmcgYSBmaWxlCj4gcm90YXRpb24gYmVmb3JlIG9w
ZW5pbmcgYSBuZXcgb25lLgo+IFRoZSByZWxheSBkb2VzIG5vdCBoYXZlIHRoaXMgcHJvYmxlbSAo
aGFuZGxlZCB3aXRoIHJlZmNvdW50cykuCj4KPiBTaWduZWQtb2ZmLWJ5OiBKdWxpZW4gRGVzZm9z
c2V6IDxqZGVzZm9zc2V6QGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2NvbW1vbi9jb25zdW1l
ci9jb25zdW1lci5jIHwgNSArKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
Cj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi9jb25zdW1lci9jb25zdW1lci5jIGIvc3JjL2Nv
bW1vbi9jb25zdW1lci9jb25zdW1lci5jCj4gaW5kZXggMjg5N2ZiOC4uNWE5MGMyOSAxMDA2NDQK
PiAtLS0gYS9zcmMvY29tbW9uL2NvbnN1bWVyL2NvbnN1bWVyLmMKPiArKysgYi9zcmMvY29tbW9u
L2NvbnN1bWVyL2NvbnN1bWVyLmMKPiBAQCAtMTc3OSw2ICsxNzc5LDExIEBAIHNzaXplX3QgbHR0
bmdfY29uc3VtZXJfb25fcmVhZF9zdWJidWZmZXJfc3BsaWNlKAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIG91dGZkID0gc3RyZWFtLT5vdXRfZmQ7Cj4KPiAgICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoc3RyZWFtLT5pbmRleF9mZCA+PSAwKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZXQgPSBjbG9zZShzdHJlYW0tPmluZGV4X2ZkKTsKPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFBFUlJPUigiQ2xvc2luZyBpbmRleCIpOwo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVuZDsKPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIH0KCkdvb2QgY2F0Y2ghIEknbSBhZGRpbmcgInN0cmVhbS0+aW5kZXhfZmQg
PSAtMTsiIGhlcmUgdG8gbWFrZSBzdXJlIHRoZQppbmRleF9mZCBpcyBub3QgY2xvc2VkIGEgc2Vj
b25kIHRpbWUgKG9uIHRlYXJkb3duKSBzaG91bGQgdGhlIGluZGV4CmZpbGUgY3JlYXRpb24gZmFp
bCBiZWxvdy4KClRoYW5rcyEKSsOpcsOpbWllCgo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmV0ID0gaW5kZXhfY3JlYXRlX2ZpbGUoc3RyZWFtLT5jaGFuLT5wYXRobmFtZSwKPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJlYW0tPm5h
bWUsIHN0cmVhbS0+dWlkLCBzdHJlYW0tPmdpZCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJlYW0tPmNoYW4tPnRyYWNlZmlsZV9zaXplLAo+IC0t
Cj4gMS45LjEKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6
Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==
