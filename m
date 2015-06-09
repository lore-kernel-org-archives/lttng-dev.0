From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: LTTng-UST new tracelog() feature
Date: Tue, 9 Jun 2015 14:42:40 +0000 (UTC)
Message-ID: <2128314805.7287.1433860960349.JavaMail.zimbra__24356.2984666371$1433861038$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Z2Kjw-0006b1-Jj
 for lttng-dev@lists.lttng.org; Tue, 09 Jun 2015 10:42:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C243D34024A
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jun 2015 14:42:52 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id oXGmUpEyoy7G for <lttng-dev@lists.lttng.org>;
 Tue,  9 Jun 2015 14:42:41 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E80FA340352
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jun 2015 14:42:40 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id BhOSXNlv1MuY for <lttng-dev@lists.lttng.org>;
 Tue,  9 Jun 2015 14:42:40 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 9885634024A
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jun 2015 14:42:40 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGksCgpJIGp1c3QgcHVzaGVkIGEgbmV3IGluc3RydW1lbnRhdGlvbiBmZWF0dXJlIGludG8gbHR0
bmctdXN0CnRhcmdldGluZyBhcHBsaWNhdGlvbnMgdGhhdCB3YW50IHRvIG1vdmUgdGhlaXIgZXhp
c3RpbmcgbG9nZ2luZwpmYWNpbGl0aWVzIHRvIExUVG5nLVVTVC4gRnJvbSB0aGUgdXBkYXRlZCBs
dHRuZy11c3QoMykgbWFucGFnZToKClVTQUdFIFdJVEggVFJBQ0VMT0cKICAgICAgIElmIHlvdSB3
YW50IHRvIG1pZ3JhdGUgZXhpc3RpbmcgbG9nZ2luZyAoaW5mbywgZXJyb3JzLCAuLi4pICAgdG8g
IExUVG5nCiAgICAgICBVU1QsIHlvdSBjYW4gdXNlIHRoZSB0cmFjZWxvZygpIGludGVyZmFjZS4g
IFRvIGRvIGl0LCBpbiBhIG51dHNoZWxsOgoKICAgICAgIDEpICNpbmNsdWRlIDxsdHRuZy90cmFj
ZWxvZy5oPgoKICAgICAgIDIpIC8qIGluIHlvdXIgY29kZSwgdXNlIGxpa2UgYSBwcmludGYsIHdp
dGggZXh0cmEgbG9nbGV2ZWwgaW5mby4gKi8KICAgICAgICAgIHRyYWNlbG9nKFRSQUNFX0lORk8s
ICJNZXNzYWdlIHdpdGggaW50ZWdlciAlZCIsIDEyMzQpOwoKICAgICAgIDMpIExpbmsgeW91ciBw
cm9ncmFtIGFnYWluc3QgbGlibHR0bmctdXN0LnNvLgoKICAgICAgIDQpICBFbmFibGUgIFVTVCBl
dmVudHMgd2hlbiB0cmFjaW5nIHdpdGggdGhlIGZvbGxvd2luZyBzZXF1ZW5jZSBvZiBjb23igJAK
ICAgICAgIG1hbmRzCiAgICAgICAgICBmcm9tIGx0dG5nLXRvb2xzOgoKICAgICAgICAgIGx0dG5n
IGNyZWF0ZQogICAgICAgICAgbHR0bmcgZW5hYmxlLWV2ZW50IC11ICJsdHRuZ191c3RfdHJhY2Vs
b2c6KiIKICAgICAgICAgIGx0dG5nIHN0YXJ0CiAgICAgICAgICBbLi4uIHJ1biB5b3VyIHByb2dy
YW0gLi4uXQogICAgICAgICAgbHR0bmcgc3RvcAogICAgICAgICAgbHR0bmcgdmlldwoKICAgICAg
IFRoYXQncyBpdCEKCiAgICAgICBZb3UgY2FuIHJlcGxhY2UgIHRoZSAgZW5hYmxlLWV2ZW50ICBs
aW5lICBhYm92ZSAgd2l0aCAgYSAgc2VsZWN0aW9uICBvZgogICAgICAgbG9nbGV2ZWxzLCBlLmcu
OgoKICAgICAgICAgIGx0dG5nIGVuYWJsZS1ldmVudCAtdSAtYSAtLWxvZ2xldmVsIFRSQUNFX0lO
Rk8KCiAgICAgICBXaGljaCAgd2lsbCAgZ2F0aGVyICBhbGwgIGV2ZW50cyAgZnJvbSAgVFJBQ0Vf
SU5GTyAgYW5kICBtb3JlIGltcG9ydGFudAogICAgICAgbG9nbGV2ZWxzLgoKRmVlZGJhY2sgaXMg
d2VsY29tZSEKClRoYW5rcywKCk1hdGhpZXUKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lP
UyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
