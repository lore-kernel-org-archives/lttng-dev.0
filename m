From: Yao Qi <yao@codesourcery.com>
Subject: Re: [PATCH] Teach babeltrace understand "native" and
 "network" for byte_order
Date: Fri, 15 Mar 2013 22:55:32 +0800
Message-ID: <51433664.30605__48720.0938900516$1363359445$gmane$org@codesourcery.com>
References: <1363341137-26956-1-git-send-email-yao@codesourcery.com>
	<20130315120753.GA30973@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Yao_Qi@mentor.com>) id 1UGW3k-0001l0-Fy
	for lttng-dev@lists.lttng.org; Fri, 15 Mar 2013 10:56:40 -0400
In-Reply-To: <20130315120753.GA30973@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gMDMvMTUvMjAxMyAwODowNyBQTSwgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6Cj4geW91ciBp
bnRlcnByZXRhdGlvbiBvZiB3aGF0IHRoZSBieXRlIG9yZGVyIHNob3VsZCBhY2NlcHQgaXMgYmFz
ZWQgb24KPiBzZWN0aW9uIDQuMS4zIG9mIHRoZSBDVEYgc3BlYywgd2hpY2ggZGlzY3Vzc2VzIHdo
YXQgYnl0ZSBvcmRlciBjYW4gYmUKPiBhY2NlcHRlZCBieSBhIHR5cGUuCj4KPiBIb3dldmVyLCBo
ZXJlIHlvdSBhcmUgcHJvcG9zaW5nIHRvIGNoYW5nZSB0aGUgYnl0ZSBvcmRlciByZWNvZ25pc2Vk
IGF0Cj4gdGhlIHRyYWNlIGRlY2xhcmF0aW9uIGxldmVsLiBVbmZvcnR1bmF0ZWx5LCB3ZSBjYW5u
b3QgYXNzdW1lIGFueXRoaW5nCj4gYWJvdXQgbmF0aXZlIGVuZGlhbm5lc3Mgb2YgdGhlIHRyYWNl
ZCBtYWNoaW5lIHVudGlsIHdlIGhhdmUgdGhlCj4gZW5kaWFubmVzcyBpbmZvcm1hdGlvbiBhdCB0
aGUgdHJhY2UgZGVjbGFyYXRpb24gbGV2ZWwsIGFzIHRoZSB0cmFjZSBjYW4KPiBjb21lIGZyb20g
YW55IHNvdXJjZS4KCkl0IGlzIGNsZWFyIHRvIG1lIG5vdy4gIFRoYW5rcyBmb3IgdGhlIGNsYXJp
ZmljYXRpb24uCgo+Cj4gUG9zc2libHkgdGhhdCB0aGUgQ1RGIHNwZWMgd291bGQgbmVlZCB0byBi
ZSBjbGFyaWZpZWQuIEN1cnJlbnRseSwgd2UKPiBuZWVkIHRvIGxvb2sgYXQ6CgpUaGUgZG9jIHBh
cnQgaXMgZmluZSwgYnV0IHRoaXMgZXJyb3IgbWVzc2FnZSBpcyBjb25mdXNpbmcsCgpbZXJyb3Jd
IGdldF90cmFjZV9ieXRlX29yZGVyOiB1bmV4cGVjdGVkIHN0cmluZyAibmF0aXZlIi4gU2hvdWxk
IGJlIAoibmF0aXZlIiwgIm5ldHdvcmsiLCAiYmUiIG9yICJsZSIuCgpMb29rcyBpdCB3YXMgZml4
ZWQuICBXaGVuIEkgdXBkYXRlIG15IHRyZWUsIHRoZSBlcnJvciBtZXNzYWdlIGlzIHVwZGF0ZWQu
CgpJJ2xsIGdpdmUgYSBjb21tZW50IGluIHlvdXIgY29tbWVudCB0byBDVEYgc3BlYy4KCi0tIApZ
YW8gKOm9kOWwpykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
