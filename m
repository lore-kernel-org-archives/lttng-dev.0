From: Simon Marchi via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: babletrace2 graph performance considerations
Date: Mon, 30 Mar 2020 18:41:34 -0400
Message-ID: <3c5709f9-5b9d-86fd-e244-6337970a8707@simark.ca>
References: <CADtyBo6B4YQ++VPhM4-cAfKYq0otJMg4zMXvQYqyNw3JsSX6Nw@mail.gmail.com>
 <9b2fe91b-4f44-3b89-eaf9-98f945384a33@simark.ca>
 <CADtyBo7EBkHsDv-=-94oFnuviFvHnYQW_R6vHv08QCfo8QTyqg@mail.gmail.com>
 <1cc5fee9-487d-61f5-6376-8b3d40dc47f5@simark.ca>
 <CADtyBo7w2bTGkvjA7jFo-iwrXCrS3yQ89MJg2G0M7rYoaNV4Fg@mail.gmail.com>
Reply-To: Simon Marchi <simark@simark.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from simark.ca (simark.ca [158.69.221.121])
 by lists.lttng.org (Postfix) with ESMTPS id 48rnWM5SkQz1Z7v
 for <lttng-dev@lists.lttng.org>; Mon, 30 Mar 2020 18:41:35 -0400 (EDT)
In-Reply-To: <CADtyBo7w2bTGkvjA7jFo-iwrXCrS3yQ89MJg2G0M7rYoaNV4Fg@mail.gmail.com>
Content-Language: en-US-large
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Rocky Dunlap <dunlap@ucar.edu>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gMjAyMC0wMy0zMCA2OjM0IHAubS4sIFJvY2t5IER1bmxhcCB2aWEgbHR0bmctZGV2IHdyb3Rl
Ogo+IEVhY2ggZ3JhcGggd291bGQgcGFyc2UgdGhlIHdob2xlIHN0cmVhbT/CoCBXaGF0IGlmIEkg
b25seSBjb25uZWN0IG9uZSBvZiB0aGUgb3V0cHV0cyBmcm9tIHRoZSBzb3VyY2UuY3RmLmZzP8Kg
IEkgd291bGQgdGhpbmsgaXQgd291bGQgb25seSBhY2Nlc3MgdGhhdCBvbmUgc3RyZWFtIGZpbGUu
CgpIbW0geWVhaCBwZXJoYXBzLCBJIGRpZG4ndCB0aGluayBvZiB0aGF0LiAgR2l2ZSBpdCBhIHRy
eSEKClNpbW9uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
