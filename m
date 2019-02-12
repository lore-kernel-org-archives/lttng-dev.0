From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Remove duplicate check for
 dlopen
Date: Tue, 12 Feb 2019 11:23:04 -0500
Message-ID: <CA+jJMxtfS4kuZoXkG3r=RCQHAuWt5s5T3=3GZ-98S4Mko_xmpQ__19650.8971903071$1549988678$gmane$org@mail.gmail.com>
References: <20181220211647.19327-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43zSdd50HVzgg0
 for <lttng-dev@lists.lttng.org>; Tue, 12 Feb 2019 11:23:49 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 583CA19D640
 for <lttng-dev@lists.lttng.org>; Tue, 12 Feb 2019 11:23:43 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id KMo33IbpAzfR for <lttng-dev@lists.lttng.org>;
 Tue, 12 Feb 2019 11:23:42 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 3C41A19D631
 for <lttng-dev@lists.lttng.org>; Tue, 12 Feb 2019 11:23:42 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id Q_L4LfnqOC3P for <lttng-dev@lists.lttng.org>;
 Tue, 12 Feb 2019 11:23:42 -0500 (EST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by mail.efficios.com (Postfix) with ESMTPSA id D94D119D628
 for <lttng-dev@lists.lttng.org>; Tue, 12 Feb 2019 11:23:41 -0500 (EST)
Received: by mail-lj1-f173.google.com with SMTP id l7-v6so2733043ljg.9
 for <lttng-dev@lists.lttng.org>; Tue, 12 Feb 2019 08:23:41 -0800 (PST)
In-Reply-To: <20181220211647.19327-1-mjeanson@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuMTEsIGFuZCBzdGFibGUtMi4xMC4KClRoYW5rcyEK
SsOpcsOpbWllCgpPbiBUaHUsIDIwIERlYyAyMDE4IGF0IDE2OjE2LCBNaWNoYWVsIEplYW5zb24g
PG1qZWFuc29uQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVs
IEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgY29uZmlndXJlLmFjIHwg
MTcgKysrLS0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MTQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvY29uZmlndXJlLmFjIGIvY29uZmlndXJl
LmFjCj4gaW5kZXggYmYxZWY2ZjIuLmZhMGVkYzQ0IDEwMDY0NAo+IC0tLSBhL2NvbmZpZ3VyZS5h
Ywo+ICsrKyBiL2NvbmZpZ3VyZS5hYwo+IEBAIC0yMTcsMTUgKzIxNywxOCBAQCBBQ19DSEVDS19M
SUIoW3J0XSwgW2Nsb2NrX2dldHRpbWUsIHRpbWVyX2NyZWF0ZSwgdGltZXJfc2V0dGltZSwgdGlt
ZXJfZGVsZXRlXSkKPiAgQUNfQ0hFQ0tfTElCKFtkbF0sIFtkbG9wZW5dLCBbCj4gICAgICAgICBo
YXZlX2xpYmRsPXllcwo+ICAgICAgICAgbGliZGxfbmFtZT1kbAo+ICsgICAgICAgRExfTElCUz0i
LWxkbCIKPiAgXSwgWwo+ICAgICAgICAgIyBsaWJkbCBub3QgZm91bmQsIGNoZWNrIGZvciBkbG9w
ZW4gaW4gbGliYy4KPiAgICAgICAgIEFDX0NIRUNLX0xJQihbY10sIFtkbG9wZW5dLCBbCj4gICAg
ICAgICAgICAgICAgIGhhdmVfbGliY19kbD15ZXMKPiAgICAgICAgICAgICAgICAgbGliZGxfbmFt
ZT1jCj4gKyAgICAgICAgICAgICAgIERMX0xJQlM9Ii1sYyIKPiAgICAgICAgIF0sIFsKPiAgICAg
ICAgICAgICAgICAgQUNfTVNHX0VSUk9SKFtDYW5ub3QgZmluZCBkbG9wZW4gaW4gbGliZGwgbm9y
IGxpYmMuIFVzZSBbTERGTEFHU109LUxkaXIgdG8gc3BlY2lmeSB0aGVpciBsb2NhdGlvbi5dKQo+
ICAgICAgICAgXSkKPiAgXSkKPiArQUNfU1VCU1QoRExfTElCUykKPgo+ICAjIENoZWNrIGlmIGxp
YmRsIGhhcyBkbG1vcGVuIHN1cHBvcnQuCj4gIEFIX1RFTVBMQVRFKFtIQVZFX0RMTU9QRU5dLCBb
IkRlZmluZSB0byAxIGlmIGRsbW9wZW4gaXMgYXZhaWxhYmxlLiJdKQo+IEBAIC01NzAsMjAgKzU3
Myw2IEBAIEFTX0lGKFt0ZXN0ICJ4JHdpdGhfbHR0bmdfdXN0IiA9ICJ4eWVzIl0sCj4gIEFNX0NP
TkRJVElPTkFMKFtIQVZFX0xJQkxUVE5HX1VTVF9DVExdLCBbdGVzdCAieCR3aXRoX2x0dG5nX3Vz
dCIgPSAieHllcyJdKQo+Cj4KPiAtCj4gLSMgY2hlY2sgZm9yIGRsb3Blbgo+IC1BQ19DSEVDS19M
SUIoW2RsXSwgW2Rsb3Blbl0sCj4gLSAgW0RMX0xJQlM9Ii1sZGwiXSwKPiAtICBbCj4gLSAgICAj
bGliZGwgbm90IGZvdW5kLCBjaGVjayBmb3IgZGxvcGVuIGluIGxpYmMuCj4gLSAgICBBQ19DSEVD
S19MSUIoW2NdLCBbZGxvcGVuXSwKPiAtICAgICAgW0RMX0xJQlM9Ii1sYyJdLAo+IC0gICAgICBb
QUNfTVNHX0ZBSUxVUkUoW0Nhbm5vdCBmaW5kIGRsb3BlbiBpbiBsaWJkbCBub3IgbGliYy4gVXNl
IFtMREZMQUdTXT0tTGRpciB0byBzcGVjaWZ5IHRoZWlyIGxvY2F0aW9uLl0pXQo+IC0gICAgKQo+
IC0gIF0KPiAtKQo+IC1BQ19TVUJTVChETF9MSUJTKQo+IC0KPiAgIyBDaGVjayBmb3IgZm1lbW9w
ZW4KPiAgQUNfQ0hFQ0tfTElCKFtjXSwgW2ZtZW1vcGVuXSwKPiAgWwo+IC0tCj4gMi4xNy4xCj4K
CgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNp
b3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
