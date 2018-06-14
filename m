From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Race condition between lttng destroy and lttng load
	commands
Date: Thu, 14 Jun 2018 15:37:48 -0400
Message-ID: <CA+jJMxuVQP_fMdW2O6opKAdAfNNLMevRGTVkFef7U6Os_Dr==A__42656.1375883923$1529004974$gmane$org@mail.gmail.com>
References: <DM5PR15MB15933B93925FD9EE8FA7B65AF0780@DM5PR15MB1593.namprd15.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 416DS36GN5z18c8
 for <lttng-dev@lists.lttng.org>; Thu, 14 Jun 2018 15:38:11 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 47CB822A9EF
 for <lttng-dev@lists.lttng.org>; Thu, 14 Jun 2018 15:38:11 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id yfQjz0I6hXZr for <lttng-dev@lists.lttng.org>;
 Thu, 14 Jun 2018 15:38:10 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id AF0C522A9E9
 for <lttng-dev@lists.lttng.org>; Thu, 14 Jun 2018 15:38:10 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id 89HL3OHw-NX7 for <lttng-dev@lists.lttng.org>;
 Thu, 14 Jun 2018 15:38:10 -0400 (EDT)
Received: from mail-lf0-f46.google.com (mail-lf0-f46.google.com
 [209.85.215.46])
 by mail.efficios.com (Postfix) with ESMTPSA id 4F8CF22A9DF
 for <lttng-dev@lists.lttng.org>; Thu, 14 Jun 2018 15:38:10 -0400 (EDT)
Received: by mail-lf0-f46.google.com with SMTP id n15-v6so11165578lfn.10
 for <lttng-dev@lists.lttng.org>; Thu, 14 Jun 2018 12:38:10 -0700 (PDT)
In-Reply-To: <DM5PR15MB15933B93925FD9EE8FA7B65AF0780@DM5PR15MB1593.namprd15.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Douglas Graham <douglas.graham@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgRG91Z2xhcywKCkkgd2FzIGFibGUgdG8gcmVwcm9kdWNlIHRoZSBwcm9ibGVtIG9uIG15IGVu
ZCBhbmQgcHVzaGVkIGEgcGF0Y2guCkNhbiB5b3UgdGVzdCB3aXRoIHRoZSBsYXRlc3QgbWFzdGVy
IHRvIGNvbmZpcm0gdGhlIHByb2JsZW0gaXMgZml4ZWQ/CgpUaGFua3MsCkrDqXLDqW1pZQoKT24g
MTEgSnVuZSAyMDE4IGF0IDE1OjUwLCBEb3VnbGFzIEdyYWhhbSA8ZG91Z2xhcy5ncmFoYW1AZXJp
Y3Nzb24uY29tPiB3cm90ZToKPiBSZWdhcmRpbmcgaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvcGlw
ZXJtYWlsL2x0dG5nLWRldi8yMDE4LUp1bmUvMDI4MDc0Lmh0bWwsCj4gaXQgbWF5IG5vdCBiZSBv
YnZpb3VzIHRoYXQgdGhlIHJlYXNvbiBoZSBpcyBicmluZ2luZyB0aGF0IHVwIGlzIHRoYXQgd2Ug
KEVyaWNzc29uKQo+IG5lZWQgdGhhdCBmdW5jdGlvbmFsaXR5IHRvIGltcGxlbWVudCB0aGUgY2xl
YXIgbG9nIGZ1bmN0aW9uYWxpdHkgdGhhdCB3ZSBoYXZlCj4gbWVudGlvbmVkIHRvIHlvdSBiZWZv
cmUuIFRvIGNsZWFyIHRoZSBsb2dzLCB3ZSBjdXJyZW50bHkgZG86Cj4KPiAkIGx0dG5nIHNhdmUg
PHNhdmVfZmlsZT4KPiAkIGx0dG5nIHN0b3AKPiAkIGx0dG5nIGRlc3Ryb3kKPiAkIGx0dG5nIGxv
YWQgPHNhdmVfZmlsZT4KPgo+IFRoZSBsdHRuZyBkZXN0cm95IGlzIHN1cHBvc2VkIHRvIHNodXQg
ZG93biB0aGUgbHR0bmcgc2Vzc2lvbiBhbmQgY2xlYXIgYWxsIHRoZQo+IGV4aXN0aW5nIGxvZ3Mu
ICBUaGVuIHRoZSBsdHRuZyBsb2FkIHJlc3RvcmVzIHRoZSBzZXNzaW9uIGFzIGl0IHdhcyBiZWZv
cmUgdGhlCj4gZGVzdHJveS4gIFRoaXMgd29ya3MgbW9zdCBvZiB0aGUgdGltZSBidXQgaXQgc2Vl
bXMgdGhhdCB0aGVyZSBpcyBhIHJhY2UuCj4gTHR0bmcgZGVzdHJveSBpc24ndCBndWFyYW50ZWVk
IHRvIGhhdmUgZmluaXNoZWQgc2h1dHRpbmcgZG93biBhbmQgZGVzdHJveWluZwo+IHRoZSBzZXNz
aW9uIGJ5IHRoZSB0aW1lIGNvbnRyb2wgcmV0dXJucyB0byB0aGUgc2hlbGwuICBXZSBvY2Nhc2lv
bmFsbHkgc2VlIHRoZQo+ICJsdHRuZyBsb2FkIiBmYWlsIGJlY2F1c2UgaXQgaXMgdHJ5aW5nIHRv
IHJlY3JlYXRlIGEgZGlyZWN0b3J5IHRyZWUgdGhhdCBpcyBzdGlsbAo+IGluIHRoZSBwcm9jZXNz
IG9mIGJlaW5nIHJlbW92ZWQgYnkgImx0dG5nIGRlc3Ryb3kiLgo+Cj4gVGhlIHByb2JsZW0gc2Vl
bXMgdG8gYmUgdGhhdCB0aGUgZGlyZWN0b3J5IHRyZWUgaXMgcmVtb3ZlZCB3aXRoIGEgY2FsbCB0
bwo+IGNhbGxfcmN1KCZyZWdwLT5ub2RlLmhlYWQsIHJjdV9mcmVlX2J1ZmZlcl9yZWdfdWlkKS4g
VGhlIGZ1bmN0aW9uCj4gcmN1X2ZyZWVfYnVmZmVyX3JlZ191aWQoKSBpcyBydW4gYXN5bmNocm9u
b3VzbHkgYW5kIGlzIG5vdCBndWFyYW50ZWVkIHRvIGhhdmUKPiBmaW5pc2hlZCBieSB0aGUgdGlt
ZSBjYWxsX3JjdSgpIHJldHVybnMuICBJIHRoaW5rIHRoaXMgc2hvdWxkIHByb2JhYmx5IGJlCj4g
Y29uc2lkZXJlZCBhIGRlZmljaWVuY3kgaW4gdGhlIGltcGxlbWVudGF0aW9uIG9mICJsdHRuZyBk
ZXN0cm95Ii4gIElzIHRoaXMKPiBzb21ldGhpbmcgdGhhdCBjYW4gYmUgZWFzaWx5IGZpeGVkIG9y
IHNob3VsZCB3ZSBiZSBsb29raW5nIGZvciBhIHdvcmthcm91bmQ/Cj4KPiBUaGFua3MsCj4gRG91
Zwo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBs
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKCgoK
LS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9z
LmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0
cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
