From: Yuxin Ren <ryx@gwmail.gwu.edu>
Subject: RCU on non-cache-coherent memory
Date: Mon, 1 Aug 2016 20:30:55 -0400
Message-ID: <CAAKbDrfJ=umcdwFp7j5RDMZt7AfhAhCnmOfZqvD2WeNuhcb0rw__4892.3764531084$1470097870$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 92467A39D0
 for <lttng-dev@lists.lttng.org>; Tue,  2 Aug 2016 00:30:57 +0000 (UTC)
Received: by mail-oi0-f66.google.com with SMTP id w143so15253880oiw.2
 for <lttng-dev@lists.lttng.org>; Mon, 01 Aug 2016 17:30:57 -0700 (PDT)
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

SGkgYWxsLAoKSXMgdGhlcmUgYW55IHJlc2VhcmNoIG9yIHB1YmxpY2F0aW9ucyBhYm91dCBSQ1Ug
b24gdG9wIG9mCm5vbi1jYWNoZS1jb2hlcmVudCBtdWx0aS1jb3JlIGFyY2hpdGVjdHVyZT8KTm90
IG9ubHkgUkNVLCBhbnkgb3RoZXIgc3luY2hyb25pemF0aW9uIHRlY2huaXF1ZSBvbiB0b3Agb2YK
bm9uLWNhY2hlLWNvaGVyZW50IG11bHRpLWNvcmUKaXMgYWxzbyBoZWxwZnVsLgoKVGhhbmtzIGEg
bG90IQpZdXhpbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
