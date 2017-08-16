From: Jonah Graham <jonah@kichwacoders.com>
Subject: Re: Status of MinGW support for babeltrace (either 1.x
	or 2.x)
Date: Wed, 16 Aug 2017 10:38:31 +0100
Message-ID: <CAPmGMviouRVv=UDdy8ay1+3oeB6f4vcazU=pVyBajAhbtfSsDA__28227.974024094$1502876365$gmane$org@mail.gmail.com>
References: <CAPmGMvh9C2E7y3uDkdHqTizkuPAd9nuPn4OvOjvjDyCqyxhCag@mail.gmail.com>
 <CAB4xu_3HM+5At3=opwrZuzz9G7tqbg1JLxxgL0-F86m_+Zqc+w@mail.gmail.com>
 <CAPmGMvjaO3Gj8PZdLD1UC6AVMi9mAbc03M+-=E7mMQybbE5qPg@mail.gmail.com>
 <CAB4xu_1QPYi_isqgf6i6-6_z6XXR_0hBGV7mBvskBypCkGNJsA@mail.gmail.com>
 <CAPmGMviXJU9ekxs_Dj7=RaLHPAxTS6eF7hvYNuaJ5nfQO7ELOQ@mail.gmail.com>
 <CAB4xu_2mfUe=OH-jytb858EiycF6=iD-euVMRfDuCZsL8qKgJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sasl.smtp.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
 by lists.lttng.org (Postfix) with ESMTPS id 3xXPSM04ZZzsqW
 for <lttng-dev@lists.lttng.org>; Wed, 16 Aug 2017 09:39:14 +0000 (UTC)
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
 by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DD1B9FBE5
 for <lttng-dev@lists.lttng.org>; Wed, 16 Aug 2017 05:39:13 -0400 (EDT)
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
 by pb-smtp1.pobox.com (Postfix) with ESMTP id 361529FBE4
 for <lttng-dev@lists.lttng.org>; Wed, 16 Aug 2017 05:39:13 -0400 (EDT)
