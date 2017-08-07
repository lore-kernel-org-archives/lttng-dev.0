From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RELEASE] Babeltrace 1.4.3
Date: Mon, 7 Aug 2017 13:22:54 -0400
Message-ID: <CA+jJMxvVFZKypvV9mGmdSRZdTpXyn108ULxBeHnSseW=v5-OJw__20220.9775955$1502126608$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x236.google.com (mail-yw0-x236.google.com
 [IPv6:2607:f8b0:4002:c05::236])
 by lists.lttng.org (Postfix) with ESMTPS id 3xR49X5Vlpzv6y
 for <lttng-dev@lists.lttng.org>; Mon,  7 Aug 2017 17:22:56 +0000 (UTC)
Received: by mail-yw0-x236.google.com with SMTP id s143so6798139ywg.1
 for <lttng-dev@lists.lttng.org>; Mon, 07 Aug 2017 10:22:56 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "diamon-discuss@lists.linuxfoundation.org" <diamon-discuss@lists.linuxfoundation.org>
List-Id: lttng-dev@lists.lttng.org

SGkgYWxsLAoKVG9kYXkgd2UgYXJlIHJlbGVhc2luZyB0aGUgdGhpcmQgYnVnLWZpeCByZWxlYXNl
IG9mIEJhYmVsdHJhY2UgMS40LjMuClRoaXMgcmVsZWFzZSBhZGRyZXNzZXMgYSBudW1iZXIgb2Yg
aXNzdWVzIGxpc3RlZCBiZWxvdy4KCgoyMDE3LTA4LTA0IGx0dG5nLXRvb2xzIDEuNC4zIChJbnRl
cm5hdGlvbmFsIEJlZXIgRGF5KQogICAgICAgICogRml4OiB1bmtub3duIHZhcmlhYmxlIG5hbWUg
aW4gUHl0aG9uIHdyaXRlcgogICAgICAgICogRml4IGxpdmUtY29tbTogb25seSBhcHBseSByZXRy
eSB0aW1lb3V0IGZvciBhbHJlYWR5IHNlZW4KaW5hY3RpdmUgaW5kZXhlcy4KICAgICAgICAqIEZp
eCBsaXZlLWNvbW06IG1lcmdlIFRDUCBzb2NrZXQgd3JpdGUtd3JpdGUgc2VxdWVuY2UgaW4gYSBz
aW5nbGUgd3JpdGUKICAgICAgICAqIEZpeDogdXNlIExERkxBR1MgaW5zdGVhZCBvZiBMSUJTIGZv
ciBweXRob24gYmluZGluZ3MKICAgICAgICAqIEZpeDogQWRkIG1pc3NpbmcgTElCUyB0byBweXRo
b24gYmluZGluZ3MKICAgICAgICAqIGF4X2xpYl9lbGZ1dGlscyAtPiBidF9saWJfZWxmdXRpbHMK
ICAgICAgICAqIG00L2F4X2xpYl9lbGZ1dGlscy5tNDogdXNlIG00X2RlZmF1bHQoKSBmb3Igb3B0
aW9uYWwgYXJncy4KICAgICAgICAqIG00L2F4X2xpYl9lbGZ1dGlscy5tNDogYWRkIGNhY2hlIHZh
cmlhYmxlCiAgICAgICAgKiBCdWlsZCBQeXRob24gYmluZGluZ3Mgd2l0aCBkaXN0dXRpbHMgZm9y
IGNvbnNpc3RlbnQgaW5zdGFsbHMKICAgICAgICAqIFNldCB0aGUgbWluaW11bSBQeXRob24gdmVy
c2lvbiB0byAzLjAKICAgICAgICAqIEZpeDogdGV4dCBvdXRwdXQgbWlzc2luZyBzZXBhcmF0b3Ig
d2hlbiBwcmludGluZyB0aGUgZG9tYWluCgoKUHJvamVjdCB3ZWJzaXRlOiBodHRwOi8vZGlhbW9u
Lm9yZy9iYWJlbHRyYWNlLwpEb3dubG9hZCBsaW5rOiBodHRwOi8vd3d3LmVmZmljaW9zLmNvbS9m
aWxlcy9iYWJlbHRyYWNlL2JhYmVsdHJhY2UtMS40LjMudGFyLmJ6MgpDVEYgc3BlY2lmaWNhdGlv
bjogaHR0cDovL2RpYW1vbi5vcmcvY3RmLwoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNp
T1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo=
