From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [RFC] Extracting the payload from select, poll,
 epoll_ctl and epoll_wait
Date: Tue, 22 Mar 2016 18:48:32 -0400
Message-ID: <20160322224832.GJ29041__30112.544555641$1458686958$gmane$org@sinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com (albert.ini-tech.com [192.99.35.19])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 58850A0816
 for <lttng-dev@lists.lttng.org>; Tue, 22 Mar 2016 22:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id 4267587BCC
 for <lttng-dev@lists.lttng.org>; Tue, 22 Mar 2016 22:48:51 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 9Htb_vCo8JqM for <lttng-dev@lists.lttng.org>;
 Tue, 22 Mar 2016 22:48:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id 919A687F9B
 for <lttng-dev@lists.lttng.org>; Tue, 22 Mar 2016 22:48:49 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id X2pS7Hv5u8gP for <lttng-dev@lists.lttng.org>;
 Tue, 22 Mar 2016 22:48:49 +0000 (UTC)
Received: from sinkpad (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTPSA id E501B87BCC
 for <lttng-dev@lists.lttng.org>; Tue, 22 Mar 2016 22:48:47 +0000 (UTC)
Content-Disposition: inline
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGksCgpDdXJyZW50bHkgd2l0aCB0aGVzZSBzeXN0ZW0gY2FsbHMsIHdlIG9ubHkgaGF2ZSB0aGUg
YWRkcmVzcyBvZiBhCnVzZXItc3BhY2UgcG9pbnRlciBjb250YWluaW5nIHRoZSBpbnRlcmVzdGlu
ZyBkYXRhLCBzbyB3ZSBjYW5ub3QgZG8gYW55CmFuYWx5c2lzLgoKRm9yIExUVG5nIDIuOSwgd2Ug
d2FudCB0byBleHRyYWN0IHRoZSBjb250ZW50IG9mIHRoZXNlIHN5c3RlbSBjYWxscyB0bwpnZXQg
bW9yZSBpbnNpZ2h0cy4gV2UgdHJ5IHRvIHN0YXkgYXMgY2xvc2UgYXMgcG9zc2libGUgdG8gdGhl
IGxheW91dApyZWNlaXZlZCBpbiBvcmRlciB0byBhdm9pZCBsb25nIHByb2Nlc3NpbmcgaW4gdGhl
IGNyaXRpY2FsIHBhdGguCgpIZXJlIGFyZSB0aGUgcHJvcG9zZWQgb3V0cHV0czoKLSBzZWxlY3Q6
IGJpdG1hc2sgb2YgRkRzIHJlcHJlc2VudGVkIGFzIGEgc2VxdWVuY2Ugb2YgbG9uZywgc28gdGhl
CiAgcG9zaXRpb24gb2YgZWFjaCBiaXQgc2V0IGlzIHRoZSBudW1iZXIgb2YgYSBGRC4gT25seSBl
eHRyYWN0IHRoZQogIG5lY2Vzc2FyeSBmaWVsZHMgKHNlbGVjdCBhbHJlYWR5IHJlY2VpdmVzIHRo
ZSBtYXhpbXVtIEZEIHNldCkuIHNlbGVjdAogIGlzIGxpbWl0ZWQgYXQgMTAyNCBGRHMsIHNvIHdl
IG91dHB1dCBhdCBtb3N0IDE2IGxvbmdzIG9uIDY0LWJpdHMgYW5kCiAgMzIgb24gMzItYml0cyBh
cmNoaXRlY3R1cmVzLgotIHBvbGw6IGZvciBlYWNoIEZEIGluIHRoZSBwb2xsIHNldCwgb3V0cHV0
IHRoZSBGRCBhbmQgdGhlIGZsYWdzCiAgKGV2ZW50cyksIGVhY2ggcG9zc2libGUgZXZlbnQgaXMg
YSBiaXQuIE9uIGV4aXQsIG9ubHkgZXh0cmFjdCB0aGUKICByZWxldmFudCBGRHMuCi0gZXBvbGxf
Y3RsOiBvdXRwdXQgdGhlIEZELCBmbGFncyAoZXZlbnRzKSBhbmQgdGhlIGRhdGEuIFRoZSBkYXRh
IGlzIGEKICB1bmlvbiB0aGF0IGNhbiBjb250YWluIGFueXRoaW5nLCB3ZSBwcm9wb3NlIHRvIG91
dHB1dCBpdCB0d2ljZTogYXMgYQogICJ1aW50NjRfdCIgaW4gaGV4YWRlY2ltYWwgKGZvciB0aGUg
dTY0IGZpZWxkcykgYW5kIGFzIGEgc2lnbmVkICJpbnQiCiAgaW4gZGVjaW1hbCAoZm9yIHRoZSAi
ZmQiIGZpZWxkKS4KLSBlcG9sbF93YWl0OiBvbiByZXR1cm4sIGlmIEZEcyBhcmUgcmV0dXJuZWQs
IGV4dHJhY3QgdGhlIGxpc3QgaW4gdGhlCiAgc2FtZSBmb3JtYXQgYXMgaW4gZXBvbGxfY3RsLgoK
SGVyZSBpcyBhbiBleGFtcGxlIG91dHB1dDoKaHR0cHM6Ly9wYXN0ZS5kZWJpYW4ubmV0L3BsYWlu
LzQxODI0OAoKRm9yIHRob3NlIGludGVyZXN0ZWQgaW4gdGhlIENURiBtZXRhZGF0YSwgaGVyZSBp
dCBpczoKaHR0cHM6Ly9wYXN0ZS5kZWJpYW4ubmV0L3BsYWluLzQxODI0NQoKWW91IHdpbGwgbm90
aWNlLCB0aGF0IHRoaXMgb3V0cHV0IGNhbiBiZSB2ZXJ5IHZlcmJvc2Ugd2l0aCBsb25nIGxpc3Qg
b2YKRkRzLiBUbyBhZGRyZXNzIHRoYXQsIHdlIHBsYW4gdG8gYWRkIHByZXR0eSBwcml0aW5nIGhp
bnRzIGluIHRoZSBuZXh0CnZlcnNpb24gb2YgQ1RGIChDVEYyKSB0byBpbmZvcm0gdGhlIHZpZXdl
cnMgdGhhdCB0aGUgZmllbGRzIGFyZSBiaXRtYXNrcwooaW4gdGhpcyBjYXNlLCB3ZSBvbmx5IGNh
cmUgYWJvdXQgdGhlIHBvc2l0aW9uIG9mIHRoZSBiaXRzIHNldCksIG9yIHRoYXQKdGhlIHN0cnVj
dHVyZXMgaGF2ZSBiaXQtc2l6ZWQgZmllbGRzIChpbiB0aGlzIGNhc2UsIHdlIG9ubHkgd2FudCB0
bwpvdXRwdXQgdGhlIG5hbWUgb2YgdGhlIGZpZWxkcyB3aGVyZSB0aGUgYml0IGlzIHNldCkuCgpU
aGlzIGZvcm1hdHRpbmcgZGVjaXNpb24gaGFzIGFuIGltcGFjdCBvbiB0aGUgYW5hbHlzaXMgdG9v
bHMsIHNvIGlmIHlvdQpoYXZlIGFueSBjb21tZW50cyBvbiB0aGUgcHJvcG9zZWQgb3V0cHV0LCBu
b3cgaXMgdGhlIHRpbWUuCgpUaGFua3MsCgpKdWxpZW4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9s
aXN0aW5mby9sdHRuZy1kZXYK
