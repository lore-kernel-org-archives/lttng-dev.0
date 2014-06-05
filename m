From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Debian specific userspace RCU configure override
Date: Thu, 5 Jun 2014 18:46:21 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359B9A22__45273.4899278314$1401994431$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD359B89C8@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <20140605182933.GA6748@helmut>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WscgF-0003JI-5u
 for lttng-dev@lists.lttng.org; Thu, 05 Jun 2014 14:46:32 -0400
In-Reply-To: <20140605182933.GA6748@helmut>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jon Bernard <jbernard@debian.org>
Cc: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Michael Jeanson <mjeanson@efficios.com>
List-Id: lttng-dev@lists.lttng.org

LS0tLS1NZXNzYWdlIGQnb3JpZ2luZS0tLS0tDQpEZcKgOiBKb24gQmVybmFyZCBbbWFpbHRvOmpi
ZXJuYXJkQGRlYmlhbi5vcmddIA0KRW52b3nDqcKgOiA1IGp1aW4gMjAxNCAxNDozMA0KDQo+IEl0
IHNvdW5kcyBsaWtlIHlvdSBtaWdodCBiZSBoaXR0aW5nIHRoZSBzYW1lIGlzc3VlIHRoYXQgSSBo
YWQuICBXaGVuIGJ1aWxkaW5nIHVyY3Ugb24gdGhpcyBwYXJ0aWN1bGFyIGhvc3QsIC4vY29uZmln
dXJlIHdpbGwgZGV0ZWN0IGFuIGFybXY3IHRhcmdldCBldmVuIHRob3VnaCB1c2VybGFuZCBpcyBh
cm12NC4NCj4gSSB3YXMgYWJsZSB0byBnZXQgYXJvdW5kIHRoaXMgYnkgZXhwbGljaXRseSBwYXNz
aW5nICctLWJ1aWxkJyBhbmQgJy0taG9zdCcgZmxhZ3MgdG8gY29uZmlndXJlLiAgVGhlcmUgaXMg
YWxzbyBhIHByZS1idWlsdCBhcm1lbCBkZWIgZm9yIHRoZSBsYXRlc3QgdmVyc2lvbiBvZiB1cmN1
IGF0Og0KPg0KPiAgICBodHRwczovL3BhY2thZ2VzLmRlYmlhbi5vcmcvc2lkL2FybWVsL2xpYnVy
Y3UyL2Rvd25sb2FkDQo+DQo+IEluIG15IHBhcnRpY3VsYXIgY2FzZSwgdGhlIGJ1aWxkIG1hY2hp
bmUgaXMgdjcgaGFyZHdhcmUgcnVubmluZyBhIHY3IGtlcm5lbCBidXQgd2l0aCBhIHY0IHVzZXJs
YW5kLiAgWW91IGNhbiBjb25maXJtIHRoaXMgd2l0aA0KPg0KPiAgICBnY2MgLWR1bXBtYWNoaW5l
DQo+DQo+IE1heWJlIHRoaXMgd2lsbCBoZWxwLCBJJ20gY3VyaW91cyB0byBrbm93IGhvdyBpdCBn
b2VzLg0KPg0KPiBKb24NCg0KIyBnY2MgLWR1bXBtYWNoaW5lIA0KYXJtLWFuZ3N0cm9tLWxpbnV4
LWdudWVhYmkNCg0KRGFuaWVsIFUuIFRoaWJhdWx0DQpQcm90ZWN0aW9uIGRlcyBzeXN0w6htZXMg
ZXQgY29udHJlbWVzdXJlcyAoUFNDKSB8IFN5c3RlbXMgUHJvdGVjdGlvbiAmIENvdW50ZXJtZWFz
dXJlcyAoU1BDKQ0KQ3liZXIgc8OpY3VyaXTDqSBwb3VyIGxlcyBtaXNzaW9ucyBlc3NlbnRpZWxs
ZXMgKENNRSkgfCBNaXNzaW9uIENyaXRpY2FsIEN5YmVyIFNlY3VyaXR5IChNQ0NTKQ0KUkREQyAt
IENlbnRyZSBkZSByZWNoZXJjaGVzIGRlIFZhbGNhcnRpZXIgfCBEUkRDIC0gVmFsY2FydGllciBS
ZXNlYXJjaCBDZW50cmUNCjI0NTkgcm91dGUgZGUgbGEgQnJhdm91cmUNClF1w6liZWMgUUMgIEcz
SiAxWDUNCkNBTkFEQQ0KVm94IDogKDQxOCkgODQ0LTQwMDAgeDQyNDUNCkZheCA6ICg0MTgpIDg0
NC00NTM4DQpOQUMgOiA5MThWIFFTREogPGh0dHA6Ly93d3cudHJhdmVsZ2lzLmNvbS9tYXAuYXNw
P2FkZHI9OTE4ViUyMFFTREo+DQpHb3V2ZXJuZW1lbnQgZHUgQ2FuYWRhIHwgR292ZXJubWVudCBv
ZiBDYW5hZGENCjxodHRwOi8vd3d3LnZhbGNhcnRpZXIuZHJkYy1yZGRjLmdjLmNhLz4NCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
