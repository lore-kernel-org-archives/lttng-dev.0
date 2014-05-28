From: =?UTF-8?Q?Ond=C5=99ej=20Sur=C3=BD?= <ondrej@sury.org>
Subject: Re: Debian specific userspace RCU configure override
Date: Wed, 28 May 2014 20:25:11 +0200
Message-ID: <1401301511.5665.122575181.146AA429__12114.575392525$1401303861$gmane$org@webmail.messagingengine.com>
References: <30703453.22036.1400852842509.JavaMail.zimbra@efficios.com>
 <400506412.22279.1400936702676.JavaMail.zimbra@efficios.com>
 <20140524145555.GA1466@helmut>
 <1851915699.22366.1400979572920.JavaMail.zimbra@efficios.com>
 <1401182846.16183.121907449.6882165F@webmail.messagingengine.com>
 <20140527201848.GA27628@helmut>
 <1220472134.23571.1401222994845.JavaMail.zimbra@efficios.com>
 <20140528011827.GA6924@helmut>
 <1529830880.24314.1401296675360.JavaMail.zimbra@efficios.com>
 <20140528181050.GA29467@helmut>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ondrej@sury.org>) id 1WpiXN-0003dp-9q
 for lttng-dev@lists.lttng.org; Wed, 28 May 2014 14:25:27 -0400
In-Reply-To: <20140528181050.GA29467@helmut>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jon Bernard <jbernard@debian.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Michael Jeanson <mjeanson@efficios.com>
List-Id: lttng-dev@lists.lttng.org

T24gV2VkLCBNYXkgMjgsIDIwMTQsIGF0IDIwOjEwLCBKb24gQmVybmFyZCB3cm90ZToKPiBBcyBJ
IGN1cnJlbnRseSB1bmRlcnN0YW5kLCB0aGUgZGViaWFuIGJ1aWxkIHByb2JsZW0gaXMgdGhhdCBh
bHRob3VnaCB0aGUKPiBwYWNrYWdlIGlzIGNvbXBpbGVkIG9uIGFybXY3IGhhcmR3YXJlLCBpdCBp
cyBleHBlY3RlZCB0byB0YXJnZXQgYXJtdjR0Lgo+IEFuZCB0aGlzIGlzIG5vdCBjb3JyZWN0bHkg
ZGV0ZWN0ZWQgYXQgY29uZmlndXJlLXRpbWUuICBUaGUgZm9sa3Mgb24KPiAjZGViaWFuLWFybSBz
dWdnZXN0ZWQgdGhhdCB0aGlzIGNvdWxkIGJlIHNvbHZlZCBpbiBjb25maWd1cmUuYWMuICBJIGNh
bgo+IGV4cGxpY2l0bHkgcGFzcyAnLS1idWlsZCA8dGFyZ2V0PicgdG8gLi9jb25maWd1cmUgdG8g
Z2V0IGFyb3VuZCB0aGlzLAo+IGJ1dCBhcm0gdXNlcnMgdGhhdCBidWlsZCBmcm9tIHNvdXJjZSB3
aWxsIG5lZWQgdG8gcmVtZW1iZXIgdGhpcy4KCkpvbiwgSSB0aGluayB5b3UgYXJlIHNvbHZpbmcg
YSBwcm9ibGVtIHlvdSBkb24ndCByZWFsbHkgbmVlZCB0byBzb2x2ZS4KClVubGVzcyB0aGUgdGhp
cmQgcGFydHkgZXhwbGljaXRseSBzZXQgdGhlIEFIX1NPTUVUSElOR19ETUIgZnJvbSBjb25maWcu
aAp0aGUgdmFsdWUgd29uJ3QgZ2V0IHNldCBmcm9tIHVyY3UvY29uZmlnLmggYW5kIHRodXMgc3Vj
aCB1c2VyIHdvbid0IGJlCmFmZmVjdGVkLgpTbyB0aGlzIHNjZW5hcmlvIGlzIHNvIGh5cG90aGV0
aWNhbCB0aGF0IGl0IHByb2JhYmx5IHdvbid0IGhhcHBlbi4KCihUaGUgb2J2aW91cyBzb2x1dGlv
biB3b3VsZCBiZSB0byBoYXZlIHVyY3UvYXJjaC5oIGdlbmVyYXRlZCBmcm9tCmFyY2guaC5pbgpp
bnN0ZWFkIG9mIG1vZGlmeWluZyB0aGUgY29udGVudHMgZnJvbSB1cmN1L2NvbmZpZy5oICNkZWZp
bmVzIHRoYXQgY2FuCmdldApvdmVycmlkZW4gYnkgdGhpcmQgcGFydHkgY29uZmlnLmguKQoKSSB0
aGluayB0aGVyZSdzIG5vdGhpbmcgdGhlIHVyY3UgZm9sa3MgY2FuIGRvIGZvciB1cywgYnV0IHRo
YW5rcyBmb3IKcGF5aW5nIGF0dGVudGlvbgphbmQgdHJ5aW5nIHRvIGhlbHAgdXMuCgpPLgotLSAK
T25kxZllaiBTdXLDvSA8b25kcmVqQHN1cnkub3JnPgpLbm90IEROUyAoaHR0cHM6Ly93d3cua25v
dC1kbnMuY3ovKSDigJMgYSBoaWdoLXBlcmZvcm1hbmNlIEROUyBzZXJ2ZXIKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