Received: from mail-it0-f53.google.com (unknown [209.85.214.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ABBAC9FBDA
 for <lttng-dev@lists.lttng.org>; Wed, 16 Aug 2017 05:39:12 -0400 (EDT)
Received: by mail-it0-f53.google.com with SMTP id 77so15164555itj.1
 for <lttng-dev@lists.lttng.org>; Wed, 16 Aug 2017 02:39:12 -0700 (PDT)
In-Reply-To: <CAB4xu_2mfUe=OH-jytb858EiycF6=iD-euVMRfDuCZsL8qKgJw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gMTUgQXVndXN0IDIwMTcgYXQgMjE6NTAsIFBoaWxpcHBlIFByb3VseCA8ZWVwcGVsaXRlbG9v
cEBnbWFpbC5jb20+IHdyb3RlOgo+IFdoeSBjYW4ndCB5b3UgdXNlIExUVG5nPwpPSywgbm93IEkg
YW0gZ2xhZCB3ZSBoYXZlIGNvbnRpbnVlZCB0aGlzIGRpc2N1c3Npb24uIEkgdGhvdWdodCB0aGF0
CmxpYmJhYmVsdHJhY2UgcHJvdmlkZWQgdGhlIGJhY2tlbmQgb2YgTFRUbmc/CgpQZXJoYXBzIEkg
YW0gbWlzdW5kZXJzdGFuZGluZywgYW5kIEkgYW0gdmVyeSBncmF0ZWZ1bCBmb3IgeW91cgppbnNp
Z2h0cy4gSSB3aWxsIHByb3ZpZGUgbW9yZSBkZXRhaWxzLCBob3BpbmcgSSBjYW4gZ2V0IG1vcmUg
aW5zaWdodAo6LSkuIFdlIGFyZSB0cnlpbmcgdG8gYWRkIHRyYWNpbmcgc3VwcG9ydCB0byBvdXIg
c2ltdWxhdGlvbiBtb2RlbHMgb2YKbWljcm9wcm9jZXNzb3Igc3lzdGVtcyAodGhlc2UgcmFuZ2Ug
ZnJvbSBhIHNpbmdsZSBwcm9jZXNzb3Igc2ltdWxhdGluZwpiYXJlIG1ldGFsIHRvIGZ1bGwgU09D
IHNpbXVsYXRpb24gbW9kZWxzIG9mIExpbnV4IGFuZCBtYW55IG90aGVyIFJUT1MKdG9vKS4gV2Ug
YWxyZWFkeSBoYXZlIGluIG1lbW9yeSByZXByZXNlbnRhdGlvbnMgd2l0aCBwbGFpbiB0ZXh0Cm91
dHB1dHMgb2YgdGhpbmdzIGxpa2UgYWN0aXZlIHRhc2tzIG9uIENQVSBhbmQgY2FsbCBzdGFja3Mu
IFdlIGZpZ3VyZWQKaWYgd2UgY3JlYXRlIENURiBmaWxlcyBvZiB0aGUgc2FtZSBmb3JtYXQgdGhh
dCBMVFRuZyBkb2VzIGZvciB2YXJpb3VzCmxpbnV4IGtlcm5lbCBhbmQgVVNUIHRyYWNlcywgd2Ug
Y291bGQgcmV1c2UgYW5kIG1pbmltYWxseSBjdXN0b21pemUKdHJhY2Vjb21wYXNzIHRvIGRpc3Bs
YXkgdGhlbS4KClR5aW5nIGJhY2sgdG8gdGhlIG9yaWdpbmFsIHF1ZXN0aW9uLCB0aGUgc2ltdWxh
dGlvbiBtb2RlbHMgcnVuIG9uCndpbmRvd3MsIHNvIHdlIG5lZWQgYSBjcm9zcyBwbGF0Zm9ybSBs
aWJyYXJ5LgoKPiBUaGUgZGlzY2xhaW1lciB3aXRoIENURiB3cml0ZXIgKHBhcnQgb2YgbGliYmFi
ZWx0cmFjZSkgaXMgdGhhdCBpdCBpcyBub3QKPiBzdXBlciBmaXQgZm9yIHRyYWNpbmcgcHVycG9z
ZXM6IGl0cyByb2xlIGlzIHRvIGhlbHAgaW4gdGhlIGNvbnZlcnNpb24KPiBmcm9tIGEgdHJhY2Ug
d3JpdHRlbiBpbiBzb21lIG5vbi1DVEYgZm9ybWF0IChmb3IgZXhhbXBsZSwgeW91ciB0ZXh0Cj4g
ZmlsZXMpIHRvIENURi4KV2VsbCB0aGF0IHNvdW5kcyBhYm91dCByaWdodCBmb3Igb3VyIHVzZS4g
SSBqdXN0IHdhbnQgdG8gdGFrZSB0aGUKaW50ZWdyYXRpb24gYmFjayBhIHN0ZXAgYXMgdGhlIHRl
eHQgZmlsZXMgaW4gb3VyIGNhc2UgYXJlIG5vdApwYXJ0aWN1bGFybHkgbWFjaGluZSByZWFkYWJs
ZS4gU28sIGluc3RlYWQgb2YgZm9ybWFsaXppbmcgdGhlIG91dHB1dApvZiBvdXIgdG9vbCBhbmQg
dGhlbiBjb252ZXJ0aW5nIHRoZW0gdG8gQ1RGIHdlIHRob3VnaHQgaXQgYmVzdCB0byBkbwp0aGF0
IGRpcmVjdGx5LgoKPiBBcyBmb3IgYmFyZWN0ZiwgdGhlIHByb2plY3QncyB0YXJnZXQgaXMgYmFy
ZSBtZXRhbCBlbWJlZGRlZCBzeXN0ZW1zLCBhbmQKPiB5b3UgbmVlZCB0byB3cml0ZSB5b3VyIG93
biBiYXJlY3RmIHBsYXRmb3JtIGZvciBlYWNoIGN1c3RvbSBlbnZpcm9ubWVudC4KVGhhdCBzZWVt
ZWQgbGlrZSBhIGZhbGxiYWNrIG9wdGlvbiwgYnV0IG5vdCByaWdodCBmb3IgdXMgaWYgd2UgY2Fu
IGRvCml0IGF0IHJ1bnRpbWUuCgoKUFMuIEkgaGF2ZSBmb3VuZCB0aGUgUHl0aG9uIGJpbmRpbmdz
IGZvciBsaWJiYWJlbHRyYWNlIHJlYWxseSB1c2VmdWwKZm9yIGV4cGVyaW1lbnRpbmcuIEkgYW0g
ZG9pbmcgdGhhdCB3aXRoIDEuNS4zIHVudGlsIHRoZSAyLjAgdmVyc2lvbgpoYXMgUHl0aG9uIGVu
YWJsZWQgYWdhaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
