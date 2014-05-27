From: Jon Bernard <jbernard@debian.org>
Subject: Re: Debian specific userspace RCU configure override
Date: Tue, 27 May 2014 16:18:48 -0400
Message-ID: <20140527201848.GA27628__6798.0608241216$1401222002$gmane$org@helmut>
References: <30703453.22036.1400852842509.JavaMail.zimbra@efficios.com>
 <247206510.22055.1400853567137.JavaMail.zimbra@efficios.com>
 <20140523222124.GA25594@helmut>
 <97D83BC6-DF7B-4A23-A0DA-22EBEF7E7A62@sury.org>
 <400506412.22279.1400936702676.JavaMail.zimbra@efficios.com>
 <20140524145555.GA1466@helmut>
 <1851915699.22366.1400979572920.JavaMail.zimbra@efficios.com>
 <1401182846.16183.121907449.6882165F@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@debian.org>) id 1WpNpm-0003Yh-Vq
 for lttng-dev@lists.lttng.org; Tue, 27 May 2014 16:19:00 -0400
Content-Disposition: inline
In-Reply-To: <1401182846.16183.121907449.6882165F@webmail.messagingengine.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Michael Jeanson <mjeanson@efficios.com>
List-Id: lttng-dev@lists.lttng.org

KiBPbmTFmWVqIFN1csO9IDxvbmRyZWpAc3VyeS5vcmc+IHdyb3RlOgo+IE9uIFN1biwgTWF5IDI1
LCAyMDE0LCBhdCAyOjU5LCBNYXRoaWV1IERlc25veWVycyB3cm90ZToKPiA+IFdoeSBhcmUgZWFj
aCBwYWNrYWdlIGNvbXBpbGVkIGFnYWluc3QgY29tcGxldGVseSBkaWZmZXJlbnQgdGFyZ2V0cyA/
Cj4gCj4gdXJjdSBpbnZva2VzIC4vY29uZmlndXJlIG1hbnVhbGx5IHdoaWxlIGx0dC1jb250cm9s
IHVzZXMKPiBkaF9hdXRvX2NvbmZpZ3VyZSB3cmFwcGVyIGFuZCB0aGF0IG1ha2VzIHRoZSBkaWZm
ZXJlbmNlCgpUaGlzIGlzIGNvcnJlY3QuICBXaGVuIEkgZmlyc3Qgc2F3IHRoZSBkaWZmZXJlbmNl
LCBJIGFzc3VtZWQgdGhleSB3b3VsZApib3RoIGludm9rZSBjb25maWd1cmUgaW4gYSB3YXkgdGhh
dCB3b3VsZG4ndCBlZmZlY3QgdGhlIHRhcmdldC4gIEJ1dCBub3cKSSByZW1lbWJlciBoYXZpbmcg
YSBzaW1pbGFyIHByb2JsZW0gb24gc3BhcmMgKHdoaWNoIGlzIHdoeSB1cmN1IGluY2x1ZGVzCnRo
aXMgb3ZlcnJpZGUpIHdoZXJlIHRoZSB0YXJnZXQgZGlzY292ZXJ5IHdhcyBub3QgY29ycmVjdC4K
Ckl0IGxvb2tzIHRvIG1lIGxpa2UgYSBidWcgcmVsYXRlZCB0byBkZWJoZWxwZXIgKHdoaWNoIHBy
b3ZpZGVzCmRoX2F1dG9fY29uZmlndXJlKS4gIEZvciBub3csIEkgdGhpbmsgdGhpcyBvdmVycmlk
ZSBhcHBsaWVkIHRvCmx0dG5nLXRvb2xzIHdpbGwgY29ycmVjdGx5IGZpeCB0aGUgYnVpbGQgd2l0
aG91dCBkaXNhYmxpbmcgZG1iLiAgSSB3aWxsCmxldCB0aGUgZXhpc3RpbmcgdHJhbnNpdGlvbiBp
bnRvIHRlc3RpbmcgY29tcGxldGUgYW5kIHRoZW4gc3VibWl0IG5ldwpwYWNrYWdlcy4KCi0tIApK
b24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5n
LWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
