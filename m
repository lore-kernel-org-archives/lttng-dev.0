From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: Crash on 3.19.3 kernel
Date: Mon, 20 Apr 2015 10:15:14 -0400
Message-ID: <CAFXXi0kR3Lb_LehT-Yid6SqaLwG8ZnXqfS+dSc+4EGZde97jow__9580.26543162323$1429539419$gmane$org@mail.gmail.com>
References: <552FFEE4.9010101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1YkCUI-0002Sh-0N
 for lttng-dev@lists.lttng.org; Mon, 20 Apr 2015 10:15:55 -0400
Received: by obfe9 with SMTP id e9so118912031obf.1
 for <lttng-dev@lists.lttng.org>; Mon, 20 Apr 2015 07:15:44 -0700 (PDT)
In-Reply-To: <552FFEE4.9010101@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?S=C3=A9bastien_Lorrain?= <sebastien.lorrain01@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gMTYgQXByaWwgMjAxNSBhdCAxNDoyNiwgU8OpYmFzdGllbiBMb3JyYWluCjxzZWJhc3RpZW4u
bG9ycmFpbjAxQGdtYWlsLmNvbT4gd3JvdGU6Cj4gSGVsbG8gTFRUbmcgZm9sa3MsCj4KPiBJJ2Ft
IHVzaW5nIEFyY2hsaW51eCB3aXRoIHN0b2NrIDMuMTkuMyBrZXJuZWwgYW5kIEknYW0gZXhwZXJp
ZW5jaW5nIGEgY3Jhc2gKPiB3aXRoIHRoZSBsYXRlc3QgYW5kIGdyZWF0ZXN0IGx0dG5nLgo+IEkg
Y29tcGlsZWQgbHR0bmctdG9vbHMgd2l0aG91dCBVU1Qgc3VwcG9ydC4KPgo+ICR1bmFtZSAtYQo+
IExpbnV4IHJlZHdpbmQgMy4xOS4zLTMtQVJDSCAjMSBTTVAgUFJFRU1QVCBXZWQgQXByIDggMTQ6
MTA6MDAgQ0VTVCAyMDE1Cj4geDg2XzY0IEdOVS9MaW51eAo+Cj4gSGVyZSdzIHRoZSBjb21waWxl
IGxvZyBvZiBsdHRuZy1tb2R1bGVzIDoKPiBodHRwOi8vcGFzdGUudWJ1bnR1LmNvbS8xMDgzNDAw
Ny8KPgo+IEkgbm90aWNlZCBJJ2FtIG1pc3NpbmcgIENPTkZJR19LQUxMU1lNU19BTEwsIGJ1dCBJ
IGRvbid0IGtub3cgaWYgaXQgaXMKPiByZWFsbHkgcmVsZXZhbnQgYXMgbHR0bmctbW9kdWxlcyAy
LjYgd2FzIHJ1bm5pbmcgZmluZSB3aXRob3V0IGl0Lgo+Cj4gSGVyZSdzIHRoZSBzeXNsb2cvam91
cm5hbCBhZnRlciBhIGNyYXNoIChvbiBhIHRlc3QgVk0pCj4gaHR0cDovL3Bhc3RlLnVidW50dS5j
b20vMTA4MzM4NzMvCj4KPiBBbnkgaGVscCBpbiBkZWJ1Z2dpbmcgdGhhdCB3b3VsZCBiZSBncmVh
dGx5IGFwcHJlY2lhdGVkIQo+Cj4gVGhhbmtzIQo+IExyb3VnZS8KPiBTZWJhc3RpZW4gTG9ycmFp
bi4KCgpIaSBTw6liYXN0aWVuLAoKSSBjYW4gcmVwcm9kdWNlIHRoaXMgYXMgd2VsbC4gSSBzdWdn
ZXN0IHlvdSBmaWxlIGEgYnVnCihodHRwOi8vYnVncy5sdHRuZy5vcmcvcHJvamVjdHMvbHR0bmct
bW9kdWxlcyksIHNvIHRoYXQgdGhlIGlzc3VlIGlzCnRyYWNrZWQgYW5kIGZpeGVkIGJlZm9yZSB0
aGUgbmV4dCByZWxlYXNlLgoKU2ltb24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYK
