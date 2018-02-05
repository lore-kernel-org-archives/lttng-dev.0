From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools master] Fix: cleanup inactive
 FDs in the consumer polling thread
Date: Mon, 5 Feb 2018 10:50:47 -0500
Message-ID: <20180205155047.GA15132__11829.3661428199$1517845749$gmane$org@joraj-alpa>
References: <1517513050-30084-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <CA+jJMxuBEB7kDogf0K=3-V-ajbxC130JdW9CPdAgi92hkj9VXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zZsWQ1dNRzCnW
 for <lttng-dev@lists.lttng.org>; Mon,  5 Feb 2018 15:50:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CA+jJMxuBEB7kDogf0K=3-V-ajbxC130JdW9CPdAgi92hkj9VXg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

PiBJIHByb3Bvc2UgdGhlIGZvbGxvd2luZyBtZXNzYWdlIHdoaWNoIHJlZmxlY3RzIG15IHVuZGVy
c3RhbmRpbmcgb2YgdGhlCj4gcHJvYmxlbS4gTGV0IG1lIGtub3cgaWYgaXQgaXMgY29ycmVjdC4K
Ckxvb2tzIG1vcmUgdGhhbiBjb3JyZWN0LgoKQ2hlZXJzCgotLSAKSm9uYXRoYW4gUmFqb3R0ZS1K
dWxpZW4KRWZmaWNpT1MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
