From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: Use bash for all test
	scripts
Date: Mon, 26 Mar 2018 14:31:50 -0400
Message-ID: <20180326183149.GA5731__25378.4441076734$1522089000$gmane$org@gmail.com>
References: <1522079264-13202-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 by lists.lttng.org (Postfix) with ESMTPS id 4092mV6HDWzxgn
 for <lttng-dev@lists.lttng.org>; Mon, 26 Mar 2018 14:31:54 -0400 (EDT)
Received: by mail-qk0-x241.google.com with SMTP id s188so21187180qkb.2
 for <lttng-dev@lists.lttng.org>; Mon, 26 Mar 2018 11:31:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1522079264-13202-1-git-send-email-mjeanson@efficios.com>
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
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuMCwgdGhhbmtzIQoKSsOpcsOpbWllCgpPbiBN
b24sIE1hciAyNiwgMjAxOCBhdCAxMTo0Nzo0NEFNIC0wNDAwLCBNaWNoYWVsIEplYW5zb24gd3Jv
dGU6Cj4gV2UgYWxyZWFkeSB1c2UgYmFzaCBpbiBtb3N0IHRlc3Qgc2NyaXB0cyBzaGViYW5nIGFu
ZCB0aGUgc2ggYmluYXJ5IG9uCj4gU29sYXJpcyAxMCBkb2Vzbid0IGxpa2Ugc29tZSBvZiBvdXIg
Im1vZGVybiIgc2NyaXB0cyBzeW50YXguCj4gCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFu
c29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHRlc3RzL3BsdWdpbnMvdGVzdC11
dGlscy1tdXhlci1jb21wbGV0ZS5pbiB8IDIgKy0KPiAgdGVzdHMvcGx1Z2lucy90ZXN0X2Jpbl9p
bmZvX2NvbXBsZXRlLmluICAgIHwgMiArLQo+ICB0ZXN0cy9wbHVnaW5zL3Rlc3RfZHdhcmZfY29t
cGxldGUuaW4gICAgICAgfCAyICstCj4gIDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0cy9wbHVnaW5zL3Rlc3QtdXRp
bHMtbXV4ZXItY29tcGxldGUuaW4gYi90ZXN0cy9wbHVnaW5zL3Rlc3QtdXRpbHMtbXV4ZXItY29t
cGxldGUuaW4KPiBpbmRleCBiZWI2ZjBhLi45YjU5OTlkIDEwMDY0NAo+IC0tLSBhL3Rlc3RzL3Bs
dWdpbnMvdGVzdC11dGlscy1tdXhlci1jb21wbGV0ZS5pbgo+ICsrKyBiL3Rlc3RzL3BsdWdpbnMv
dGVzdC11dGlscy1tdXhlci1jb21wbGV0ZS5pbgo+IEBAIC0xLDQgKzEsNCBAQAo+IC0jIS9iaW4v
c2gKPiArIyEvYmluL2Jhc2gKPiAgIwo+ICAjIENvcHlyaWdodCAoQykgMjAxNyBQaGlsaXBwZSBQ
cm91bHggPHBwcm91bHhAZWZmaWNpb3MuY29tPgo+ICAjCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3Bs
dWdpbnMvdGVzdF9iaW5faW5mb19jb21wbGV0ZS5pbiBiL3Rlc3RzL3BsdWdpbnMvdGVzdF9iaW5f
aW5mb19jb21wbGV0ZS5pbgo+IGluZGV4IDAwNjlkZDcuLjQzNGEwYzMgMTAwNjQ0Cj4gLS0tIGEv
dGVzdHMvcGx1Z2lucy90ZXN0X2Jpbl9pbmZvX2NvbXBsZXRlLmluCj4gKysrIGIvdGVzdHMvcGx1
Z2lucy90ZXN0X2Jpbl9pbmZvX2NvbXBsZXRlLmluCj4gQEAgLTEsNCArMSw0IEBACj4gLSMhL2Jp
bi9zaAo+ICsjIS9iaW4vYmFzaAo+ICAjCj4gICMgQ29weXJpZ2h0IChDKSAyMDE1IC0gQW50b2lu
ZSBCdXNxdWUgPGFidXNxdWVAZWZmaWNpb3MuY29tPgo+ICAjCj4gZGlmZiAtLWdpdCBhL3Rlc3Rz
L3BsdWdpbnMvdGVzdF9kd2FyZl9jb21wbGV0ZS5pbiBiL3Rlc3RzL3BsdWdpbnMvdGVzdF9kd2Fy
Zl9jb21wbGV0ZS5pbgo+IGluZGV4IDBhOTllN2QuLjQyYmZmMjIgMTAwNjQ0Cj4gLS0tIGEvdGVz
dHMvcGx1Z2lucy90ZXN0X2R3YXJmX2NvbXBsZXRlLmluCj4gKysrIGIvdGVzdHMvcGx1Z2lucy90
ZXN0X2R3YXJmX2NvbXBsZXRlLmluCj4gQEAgLTEsNCArMSw0IEBACj4gLSMhL2Jpbi9zaAo+ICsj
IS9iaW4vYmFzaAo+ICAjCj4gICMgQ29weXJpZ2h0IChDKSAyMDE1IC0gQW50b2luZSBCdXNxdWUg
PGFidXNxdWVAZWZmaWNpb3MuY29tPgo+ICAjCj4gLS0gCj4gMi43LjQKPiAKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlz
dApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
