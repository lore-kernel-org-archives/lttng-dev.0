From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: Beginner question: how to inspect scheduling of
 multi-threaded user application?
Date: Mon, 19 Sep 2016 12:04:54 -0400
Message-ID: <CAB4xu_0m1wtkYe+R5q_VqwnjvPPo_rc8JyqQa-VHA4jaj1kmqQ__31685.1890100681$1474301146$gmane$org@mail.gmail.com>
References: <35de22c3d2034f3abb75596477b23e3a@EUX13SRV1.EU.NEC.COM>
 <CADcCL0hqkvEPZEu85GzJnJKi9nOi0wntpOYoVz37QhcRVpb+=g@mail.gmail.com>
 <CAF4oYfHJCGnmmDfNokV2029Kp_8k7n1rCt4CX=OaLrLKEc_5wg@mail.gmail.com>
 <CAF4oYfHyRe1KmbAgy4eKk6oDVWvZp+TP3SRXZ+BuJf5iWwEQwQ@mail.gmail.com>
 <022bc22a602e4631903ee12b6dd1be6c@EUX13SRV1.EU.NEC.COM>
 <02c06e3a-06ad-0c77-c3b2-bb9ab1dc3995@efficios.com>
 <bf4d2ea2d4844db0bf0511d48cade46d@EUX13SRV1.EU.NEC.COM>
 <646123a6-aed5-0b8e-bafa-ca9dfed6d802@efficios.com>
 <af8ddfb9c34443618a768264ee4f059f@EUX13SRV1.EU.NEC.COM>
 <5f03ae09-bc3a-8e14-0611-bb06b614d981@efficios.com>
 <cbd292c898ec46ce8a4150c01ed71d3a@EUX13SRV1.EU.NEC.COM>
 <87c9dc47-8275-aa10-29ee-ee8769231bf6@efficios.com>
 <fb0767baf6a94600ae92b30282411f54@EUX13SRV1.EU.NEC.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-f172.google.com (mail-qt0-f172.google.com
 [209.85.216.172])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 94105A3EDD
 for <lttng-dev@lists.lttng.org>; Mon, 19 Sep 2016 16:06:30 +0000 (UTC)
Received: by mail-qt0-f172.google.com with SMTP id l91so73448674qte.3
 for <lttng-dev@lists.lttng.org>; Mon, 19 Sep 2016 09:05:25 -0700 (PDT)
In-Reply-To: <fb0767baf6a94600ae92b30282411f54@EUX13SRV1.EU.NEC.COM>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: David Aldrich <David.Aldrich@emea.nec.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gTW9uLCBTZXAgMTksIDIwMTYgYXQgMTE6MzggQU0sIERhdmlkIEFsZHJpY2gKPERhdmlkLkFs
ZHJpY2hAZW1lYS5uZWMuY29tPiB3cm90ZToKPgo+IEhpIEpvbmF0aGFuCj4KPiBUaGFua3MgZm9y
IHlvdXIgcmVwbHkuIFdoYXQgaXMgJ2NvbW0nIGluICdwcmV2X2NvbW0nPwoKImNvbW0iIHN0YW5k
cyBmb3IgImNvbW1hbmQiLgoKU2VlIHRoaXMgaW4gc2NoZWQuaDoKCiAgICAvKiBUYXNrIGNvbW1h
bmQgbmFtZSBsZW5ndGggKi8KICAgICNkZWZpbmUgVEFTS19DT01NX0xFTiAxNgoKUGhpbAoKPgo+
IEJlc3QgcmVnYXJkcwo+Cj4gRGF2aWQKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
