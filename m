From: Gunnar Strand <Gunnar.Strand@ericsson.com>
Subject: Bug in lttng-ust tool lttng-gen-tp which replaces all
 ".c" with ".h" in the path
Date: Mon, 18 Sep 2017 11:47:28 +0200
Message-ID: <021b9053-2599-9b1c-0218-a994fa0e25a7__20950.5121027634$1505728073$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sessmg23.ericsson.net (sessmg23.ericsson.net [193.180.251.45])
 by lists.lttng.org (Postfix) with ESMTPS id 3xwh4m2DjHzCLx
 for <lttng-dev@lists.lttng.org>; Mon, 18 Sep 2017 09:47:35 +0000 (UTC)
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGksCgpJdCBkb2VzIG5vdCBzZWVtIGxpa2UgYW5vbnltb3VzIGJ1ZyByZXBvcnRpbmcgaXMgc3Vw
cG9ydGVkLCBzbyBJIGFtIApzdWJtaXR0aW5nIHRoZSByZXBvcnQgaGVyZSBpbnN0ZWFkLgoKSSBm
b3VuZCB0aGUgZm9sbG93aW5nIGJ1ZyBpbiB0aGUgdG9vbHMvbHR0bmctZ2VuLXRwIHRvb2wgaW4g
dGhlIApsdHRuZy11c3QgY29tcG9uZW50LCB3aGljaCBpcyBwcmVzZW50IGluIHRoZSBsYXRlc3Qg
Y29tbWl0IG9uIG1hc3RlciwgCmQwZjZjZjU3NGVmOTkyNjIwYjA5YzE4M2NiM2EwZWE3NzEwNzBl
YTU6CgogwqA2NiBjbGFzcyBDRmlsZToKLi4uCiDCoDc5wqDCoMKgwqAgZGVmIHdyaXRlKHNlbGYp
OgogwqA4MMKgwqDCoMKgwqDCoMKgwqAgb3V0cHV0RmlsZSA9IG9wZW4oc2VsZi5vdXRwdXRGaWxl
bmFtZSwidyIpCiDCoDgxCiDCoDgywqDCoMKgwqDCoMKgwqDCoCBoZWFkZXJGaWxlbmFtZSA9IHNl
bGYub3V0cHV0RmlsZW5hbWUucmVwbGFjZSgiLmMiLCIuaCIpCgpMaW5lIDgyIHJlcGxhY2VzIGFs
bCBvY2N1cnJlbmNlcyBvZiAiLmMiIHdpdGggIi5oIiB3aGljaCBicmVha3MgCmNvbXBpbGF0aW9u
IGlmIHRoZSBwYXRoIHRvIHRoZSBzb3VyY2UgY29udGFpbnMgIi5jIiBhbnl3aGVyZSwgZWcuOiAK
L3BhdGgvdG8vbXkuY2lnYXIvc291cmNlLy4uLgoKT25seSB0aGUgbGFzdCBvY2N1cnJlbmNlIHNo
b3VsZCBiZSByZXBsYWNlZCwgZWcuOgoKaWYgc2VsZi5vdXRwdXRGaWxlbmFtZS5lbmRzd2l0aCgi
LmMiKToKCiDCoMKgwqAgaGVhZGVyRmlsZW5hbWUgPSBzZWxmLm91dHB1dEZpbGVuYW1lWzotMl0g
KyAiLmgiCgpPciBqdXN0IHRoZSBzZWNvbmQgbGluZSBpZiB0aGUgY29kZSBjYW4gYXNzdW1lIHRo
YXQgdGhlIHN0cmluZyBoYXMgYSAKIi5jIiBzdWZmaXguCgpCUgoKR3VubmFyCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dp
LWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
